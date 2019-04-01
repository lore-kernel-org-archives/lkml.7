Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9BC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D112084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141483;
	bh=dik5Fs2p2RHoeNEbYJWfJ5+EvrvSP9ufaO2l/1DePE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sRGeqKlIWZ5vCZlAbxmRCDFa8rm8mrJDy/2rYpkeeKtqs9+RybcUHncij5pocE1GU
	 F+OEEJfT5tkhwEdSoqO/58UB3OcVBuZh5KQ8rbSxOGlx5cmaih2GtkVBSkcc98yRBT
	 k08fKYvtJtwKjOioMFEcY8ae6lfsxddvcQX68TiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfDARTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbfDARTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9318D206DD;
        Mon,  1 Apr 2019 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139151;
        bh=dik5Fs2p2RHoeNEbYJWfJ5+EvrvSP9ufaO2l/1DePE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upgBQ3v9ZZ7vyaYJ2CVpXyBZrmjAT5EV+85ACCH89MXclKyjo2THWY+e1G9HB4hDU
         aiFpMdUAf/eMJTb4L4dPptRmvl+VGNWhQGUoRKEVqZjfLGN3uOoT+2uS9opGqprbij
         84h4PJ4wzMvVJQ3JEz+s5DwgZ2jSw3a8YvS1pa7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 129/134] drivers: base: Helpers for adding device connection descriptions
Date:   Mon,  1 Apr 2019 19:02:45 +0200
Message-Id: <20190401170056.269626760@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit cd7753d371388e712e3ee52b693459f9b71aaac2 upstream.

Introducing helpers for adding and removing multiple device
connection descriptions at once.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/device.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -774,6 +774,30 @@ void device_connection_add(struct device
 void device_connection_remove(struct device_connection *con);
 
 /**
+ * device_connections_add - Add multiple device connections at once
+ * @cons: Zero terminated array of device connection descriptors
+ */
+static inline void device_connections_add(struct device_connection *cons)
+{
+	struct device_connection *c;
+
+	for (c = cons; c->endpoint[0]; c++)
+		device_connection_add(c);
+}
+
+/**
+ * device_connections_remove - Remove multiple device connections at once
+ * @cons: Zero terminated array of device connection descriptors
+ */
+static inline void device_connections_remove(struct device_connection *cons)
+{
+	struct device_connection *c;
+
+	for (c = cons; c->endpoint[0]; c++)
+		device_connection_remove(c);
+}
+
+/**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
  * @DL_STATE_DORMANT: None of the supplier/consumer drivers is present.



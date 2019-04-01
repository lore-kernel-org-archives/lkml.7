Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139938;
	bh=anRTUe9WKGLlIQRz5guNoGmaiMfJTBg2AXg/IovC/gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LEXij6XA/j05of+gJ3ffrka0svm4yyRa02zX/JC1UhwkwMSw66EfKguiaZ3BLbLcU
	 pYiB8pFt0s1j8nvRJpA3lvk/W7leXjx0JnTgKVyqKGMSo1PIEy4T8Oc7B4Vb3FFatd
	 lUBOuEL8Gyb5vGaDFLL0SynD6HKJQHeaXBnh0CME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbfDARcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733135AbfDARcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBADD2171F;
        Mon,  1 Apr 2019 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139931;
        bh=anRTUe9WKGLlIQRz5guNoGmaiMfJTBg2AXg/IovC/gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zp4JjhFLm+5LwTHIFIFlbmmScOW82A2mtU/YowAQLzplFTYSumUEuW8GP2aL65k5U
         xDfiq5Q8vuMIxeLwt0rtS6s9gwYu6C/b7YMfe+vyJpgaEFoDQUePYud/O+K6nKiwTc
         F2zkeYVL9tCudQmk8OMD14EIaInnSma9AX4kxlH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 057/131] coresight: remove csdevs link from topology
Date:   Mon,  1 Apr 2019 19:02:07 +0200
Message-Id: <20190401170057.109835825@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ad725aee070caf8fa93d84d6fb78321f9642db18 ]

In function 'coresight_unregister()', all references to the csdev that
is being taken away need to be removed from the topology.  Otherwise
building the next coresight path from source to sink may use memory
that has been released.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight.c | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 5e2a2a5ad601..c6aea4795d0b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -582,6 +582,50 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 	}
 }
 
+static int coresight_remove_match(struct device *dev, void *data)
+{
+	int i;
+	struct coresight_device *csdev, *iterator;
+	struct coresight_connection *conn;
+
+	csdev = data;
+	iterator = to_coresight_device(dev);
+
+	/* No need to check oneself */
+	if (csdev == iterator)
+		return 0;
+
+	/*
+	 * Circle throuch all the connection of that component.  If we find
+	 * a connection whose name matches @csdev, remove it.
+	 */
+	for (i = 0; i < iterator->nr_outport; i++) {
+		conn = &iterator->conns[i];
+
+		if (conn->child_dev == NULL)
+			continue;
+
+		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
+			iterator->orphan = true;
+			conn->child_dev = NULL;
+			/* No need to continue */
+			break;
+		}
+	}
+
+	/*
+	 * Returning '0' ensures that all known component on the
+	 * bus will be checked.
+	 */
+	return 0;
+}
+
+static void coresight_remove_conns(struct coresight_device *csdev)
+{
+	bus_for_each_dev(&coresight_bustype, NULL,
+			 csdev, coresight_remove_match);
+}
+
 /**
  * coresight_timeout - loop until a bit has changed to a specific state.
  * @addr: base address of the area of interest.
@@ -720,6 +764,8 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+	/* Remove references of that device in the topology */
+	coresight_remove_conns(csdev);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.19.1




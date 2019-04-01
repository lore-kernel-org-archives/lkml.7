Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4447AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0850F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141479;
	bh=aQOcQB68RMuopv+/nSY9IeAMC1/30fLt51ONVGePQHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rIKKBhchO99pg37krftN4U7KoTmaWwJvLdZHtSzY/lLphj6r5pEq8PMbTLK6G+yBC
	 i108b+svFegnyLVVE8Zgt8T5Q7bjyDqwiSKpiR4O/8NMaO+liRc6k+nBx8ehhnvtZo
	 JCZ2DqHN/CCYGaR0Q+MDu0SUpEeL+qL/ZXxBEvSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfDAR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbfDARTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC08621852;
        Mon,  1 Apr 2019 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139156;
        bh=aQOcQB68RMuopv+/nSY9IeAMC1/30fLt51ONVGePQHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXBB2OPYw7ZMFsTWVilacpou7AM4YQ7dZ/s3l2IDx7/3nXKaOnG2uFFBiyKBdFP9Q
         G2rYcjl8VQecpPD/jxcYwB8MW32ICr2bkdqPGDn7L288uvh6WG6YTUeeMK1f3wxo6s
         rUjuxPRgXd3CljZAYpcopg3xuDVJ8oUKJgKgB1TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 130/134] platform: x86: intel_cht_int33fe: Register all connections at once
Date:   Mon,  1 Apr 2019 19:02:46 +0200
Message-Id: <20190401170056.358791374@linuxfoundation.org>
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

commit 140a4ec4adddda615b4e8e8055ca37a30c7fe5e8 upstream.

We can register all device connection descriptors with a
single call to device_connections_add().

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_cht_int33fe.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,7 +34,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[3];
+	struct device_connection connections[4];
 };
 
 /*
@@ -184,9 +184,7 @@ static int cht_int33fe_probe(struct i2c_
 	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
 	data->connections[2].id = "usb-role-switch";
 
-	device_connection_add(&data->connections[0]);
-	device_connection_add(&data->connections[1]);
-	device_connection_add(&data->connections[2]);
+	device_connections_add(data->connections);
 
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
@@ -217,9 +215,7 @@ out_unregister_max17047:
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
-	device_connection_remove(&data->connections[2]);
-	device_connection_remove(&data->connections[1]);
-	device_connection_remove(&data->connections[0]);
+	device_connections_remove(data->connections);
 
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
@@ -233,9 +229,7 @@ static int cht_int33fe_remove(struct i2c
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
-	device_connection_remove(&data->connections[2]);
-	device_connection_remove(&data->connections[1]);
-	device_connection_remove(&data->connections[0]);
+	device_connections_remove(data->connections);
 
 	return 0;
 }



Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE14DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D620731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452230;
	bh=qOkPPUwOCewg24RzBR9eUeRxpKwdepqXTSJPY4c648g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I08eu7p0K+PQ4n2Qpckf8XPLqVxNNKrkoIzL8w54e/LQHRM+UZDxtlArobRPk2ZeI
	 dzooqcAxfa9brySNJkYvKqcse46oL6Vqf+6hPcMRGCjlZ9yu+aSPtsYlP8ZqOZLLwl
	 U1nmnH8RBc43u8mMm3a7CxhrK2skNrTds8x+ggg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfKVTuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfKVTuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C2220730;
        Fri, 22 Nov 2019 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452221;
        bh=qOkPPUwOCewg24RzBR9eUeRxpKwdepqXTSJPY4c648g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cajrVOPVA5WCuXTZpYBDSrr9W8fjnYACeQna02ocOqGFy65PFdZmqvYexKzglW4Bm
         mD2F/aAZE8ZNraz6OBGikgseZuR4xJyaLsoN9dGFvOnsy9mMkEUpqUoGhABnDPGPFX
         P9dX4ZybTC3mylbrc5uslQBoAArj4+Os6aFrnhpQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 6/9] net: cdc_ncm: Signedness bug in cdc_ncm_set_dgram_size()
Date:   Fri, 22 Nov 2019 14:50:11 -0500
Message-Id: <20191122195014.25065-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122195014.25065-1-sashal@kernel.org>
References: <20191122195014.25065-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a56dcc6b455830776899ce3686735f1172e12243 ]

This code is supposed to test for negative error codes and partial
reads, but because sizeof() is size_t (unsigned) type then negative
error codes are type promoted to high positive values and the condition
doesn't work as expected.

Fixes: 332f989a3b00 ("CDC-NCM: handle incomplete transfer of MTU")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 71ef895b4dcae..bab13ccfb0850 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -534,7 +534,7 @@ static void cdc_ncm_set_dgram_size(struct usbnet *dev, int new_size)
 	err = usbnet_read_cmd(dev, USB_CDC_GET_MAX_DATAGRAM_SIZE,
 			      USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
 			      0, iface_no, &max_datagram_size, sizeof(max_datagram_size));
-	if (err < sizeof(max_datagram_size)) {
+	if (err != sizeof(max_datagram_size)) {
 		dev_dbg(&dev->intf->dev, "GET_MAX_DATAGRAM_SIZE failed\n");
 		goto out;
 	}
-- 
2.20.1


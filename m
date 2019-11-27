Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA16C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28B21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887401;
	bh=luqP4xoGP1K9bacavhN3oKuBE214qMJYyj/o2cLvzy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1oOkpduresAfpuxAHRAQ6TrT+Hi09V3WP3fWzbHBbG3kd06DnnBEIEvm5BVIiLXW
	 LEQA6ex2Wmap+CE4IF+jusGrDDNc1yfgjFoiKZhwwmZ3FwPLWKriLxLStIAHJDlnEL
	 QHm8cUY5FIbYoOKXjWvhJJbh5GFV1WQeS5HMkADo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfK0UnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfK0UnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:43:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938BB21780;
        Wed, 27 Nov 2019 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887395;
        bh=luqP4xoGP1K9bacavhN3oKuBE214qMJYyj/o2cLvzy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q22AyfxIPYneqZMW2cvwCBgwqW8YTjoAytZdBhgrqZiR4xc0k2rl6Z7SPtn4nrROK
         kr9ljNaBibp/cCbFX4vMIWTO91Dyo6ISnclCzEC2y9nmTNjRugmKhTSpxGzf1+yTh1
         g/rTcAVdFF2W/KSZ2BxCs+gE/A8H/5hwlBnSMb0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 093/151] wireless: airo: potential buffer overflow in sprintf()
Date:   Wed, 27 Nov 2019 21:31:16 +0100
Message-Id: <20191127203037.520387798@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3d39e1bb1c88f32820c5f9271f2c8c2fb9a52bac ]

It looks like we wanted to print a maximum of BSSList_rid.ssidLen bytes
of the ssid, but we accidentally use "%*s" (width) instead of "%.*s"
(precision) so if the ssid doesn't have a NUL terminator this could lead
to an overflow.

Static analysis.  Not tested.

Fixes: e174961ca1a0 ("net: convert print_mac to %pM")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/cisco/airo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 69b826d229c5b..04939e576ee02 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -5472,7 +5472,7 @@ static int proc_BSSList_open( struct inode *inode, struct file *file ) {
            we have to add a spin lock... */
 	rc = readBSSListRid(ai, doLoseSync, &BSSList_rid);
 	while(rc == 0 && BSSList_rid.index != cpu_to_le16(0xffff)) {
-		ptr += sprintf(ptr, "%pM %*s rssi = %d",
+		ptr += sprintf(ptr, "%pM %.*s rssi = %d",
 			       BSSList_rid.bssid,
 				(int)BSSList_rid.ssidLen,
 				BSSList_rid.ssid,
-- 
2.20.1




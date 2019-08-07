Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B342C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2215222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IhyWC51n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfHGQdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:33:51 -0400
Received: from gateway30.websitewelcome.com ([192.185.152.11]:20328 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729278AbfHGQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:33:50 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2019 12:33:49 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 81769183F2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 11:13:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vOYuh80BD4FKpvOYuhG78f; Wed, 07 Aug 2019 11:13:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RDLih2xLWqp+jClGe6quPxx2j3NmBQT7gXxnFLBcjPI=; b=IhyWC51nLhTrjc3Vu16cl6sJ2G
        s9ltt4Pt+NqZlV9CIrKWPURUTLN8cPdvJ0HvpO5m1CsjLff9dgV/lP9thSiNTZJbBUslbCrJHHYhc
        p4nMhqr/IOSY5a/guns9P49UhBLpexJrh3kDoShOrDRw4LczwgjN3lOp+tj340g3v+o9TZ8iw5k+f
        NusgwMbGUySHojHyu+VDpevlDA4y77iu9KgCcmkINyyprQrScRVY7n/PsaapB74U/dQbW1TFc26nm
        QBzuWEHaA+dNdwxXH6Jt2y1zIsXvZ5txKv7D34NGHHrkWYiLiq29TdiywNlRiSqQlwAENCxm3E+Xz
        /OMfnK4Q==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:45386 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvOYt-000bPc-21; Wed, 07 Aug 2019 11:13:15 -0500
Date:   Wed, 7 Aug 2019 11:13:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] video: fbdev/mmp/core: Use struct_size() in kzalloc()
Message-ID: <20190807161312.GA26835@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1hvOYt-000bPc-21
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:45386
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct mmp_path {
	...
        struct mmp_overlay overlays[0];
};

size = sizeof(struct mmp_path) + count * sizeof(struct mmp_overlay);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, overlays, count), GFP_KERNEL)

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/mmp/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index 0ffc1b7b7052..154127256a2c 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -153,13 +153,11 @@ EXPORT_SYMBOL_GPL(mmp_get_path);
 struct mmp_path *mmp_register_path(struct mmp_path_info *info)
 {
 	int i;
-	size_t size;
 	struct mmp_path *path = NULL;
 	struct mmp_panel *panel;
 
-	size = sizeof(struct mmp_path)
-		+ sizeof(struct mmp_overlay) * info->overlay_num;
-	path = kzalloc(size, GFP_KERNEL);
+	path = kzalloc(struct_size(path, overlays, info->overlay_num),
+		       GFP_KERNEL);
 	if (!path)
 		return NULL;
 
-- 
2.22.0


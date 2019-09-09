Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4456EC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A41218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfIIIjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:39:48 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2384 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfIIIjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:39:48 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 04:39:47 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25d760d96739-c508a; Mon, 09 Sep 2019 16:30:14 +0800 (CST)
X-RM-TRANSID: 2ee25d760d96739-c508a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d760d93853-071fb;
        Mon, 09 Sep 2019 16:30:13 +0800 (CST)
X-RM-TRANSID: 2eea5d760d93853-071fb
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: Fix dereferencing possible ERR_PTR()
Date:   Mon,  9 Sep 2019 16:29:56 +0800
Message-Id: <1568017796-27513-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if ovl_encode_real_fh() fails, no memory was allocated
and the error in the error-valued pointer should be returned.

Fixes: 9b6faee0747 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 fs/overlayfs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index cb8ec1f..50ade19 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
 				ovl_dentry_upper(dentry), !enc_lower);
 	err = PTR_ERR(fh);
 	if (IS_ERR(fh))
-		goto fail;
+		return err;
 
 	err = -EOVERFLOW;
 	if (fh->len > buflen)
-- 
1.9.1




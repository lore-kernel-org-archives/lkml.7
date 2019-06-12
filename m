Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E11C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC16421734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560353685;
	bh=20hqjh+MXo6Qxzy1dhGmE3uoA4SiBX7IxlIyx0j0IYs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CkDK7WohGxzi3sINLINSctdABbzA/1i2Wvm5egoeSQ6gKgMkP5gR93FG52BNx9AZN
	 v4oHH0Ch2zniq3nOocscYdywkr+Qo769yM6m7a5nkU/8e4Gn/GTk3nZf0l8iUl5HUI
	 KKFFLIojtH9LJPNpmhz5mNrd2wENH1u4UyXjWlu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409403AbfFLPen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbfFLPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:34:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D533215EA;
        Wed, 12 Jun 2019 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353682;
        bh=20hqjh+MXo6Qxzy1dhGmE3uoA4SiBX7IxlIyx0j0IYs=;
        h=Date:From:To:Cc:Subject:From;
        b=LPGgObTpxPnej03XvQHzPjEivCYDLS7/XbqqIq0RU6UjA3jyQR4enj1fFrv+gnVR+
         j4ZmhARUkr3NGbaLu8QJpoMsO9xoRKdriHNNNeL5t9tsksHa4xL80tTe/lWYi0TXFQ
         FHDzkkKj774IYESHgf6TetJoVoD6DOQNvEygm0+Q=
Date:   Wed, 12 Jun 2019 17:34:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haren Myneni <haren@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: 842: no need to check return value of debugfs_create
 functions
Message-ID: <20190612153440.GA21006@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Haren Myneni <haren@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/842/842_debugfs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/842/842_debugfs.h b/lib/842/842_debugfs.h
index 277e403e8701..4469407c3e0d 100644
--- a/lib/842/842_debugfs.h
+++ b/lib/842/842_debugfs.h
@@ -22,8 +22,6 @@ static int __init sw842_debugfs_create(void)
 		return -ENODEV;
 
 	sw842_debugfs_root = debugfs_create_dir(MODULE_NAME, NULL);
-	if (IS_ERR(sw842_debugfs_root))
-		return PTR_ERR(sw842_debugfs_root);
 
 	for (i = 0; i < ARRAY_SIZE(template_count); i++) {
 		char name[32];
@@ -46,8 +44,7 @@ static int __init sw842_debugfs_create(void)
 
 static void __exit sw842_debugfs_remove(void)
 {
-	if (sw842_debugfs_root && !IS_ERR(sw842_debugfs_root))
-		debugfs_remove_recursive(sw842_debugfs_root);
+	debugfs_remove_recursive(sw842_debugfs_root);
 }
 
 #endif
-- 
2.22.0


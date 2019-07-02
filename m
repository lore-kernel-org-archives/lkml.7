Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F4C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A083216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeKCuuuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:58:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:58:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so6944933pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/7tczepEzqTlmdybJcXMyIiLXAAIYH2wxpVMMpPnygI=;
        b=YeKCuuufxt1rPwf9tFm3JoYgmAoX8/7P77uCZJXLc34ku8ooPUW6fm90JBYOr7fonU
         Ec9Th7cAjR+DQOigpd7hJnJmSLu0cOtx1uyOAuNSPE/JBg0hDPhlena8qQNlhW0TW+cf
         jV0gQMltaEN3EWijsKA5MjLkCYgimin7zrHkZN7HipFBIKEQ4mZW7pvVbdTOcf/q4Zcy
         +8zftBaFi4ny41YIfIp7UGh1JQVwoGDoxA3fyhln1QGOlx+2NFWYYuGKFCwdV8m+e/ZR
         b9pPgJIHL86/YaD5/NNB42cjlsBPYnTfenXY+14o15yMX4F8QW1FwEjn/6cKy0UdB5M7
         E5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/7tczepEzqTlmdybJcXMyIiLXAAIYH2wxpVMMpPnygI=;
        b=mhP1SxHzXYqoqcnmtTqTNQy13qGElJjF9CamWvn/K4V1CS+t0AH0Rt7VLYm67LvLiq
         0obF0lT/Lx+UC7qVaaTAacYvUNWXmKLGR5LdTvgBXDEuYI1ipEj4Nu5tPXNjKn73tuct
         1LCwZLJehaBvtGPpwN3ScAx4LFQJaj1KjNrMxS1WEL3xUWkaOXwi+ZTK1I19D6RrW8PV
         pCOLRSNQzh32tueJQk8FYuNcLH4m2vw1zw3cLHy6Mk5Vcqu2wzKfxlbTFbuHU0o1rLYJ
         Dx7i1Grbe4PyBlp3AejdO7gKUa0g6jDJmBv3wGMQnZnI77tj2QJEVsvo9sHeANxb0WsY
         XesQ==
X-Gm-Message-State: APjAAAVjJB1VANfsZwFPrqVVFfO74qaKcm1h0dPGX/NR6HHPpFxfee6x
        otjDNJXY95p9ew6kgtwpshM=
X-Google-Smtp-Source: APXvYqxwIeo9k12FDWXw1KWHtI7qKb4pB//KHdHVifTgoV2Vgw9mYCBFEQh08tMtoqU0COrGYsUgzw==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr15007946pgc.276.1562036325159;
        Mon, 01 Jul 2019 19:58:45 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id r198sm14506893pfc.149.2019.07.01.19.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 19:58:44 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode check in fill_inline_data()
Date:   Tue,  2 Jul 2019 10:56:01 +0800
Message-Id: <20190702025601.7976-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
no change

 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1


Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D680C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79FA2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1c81wXFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKKCZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:25:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43905 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKKCZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:25:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so10176805oie.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HCu3swpM3JCV50k6ZcWSUdcyGBcr8prizowXxNin5Yo=;
        b=1c81wXFNSIu/f5fEVf9F9KjN7P15qofCc6uZH0bEYDARWq6otCYYqxViEA7zn/GuTt
         fBRIKGe1PL57LSVi3Yl3pQHHul9djPae0Kc1yncngkqj3Wid+l1YMDlV6S6RQt5j8Sdj
         YWJIZrjtEfUzFfGQhSF8sAEHJ9QTaR+Zfw9UyWPPVZtMa3o4iHIChTFYwrYErBZLGxwW
         DiTEhgei/DHqST5qT9oUjPX01Un0umf5uYPwuVEY6xbo7/jUIehB9cGBGm59Rf2ebLP/
         /TGEBJvDkf7oyyqXe0D+WKa1CGbwDO8iUQTTQYFmyvAF+RPs3XOEyLljvIas1GRP0n8N
         Z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCu3swpM3JCV50k6ZcWSUdcyGBcr8prizowXxNin5Yo=;
        b=j5Epmn/JZ06L8YvZd1QBjcfbQnmlo9+5oHOw+Emw7PMXaR1fDOqQh6fDcVlMbKzAJF
         MfGcfpakL6oc5bgs7Anwz9n8u8DyDTi6s3b87DKg8qseG5490oBvpDjMP+GOyQNrL214
         ci7oiNuKppst1HZP4AVhgGx0LzfDYT9OD8qP45mZ/qJw7F6fWDDnTMeR88sJklMMERem
         F8mMAy2D16GtfTjrLxCu6nmYI3cOoE0iZJroT2xRquc7Eeey1oQZtY50oUZrdLqGDpHe
         wdUcbZwnOpfr1cVRh8poIfZsmsjwjLCjfEIwZ0tO0krz9JstxEdN2efa6f5YzA7Fa2CM
         bArA==
X-Gm-Message-State: APjAAAVbHeOC0jRILFzPE6Hgd89d5cs9XpVBEYeJi7Evd33lx/tlzKuu
        gO7oLapa96IHxF88N2j+nKqEZJotGyEYyLFx
X-Google-Smtp-Source: APXvYqwO9M4qZjpZYl652jcC13m4seu86L7WZZYHJBH8yXU/VmSJT0DU8se+/bybcXOe14AMN2IPAQ==
X-Received: by 2002:aca:39d7:: with SMTP id g206mr20734392oia.101.1573439130470;
        Sun, 10 Nov 2019 18:25:30 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id e19sm4363985otj.51.2019.11.10.18.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 18:25:29 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] fs: ext4: remove unused variable warning in parse_options()
Date:   Sun, 10 Nov 2019 18:25:23 -0800
Message-Id: <20191111022523.34256-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for
dioread_nolock") removed the only user of 'sbi' outside of the ifdef,
so it caused a new warning:

fs/ext4/super.c:2068:23: warning: unused variable 'sbi' [-Wunused-variable]

Fixes: c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for dioread_nolock")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f3279210f0ba9..ee8c42d8a04f0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2065,7 +2065,7 @@ static int parse_options(char *options, struct super_block *sb,
 			 unsigned int *journal_ioprio,
 			 int is_remount)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_sb_info __maybe_unused *sbi = EXT4_SB(sb);
 	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
-- 
2.11.0


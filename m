Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA434C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7915720840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJeOPnGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCHAe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:34:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36044 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHAe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:34:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so15034940eds.3;
        Thu, 07 Mar 2019 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzDbEfVZ0JKScB+VD8mAu8ZcFBVdjaYxgrBDjaB0nn4=;
        b=jJeOPnGQjXHIM2zOOmzam7TFLhCAAp+gn55olh1C5UbXQ7VUIy0qDyKImzxoYYJJOw
         8xEvtWtPCPwCJLdtAEVpCgRNtjQ8y1UKHl3asOIdo7QnaFlsVZ4ES7q1IoyHNBI2ZnIR
         WtLZepoAlE/7Dk1/JT6Qw61rtrb/XytITeqqPwRO4e0VO0wkJ/0JvS2f6NgOe+XTXhG3
         UFa3/HeGKrOcOoiEO0Am7o8omNJgNifrsREtqaJwFifNwPQrkb1tQCkIJu61JrDN1XPx
         t+kLCctAgh+HvTfFLoAkbwuOIlTVti2+3dIhDoplfD2qe91ib/+b6KtkjqBHnkMHJFqy
         JYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzDbEfVZ0JKScB+VD8mAu8ZcFBVdjaYxgrBDjaB0nn4=;
        b=mhvM1jaSNZNO9tXsOWwCbU6ZR6Y9j31Q4TOmUNrV5RcSfP7YflXY2WU0S5+RCi/KOX
         34JC9l8/L2wR+klPaqngIvYOAfEF/UPM7bSBLpNh5U6voIccVXsbXGboewKOGP1P3Ucs
         K92BM56S/c/EAIGGRGO3iGYBjnyVt8yggSa3kBvTDl01i0467gWuJLMWxRfFfVG8klZn
         pGc1msgG8gSsNVtB+nzFlSVrORPyvoB4VXcWTk5d8jeLJKdi8PbleUEh8fTNMADxWrgB
         2sNc6JgK1bhAj8c6BbclUltLfiFwoNYkYWNUT8U7ReCt+RSD/yjB7RZNCeBUdNpToK70
         jGpg==
X-Gm-Message-State: APjAAAULY8gOyiFusRdXNjume5NYiB6GhqUpSbwiu3w5eSU9Hqrhrd2U
        VJTeg9LIOmjVt4y+4j4JXYI=
X-Google-Smtp-Source: APXvYqzKfKxWW+sLft20azD1DIH1II0QkoCKDIdHrg4ZWqd/5Iuou6qE8kmo2HM3JgA12QuXXQbf2w==
X-Received: by 2002:a17:906:3d7:: with SMTP id c23mr9698330eja.138.1552005263829;
        Thu, 07 Mar 2019 16:34:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id i19sm1135241ejh.44.2019.03.07.16.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 16:34:23 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] xfs: Zero initialize highstale and lowstale in xfs_dir2_leafn_add
Date:   Thu,  7 Mar 2019 17:34:13 -0700
Message-Id: <20190308003413.25068-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

fs/xfs/libxfs/xfs_dir2_node.c:481:6: warning: variable 'lowstale' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
fs/xfs/libxfs/xfs_dir2_node.c:481:6: warning: variable 'highstale' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

While it isn't technically wrong, it isn't a problem in practice because
highstale and lowstale are only initialized in xfs_dir2_leafn_add when
compact is not zero then they are passed to xfs_dir3_leaf_find_entry,
where they are initialized before use when compact is zero. Regardless,
it's better not to be passing around uninitialized stack memory so zero
initialize these variables, which silences this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/393
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/xfs/libxfs/xfs_dir2_node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
index 3b03703c5c3d..de46f26c5292 100644
--- a/fs/xfs/libxfs/xfs_dir2_node.c
+++ b/fs/xfs/libxfs/xfs_dir2_node.c
@@ -444,6 +444,8 @@ xfs_dir2_leafn_add(
 
 	dp = args->dp;
 	leaf = bp->b_addr;
+	highstale = 0;
+	lowstale = 0;
 	dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
 	ents = dp->d_ops->leaf_ents_p(leaf);
 
-- 
2.21.0


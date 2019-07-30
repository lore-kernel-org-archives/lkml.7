Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FEA2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEU9KPKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfG3BvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:51:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37831 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbfG3Buj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so28239426plr.4;
        Mon, 29 Jul 2019 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1RF9tSxg4ftPaCa44wQSYVO8OxIT8+s62dDQIN7bX2o=;
        b=iEU9KPKEpUOeQc+TDqw/j8EP61bJbMSCI7uNc6Xdq7LWM74Uy1YzbFeoOmrAwxgSNo
         Ay+T+mES8hCLhp7bAwoC6cNDFauOvqOKRflK8MpN3lRzXW38Qo6IFTbh8Zhz3FkSveuo
         h+pnt/9QISKNzrEL//VZ6KZp5mmpTnX6FZ0Vgi1PB6wn1B8qQkSdsGK8X5dgHsRTT/Se
         9SsWbtD9Abw8gA3Xxi5lzsPoCXgL+5sRVQezJJK8gOTmAyWdPJ1cdqIwdcSXUCQQWL3h
         mGhI3EpiMtJuauLsd7nYM23xklau+V7734ZHdWkigGIj+iNIxHPEDqWqFKgU1F2nQt3H
         ZWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1RF9tSxg4ftPaCa44wQSYVO8OxIT8+s62dDQIN7bX2o=;
        b=LYm062RJVh+eTaIIZLex6Z3hqE1h0jiF7sifGVzE30Rb5MdrNXvZlN4cwvPbPa5Tsz
         DFgU30+Ejbqf8wJaOg5pU2dERBHbUPqwrJ9/dmKLAezw0l/gkUNbhwu1jVfpVGdE2pSN
         jHSZ40yQ/Z6iuVuabglXhYbcmzvs5VCpZ5mZUnQ+xNLeQ/QC8W+mjYouYn7J1h7ps3M+
         3OsQz4dCaV2sy5OW42/OQfUqrBX/KztW3khrHC2D7g01XmJtBzEYcSVsTKbaLb2slxwL
         PuC6FXw84BC2cscM82DJfnwk3nGQYHiKtzcY5bJ3qmcdRK6DEWCxi5OiriuPS26WR3a9
         8xYA==
X-Gm-Message-State: APjAAAW2Phsz2JflbQSTX61/uJttCzTuHEt5sFPIMIHQRV1kWEdlqUyL
        UOyF8mUM0izVuo4W9qpGm3c=
X-Google-Smtp-Source: APXvYqwbh2HCKG+rqxkUOX27ALuwe+xOKD139Cl19RTPM9CGSWVCglZ7EgjUivdAahWtSXC/XiaSDA==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr109757855plk.91.1564451438988;
        Mon, 29 Jul 2019 18:50:38 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:38 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, me@bobcopeland.com,
        linux-karma-devel@lists.sourceforge.net
Subject: [PATCH 18/20] fs: omfs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:22 -0700
Message-Id: <20190730014924.2193-19-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net
---
 fs/omfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a835ec3..b76ec6b88ded 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -478,6 +478,10 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = 0xffffffff;
 
+	sb->s_time_gran = NSEC_PER_MSEC;
+	sb->s_time_min = 0;
+	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
+
 	sb_set_blocksize(sb, 0x200);
 
 	bh = sb_bread(sb, 0);
-- 
2.17.1


Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0423D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lqTAy0ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfCOHmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:42:55 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:32894 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCOHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:42:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 53A80D3D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MF_tLOxjzHpA for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 02:42:53 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 26F82D10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:42:53 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id c2so6286551ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o2ADGufCuxIAT4soQw3JMLB7pYqNLiLeR85PAz0yM0E=;
        b=lqTAy0mscZgZFcHHHMJwTfpsWitHRTru4MSKjRTaiSa3NoDq9+/J7vSv7vG5UBLFI1
         0pzryCtiE2imLPydQuQnZRK8/nxaGYAqPZLeklHABquDHodYff5CWPoJiiKHHHU/bvZ8
         q4xglO3g8zCimPz5rj7gIiQ0zpgnuNAc7Bp2vPWynP+arOW4WhtzEQBVp9aW7u4YtByL
         HElbYs/wlF++k1V4qRLrgFLvnLoaDWbwJHI4peB9BWBzCQ/3+iPHukBPwd33TlpMpC1Y
         s71Jirwb6OZR2gOVEhNVcEs0DfA0xiNlnDjT3k1SGTNFpuB5MnCjclFE1s+ZnX2PYNIt
         2ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o2ADGufCuxIAT4soQw3JMLB7pYqNLiLeR85PAz0yM0E=;
        b=caVVwFxVg0Q0VlQaPxW3Ud0qp4uVJpsEVQubTZwPUCEXxg4TmrTSNgex5gsajzE9YP
         U0nauMvdagJNxHJndpWnNyK1E6EDNx/NuApFlfGRiCotr3oJAgjUbcobS5axyfENIdaU
         CmURL/dkozXsHI/LWf86Ghh9M6HRlYLhTPvTauyuG5f52UKYKKFAUlL8YasBJ1Td2qRi
         7X5La+M9+46Pu5b2gLtztxDvpEyX2b2+pRf2t+2Ie35TfogzkU+ssO69uBesXOWzZ+WU
         Rx3R4LtTuwFhfplFWTrKkvr7m7/bZFSyauM2OaaSXUILu3F0/KCzdfqa5zA6VgPTepXO
         dPFA==
X-Gm-Message-State: APjAAAXRIRVioeB97YwP2cao1T2bYV7lQ+95BOybEhjGgd4YSLI+oKM4
        QZl/kgmR+GbCzAAOa79QC6q9axjaMgQHtpQQliiQQHmMB1qrKkA4oYtDqcmyoYgYn1hvmR/vlvI
        wHhPDVDA+VqHwWOh0q5KWIyfd/Hwh
X-Received: by 2002:a24:2812:: with SMTP id h18mr1127900ith.173.1552635772770;
        Fri, 15 Mar 2019 00:42:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyarjbyBKYUS2hIjS3/9z24WEo/774xS56yER24rLMu6sBbl09xZ0G6kaDGenWb06nXXMCiog==
X-Received: by 2002:a24:2812:: with SMTP id h18mr1127883ith.173.1552635772454;
        Fri, 15 Mar 2019 00:42:52 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id w19sm650791ita.33.2019.03.15.00.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:42:51 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, David Sterba <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: affs: fix a NULL pointer dereference
Date:   Fri, 15 Mar 2019 02:42:44 -0500
Message-Id: <20190315074246.26426-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If affs_bread fails, do not use ext_bh to avoid NULL pointer
 dereference

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/affs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index a85817f54483..29cbc8eda085 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -941,8 +941,10 @@ affs_truncate(struct inode *inode)
 		size = AFFS_SB(sb)->s_hashsize;
 		if (size > blkcnt - blk)
 			size = blkcnt - blk;
-		for (i = 0; i < size; i++, blk++)
-			affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
+		if (ext_bh) {
+			for (i = 0; i < size; i++, blk++)
+				affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
+		}
 		affs_free_block(sb, ext_key);
 		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
 		affs_brelse(ext_bh);
-- 
2.17.1


Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD451C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E52A20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuK5zbEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfFRQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:34:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43011 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:34:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so7959164pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxDQL9GgjzWaRaA2EXv46RSRTEziDfpy9C7Cc/aMUTo=;
        b=IuK5zbEtumCGEVO+M95zgIPLSoHM80jvjDIHH3aB8i5itoV5++AeLukMeJUQJevVRX
         JvpcQjrMIxuqQnzZq6W5DE75LD6KRKjJ+cwdpOuHF8h8E6YpGUil//KPhnO5E3cKuNA5
         SP5lVgPfv8dYAbxOxcPAna+aQCi5MrZBERoEi42AZQEgSRAWW/DXrcKGYUTj3MO7ms+k
         ypUcd8HgV1MleTbvnSep+BKKheFuVCEeFiO/cG0zUHKA4p2Rx+M/YjIhaTpgvpDAA/QX
         510Mnfy+uRLtrwE+wj551G5O9AgNefwGw87zZPE5cz4TQ0fig1vRx1nQZnzRYIjjzFW9
         tGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxDQL9GgjzWaRaA2EXv46RSRTEziDfpy9C7Cc/aMUTo=;
        b=sBvqU7DXET0TNPOoKDgo4CZKdWqk0hdwCBEWjrGAM6hJl6anECSINMV+21JOqNj+9G
         DDq80x4JqXuchngesoAgiwe0JRECVl/miSkyB0sL/MYOo5C8XJwgh2H0RzX5j4jbhbg4
         DBN7a3e4cUkWoxbScZkV3q4/mokzxl/Ouk7qRS9vcLbDO5XZHwE/9E94g8LG/GPm0IPK
         BfVMmPs2K7XTxWKaoVh8KgcEqiuiHs30jhHOtRDvrcbsPE+po5CcPVYtn6OUfx8Vdqgb
         BK6m0BxSCq6jaEkwuyIs6P6hlELMa05OuKcXZch7DqtMaL0mn8efRGVQdMx9GFrbmGhY
         LxBg==
X-Gm-Message-State: APjAAAUWD9VQ70EM8fJJ0vpqC60xAfinFp9aZSOe7+U8n8LqT9zM/uu7
        8yA/wXlLFBdhgCzNOfE616Y=
X-Google-Smtp-Source: APXvYqwuc+ppDffBpiMRW/Q2jqW+a9ountkOWf50NQoK96phgaWJsmVrllN7pasn7CsfLCMDPIacCQ==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr86080378pfd.194.1560875665996;
        Tue, 18 Jun 2019 09:34:25 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.128])
        by smtp.googlemail.com with ESMTPSA id z22sm12103041pgu.28.2019.06.18.09.34.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 09:34:25 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 RESEND] fs: cramfs_fs.h: Fix shifting signed 32-bit value by 31 bits problem
Date:   Tue, 18 Jun 2019 22:03:52 +0530
Message-Id: <20190618163352.4177-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
32-bit value by 31 bits problem. This isn't a problem for kernel builds
with gcc.

This could be problem since this header is part of public API which
could be included for builds using compilers that don't handle this
condition safely resulting in undefined behavior.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
V2 - use the unsigned constants for all flags, not just one
RESEND - Added Nicolas Pitre to CC list, added reviewed by tags.

 include/uapi/linux/cramfs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/cramfs_fs.h b/include/uapi/linux/cramfs_fs.h
index 6713669aa2ed..71cb602d4198 100644
--- a/include/uapi/linux/cramfs_fs.h
+++ b/include/uapi/linux/cramfs_fs.h
@@ -98,8 +98,8 @@ struct cramfs_super {
  *
  * That leaves room for 3 flag bits in the block pointer table.
  */
-#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1 << 31)
-#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1 << 30)
+#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1U << 31)
+#define CRAMFS_BLK_FLAG_DIRECT_PTR	(1U << 30)
 
 #define CRAMFS_BLK_FLAGS	( CRAMFS_BLK_FLAG_UNCOMPRESSED \
 				| CRAMFS_BLK_FLAG_DIRECT_PTR )
-- 
2.21.0


Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DA5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EC0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvQj1OBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbfHATLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:11:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41521 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbfHATLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:11:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id t187so225306qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avLc3lO+Ey/3jM2qXMI8h6ADbx1TIzf6RcD98NQeRnw=;
        b=WvQj1OBBHc0Qp8+uf+/uAyzcW1E0wlXOomYPe+1c4gzS2D1W7QS29h/geHlub/OmD8
         gvisfzwk7rVFBXsfzLqcHyCzbnrn3waVjiPo1bifkaAPVTwRCZoONOMREIaNf6PFd7kq
         SicdZAQ1ZnsE2gyOHEl+6DUAIEn+QwuPGEOLV0PbEZntk743WCCLr8J63TETgguSBGMP
         +XNgCIQiZYc4hOtyr9E9OKEaxc24dPdjBGWYytNAivoifyO4g9Ay39zaYaX/s+HQ9Rvv
         SM+ecP/UGhxb8J4Jq2ksFa3yueEJEipYjmmEjug0iMy78USEH4irj0t1u+1UPdqmZLpY
         PyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avLc3lO+Ey/3jM2qXMI8h6ADbx1TIzf6RcD98NQeRnw=;
        b=fRP2cZGCsJ2DZUL0GAAjxX2YyaycRL6mkDpq+k8jlWZhKsOWHdYyzQVtvDkxeKDWoM
         FcETI7aCY2tuQPmLsXPrLFZRAoy/QLiY5berKbE2v8vrvLK/s/JKi3P48lhvWVYY8IgC
         +XwddN0BEMxYdeGS/JPTlhaTZzirJg04Nqw86VYMBQC/Qqi4LfvBRO9pRcSgBB00knZ1
         iVv7+AepQA7yhsYo5PQ/SgTOsJp8A803ub7GAoQjkX4pepq8jsHp9OQkKQBCJH4qnODH
         mCqf7DWxb7sY9vCCxrGpSi2c9z6AGVcWZAGK1V7QSTmOBc84v2pu/TSHmF3WZjolCrHK
         l9Cg==
X-Gm-Message-State: APjAAAXKy45IjvCC6i4r2lftlGI55V2rlbL3/F4lS+wzO/tHyyERagWy
        C3bqPi3yPBvr3vCsGsmr2w==
X-Google-Smtp-Source: APXvYqz3drEiFjPn37tkkcqdRfH8qajKlRih2mx+QvSq5Q2oHyAmoRom4kH6Ydo27mAuvDxTwcE4JQ==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr81260277qks.366.1564686674076;
        Thu, 01 Aug 2019 12:11:14 -0700 (PDT)
Received: from cpp-rtp-gca-06.cisco.com ([2001:420:27c1:b05:225:b5ff:fe00:81d])
        by smtp.googlemail.com with ESMTPSA id f22sm28534409qkk.45.2019.08.01.12.11.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:11:13 -0700 (PDT)
From:   Adam Drescher <adam.r.drescher@gmail.com>
To:     talgi@mellanox.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] linux/dim: fix comment for enum dim_stats_state
Date:   Thu,  1 Aug 2019 19:10:44 +0000
Message-Id: <20190801191044.29046-1-adam.r.drescher@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace duplicate DIM_STATS_WORSE in comment with correct names.

Signed-off-by: Adam Drescher <adam.r.drescher@gmail.com>
---
 include/linux/dim.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index d3a0fbfff2bb..2fc0740ba55d 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -162,8 +162,8 @@ enum {
  * These will determine the verdict of current iteration.
  *
  * @DIM_STATS_WORSE: Current iteration shows worse performance than before
- * @DIM_STATS_WORSE: Current iteration shows same performance than before
- * @DIM_STATS_WORSE: Current iteration shows better performance than before
+ * @DIM_STATS_SAME: Current iteration shows same performance than before
+ * @DIM_STATS_BETTER: Current iteration shows better performance than before
  */
 enum {
 	DIM_STATS_WORSE,
-- 
2.20.1


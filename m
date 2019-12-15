Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDCC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557A5206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cnNd13+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLOPok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:44:40 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38870 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfLOPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:44:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bTH90rtlz9vZ66
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 15:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N7Y4EzEUsrhx for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 09:44:37 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bTH86nlPz9vZ5l
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:44:36 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id v186so4583177ybc.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MaXjt0FsXUXsO6312KufDDg3uo/7OWWPMETqU4hGeg=;
        b=cnNd13+MtvIB7XKLTmQwE4VJKaQjPQ8wtnZCXQsg33NjgkokHMxaaT5QCrTgssaHde
         POVQXccfXfAiF9O+b2ys327nAtgo48KwfPbgYIvTpe6B8IPeOhgiJanctpNfwK7v775X
         qk2EJ2OKcHECm5gPYILCmLyU99qG+xCJijZ7lBUzlyZwI+gIe9UmmGJW//jWfUsxakyc
         6es+JarwGukRoGu1J/Kiq1gdwfUgUVPfXTMi43KIqvtOzoC8G1GJ21bd3PikdG+QALT5
         wwyD3GZ8nHLMqxrLYwIJX9X7bYEdR1hhlWXiCwufFOhGlmvTvBUQTWUI2XkhGCXV//uU
         vA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MaXjt0FsXUXsO6312KufDDg3uo/7OWWPMETqU4hGeg=;
        b=JJLPRAo/kfmosvk6Udyfox8Ioxme/U5o8qJoxeFm3CFVHYqKFuAxn0VuuONvI2imFS
         en6fGWR+8UVm+e+IJ7X+L8rSR9dvtbCztcTxqYBvwClT25BINLRWrVylVryYeEOsUg0m
         IvM94f2lLU+wHDErcP4UDdnAuXkiP7mItWEmQ4mNV+tyPlUaEiWUQtOi8TGr26pDVGG4
         7ulgQpbVV/r5KqTKC70GQqysG/maX8KiUF5cKtsHj8IwWW6jdhjZoBmR0pLWn/UHb/4s
         RFE8WEopIMjkCKSe7ylgK9VZz5o2Ff/HRTu8plmmIC3lnt6wyzYMBqYiUIbkupicm52E
         TZSw==
X-Gm-Message-State: APjAAAXoixs6d0GyJQVethODyyIW22Vi2CVleVnHynClYaeNX0iYjhYO
        typEx0aDYiOJy8rTWwdU48I/bjJQ0gnujitDLHd6m+k1eGpncJrCvQcb2AwyZ9mUj1J7C4vBKMa
        0Mul+yEFQ1HVVVL1EymwbQPNiIpkS
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr9032685ybk.206.1576424676491;
        Sun, 15 Dec 2019 07:44:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfT6IU9GI6GwDtKMoF1A0NCGhTTkrNK7he9FRqEQKmqPMb/HlUzknbmIsjfrz3L+8vuWgxiA==
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr9032670ybk.206.1576424676248;
        Sun, 15 Dec 2019 07:44:36 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id s3sm7164142ywf.22.2019.12.15.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 07:44:35 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Replace BUG_ON when fp_old is NULL
Date:   Sun, 15 Dec 2019 09:44:32 -0600
Message-Id: <20191215154432.22399-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fp_old is NULL in bpf_prog_realloc, the program does an assertion
and crashes. However, we can continue execution by returning NULL to
the upper callers. The patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 kernel/bpf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49e32acad7d8..4b46654fb26b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -222,7 +222,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 	u32 pages, delta;
 	int ret;
 
-	BUG_ON(fp_old == NULL);
+	if (!fp_old)
+		return NULL;
 
 	size = round_up(size, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
-- 
2.20.1


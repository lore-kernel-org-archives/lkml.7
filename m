Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF44C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06242176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prGhNzQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLPWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:53:52 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49125 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLPWxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:53:52 -0500
Received: by mail-pg1-f202.google.com with SMTP id c8so6059160pgl.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bQ8QzEXxNwLQtu5/AW8/kGSMklHAJ8d3m3TVrIuYDYc=;
        b=prGhNzQY+dB4zCw0ezsfaIwtISNKIg68DNEeWrUth5SGPGMbc0jTH6T70FyYbIhkMT
         9ND7sgbxXPxxLKt5JruEMT1MWdR6kfAA8n13xP6Pn/xy52wfaO64NIoNvTgEfhOOqKaJ
         76WCG6/AmZLLCUsAjmdIkIycPOnFhLh9pNYcn80Zfxj/Iis7oLyOe/hM+p+bhrrBtahR
         pbMyuIwVL+VWI34Qwii/KMDEhcqY3HujKkuHSMfj/Vybp7a9a3AeCnoCGSpDzs+Xt1li
         oXXhjALRERUa20ZEabdRBhRp+4UFFBq4ga131gP4L/Ndu9Bm3RqcF4BmFJs0yfu/l1o4
         5DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bQ8QzEXxNwLQtu5/AW8/kGSMklHAJ8d3m3TVrIuYDYc=;
        b=ghJ/7oc2FnMc/f86bQq+TN29/UbeFUCI0fnhFbFuK87mxopphJlVG5HoGcX4udoNx0
         MPNbkrtpyibO/g/IJT00qlH3j7ULduWXt3eo91BtzOzxc1J68dreaKeoAjWnmjHR1nD4
         LiLhSg7nN5f6GMGKLgIjQvfF9X90hdQciSTw32jA3KWleXQighLFOG+hRaUTW1O5mbbo
         2LSja8E2jIGYwazMP4+s4U+M1remwmxs7izkWpGWlXuG6xUNHnL/DRdJ6MpYxWheD7FA
         VdZ7CF4yOupbioa/n6QuqbqUyWgKN82StG7rWmB+R2deVSXFzkr1XkWXefjBzmYDzbNr
         HJzg==
X-Gm-Message-State: APjAAAX08LoHZn0fLmb1OOx27ZOv6bB7Lcl43p8reSVq4NZF1jPgBVk7
        r7/gWUQvmJU7VrWxgiaMwuJK6yU2zss91yOkDc+5VAKo3w2o2u03YCuN7AgGy3QbNNjHh7xeYoh
        E+0f6U9TJuqelTP0mLK2UvwQ9j6/XQpJfKOyVC66a9U/ELTNzE80fJr7qUdYktUCnn1TPiREjhr
        xDv7k/5sh/
X-Google-Smtp-Source: APXvYqwQktRybkzwjldGb4vFcdNFQCleasmAXuExKHiYGUlxF4zWzS1sPvE57rv7nspaGNvdhkLd28hE5s7AmwcBN6g=
X-Received: by 2002:a63:1344:: with SMTP id 4mr21762037pgt.0.1576536831465;
 Mon, 16 Dec 2019 14:53:51 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:53:47 -0800
Message-Id: <20191216225347.51643-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] Return ENODEV when the selected speculation misfeature is unsupported
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the control of the selected speculation misbehavior is unsupported,
the kernel should return ENODEV according to the documentation:
https://www.kernel.org/doc/html/v4.17/userspace-api/spec_ctrl.html
Current aarch64 implementation of SSB control sometimes returns EINVAL
which is reserved for unimplemented prctl and for violations of reserved
arguments. This change makes the aarch64 implementation consistent with
the x86 implementation and with the documentation.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---
 arch/arm64/kernel/ssbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
index 52cfc6148355..b26955f56750 100644
--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -37,7 +37,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 
 	/* Unsupported */
 	if (state == ARM64_SSBD_UNKNOWN)
-		return -EINVAL;
+		return -ENODEV;
 
 	/* Treat the unaffected/mitigated state separately */
 	if (state == ARM64_SSBD_MITIGATED) {
@@ -102,7 +102,7 @@ static int ssbd_prctl_get(struct task_struct *task)
 {
 	switch (arm64_get_ssbd_state()) {
 	case ARM64_SSBD_UNKNOWN:
-		return -EINVAL;
+		return -ENODEV;
 	case ARM64_SSBD_FORCE_ENABLE:
 		return PR_SPEC_DISABLE;
 	case ARM64_SSBD_KERNEL:
-- 
2.24.1.735.g03f4e72817-goog


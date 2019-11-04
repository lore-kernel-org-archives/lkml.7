Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307E3222CF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j06SGU3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfKDJDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:03:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:03:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id m17so6412769wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y0YQGawiwSeX4aHJm0zQu9hKirW5TWrGPsoV/UHqG+A=;
        b=j06SGU3hEgITu2qzYlzuVz3+fmvRaYPESNsw0LcNX+Tn1M5zqa8t+EOORwCH/TrVoN
         XypTKlEXD/bPtZm77J70tm60+KbhBuwmNTq1HfvuiL6jGsWxlXJi0VQJXVJD/kjwXyHe
         raQ0/1eRhR0cyffaJFkFpx1UPkaTxI9kzRaklsP4cBMZPPiPl4Sgmk3LSyOAwYzXdgZs
         OiiyUaE2tnCFjVhojatdB4PmCiXs0QRc+gPBU5tLyE1eTJzqc/GajdOqzvtbudZMdTuj
         2owZQUiTR0frGcA3ihMkKm6Zpx6YIlzLiOPnw87XMzHVV6DkSOTSqe+frUKYqxnoC5tu
         Kdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y0YQGawiwSeX4aHJm0zQu9hKirW5TWrGPsoV/UHqG+A=;
        b=oyyO1OkKvV84ZVie1d/mSutW/PNRgX/sk6AHwT9ozv/AVp9d00F0D11z4VZH7V+xrm
         1e2qDuJEqLxBfwINFyd4FEJdQrf8e5vEZDELC0lkXzGAjLLvzcT3uA8IfpASDe4Djwy/
         CtrS5eWmvg/WJ8KnPbNlNSgN6u9znDAxdEbV7AhWCkdw3eRY/ZINR7hn0hYn61zpMc30
         KX48Iop+bAqmrdEF8pvgI3VOAEGkgYOrQMk2oSSms5yFgbYoe6h92fIuKZg+vSsAkKhC
         K6IulRkW8ufCymep/d+1w31XMia6OiiBhaQ5YFuV8iYlCec6bSyASZ82SIX5hELb3wTR
         4ZeA==
X-Gm-Message-State: APjAAAXMIxGA7AiGA5nVyE6OZf2BNdTvkxt8vOSyyW5F/0sdzCg4vg41
        33ieF1/H6uT2XAi2lTKGkRk=
X-Google-Smtp-Source: APXvYqyzB0kpKaK7DNWgDow2t3UX95fOCqiyiE/7K8d3aaiwjANGr92vU8tnFFytW/NVUc8QZC/RYA==
X-Received: by 2002:a1c:3801:: with SMTP id f1mr7726259wma.44.1572858229634;
        Mon, 04 Nov 2019 01:03:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:a58:8166:7500:4997:f83a:5cb7:7659])
        by smtp.gmail.com with ESMTPSA id d13sm14493544wrq.51.2019.11.04.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:03:48 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] x86/boot: explicitly place .eh_frame after .rodata
Date:   Mon,  4 Nov 2019 11:03:38 +0200
Message-Id: <20191104090339.20941-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using GCC as compiler and LLVM's lld as linker, linking
setup.elf fails:
      LD      arch/x86/boot/setup.elf
    ld.lld: error: init sections too big!

This happens because ld.lld has different rules for placing
orphan sections (i.e. sections not mentioned in a linker script)
compared to ld.bfd.

Particularly, in this case, the merged .eh_frame section is
placed before __end_init, which triggers an assert in the script.

Explicitly place this section after .rodata, in accordance with
ld.bfd's behavior.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/760
---
 arch/x86/boot/setup.ld | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 0149e41d42c2..4e02eab11b59 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -25,6 +25,7 @@ SECTIONS
 
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
+	.eh_frame	: { *(.eh_frame*) }
 
 	.videocards	: {
 		video_cards = .;
-- 
2.17.1


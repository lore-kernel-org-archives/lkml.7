Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E8EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE26721874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmFDg61t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfCWLfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:35:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37822 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCWLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:35:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so3275423pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U48vP4N6X5/56S8YagJy7LSE2gmgpbkM0wkqFtxhed4=;
        b=DmFDg61tS+3pScXOg8D8Lv71bdMiq3KrTxASvFfbJIzPYnkMNgjKEkM0hrZ+DOhptY
         s2BptzwRhk7f/KmQNji+i21YGqCIIVAnUUcdahNCuLrBZVyLUPxIFEE9rc/vB8/x1BR0
         j3dly5dRE1Ias46i9rM3dZdAhWCvH6ZEV1EmLyEOHO3w9ZADNn9HpKjeadtPKapAiFGc
         IN4t69DC+TTZRS89tNFgd9gHWDDr4SvR61r8EnjykAg2xHNf/DuSgVYOrRfVXBRxLTS3
         tf++LmWb34O5FFcXyEUJccLurOc1nIfP2h3IDdn+5aElAFpTAIpWGFUkcl/QxoMciKlf
         GMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U48vP4N6X5/56S8YagJy7LSE2gmgpbkM0wkqFtxhed4=;
        b=VZTTxmSxAUM+qDKur+15+dGnqRGeVlpoymm2gnZkY+kP9WNwCDXKlHpXAomdmjX6uE
         s2MuLvfNmSKE88fgKoZbglj2045toDP3RsajKAxJoyMInvg4lZFPqCPY/gzWnqrtcIF5
         Zgw+hMqTls9JpuQmB8SSKxBOZd6QBOm544LGG6KK4Gi9LjR45eSuQk0xicClyEzHTEpR
         r7rtGvIEJxLZm/TxSNUPUqi33Ty/l2GvfnT+L5XAPkDYZFoCpU7EUf9H+iCK8b4MSyJA
         KkanUDVygZVb0Epi5PzQObF5xkWGMNuF5NkiOrjwOljOkGx9opfpRPL8/EARU8w36yBY
         u6Jg==
X-Gm-Message-State: APjAAAU5qXIjYJteiGmfS1q2iAbXzNyshYJecSZPTxJMVqRxg7C2hHOT
        LuZq9CpiVmI94hZ2A0dpzWg=
X-Google-Smtp-Source: APXvYqxSdi3uuZxuODk5EP35do/aiWmVHKw3pEEhCp/mje7selfgWMYJuoAWG4S9hl39RTcneU63ng==
X-Received: by 2002:a62:fb04:: with SMTP id x4mr14098587pfm.83.1553340904150;
        Sat, 23 Mar 2019 04:35:04 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id h87sm20403839pfj.20.2019.03.23.04.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 04:35:03 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     linux@armlinux.org.uk, akpm@linux-foundation.org,
        rppt@linux.ibm.com, paul.burton@mips.com, anders.roxell@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arm:mm/mmu.c : Remove duplicate header
Date:   Sat, 23 Mar 2019 17:04:24 +0530
Message-Id: <1553340864-29200-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/arm/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f3ce341..a7863a5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -23,7 +23,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -36,7 +35,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/fixmap.h>
 
 #include "fault.h"
 #include "mm.h"
-- 
1.8.3.1


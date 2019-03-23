Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C24FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90A21874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlC9gaKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCWMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:51:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39507 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfCWMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:51:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so3346969pgp.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8ChnlVqrga2W8EZIJdLuUoeyqlT7OHpe4yzIC29FI84=;
        b=nlC9gaKaMvjO9I+zCoKz3DAuQOFrWigLoi2/kt/FZIaAkdWQlv601my1uWwEL2o/lZ
         Va0ZeSRLU5LTMYSb78t/LjeNTCYp5XggebFwiRdA+37vNVxcyLzAV+P7HjXNVXP1bjy9
         5ki5cI5O0Hgt0IUB1RDZvF2zXaBENo/OVpliD+vsgBs73bJ0EzpkNQ77Igssc6LdgxKM
         uLeBJQiYoVixkKXVIIFTzZPUnPKsEHkJfhEk6fpnFA0JGYvXyz73MKpyHTxNiI1r8KJW
         u/IvNTcwoD+OCVr8yFcY+q7lBY63NSRSlNH1aXevzIOLgZj+UNeq51iaYJMg0YF/b8j3
         G4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ChnlVqrga2W8EZIJdLuUoeyqlT7OHpe4yzIC29FI84=;
        b=pzCoMEiNWv9eV8DLCFrWRr4QwDisHM1VxsfeIrg9uuPYN6MIqUBPAPEaIzb/poowvO
         kT5Sewyh1+6nWzQhwhdzhOS1BViD0IuxBmPtUfw8L8Q4pRQOOrifESIW0mVg0H8aqmBr
         higTzeQBebQrZ9ywajaa9GMmbbz0w79wnWd9QOwNipQBTzz9SnF7uyuBXBWNQHMjB6Je
         txA0Wp6lgANRH0/D+fnCDjf1QxZGJafJqBjDl7heCHPsWcznuWomOmc/r2e1HRioLRJr
         /d1WIwqUKaAPNqmuQd2594e+3lFOSauMgEaINxTjjUg6enlPVp1ih5hPkc+JwjKwjf8C
         ALqg==
X-Gm-Message-State: APjAAAWaJcRHTMC2Bd/bFQTOvpvw0E9kONlClyiJJismGS5/KRb5kOpZ
        1ERu2g7G8Uw9NoOQoJNoE0U=
X-Google-Smtp-Source: APXvYqwYlcL6Cr3p/H7TNbgapyzT5BIiqgu/uTsPEQSH4BuWc/be2+h4wYHeckljdUQL1FrMI956bA==
X-Received: by 2002:a17:902:1121:: with SMTP id d30mr15011160pla.104.1553345475734;
        Sat, 23 Mar 2019 05:51:15 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id t190sm16657001pfb.33.2019.03.23.05.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:51:14 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, hristophe.leroy@c-s.fr, arnd@arndb.de,
        anton@ozlabs.org, paul.burton@mips.com, mikey@neuling.org,
        akpm@linux-foundation.org, mwb@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arch/powerpc: Remove duplicate headers
Date:   Sat, 23 Mar 2019 18:20:55 +0530
Message-Id: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/powerpc/kernel/time.c       | 1 -
 arch/powerpc/lib/code-patching.c | 1 -
 arch/powerpc/mm/numa.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc0503e..6ef3247 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -43,7 +43,6 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/time.h>
-#include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/cpu.h>
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 506413a..587ff97 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -15,7 +15,6 @@
 #include <linux/cpuhotplug.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f976676..f3ee0e1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -32,7 +32,6 @@
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/cputhreads.h>
 #include <asm/topology.h>
 #include <asm/firmware.h>
 #include <asm/paca.h>
-- 
1.8.3.1


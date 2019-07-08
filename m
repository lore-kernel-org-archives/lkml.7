Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE9C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD7C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jKVu3uS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfGHVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:36:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32873 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfGHVgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:36:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id h24so19630085qto.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Hmor1iqxZi1VkrR/Wq3PdF/MrxyHn6oUz2bb5wNYseo=;
        b=jKVu3uS2OBDD1Wf5jQcAcfzAxEfTbab222vJtEqpdiI/W9pY8/VYrk8EHDQoxFaILn
         9cOd0gRItG+TTdeqEEyaAHAXXEwUl05asjMPRpdeqiScxkC6mN4wYr0diue3xAEc4CXf
         7piTiX16xtXSV9nVloRUNG1x6PtMnkof+A2lUlnsats8ayq/9cEUC7xaavYef3N96euD
         CpDLlVlGTxvSDpB7J7rHWyLatKPlkX/RFbhu/TpQdNO62oeZft7UtT6JNdWo4lKl0XPX
         KSpjPdWJ+iu/7QUk7IsQ6UPG3dmWy9LSe0tNqj1xOXTj63a31RmMQFjcO3QV1uwc0Eyn
         j/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hmor1iqxZi1VkrR/Wq3PdF/MrxyHn6oUz2bb5wNYseo=;
        b=QhZixGDVezmHQR7GO5qLCFmIWiDJxwfFuQKmQ3fevqRdPe68GjGWlekK+D5TI8odv7
         2EenUUCXIP3EYJbJ8ucX4WaqcYGVhFjfyRk19XiKO7d+/ZwGHWexa0/G2kT5nQNOkUPq
         lV+wxehR/Ez9Mw6QSXy968qFv90JN3aJHZaxp3yEHcEoQKeoC6fRa88ERCP2SPaeVBUv
         onx2BERZWSv4019z11/+TXozE1SZsED0rYDL5THD+YRbQ3EUS475xZ5DpiH0JJGRHGAi
         QrfBDUIOzEH+docBk79Z/UWnuwtIsjMQgaR2IPHTK7z4/32pQZ1h5wEu1qXXWFMaEDjo
         lKXA==
X-Gm-Message-State: APjAAAWw/K98yV701lK/rDSl73o5k6Zw7yfhGfc1mBmCu9WigvRxWRiq
        L/zpruKHsKSDYlw8FECnSKVxQP6YUCga5A==
X-Google-Smtp-Source: APXvYqzw5js3CQpEP4Hd26da9NTftH42q9OkauwafRzLckdOk8eyBrrkVHY5TQ383+rwo5peGSsOkQ==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr15698369qtk.68.1562621814668;
        Mon, 08 Jul 2019 14:36:54 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q14sm4255590qtp.78.2019.07.08.14.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:36:54 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/apic: silence compiler -Wtype-limits warnings
Date:   Mon,  8 Jul 2019 17:36:45 -0400
Message-Id: <1562621805-24789-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many compiler warnings like this,

In file included from ./arch/x86/include/asm/smp.h:13,
                 from ./arch/x86/include/asm/mmzone_64.h:11,
                 from ./arch/x86/include/asm/mmzone.h:5,
                 from ./include/linux/mmzone.h:969,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from arch/x86/kernel/apic/io_apic.c:34:
arch/x86/kernel/apic/io_apic.c: In function 'check_timer':
./arch/x86/include/asm/apic.h:37:11: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]
   if ((v) <= apic_verbosity) \
           ^~
arch/x86/kernel/apic/io_apic.c:2160:2: note: in expansion of macro
'apic_printk'
  apic_printk(APIC_QUIET, KERN_INFO "..TIMER: vector=0x%02X "
  ^~~~~~~~~~~
./arch/x86/include/asm/apic.h:37:11: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]
   if ((v) <= apic_verbosity) \
           ^~
arch/x86/kernel/apic/io_apic.c:2207:4: note: in expansion of macro
'apic_printk'
    apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
    ^~~~~~~~~~~

APIC_QUIET is 0, so silence them by making "apic_verbosity" an "int"
which is a simpler fix than adding more checks in apic_printk().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/include/asm/apic.h | 2 +-
 arch/x86/kernel/apic/apic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 1340fa53b575..2e599384abd8 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -49,7 +49,7 @@ static inline void generic_apic_probe(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern unsigned int apic_verbosity;
+extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 85be316665b4..1e49de432c4c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -183,7 +183,7 @@ static __init int setup_apicpmtimer(char *s)
 /*
  * Debug level, exported for io_apic.c
  */
-unsigned int apic_verbosity;
+int apic_verbosity;
 
 int pic_mode;
 
-- 
1.8.3.1


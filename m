Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D975B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMgmYD2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfCMUAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:00:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCMUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:00:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id y15so539122wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCHDAob2L2Ty8cKpbvR0K56/ZQonIWJzTExy3tCtNQ0=;
        b=AMgmYD2M3KR8ZZlQiXI7NIS7Yub8S3tYNOIB4za9vqTL5u2+yWf1Bm7SdmxgcypTht
         ECzhMQ6/9UTfsr1bnzOLHIfiu0x3HOjhIphrshRIRNZ2MJvO1TQisCW1nx2HoIzUuPSM
         leX+AFydh2ekX3phK+rKfxA089LC5ZTRrDlcGYHeooPKrmLHZR5i27hnaVDhDgEt9Eu3
         4Wua+KkCz6qKmm9QnaBEKNGAFfUha7sg4swxfbQgh0jTJzm+lW28sRIbk3588M/umLq/
         Jer+etUFn8NwfKN01+wCxcRTAHvRqN0OVdms+PkD51jkropRa8NfVJanbFrSjwAr64dw
         yEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GCHDAob2L2Ty8cKpbvR0K56/ZQonIWJzTExy3tCtNQ0=;
        b=YeX2esk6UEViLELEHcNiZcOeAOBLAxa9OSnMJm/mCVvVcQTrdsWu4493x/85n/KxSG
         aWs7zckYpQZuL7Af04ERZuxgf//yYwxlghD7YesqC8DZNGPhywDMC4h1G4eH/zeaUcHq
         O0UMXgjCCZGuxJZS2mskd0HJLq99c/Pul+QTaLWMmOu4DnPty/CGsK+NvfXN0DZLOyRH
         qsf2CDt7b7j4HI0HzD43ucVYDJ30zcdbrQDWo8x3KnLNgubRSfFaWVO8Q4cdvFNQpYqX
         15jDEEGje0rRuBfR0tvDYiaXUMOpIrlM5s+RG5knEr/bKFvIbekWXH4M4jwpfAyajPmV
         Yq9A==
X-Gm-Message-State: APjAAAXTMme/3uTsdV+jEth3yXGi+Fk59I1ziuih0xnjRhZl0ZOJepSX
        001KWu9q7wKLoCLDVPHs1WU=
X-Google-Smtp-Source: APXvYqxSAKrpYuccNZtrZ/rJwN6FCBUoES8meVdd7HDb1pZFOvQ4bB12ILPgd4b6s3IfwnM54r2DqQ==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr3529639wmc.69.1552507234662;
        Wed, 13 Mar 2019 13:00:34 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 26sm4623926wmg.42.2019.03.13.13.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 13:00:33 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 787691140A07; Wed, 13 Mar 2019 21:00:32 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/64s: Remove 'dummy_copy_buffer'
Date:   Wed, 13 Mar 2019 21:00:30 +0100
Message-Id: <20190313200030.19145-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312202921.31331-1-malat@debian.org>
References: <20190312202921.31331-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") the
function __switch_to remove usage for 'dummy_copy_buffer'. Since it is
not used anywhere else, remove it completely.

This remove the following warning:

  arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]

Cc: Nicholas Piggin <npiggin@gmail.com>
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: complely remove dummy_copy_buffer instead of marking it as used (since not anymore)
 arch/powerpc/kernel/process.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 77e44275d025..b2f0daa2fcf1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1151,11 +1151,6 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	thread_pkey_regs_restore(new_thread, old_thread);
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-#define CP_SIZE 128
-static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
-#endif
-
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
-- 
2.20.1


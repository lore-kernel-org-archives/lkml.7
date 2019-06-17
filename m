Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0CBC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92520657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktB3GFf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfFQWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:11:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38637 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfFQWLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:11:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so4758789plb.5;
        Mon, 17 Jun 2019 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dXXVrwVJ7l6qanDf/467EF9XBDIFBZuBR9eikjI7P94=;
        b=ktB3GFf5FEja7OHgZ62Tj+mr5bzvFdgAsDzwXRTPBR67wYn+S60crWeOGheVh4+t01
         EeNTXe+tXFy4usAIPJ9UHwBUQwyBFAxdHQJZkGSySN0Yq4VuCEz4QHcHKTyxSZOwD1OL
         HhK405Rin9/dN3xk0F4sefBZ/mCYOFSTGbW8gZAjETNtzdUdm6NHMAYf7Hoy/6fY8WJJ
         ZnfF9qaeGNYfpuIX4X4vgEoVeBziTXR2azrc91r7rEDtR4oEzOIUtxZNbMLvrx0kZ7V0
         6aXSK0lOggrPTENldxhigMgIgUIz/6ntPYbjkFGIbIfsoYGLxVOx+ve7xHK4csvklZ0q
         XIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dXXVrwVJ7l6qanDf/467EF9XBDIFBZuBR9eikjI7P94=;
        b=fNcUBlNjuiwATZfSC6Vul6pb/O3Ur4SI8aZRIsO6ThmiXpqrTHb6lDBrsgGycD738Q
         8uVG1UhSEl6nb0rpde7WL8SgCJSsjB6Ut3PJMSMQvjqKz4wPVhm9yBu6SQY/tRpZHlJL
         h5xxJpGK4uJT9wIrYyvsRonzNzAt5iWa0RUHFTAZXEYQh6NMl8GzrMhI40JDpm7KodIE
         fd/qh3S4ScLouzyvh4zN71uJy5GE/UJkgti//Gf/lpvh4Z2UGCo4sOUvTBJf+xaPbKwH
         /oxgepuQdXl0dkCbsoEcvnRWpMKpaGXoJgKDgpAikFBt1t8uVqiHK/JpVOm2M7Ib7KuD
         1HmQ==
X-Gm-Message-State: APjAAAUK3kqYeBFeb+CLTBuyjzUxR4aOai/bExmTxY6tKS1In4qHgzfT
        yXpWaLHMqr7kbhCBvxifYSM=
X-Google-Smtp-Source: APXvYqwcOoOXFRDRnFBWVqoZC2mEUFzxj+YkPGRyZadEJr+Pw1USgY1MQ7N/T4eqUgZ43nrZBvdexQ==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr102286611plq.98.1560809505570;
        Mon, 17 Jun 2019 15:11:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s129sm12551020pfb.186.2019.06.17.15.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:11:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
        christoffer.dall@arm.com, marc.zyngier@arm.com, arnd@arndb.de,
        nico@fluxnic.net, vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, alexandre.belloni@bootlin.com,
        ard.biesheuvel@linaro.org, daniel.lezcano@linaro.org,
        pombredanne@nexb.com, rob@landley.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
        geert@linux-m68k.org, andre.przywara@arm.com,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        ryabinin.a.a@gmail.com
Subject: [PATCH v6 2/6] ARM: Disable instrumentation for some code
Date:   Mon, 17 Jun 2019 15:11:30 -0700
Message-Id: <20190617221134.9930-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617221134.9930-1-f.fainelli@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

Disable instrumentation for arch/arm/boot/compressed/* and
arch/arm/vdso/* because those code won't linkd with kernel image.

Disable instrumentation for arch/arm/kvm/hyp/*. See commit a6cdf1c08cbf
("kvm: arm64: Disable compiler instrumentation for hypervisor code") for
more details.

Disable instrumentation for arch/arm/mm/physaddr.c. See commit
ec6d06efb0ba ("arm64: Add support for CONFIG_DEBUG_VIRTUAL") for more
details.

Disable kasan check in the function unwind_pop_register because it
doesn't matter that kasan checks failed when unwind_pop_register read
stack memory of task.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 arch/arm/kernel/unwind.c          | 3 ++-
 arch/arm/mm/Makefile              | 1 +
 arch/arm/vdso/Makefile            | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 9219389bbe61..fa4d1fddf1db 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
 endif
 
 GCOV_PROFILE		:= n
+KASAN_SANITIZE		:= n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 4574e6aea0a5..b70fb260c28a 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -236,7 +236,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
 		if (*vsp >= (unsigned long *)ctrl->sp_high)
 			return -URC_FAILURE;
 
-	ctrl->vrs[reg] = *(*vsp)++;
+	ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
+	(*vsp)++;
 	return URC_OK;
 }
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699fbfc4..432302911d6e 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -16,6 +16,7 @@ endif
 obj-$(CONFIG_ARM_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
+KASAN_SANITIZE_physaddr.o	:= n
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index fadf554d9391..855fa82bf3ec 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -33,6 +33,8 @@ GCOV_PROFILE := n
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT := n
 
+KASAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
-- 
2.17.1


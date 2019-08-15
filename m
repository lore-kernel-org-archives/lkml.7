Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1202FC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53E5206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h8NgnlPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfHOQjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:39:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbfHOQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so2780495wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=h8NgnlPUTiF5wVsNev50I/YOtqJjKSy5vLIaU2eN9nCpZcTALr4MPd+FenrgztWbfv
         3D0klacd/3elaTXqSlumajss4KRd/R5oZ6OS9naf4u5lmkLnR+uru5GMDkfmQQmYzE9g
         /Il1I2wJNf6eZtgrGs0ONwchUkxhn+EqFcxr6UJOjay1lyzoU+2dutEiukEFk0+XJMqR
         D7kCQ41b7rARv4kqAruadOaD6deYpxFHjNn+JDvHi1RgRxuo0BCJxOx5iofUxRpdSLPT
         Ztf/9+xTXY7Tg4SBxmw8bmhYrFoeaz0CL6Iw5/ydI0drLrzZVL0IpsW1XBq+hU8Ps6G/
         IVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=jmQ2u0CUql/fSD7cwXuny+qbFrsTxWILz4xw137uRsL+8Lrv7Nk8G+YI7xcGX7HzXN
         ykgmrwHzVAU0Fjh5oNHkFYHTe4BEG+CDOW3ycpirpj2Cg9onGsGjPloH+EVCnp5bf+O6
         oJEIjiL2lAj4/NpWUjjMIF3aGKBVRdkYb6dV9/P1+Pv/srvB7jckXWCBCZWSTgsWUt4j
         /sBcYOhGMBD4u0/ZKzHhJ2ZlUqhz0ttYnIHE25XyTM7+KZDQfvOlFYHPoejqKEOUvkPv
         4a4XHyXo+DKvaqVij2AlnkrxrTLDrZiO6Kk+wrUk+A/bGIYLjrtpY1rfzEdjeB28TV6r
         e+ow==
X-Gm-Message-State: APjAAAUvV/df74VB2GWMHz0i4Yb9Fh2HgAgitRdW4B4Z72WrGBVNm9lP
        GSaTYK16DgUmBLb0trTTIaYHpq4p9N4=
X-Google-Smtp-Source: APXvYqwCIu5CCYmSqesKN8wH1344KKjZPusYqSYMWbcWtojROTGdeO5FK5una9x2h//MzJWxGG3f1A==
X-Received: by 2002:adf:f991:: with SMTP id f17mr6087291wrr.233.1565887145365;
        Thu, 15 Aug 2019 09:39:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 19/36] x86/vdso/Makefile: Add vobjs32
Date:   Thu, 15 Aug 2019 17:38:19 +0100
Message-Id: <20190815163836.2927-20-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat ia32/i386 objects in array the same As for 64-bit vdso objects.
This is a preparation ground to avoid code duplication on introduction
timens vdso.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 8df549138193..d4bffc4cabd1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -24,6 +24,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -37,10 +39,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -131,10 +135,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -159,12 +159,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)
 
 #
-- 
2.22.0


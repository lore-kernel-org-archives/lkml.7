Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC11C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED40220651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YEz7opQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfDYQOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39694 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfDYQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id k45so393254edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yyiz1ho7fR3OmdSv5ZHPmjy0yB3MJ9NprzDUclrfcsQ=;
        b=YEz7opQRviIXo5p00GAypoKNR4+z6gCj14ts7ve3i9dCM8OqypIoCA4xg/ywaZDs0v
         5tVkoGlKsGYq28oF6c6jClOr3iiMV37y9gBS7h1NPHCnQYfIVceZMwFS2zLkjMk06xoZ
         Ru9Ra/elrg29ULmBK/Pfjlw/FTjbDXSDggRSzP06t3M7mQwrnrJ3uJtE9V8HzsSZLYgY
         rA7XcgvydbIEfJpIUxgYr5kLJA0oGcT692RDUHgP9p5uCag78efcJfvMg0fOX0ETZqRi
         RyyduJ2bSopNl2L/rQ37/wM0lxck+iK4rzGHkf1p8WYF4m4PL38+ZJ0CqJX/Bw82H2t8
         +ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yyiz1ho7fR3OmdSv5ZHPmjy0yB3MJ9NprzDUclrfcsQ=;
        b=MInwhyFzhE4HbnnPV8de/MddFUpn6aJLwss/7AAIVWLjUOFSzlJrfdanJRmJEio7F+
         naamF9DBwlY0PUJ1+1h5JD0DZHJHOE03ww5sX/wq02Wrvku9m+YnWaeH3oXyB4Ve2GPQ
         BM45hbtdiYdx5nk7qWRa6V0IpKZ4+crIFPpM0uP07PCfOyGIDXZhCnTKT0G4PHNDivKp
         Z3y3ga0rvyLVasDIfqpNZQ+TJ3fl0oD8IcZZl72WZjmXeH/y49M/G/gX4bXr1dufrHh5
         hZP0typWK4IjGRa21nBWfvYTdLppReprA4UYKF2hEewehEYyY6JIBsPBTihOn/Z2Nlfr
         /O9A==
X-Gm-Message-State: APjAAAUfzgWGQP1754zSHa7BoeI7oHW27JJ/8btevQO6M0v0eG1H9dP1
        8TtOBpBfOge5RXUYUJ41Q7JauOBtzns=
X-Google-Smtp-Source: APXvYqyV9e/F06/y3HJaw12uQBsPJxScVIa2eyhbnOGAzht03vgAimE45wduit8eJ7PyVEr6QRcGDw==
X-Received: by 2002:a50:b78a:: with SMTP id h10mr25236761ede.65.1556208876540;
        Thu, 25 Apr 2019 09:14:36 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:36 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 11/27] x86/vdso/Makefile: Add vobjs32
Date:   Thu, 25 Apr 2019 17:14:00 +0100
Message-Id: <20190425161416.26600-12-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat ia32/i386 objects in array the same As for 64-bit vdso objects.
This is a preparation ground to avoid code duplication on introduction
timens vdso.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe2243a08f..bc0bdbf49397 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,6 +18,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -31,10 +33,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -125,10 +129,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -153,12 +153,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso)
 
 #
-- 
2.21.0


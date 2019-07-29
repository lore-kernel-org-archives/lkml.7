Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E652AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="m3yFpZ8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfG2WBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44353 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfG2V63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so63447589wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=m3yFpZ8poaRzOa/MxADE5K5sL/TnKgMt4BEe+aPbbp8xHRDgN5aLl6Miohq5KIwQMB
         G+7Rad8bup04SNcaHQuvFDtcpH+h+RKHJ6cdoaLpI6iqv2yE8YU5RMb1T28NEc7vupeR
         x/o+VMnd7pXmwe5LR/+Ux0XFjw3nxAQzGttiZhO3t4A2nzeSHT2hNqngOTEIGwsXogNV
         99T52Ddl/ix0LFWVXSQT7hAXKfeoTmbWC7RXXAOnYJzEwH2ru0spwMiyxpNxYmU+ucR5
         q373gy7peX1g4cMgt/NDPrh/QhOJZBa5WXbOwvjHFkw0k7XEeqgNn2NJIr3F2qmFzFrV
         o7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=au4s17032geQRWPz5/AeuAbB+nnbvY0InZ0SqZJktYiRmXYAOHE1hrt6ibmn0WQTT4
         s7GxXIz2VXEvahD2ZmFow7mzxMUYHfdAXeSHcJbIEc2sNZy4zYpbP65ZkDwciZyi025G
         jo9XttM6hhk02DDFxeBzt97YIK8f5mWiuoWy1z5RNWZ9D3KVHxbR2TdL6A3idvJgFkKL
         ajMHkU9WRxfMeRDy04tWZBAGB3qnO25zix8gGs8d15gviU0pRY1MbWZGXY+8nwksVm03
         5nhD+oXCJwLAPcuWYmR/+GCN99y+EIXIFHh+9Y20DSh1Z4+2nAmYyX1SAENnyosoF//m
         amxw==
X-Gm-Message-State: APjAAAXRZrSye4C9mTM+ESCzgyCYfa4eD1+uY0ZrYJK8xUe9kSM+4I3W
        R2AvrNQ4EfDCfHN2e7/JjN5jnuYwM7zKk00fzPIQjZLhjqKUeKq5ZlngloZBfc2JrErdKDKvtKv
        dEK989KAOVChELuMZiOELY0+PBMQxFkuCpC3ZaAWRii4vAModFOznTdKteaHgkpdKJzlMde4oKC
        7BOqP7q97LVcnjNj5yYUiwQ8IHU/OHLoGLAojz8Ho=
X-Google-Smtp-Source: APXvYqxe140732//L/bynIz7NqQJ73mBM6Qqjk+350TEqAjF0B3mriLWFXVhnez+lkDIkgz5G7FeGA==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr50896110wrk.229.1564437507897;
        Mon, 29 Jul 2019 14:58:27 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:27 -0700 (PDT)
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
Subject: [PATCHv5 20/37] x86/vdso/Makefile: Add vobjs32
Date:   Mon, 29 Jul 2019 22:57:02 +0100
Message-Id: <20190729215758.28405-21-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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


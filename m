Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F9C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B363D2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfHCGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:23:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36918 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfHCGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:23:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so54215028wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 23:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKCEdY21OLJxRkmARtmM/H12CoGOkS+6ZoKMiApGdkc=;
        b=bAyzg4vJGaHQnHr2xkiRINem3RcVBOnX7W8+0qFfQl4Xv+RRFn7ZHxzdDHKArTEOV/
         FlkMxkYDmbiL5yL+s5tlBSV8YzN45NXm6ZG8ZoI/7oGrycpOm8nFTF7EFwGuhBgydiPH
         skRITqq7gvZTUdHMqLyFVN8cfB6SBfj9/gV5SKEu5PXaNXqCgymoF1e1EaEiicbJD85W
         SsJsdyL/rw2uAVqxCiaWer/9Ss8GgdUipnGA9xuk9g46BCkPDSUdThDPVbRIlSASuRU6
         nD5XpvYMnuf3yJ7PdMVdKFP15pNMdq8Tx7bzjwZ0mHF4R1OGEiyNWsVWOTYHH0EQdPvj
         DcgA==
X-Gm-Message-State: APjAAAWFnnM6A0QFAOXTT+YYalK7OexAooyedsjwB6Kkeq6b9g3lQc0F
        G8tT7hndzPwZFJNIsVmH1OywMm0810Q=
X-Google-Smtp-Source: APXvYqxHYTkGcyhrkWQFMXu9GeJbo147gfocr3isgZ0f/6hevwVfvAjZVu5qW4pTdqUQfRslWl5wXg==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr30869456wrl.79.1564813406807;
        Fri, 02 Aug 2019 23:23:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id f204sm123834500wme.18.2019.08.02.23.23.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:23:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: remove kvm_arch_has_vcpu_debugfs()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Radim Krm <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190731185556.GA703@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ddc98b6-67d9-1ea4-77d8-dcaf0b5a94cc@redhat.com>
Date:   Sat, 3 Aug 2019 08:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731185556.GA703@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 20:55, Greg KH wrote:
> There is no need for this function as all arches have to implement
> kvm_arch_create_vcpu_debugfs() no matter what, so just remove this call
> as it is pointless.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krm" <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <kvm@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: new patch in the series

Let's remove kvm_arch_arch_create_vcpu_debugfs too for non-x86 arches.

I'll queue your 2/2.

---------------- 8< ------------------
From fe1b874aca4679836f0533a923c641a1a367cd32 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 3 Aug 2019 08:14:25 +0200
Subject: [PATCH] KVM: remove kvm_arch_has_vcpu_debugfs()

There is no need for this function as all arches have to implement
kvm_arch_create_vcpu_debugfs() no matter what.  A #define symbol
let us actually simplify the code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2cfe839f0b3a..1109924560d8 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -150,16 +150,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
        return 0;
 }
 
-bool kvm_arch_has_vcpu_debugfs(void)
-{
-       return false;
-}
-
-int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
-{
-       return 0;
-}
-
 void kvm_mips_free_vcpus(struct kvm *kvm)
 {
        unsigned int i;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0dba7eb24f92..d71b21b4eea6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -452,16 +452,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
        return -EINVAL;
 }
 
-bool kvm_arch_has_vcpu_debugfs(void)
-{
-       return false;
-}
-
-int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
-{
-       return 0;
-}
-
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
        unsigned int i;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f520cd837fb..f329dcb3f44c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2516,16 +2516,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
        return rc;
 }
 
-bool kvm_arch_has_vcpu_debugfs(void)
-{
-       return false;
-}
-
-int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
-{
-       return 0;
-}
-
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
        VCPU_EVENT(vcpu, 3, "%s", "free cpu");
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e74f0711eaaf..a40a77e09cb0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -35,6 +35,8 @@
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/hyperv-tlfs.h>
 
+#define __KVM_HAVE_ARCH_VCPU_DEBUGFS
+
 #define KVM_MAX_VCPUS 288
 #define KVM_SOFT_MAX_VCPUS 240
 #define KVM_MAX_VCPU_ID 1023
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 329361b69d5e..9bd93e0d5f63 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -8,11 +8,6 @@
 #include <linux/debugfs.h>
 #include "lapic.h"
 
-bool kvm_arch_has_vcpu_debugfs(void)
-{
-       return true;
-}
-
 static int vcpu_get_timer_advance_ns(void *data, u64 *val)
 {
        struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5c5b5867024c..65b85737ad22 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -861,8 +861,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
-bool kvm_arch_has_vcpu_debugfs(void);
+#ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu);
+#endif
 
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index acc43242a310..13f5a1aa6d79 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -144,11 +144,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
        return ret;
 }
 
-bool kvm_arch_has_vcpu_debugfs(void)
-{
-       return false;
-}
-
 int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
        return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 887f3b0c2b60..9c210f848ebd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2593,12 +2593,10 @@ static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 
 static int kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
+#ifdef __KVM_HAVE_ARCH_VCPU_DEBUGFS
 	char dir_name[ITOA_MAX_LEN * 2];
 	int ret;
 
-	if (!kvm_arch_has_vcpu_debugfs())
-		return 0;
-
 	if (!debugfs_initialized())
 		return 0;
 
@@ -2613,6 +2611,7 @@ static int kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 		debugfs_remove_recursive(vcpu->debugfs_dentry);
 		return ret;
 	}
+#endif
 
 	return 0;
 }

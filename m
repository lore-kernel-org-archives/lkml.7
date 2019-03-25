Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565C920700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApsvyUbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfCYSrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:47:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40956 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfCYSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:47:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so6999593pgo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=fRdq63OhSxm5cgv8tRdBJK1Sff/Wou+7tzmBvJBIrrU=;
        b=ApsvyUbVLS4sN8mLCNZ0dSvTIL37bi8ZAKmmhCRHCqF/YOYbXxBHnlpBmimIgdrjPZ
         D8eX4iQR/iV7vwrlu/a1q9PTDnqrdazDIhqfIeyA1Zg47+toNQdIqMFLg3UBE4mpqyVF
         2FrrfdiEIWJ8keELyAaOmLJMLXl1PeU+CSezjU1LsmJGKP1IhUR0aL3UrSCyNM2OiUkD
         72all7OweA4O7qWPv6WmgeSzrIlLAFy/A0TZ8kcFnQiEZfThjLFe/ff9lcIiU5VFwxI2
         04F7YUp1RyoQOaijNWFANSlS+h/QH0+i/ufdYHwY/Pt1O3BitMDRMKBzwwfE7OnBN6FX
         k1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=fRdq63OhSxm5cgv8tRdBJK1Sff/Wou+7tzmBvJBIrrU=;
        b=ejBjOGCcnw0IzO2ag753AEdXx2CD1Gd0fwQ/BJ/gP8ZPuIVAroo6OboRmeAtwNIsQr
         99P3ynWODEbc7bYQwDDb1QENDZN1/ZqPp0AaXodQD2A252ydeRn7+Qsk9W4Z9ey+bB77
         XZ2E85sDujDNYsjfUetQXWLcKFxZG53PyB60S309om9HI5FWaRqqZ6yQGHDiquioaNPz
         dMIWI3py3bO7fIp5L2G+ZJiC2YZ7bVJ8gESeahC4RsikuVoIbWqLdA4/QSTEm4gHRZD9
         IkaIbo7wRQpXWVdA7zS85pk+/25++b3cudhfdjHUVvQgsd2HJeYnJjI2JjOvg5MagALI
         y5yg==
X-Gm-Message-State: APjAAAVJ9OLIHjib/Vd4J2oPwzroMnDyY41ElgvkWAYCiJcdmxRqLmbV
        5ypPprY+yD3bPbxg1mxvb2vuDg==
X-Google-Smtp-Source: APXvYqxYG0EDdOeSHsVt+srIwGgDgZV5j2oAGIcoS+zCeAb0HoExNgRBQxX/Am1W5yFZrJ2AyVMS3Q==
X-Received: by 2002:a63:c145:: with SMTP id p5mr25246258pgi.248.1553539652886;
        Mon, 25 Mar 2019 11:47:32 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f14sm20714146pfn.3.2019.03.25.11.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:47:32 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:47:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [patch] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
Message-ID: <alpine.DEB.2.21.1903251146160.188887@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures that the address and length provided to DBG_DECRYPT and
DBG_ENCRYPT do not cause an overflow.

At the same time, pass the actual number of pages pinned in memory to
sev_unpin_memory() as a cleanup.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/kvm/svm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6799,7 +6799,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	struct page **src_p, **dst_p;
 	struct kvm_sev_dbg debug;
 	unsigned long n;
-	int ret, size;
+	unsigned int size;
+	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
@@ -6807,6 +6808,11 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	if (copy_from_user(&debug, (void __user *)(uintptr_t)argp->data, sizeof(debug)))
 		return -EFAULT;
 
+	if (!debug.len || debug.src_uaddr + debug.len < debug.src_uaddr)
+		return -EINVAL;
+	if (!debug.dst_uaddr)
+		return -EINVAL;
+
 	vaddr = debug.src_uaddr;
 	size = debug.len;
 	vaddr_end = vaddr + size;
@@ -6857,8 +6863,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 						     dst_vaddr,
 						     len, &argp->error);
 
-		sev_unpin_memory(kvm, src_p, 1);
-		sev_unpin_memory(kvm, dst_p, 1);
+		sev_unpin_memory(kvm, src_p, n);
+		sev_unpin_memory(kvm, dst_p, n);
 
 		if (ret)
 			goto err;

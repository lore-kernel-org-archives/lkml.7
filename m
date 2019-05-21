Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915EDC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC221479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f54Jfcj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEUC6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:58:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35270 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:58:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so2288396plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7HdXPYxvmLu7dAn+oOr5Hftd2YV/QZHVEZ2U127O1k=;
        b=f54Jfcj7s8GNo9SMGfgOnaYMr/gXcigJiadGDGGiYPTMmAqroUbOANfzUMjX+ImAls
         HidKU0nWRrkW648S0TE8KBWk5oDuiLVgnLrPijhtjlgec6uMImll6VnPUEA0J8GE75BY
         +VtJpLOgadWsJWh2/v7ah8hJvKE6Afu8bk1eBb/i9PeT/oiHFu1DArZwGicd3Y9tla6y
         aDQg8TVtwmNULO7fsZO5LhFxfVVvHZEg6iJue61j3XawYo9+m6fPlvVPHJNggRfe9Rb4
         DVxSi3WWyfpPfjrAPHt03++Jmfj8REg1P9Gl0Bs7dneY0Q2rBhAdokDkxD5rLCjRNidB
         8yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7HdXPYxvmLu7dAn+oOr5Hftd2YV/QZHVEZ2U127O1k=;
        b=Y5NQkHCdIvIjXUgBo+h75jnb0BgCabe81KfRsyEATKYQHlBOqBYJdLwoR6YqiDdL0Y
         J43RhsBj1V7NYZ7oQReYuI7cHCcenMOtIXAFINF1dpaIN0h2FmUCieQKV256qAhzKWmF
         NQSPvzR2EnLKbH2N15E9O+rGfD6IsyRnj1wgsFg+husv/vHWE7v63VfTVfgW2klfItFv
         KUZ/EYLxjE82Rx+xuPeopFcgjpSVcT7SnSOsnBoTLFxyz0i0dx9JA+mASzCzJ2PSgrYG
         V+m2khCmUCpRGs4Gyh1gvwMihnzLumT0nqGcq8ppPUN3aamw4MdhhbElZnQ7aY+DPJUD
         GHHQ==
X-Gm-Message-State: APjAAAVJbdA7UoWGJ4fxlVCrd63RAvwddLuCWCqTNCpf3vpAMgz1xgFQ
        Mzv9xJhnO4thSdQxiBA+Ail5fxZ5/4g=
X-Google-Smtp-Source: APXvYqzpfN58U1nrshnBlaB6asXK9A1lYbCFK4RB3FQh0SgbCjtfsJOFze4QscnYoYo3uePeHeYqDQ==
X-Received: by 2002:a17:902:2808:: with SMTP id e8mr53478533plb.244.1558407491166;
        Mon, 20 May 2019 19:58:11 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id h13sm22849302pfo.98.2019.05.20.19.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 19:58:10 -0700 (PDT)
Date:   Tue, 21 May 2019 10:57:59 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c
Message-ID: <20190521025759.GA5263@zhanggen-UX430UQ>
References: <20190517082633.GA3890@zhanggen-UX430UQ>
 <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
 <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:24:27AM +0200, Ard Biesheuvel wrote:
> On Fri, 17 May 2019 at 11:06, Gen Zhang <blackgod016574@gmail.com> wrote:
> >
> > On Fri, May 17, 2019 at 10:41:28AM +0200, Ard Biesheuvel wrote:
> > > Returning an error here is not going to make much difference, given
> > > that the caller of efi_call_phys_prolog() does not bother to check it,
> > > and passes the result straight into efi_call_phys_epilog(), which
> > > happily attempts to dereference it.
> > >
> > > So if you want to fix this properly, please fix it at the call site as
> > > well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
> > > allocation though.
> > Hi Ard,
> > Thanks for your timely reply!
> > I think returning NULL in efi_call_phys_prolog() and checking in
> > efi_call_phys_epilog() is much better. But I am confused what to return
> > in efi_call_phys_epilog() if save_pgd is NULL. Definitely not return
> > -ENOMEM, because efi_call_phys_epilog() returns unsigned long. Could
> > please light on me to fix this problem?
> 
> 
> If efi_call_phys_prolog() returns NULL, the calling function should
> abort and never call efi_call_phys_epilog().
In efi_call_phys_prolog(), save_pgd is allocated by kmalloc_array(). 
And it is dereferenced in the following codes. However, memory 
allocation functions such as kmalloc_array() may fail. Dereferencing
this save_pgd null pointer may cause the kernel go wrong. Thus we 
should check this allocation.
Further, if efi_call_phys_prolog() returns NULL, we should abort the 
process in phys_efi_set_virtual_address_map(), and return EFI_ABORTED.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a..a7189a3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f..828460a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
---

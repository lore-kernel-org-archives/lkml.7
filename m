Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9B420640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3FmNZpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437424AbfJRQ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:29:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46796 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfJRQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:29:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4187904pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2wpqKYgqS1BkiorV4FohVUrj12ksHYUyybev2uqGPeY=;
        b=l3FmNZpvX+8KI2ixC4ixdLwdJ0RidwxgffrvTy7zM8oU1fT+BjavgsmLp5SpYYOdpJ
         H2sbPxZkmFoQp7QnnL1ot/lNxCls7i9E24SDA8SvByvn7v2viZTVaDMIDJaliFKQMJqd
         narsjaPjtXVEgtKdQuKQ2AWBqEppY2l2epuDSL319JLa/8kiSxk1Y1+lQBPBPTi/iwkr
         +D9FDgVuA6rwS1u0lXr6JA6rCwTKuvRaiLEEZ5fGpn0fSXIMDKo1ubEfC4mjx1Ao4y32
         SQHAy55r9Yo6HV9hmW8do0nGEwt8exF5zWN0X0wufAgnsElTEtP/jTUysqk5ShR268Iz
         RVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2wpqKYgqS1BkiorV4FohVUrj12ksHYUyybev2uqGPeY=;
        b=XE3wn+k+DL6/zw0NF7Vlkiq9JzDmbq8Pjki0i2S7G6lzgYoQivJwNLbkgN+/9id2hP
         HL/qdPvfoYdj0m9oN09fFInIrRmr1lDvW3r7eIUbgh9kArxRoh4EURYWVKHukxRNccQJ
         oua9a3DwMVt6cIK2+I8dNIDw1GnZ4mejXXZVmVx+QDTrfZfrfcaDXk8wlanDrBVlnGMp
         FwyBgDRDQwcEz+zotr6J98m6ZX/d7ONlzAXkZeleXLkCzjE3CrXaYlDpwLqweHzCHxNS
         9HRva7rpmILtI3yS3NwFbVh2BckJE2YsioKN+oaPzhsAotZ0dMWHdvJ+sUmvOIHG6mtr
         wfuQ==
X-Gm-Message-State: APjAAAUhZWK0k2y9XawKXrNA52k0yDhjT5x1kE6ke5EJ8lVAKI8aJqLO
        fV0JKIv3Qi+qKLjo3L/XOy/P/nGTFkV/snP+Ihm0Aw==
X-Google-Smtp-Source: APXvYqycy8C6FgkneRJuwyCOlTuUjZ/6EPb8v+vfWERGg/dW0EQ8jrZJYINcw33VYYsOuItcFjmi3LkWtPLxyac+kAs=
X-Received: by 2002:a65:464b:: with SMTP id k11mr11317125pgr.263.1571416149678;
 Fri, 18 Oct 2019 09:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134052.3023-1-thomas_os@shipmail.org> <20191018134052.3023-2-thomas_os@shipmail.org>
In-Reply-To: <20191018134052.3023-2-thomas_os@shipmail.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 09:28:58 -0700
Message-ID: <CAKwvOd==mdqaEQZU3YYn2CjzZcW6Nfjjva_RijMMOywA8a-Lqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/cpu/vmware: Use the full form of INL in VMWARE_HYPERCALL
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:41 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> LLVM's assembler doesn't accept the short form INL instruction:
>
>   inl (%%dx)
>
> but instead insists on the output register to be explicitly specified.
>
> This was previously fixed for the VMWARE_PORT macro. Fix it also for
> the VMWARE_HYPERCALL macro.
>
> Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Thank you for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Cc: clang-built-linux@googlegroups.com
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/vmware.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.=
h
> index e00c9e875933..f5fbe3778aef 100644
> --- a/arch/x86/include/asm/vmware.h
> +++ b/arch/x86/include/asm/vmware.h
> @@ -29,7 +29,8 @@
>
>  /* The low bandwidth call. The low word of edx is presumed clear. */
>  #define VMWARE_HYPERCALL                                               \
> -       ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx)=
", \
> +       ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT                   \
> +                     ", %%dx; inl (%%dx), %%eax",                      \
>                       "vmcall", X86_FEATURE_VMCALL,                     \
>                       "vmmcall", X86_FEATURE_VMW_VMMCALL)
>
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20191018134052.3023-2-thomas_os%40shipmail.org.



--=20
Thanks,
~Nick Desaulniers

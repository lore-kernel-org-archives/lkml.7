Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF15CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E76B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOzYqE+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfJUGTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:19:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56156 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfJUGTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:19:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so2585546wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMdLEV+CTaW2gmBLhEBpHxDKc063E21l+ayq5nzIrFw=;
        b=WOzYqE+LWe+E/HVhSozCNdcMsHavUK6DUIItAaXEkClsKdQaQfB42QALzHNS2WWwYS
         7/nd0om4bK/hNaghrCrAxwLmdR73Z4tXnnuwroc0+54D/uEAdDUy0U3x7XFfcuNcacaM
         G2t2PVl0OEsWAs+ON0q7SJAm80g0Gockqb5V9TwDq9CgrsLxWwFINCmx8t7mDomvn163
         au+GtLS99ib8TAWDJ1J+jgd/h16JcLxkcT/O5E+tFPIrOxgasAcAQUkydYejvXgehJGR
         CJoWn+myZwethBoe0UOOL2ixvKeT7IQpefZS3Izts0s0MnBwR25h089ZPQbW0zpPnsFy
         R5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMdLEV+CTaW2gmBLhEBpHxDKc063E21l+ayq5nzIrFw=;
        b=mkPulhd1rHk/ldlraUmVk9ta62FpuCMiW5hoQiS7jkPMAlUZzje+tmOsMMdRjcc/5p
         5ViB2yxmudNNomgxaoOrSK2EbETDZP6+CeHEDmW45XlwECFQOew7rdiCp0WefhlOSLRb
         CczItT/kaZUKq2vKb/W3imsztTdqQrA6HQORE35vbeWh7aDhUqeNmNdoplQKatPXzHEF
         JaRN2WYinsn2WIV2WwImb3pnf6RYOO1W8GOl66Y3VHl5PCOA4Ueu4woxJ5IDE9D745yu
         wzlUzk1bxMSOIAj1woxyZdtvktHxGc+mmSfh+LU5qcIIiM3mXcAiuIa+3XWFkgIMtI3h
         P/4Q==
X-Gm-Message-State: APjAAAUhZpEIeygGodzFS8GOXaCvm28NbQ/As6e6/njeJlX4oWPle69i
        1IE+rPusblEFivGBgYQLnHu5Y85QJvEyvcJfDJka4Q==
X-Google-Smtp-Source: APXvYqwtVZTOqZaaU9Te8Vy1PYbGo0mpgYTxtO/oPglrkIr329wlVgskZ9sxWEpAm2PexwLH+zbd9/RN3RL88+vlV/U=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr1400556wmb.136.1571638773936;
 Sun, 20 Oct 2019 23:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-4-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-4-samitolvanen@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Oct 2019 08:19:23 +0200
Message-ID: <CAKv+Gu9u-yO1SRTaT4TfdtckmPT0+JnHR6R=RPYRGfm9AACvCw@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: kvm: stop treating register x18 as caller save
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 18:10, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> In preparation of using x18 as a task struct pointer register when
> running in the kernel, stop treating it as caller save in the KVM
> guest entry/exit code. Currently, the code assumes there is no need
> to preserve it for the host, given that it would have been assumed
> clobbered anyway by the function call to __guest_enter(). Instead,
> preserve its value and restore it upon return.
>
> Link: https://patchwork.kernel.org/patch/9836891/
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

You might want to update the commit log to drop the reference to the
task struct pointer.

> ---
>  arch/arm64/kvm/hyp/entry.S | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index e5cc8d66bf53..20bd9a20ea27 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -23,6 +23,7 @@
>         .pushsection    .hyp.text, "ax"
>
>  .macro save_callee_saved_regs ctxt
> +       str     x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>         stp     x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
>         stp     x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
>         stp     x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
> @@ -38,6 +39,7 @@
>         ldp     x25, x26, [\ctxt, #CPU_XREG_OFFSET(25)]
>         ldp     x27, x28, [\ctxt, #CPU_XREG_OFFSET(27)]
>         ldp     x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
> +       ldr     x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>  .endm
>
>  /*
> @@ -87,12 +89,9 @@ alternative_else_nop_endif
>         ldp     x14, x15, [x18, #CPU_XREG_OFFSET(14)]
>         ldp     x16, x17, [x18, #CPU_XREG_OFFSET(16)]
>
> -       // Restore guest regs x19-x29, lr
> +       // Restore guest regs x18-x29, lr
>         restore_callee_saved_regs x18
>
> -       // Restore guest reg x18
> -       ldr     x18,      [x18, #CPU_XREG_OFFSET(18)]
> -
>         // Do not touch any register after this!
>         eret
>         sb
> @@ -114,7 +113,7 @@ ENTRY(__guest_exit)
>         // Retrieve the guest regs x0-x1 from the stack
>         ldp     x2, x3, [sp], #16       // x0, x1
>
> -       // Store the guest regs x0-x1 and x4-x18
> +       // Store the guest regs x0-x1 and x4-x17
>         stp     x2, x3,   [x1, #CPU_XREG_OFFSET(0)]
>         stp     x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
>         stp     x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
> @@ -123,9 +122,8 @@ ENTRY(__guest_exit)
>         stp     x12, x13, [x1, #CPU_XREG_OFFSET(12)]
>         stp     x14, x15, [x1, #CPU_XREG_OFFSET(14)]
>         stp     x16, x17, [x1, #CPU_XREG_OFFSET(16)]
> -       str     x18,      [x1, #CPU_XREG_OFFSET(18)]
>
> -       // Store the guest regs x19-x29, lr
> +       // Store the guest regs x18-x29, lr
>         save_callee_saved_regs x1
>
>         get_host_ctxt   x2, x3
> --
> 2.23.0.866.gb869b98d4c-goog
>

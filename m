Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1752053B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7GEnWKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfJVVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:46:00 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35379 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbfJVVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:45:59 -0400
Received: by mail-vk1-f193.google.com with SMTP id d66so3960511vka.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMrKTryhNXEL/B3UTp309ZugYMIYjNFJ3JCQDb7MpUg=;
        b=e7GEnWKdbrItjF4U3+0nKF/lx06Wuk/tgdQ9ljPjtYqFQxUxKdNDAzX4a3J6VJRTNe
         fvZtiXWCwgTHkznQdje8cmtubTkLp7iAWQx8JQFReAwrsWNXsaolV9s3JWeGTMMfUgSg
         /repYwQIO6djr64TXfPZeXSpbh0xxoZWJHDJcfD+y+CBwuzbqN5LUnqOWUTiGUf9R0Qr
         mx9Cap4UGrAAnISWvG3FD7dZFNO0uJ247ZJQzIRI+2iGU4ea2aaoSxUg8M9zDlq777fS
         qDyNrdBaDb9pA7+swtiQSKBEfo7e0BGKpeLpbQo3G6PYa3kXJxBuLrIskMILqlTGUpAh
         147A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMrKTryhNXEL/B3UTp309ZugYMIYjNFJ3JCQDb7MpUg=;
        b=hBdWPHf7A4hMlikAIbQDPmjuLX/w7qrVDSe+/DTZ7Id4dBp5kFkOf/oXGXN9q8HRQK
         rldMsGJPzodDJlBuFCCW+/qkxM8EU7OD7ap0sd+o6D47sVoKmJrUYngLLX336g2FyLUw
         z3Rz6mYm3zhKVVSSXnsUritVkMzbydg5PB4Ni+AZi+zpC4l+EpBM9RkXj+VRKUyLlcwS
         kou3uS/VZsb6l3hAo29YlpWvX+4ZGD7WsxysS+BVHaR2ggs0Qgu+xjLguF+CDdd1J++O
         f54IGyi21m872MXvKuzRkEL0TryuChCnY07xONQAjdVXUTTUdCrLRDuaAfX9fnRh924W
         +GTQ==
X-Gm-Message-State: APjAAAUq8AaAfK+tr9//pQU/RVIls2+IfL2+pQXDL84mg9dPDLctRDfc
        oZ9BuXD9FpOFyNE6jNR4HtyXDWgbPPOlzxaVb8BylQ==
X-Google-Smtp-Source: APXvYqzBN7l8ISCANHOSmoQVZ7BSwt3ADui9uc+L7MwmUC/V+3k+jtXG0/+Q6ONVrUpOvA8D2yYjNueSFsMjPD9iN3Q=
X-Received: by 2002:a1f:a5d8:: with SMTP id o207mr3327674vke.81.1571780756763;
 Tue, 22 Oct 2019 14:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-4-samitolvanen@google.com> <20191022182206.0d8b2301@why>
In-Reply-To: <20191022182206.0d8b2301@why>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 22 Oct 2019 14:45:45 -0700
Message-ID: <CABCJKudSBjOkPFZ-DBFRNqQ=kx5u1Q8W6MY0VGoo=5BTakP2dg@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: kvm: stop treating register x18 as caller save
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:22 AM Marc Zyngier <maz@kernel.org> wrote:
> >  .macro save_callee_saved_regs ctxt
> > +     str     x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
> >       stp     x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
> >       stp     x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
> >       stp     x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
> > @@ -38,6 +39,7 @@
> >       ldp     x25, x26, [\ctxt, #CPU_XREG_OFFSET(25)]
> >       ldp     x27, x28, [\ctxt, #CPU_XREG_OFFSET(27)]
> >       ldp     x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
> > +     ldr     x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>
> There is now an assumption that ctxt is x18 (otherwise why would it be
> out of order?). Please add a comment to that effect.

> > -     // Restore guest regs x19-x29, lr
> > +     // Restore guest regs x18-x29, lr
> >       restore_callee_saved_regs x18
>
> Or you could elect another register such as x29 as the base, and keep
> the above in a reasonable order.

I'm fine with either option. Ard, any thoughts?

Sami

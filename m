Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C92064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pru8Y7xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505274AbfJRRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:05:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42443 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505215AbfJRRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:05:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so4484907vsl.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6GpsgHPaenSyC5p+IrYQknWia4lKY0B5Vf4l4gdQSw=;
        b=pru8Y7xsWSIdqZR1UXLglz64NrdFImykv1hpXma1k378qh9GF0SPliCcyZB8vMX7gE
         X3PfTswubuOthM8DCa4MKuMqqB1ZfOPHIhuEN9TMHd7OTZoscSb0DkIwcKzx/zVRsRzZ
         QpVsX696Og4ZxdvD3yeFj/AnBmqkJaxHpcBabDgxa1/06jnOKR4SPg62RTTmmQ52t+8S
         vOzXu4T6IK5JJ+sLrpw1VPCRku6gZS08n7Kckhw2KqDpdWTQICKrAUvwcmSbe2WDexT6
         KcVKUWL1M2hSYKLv2USJ9PsVEnaLnEqc22VydBFXRMPGh4AiAOA8mz7cgBZHgxDEDolP
         r6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6GpsgHPaenSyC5p+IrYQknWia4lKY0B5Vf4l4gdQSw=;
        b=rLZ53lJURkkhqNXHY0VdIGmIIehCuLH2Tl3vyt+4i771o4eliM4of2xHTatPl8gWBR
         XnOnh6xaUkNubnJFWFClt46oWKnH8f4IGyN3SJ3slPVUY5xjqdWN9z6PZL4IFf5TVhgx
         Gg0o3G0CT3NuwJbtreozNigPtgc5B+zUF1RbpRUZj8cJzXN7ahRp0XKQYR9X+LNMIsx1
         jPZOms52urQBnV41e1Ov/9J+o2u5AiBlcuXW17HlFk4dPhVAE2YtDUCvL2pZw1o7QFpZ
         FxVtKEexfaJxgjKuKndoTmauHuvg/Dy2y29Kk6bDKWCS1ck1uv/UBFta43j00ZBxJdWd
         5+eg==
X-Gm-Message-State: APjAAAU5+lDaOYuDNQxovZ6OMT+ZqZt21tcyjR5dyYA7zIapJD83H8vM
        6Sq6L150nqDwFq8NaOdX/+WM51Qczmn3aMx/gSkACQ==
X-Google-Smtp-Source: APXvYqwYzSrQhNESR2odZjGb7CA2wtjkk8PIj6W3+g28TbncpOPsZUdRhuZ5AejLhrFJsW3Q8+X1IzSvMoqY0M2m7JA=
X-Received: by 2002:a67:ffc7:: with SMTP id w7mr6159173vsq.15.1571418330160;
 Fri, 18 Oct 2019 10:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-14-samitolvanen@google.com> <CAKwvOd=7g2zbGpL41KC=VgapTYYd7-XqFxf+WQUyHVVJSMq=5A@mail.gmail.com>
In-Reply-To: <CAKwvOd=7g2zbGpL41KC=VgapTYYd7-XqFxf+WQUyHVVJSMq=5A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 10:05:18 -0700
Message-ID: <CABCJKud7bJOQqyve9=niSP62H0WTrCk5ZAmAcD2-KR=vf_gn0Q@mail.gmail.com>
Subject: Re: [PATCH 13/18] arm64: preserve x18 when CPU is suspended
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:49 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index fdabf40a83c8..9a8bd4bc8549 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -73,6 +73,9 @@ alternative_endif
> >         stp     x8, x9, [x0, #48]
> >         stp     x10, x11, [x0, #64]
> >         stp     x12, x13, [x0, #80]
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +       stp     x18, xzr, [x0, #96]
>
> Could this be a str/ldr of just x18 rather than stp/ldp of x18 +
> garbage?  Maybe there's no real cost difference, or some kind of
> alignment invariant?

Sure, this can be changed to str/ldr. I don't think there's a
noticeable difference in cost.

Sami

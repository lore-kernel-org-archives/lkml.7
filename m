Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B681BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H3Qpl43z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfHNBwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:52:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfHNBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:52:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so25757253otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ug4XyDfcmMOuMpWVbRrmxyBe79U3+07+R7DrPjFhFk=;
        b=H3Qpl43zHubnuxu9OeDUV6gNsk9ptFFpiS3tjk+JhDbkCzO5OTUNJ+x6iHMyC3vCEx
         VbkQ8BjdNO+ZzE6JvWHFDZXdAAfL3wlIr74iP1WMr+un9rdwPj2rr1/qt/eZ9eWhECwm
         Q9/6UM3j2Rmcy8meLn/KdQjrKCmP10rnnRpjK5vipv8V0+azE4ZI8y+vHThYi4fV3lcr
         kmcSGolb6s6Rse18SFBm8A0G0B6iZuhypyyrhygGMEcW+/JxYBA99AZjSQ4xHiZMvDBJ
         c8CYz9uU4zagJrwSkP+YnoM0kakAgjJN0+LJauBeDSyNAA6mfx27pxnGrbWr0f0x2B07
         O4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ug4XyDfcmMOuMpWVbRrmxyBe79U3+07+R7DrPjFhFk=;
        b=LwHbuxuSxxHrjg8V00psQ7yXtvGxOb2ymG4FDqjjLnd5KcfPGxnXEtLszbFYN22N0N
         JN0UnVUL8FpQyOmOzN1hV4KGVjJST8Ue38P6ferUM0Eg2jGdBDbhgEumtS/0k2oSvWo+
         xoyBjJHYW9N4gfCj/TwUfS9mfm8V2Yop07UhiGVubqvgEmltkvCw4fimC9Bk7WHLxmE/
         xbG9DJ/Tx8GjQXGHHyd4jdK9ZrDhfdxZBqNxGTyG8Jxu6SJF1C6ofMaBqt4nz4zEVccr
         BTMx9Cg9wN8wOmpUjOSUJIVzh54+N8S5JCbunQStAyK3/sHod713ip942JxHRc1JDBRb
         MoFQ==
X-Gm-Message-State: APjAAAUHlyGCEC9zXBw1KU8/ukiDE9woqbhwiaoHLaLMC+iR/bjE71Gp
        rVbqwTMJ+8+LcXXDd/1NIkFyWDgXVWVc5wMrI8Snyg==
X-Google-Smtp-Source: APXvYqzWeCKpEUmkGDS8DBay+V92sEA+A3njpbTvqLWlVAz5mO3zMFf1YbawLtL2Mhs9gzmNr1ooW6c52hDsZtykv70=
X-Received: by 2002:a5d:8550:: with SMTP id b16mr20860458ios.11.1565747541406;
 Tue, 13 Aug 2019 18:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-2-git-send-email-vincent.chen@sifive.com> <20190812145816.GD26897@infradead.org>
In-Reply-To: <20190812145816.GD26897@infradead.org>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 14 Aug 2019 09:52:10 +0800
Message-ID: <CABvJ_xiPJnAOuU95jqNJx4hBGP0fFqD4suYFz_TY5F+aP9ni2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:58 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static inline void fstate_off(struct task_struct *task,
> > +                            struct pt_regs *regs)
> > +{
> > +     regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;
>
> No need for the inner braces here.

Ok.

>
> > +}
> > +
> >  static inline void fstate_save(struct task_struct *task,
> >                              struct pt_regs *regs)
> >  {
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index f23794b..e3077ee 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -64,8 +64,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
> >       unsigned long sp)
> >  {
> >       regs->sstatus = SR_SPIE;
> > -     if (has_fpu)
> > +     if (has_fpu) {
> >               regs->sstatus |= SR_FS_INITIAL;
> > +#ifdef CONFIG_FPU
> > +             /*
> > +              * Restore the initial value to the FP register
> > +              * before starting the user program.
> > +              */
> > +             fstate_restore(current, regs);
> > +#endif
>
> fstate_restore has a no-op stub for the !CONFIG_FPU case, so the ifdef
> here is not needed.
>
You are right. I will remove the Ifdef condition.

> Otherwise this looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for your comments.

Regards,
Vincent Chen

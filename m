Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D77AC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327372067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nR8gnnyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfHNBzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:55:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41244 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHNBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:55:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so70691252oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvZgcIP+Jz1WkFSRFJD+95uSrVx6pGRMAeYWt8sXANU=;
        b=nR8gnnyZRdfRZx9cim3gfa/2rzzlVipxp14EzBfCKecBs0Grr6AFbJafklNapdif5f
         hIoqsk+mTRXFf2UXw6qFcPGpXgmVPO4J+U8Jlz/+s0IYqRxh35OzmQTs1c3bH4FlY3mn
         SAznTDtZCGVgQPKfZJbkr3R4/5cXJl8xvZcp4CLm8hfEBpeyo+EFw02RbVD/8X9yHl6l
         FHTEt0T2pOHo9b+Tfjn4+a1y152LDTnUVEGuo045KlpJ/J1fRKThlyJfhT/VplY6L4pU
         vec0pNhtcH6/6ADhfcjcsDcXXUgeT/0pG89j+VaJed4xyrxDSxLp8f4DSDjEHUIsumT7
         MnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvZgcIP+Jz1WkFSRFJD+95uSrVx6pGRMAeYWt8sXANU=;
        b=ieXJpSyFaxWEBHE4JeKHyxbsYsQWk3GhD6awgQ2SNRC9r8M1xGA6IVRj2dWvA9Lp7M
         n2Ha/+n5XeczsqA6UpI9LJB63j+oqjaCzA9M+Xnk8rXP3waQGWYAUg8ou9nqxY37IXni
         DG9tNxV3KCJCmTPFoYrAjFtUc3eTTBaHqHgLQUEaOxMHKbk8Cf/+3ed1dz5tfBx9mNCX
         GzRKmQzG4ZWC3Sx74CwCGxkndpIghfDmkjkpjMrXXXWtxd7KMBw2RjbLhp4EdWsoKTNZ
         /m2X4S2DaZsRNRDvOHdDueY+7/Vb3pDXsEKVRzwUkSNVl0NqzJ62SLfts05efbBJ4hvi
         LbUg==
X-Gm-Message-State: APjAAAX8cOXtJwPAlkJrmrayBuFeeMdsj17MemH9nkQEOINnLAlBobyO
        ujqP9R/AS04ykEVKzkjsHykBmwLkuZm6GYBkgzIu4A==
X-Google-Smtp-Source: APXvYqxabDnVCz5t3YGwHj4Wajl2jkHY57yV8V5il3H+b7zJluu8RtF0b2vDXOPUfLIYaCxMg97I5SrxEqwI/LjsarI=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr889740jan.18.1565747711676;
 Tue, 13 Aug 2019 18:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-3-git-send-email-vincent.chen@sifive.com> <CAAhSdy0+FeZecT0Xppwq+fGu-BV7dp+zY141R73=0O=khKdOKQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0+FeZecT0Xppwq+fGu-BV7dp+zY141R73=0O=khKdOKQ@mail.gmail.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 14 Aug 2019 09:55:00 +0800
Message-ID: <CABvJ_xjvot3xuHrbmV01hzejx7y6ty2Oy-BNLRfa=Fq4=u3dFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Make __fstate_clean() can work correctly.
To:     Anup Patel <anup@brainfault.org>
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

On Thu, Aug 8, 2019 at 6:17 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
> >
> > Make the __fstate_clean() function can correctly set the
> > state of sstatus.FS in pt_regs to SR_FS_CLEAN.
> >
> > Tested on both QEMU and HiFive Unleashed using BBL + Linux.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  arch/riscv/include/asm/switch_to.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index d5fe573..544f99a 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
> >
> >  static inline void __fstate_clean(struct pt_regs *regs)
> >  {
> > -       regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
> > +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
> >  }
> >
> >  static inline void fstate_off(struct task_struct *task,
> > --
> > 2.7.4
> >
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> This should be a RC fix.
>
> Please add "Fixes:" in your commit description and
> CC stable kernel.
>
OK, I will follow your suggestions and resend this patch
Thanks for your comments.

Regards,
Vincent Chen

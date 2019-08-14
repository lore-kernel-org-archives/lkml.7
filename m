Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2010FC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87822064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="HFCBcW46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfHNDwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 23:52:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42438 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHNDwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 23:52:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so12989303wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++nUJKgOGfOdCIF5m2zpPrP5+AC7n3dwa/EWdf1OwMc=;
        b=HFCBcW46Up/t7+Wpl1cQtJ2Z0MWWKq6hkQvKXb3ym5uKoaplfmgQwory4qEbWfO4jw
         tk4sWyGPPvxTFuwmNH0szfExit3F3tjHFyEC17hzd/O+B26qqXulmiGX4YwMuKHgHizU
         8TgYxnzBNDEmjCDzCQh4mAmIHvEmxajyieBp+Q3VHuVWOUchIrYDojdBEU5R7S+xICm2
         J5V2EQAPVtzexPzWD9BnIpG5lPctZMUORM4Avsyg6roeqpB1C8xkvivNLmXQmGdckM87
         PwnQyfM05C3qbnxKCnsyx57TASNa2KqJY4CbFeyk5lrZMRDLbodZIOcFwe0hZQsw2HiQ
         c/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++nUJKgOGfOdCIF5m2zpPrP5+AC7n3dwa/EWdf1OwMc=;
        b=tGjVbQF5IemV28QpGs30IOtG9Fkp1aYC0GIMxzS0WU5JKQ/971uRdrOMZCLUujHcA9
         yYG4rmHFFdzbT/gLmnqS8zL/dH39DLhBvXncIbt0uATPxCMODsYTR5ugQ3FDgFNCcdSq
         yT3SOYOd3QF+Ps9+JsODcAg7ls0/Hj1g76LxWyifmw1zgkEDHzOdyVBqZ7UbNIvpA41M
         5uWmAncUbCj6PBpYAgbZRLF9zRT87jYwuc6xHrSsoFSyVHm/qYQByHNrrjr6ysB/rOAi
         McTlzPXk67eYsy4D1CFm3jGPwZnThX7Tb/vmdizEUwAiiGrCNo87TSa0CbEIEogNVoUI
         agng==
X-Gm-Message-State: APjAAAVQa57LB8BhWGhBBVDdI2OkXs6ro7hZtriww071bvW4ieWVnQGh
        LWtZb2ZO4HI1NuvBjAxu5zG+Dk1F+kAQc96eu+9imI9Ep3Uylw==
X-Google-Smtp-Source: APXvYqyKhu6lwNRBKi6qoG6yfgcV2346iuvFcAyShI7YY1Od8sKPmm/Nn1gLTd8DaJxE6ZEhmmIXoQqWi/pM+l6tNl0=
X-Received: by 2002:adf:f641:: with SMTP id x1mr6622878wrp.179.1565754728415;
 Tue, 13 Aug 2019 20:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
 <CAAhSdy0BNN4G270WJ+OqrFAv3-z9o2iE+QDHHo-FY0fqh5wGqg@mail.gmail.com>
 <alpine.DEB.2.21.9999.1908080846220.21111@viisi.sifive.com> <CABvJ_xgHVT4QKAxRPdLQp3Q5bTmjQ5QfTo6R49Z0Qwatuc_b+A@mail.gmail.com>
In-Reply-To: <CABvJ_xgHVT4QKAxRPdLQp3Q5bTmjQ5QfTo6R49Z0Qwatuc_b+A@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 14 Aug 2019 09:21:57 +0530
Message-ID: <CAAhSdy0mOspKF7Z7H9MsbdrYYF3M_XGfm+F-dAt2wZSW_90PFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
To:     Vincent Chen <vincent.chen@sifive.com>
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

On Wed, Aug 14, 2019 at 7:15 AM Vincent Chen <vincent.chen@sifive.com> wrote:
>
> On Thu, Aug 8, 2019 at 11:50 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Thu, 8 Aug 2019, Anup Patel wrote:
> >
> > > On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
> > > >
> > > > +static inline void fstate_off(struct task_struct *task,
> > > > +                              struct pt_regs *regs)
> > > > +{
> > > > +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;
> > >
> > > The SR_FS_OFF is 0x0 so no need for ORing it.
> >
> > That one looks OK to me, since it makes it more obvious to humans what's
> > happening here - reviewers won't need to know that "off" is 0x0.  The
> > compiler should drop it internally, so it won't affect the generated
> > code.
> >
> Thanks for Paul's comment
> My thought is the same as Paul.
>
>
> > > Apart from above minor comment, looks good to me.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > Will add your Reviewed-by: tag - let us know if you want me to drop it or
> > caveat it.
> >
> >
> > - Paul
>
> Dear Anup,
> I suppose you can accept our thought about using the SR_FS_OFF flag
> because I didn't receive any reply from you.
> Thanks for your review and comments.

No problem, go ahead without dropping SR_FS_OFF flag.

You can include my Reviewed-by.

Regards,
Anup

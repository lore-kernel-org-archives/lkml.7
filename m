Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B39C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD4420679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ksZ5YGUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfHNBpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:45:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41405 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfHNBpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:45:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so70668108oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fZGGflcHSO6++NhFYLpIqwxfvqbffISbsrAMMT2Dzk=;
        b=ksZ5YGUjNXobZyPLfwAAQMKGG8OGkzL5xNvBSPDRQVxxsPqDOYDlQJPpZcxXmKgCL0
         IW7G2Z/WCnAjH+mnJzQFhjKsz5jXULbm9rNlirMr32SZJeoyKd1lnYvFhDgqtG/Ho7Dh
         HP126MRyLkQTxd3tCozy6FwqMN7VTAE39GUQTZl/R6qFq4maEqJecfRZEX7WKzjLNTsp
         dhvh8buW+JavLizx/kuQV4NJ9q3GKdIpr3w1HpFq6Oshe21aY9PM3zxVtvP+FjANyQ4b
         MhIbA6PwzgoRiSvbdQfxJOEgYayZXwrPd85HZ9dwfKp/mh/YLOf0sc8nczy5Nt4bpbmj
         DgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fZGGflcHSO6++NhFYLpIqwxfvqbffISbsrAMMT2Dzk=;
        b=n/yng6XSRFrdZ8P+Fugp7IsxD+3+/Spo7YOCv+wqsKY8eaW1ejcRQ+cmldK6q6SlEe
         PdcNWzvWpGHD5k4/lTAE0edv1XZSQyxD5pv9/xhAqWtqaMbGAl+v8L2BOybD0Gvc/iQk
         vCPOjp4U1lerGwRwMxUhoMTGDtyKEVODIVXWonmlt5SJk+LvvzRQzP+lfLkUZMXrXDmJ
         e4D+dmEgDi+uKtcbh7N7JrRLqaNI6fog9+nOA0FGH7TOeOdJbnlZ8xN4bBQIhtHnhNQf
         U1n72D7ELvJQKjwqOU9Wf0gnNdJj/AgY8yXX+nVKBDwJumOao2CYvEt62wSduQtcSHsH
         vfgA==
X-Gm-Message-State: APjAAAVyX04iB0WrUSUqHR/UoWoUZG108sX2btdNdzbN2gBRpk50SCHM
        bXX6PWfNUamUwn4UWEYPtriKXcp5Tq/HglVm1rdq5w==
X-Google-Smtp-Source: APXvYqyuKYoG2z8x+utlTG7GYkCrZ6xSw4dAV5128rMNgdisgD0O2/PVakMv3+vupQM4KHg4U90WmSfubI0A1WzKinM=
X-Received: by 2002:a02:2384:: with SMTP id u126mr858943jau.30.1565747148032;
 Tue, 13 Aug 2019 18:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
 <CAAhSdy0BNN4G270WJ+OqrFAv3-z9o2iE+QDHHo-FY0fqh5wGqg@mail.gmail.com> <alpine.DEB.2.21.9999.1908080846220.21111@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908080846220.21111@viisi.sifive.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 14 Aug 2019 09:45:36 +0800
Message-ID: <CABvJ_xgHVT4QKAxRPdLQp3Q5bTmjQ5QfTo6R49Z0Qwatuc_b+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 11:50 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 8 Aug 2019, Anup Patel wrote:
>
> > On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
> > >
> > > +static inline void fstate_off(struct task_struct *task,
> > > +                              struct pt_regs *regs)
> > > +{
> > > +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;
> >
> > The SR_FS_OFF is 0x0 so no need for ORing it.
>
> That one looks OK to me, since it makes it more obvious to humans what's
> happening here - reviewers won't need to know that "off" is 0x0.  The
> compiler should drop it internally, so it won't affect the generated
> code.
>
Thanks for Paul's comment
My thought is the same as Paul.


> > Apart from above minor comment, looks good to me.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Will add your Reviewed-by: tag - let us know if you want me to drop it or
> caveat it.
>
>
> - Paul

Dear Anup,
I suppose you can accept our thought about using the SR_FS_OFF flag
because I didn't receive any reply from you.
Thanks for your review and comments.

Regards,
Vincent

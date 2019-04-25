Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAEDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA75E214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OW30lv7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfDYIRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:17:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfDYIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:17:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so23311000wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9RYUwqYs8GxnXHLt/p3Fz6x5DoO+pRsegYtnMfkhYI=;
        b=OW30lv7+KMGA1SvNnrC1b9nUxyPmrhzCwlLdnhO49dL4Y2a3DCBE1TGq2LS2gO18ts
         bNVhuCfsZ2dYI3OqebC2QB1SRjQyM8HndAJuRSFxsqmU2dZMcJZEI7+EKm+0iNNErUvP
         52/iFBVr5IzSt08jveciUgxVXttQ4d+GdNmM85RPSBT+SIpqMnNYT2HJSqz0kv46BH1Y
         c1jvlsP+FOxDQ2Eg8X2Aq4+t1Hpdi2lnJoocoAulmgT7hjtdGbSEUapFtuldk2nhAmRd
         2MrOCtd9qhO2QzTLwNQFqCnF8Bg0YurSosNVvqYW6ASIR/06jfc0vrWzlgJmgrIEY1do
         1vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9RYUwqYs8GxnXHLt/p3Fz6x5DoO+pRsegYtnMfkhYI=;
        b=qezDImjgos91Hwiir5O3rKOY2KzKVE79tq0mxpxKPVwsWK/d/IpDBbnLbH35uijFRZ
         WA/99qUz+bsQT3lk1VsIH+rWX3iddlyVN1+BAfV9g9ot/l4CDMDjNBeoLzpmVFaI4zCM
         skMpCGP2nLtS7A2FdK3dusTztDbL2BVjuUD5b7KfQYmspfgegDwjV8X3WtgR4ZZoGznB
         sYfqTVDiU0lbuc6xHyN1Y94s3NV7rrWYYC1bKa5Llc0rfza5oKq+lD8/5wJdGcUJBCID
         PtuKYvUkqdMfEYulqvcSctryWsIasABRs1zRugHaA+bBs9OihCMBxtpjrgs0NEON166R
         z1Og==
X-Gm-Message-State: APjAAAX6x+1oiQLoKUb+b20dxDh6JAsB9gLwPt53PHIyr33nxhxlEAJq
        2/+GkI2h+RMJIJ6WudWjOttjYT0Cm8JcfscxvDUD9A==
X-Google-Smtp-Source: APXvYqz6cL1WMgmusMQg+hkMCdQCzrq7wzmGiwVnpGvldT/cM4eqPWnf8C8tW1NZQkbZOu5U4n7+NAWd4McNqKXyRO0=
X-Received: by 2002:a5d:5346:: with SMTP id t6mr4334662wrv.59.1556180257986;
 Thu, 25 Apr 2019 01:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190425055015.45487-1-anup.patel@wdc.com> <20190425055015.45487-3-anup.patel@wdc.com>
 <20190425055757.GA30545@infradead.org> <CAAhSdy36q1R8HQRG3kXDqj5JoJbO_drignvO7wCHJ3-6wkE5rw@mail.gmail.com>
 <20190425080117.GA3575@infradead.org>
In-Reply-To: <20190425080117.GA3575@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 Apr 2019 13:47:26 +0530
Message-ID: <CAAhSdy3rEPGHkHEL9gSnEQVArFxXNNfPsbUHrQjqMf+Qbqw0zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 1:31 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 25, 2019 at 12:46:52PM +0530, Anup Patel wrote:
> > On Thu, Apr 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > +#ifdef CONFIG_64BIT
> > > > +#define SCAUSE_IRQ_FLAG              _AC(0x8000000000000000, UL)
> > > > +#else
> > > > +#define SCAUSE_IRQ_FLAG              _AC(0x80000000, UL)
> > > > +#endif
> > >
> > > Please keep the existing defintion that doesn't need an ifdef..
> >
> > Sure, will do.
>
> While we're at it: I don't think we need both INTERRUPT_CAUSE_FLAG and
> SCAUSE_IRQ_FLAG.

Oops, I already send v5. Saw your comment just now.

Regards,
Anup

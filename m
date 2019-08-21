Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DE2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA8722CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CC01joea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfHUDxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:53:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37766 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHUDxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:53:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so624943wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q866pfLZUUGzykCVlgEKOZZOziqbhijhD1KhBLgHDuA=;
        b=CC01joeanbShowTYisfRKQQ61kAqiysEDe7KMhHsnvznkhCvA0zOqJJ3ZLtNn9TzNR
         d4q11HxmhCYM5xBMBbmm/7OPjW5vwv/MNCer3+ZWkpumdjU9siisBaMAaJVEBXnFDOje
         BFI3q5R0PpiqBxvKVcxTuRSpQntslzKq3jtR2aldxgBB+zHHA5GG+brSqjTztNsmm2dZ
         Wa4Voa1vfrl7cagd03kgcjwZbJXGmwO1u9NK0CcoOIgTt42geUwgVkA977wX2Nkkawth
         RjbTy+5+7/G4T1cDWvaAS3nLUi9GQWtaZ1T/t8tBFXAR096gRYYUGmTlkQngJU0/xfoQ
         kbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q866pfLZUUGzykCVlgEKOZZOziqbhijhD1KhBLgHDuA=;
        b=mbSjEOueFyU4c7H9Y/KDVc7i7VnTeT/8/YRCtIHPNuJ2H1/B7LpNRMu78NAb8uWQr5
         19Uv6in58Z1w8MH39au5zEo+CWWHogERznkECHnlmUkGD8n6bvbTvb17nv9Msnyhx89V
         2Ft3ZJHY0/zSRqsuErNQfloy85iuYGvaNyM7909BcqHEZdQ8kywd+BJZogkvkEcoJcXK
         JasS1QDhMOOU9cVDNpq2+Geiq8vzKyBMUAdAq40sJIkjzUcAyd7v01YD+Ix6lPFfSdrQ
         IHQJ2Iu7GVT1aUv0KeWIs1PIK9jpiVxmYKg6ghYyHoTAcsH4Lkv5n0blMlikh4DntTP3
         P8nA==
X-Gm-Message-State: APjAAAVoUAnxPbfBlgi+fm6rOIZBYnehGzP05Rb9wvFsfFcfJ/NjHamt
        MQvKwBy5z/tmdrp2DpMH1k4eJX2QOLezvh5bn8IR5A==
X-Google-Smtp-Source: APXvYqzDZPixEa7x5dg6CFkkM3l2F1MJKZKytyiRjSYnXVT5ZH6+qKWyalba8BS/+Y8qD7J/UcdZL695Rb+CDBmimGQ=
X-Received: by 2002:a1c:3d89:: with SMTP id k131mr3004134wma.24.1566359579978;
 Tue, 20 Aug 2019 20:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190820004735.18518-1-atish.patra@wdc.com> <mvmh86cl1o3.fsf@linux-m68k.org>
 <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com> <20190820092207.GA26271@infradead.org>
 <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com> <20190821012921.GA30187@andestech.com>
 <20190821014052.GA25550@infradead.org>
In-Reply-To: <20190821014052.GA25550@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 21 Aug 2019 09:22:48 +0530
Message-ID: <CAAhSdy0GX9BbayYScsm2_Mvi0hDH-y0UVvTWFGLbKY-rE8TfZQ@mail.gmail.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Alan Kao <alankao@andestech.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:10 AM hch@infradead.org <hch@infradead.org> wrote:
>
> On Wed, Aug 21, 2019 at 09:29:22AM +0800, Alan Kao wrote:
> > IMHO, this approach should be avoided because CLINT is compatible to but
> >  not mandatory in the privileged spec.  In other words, it is possible that
> > a Linux-capable RISC-V platform does not contain a CLINT component but
> > rely on some other mechanism to deal with SW/timer interrupts.
>
> Hi Alan,
>
> at this point the above is just a prototype showing the performance
> improvement if we can inject IPIs and timer interrups directly from
> S-mode and delivered directly to S-mode.  It is based on a copy of
> the clint IPI block currently used by SiFive, qemu, Ariane and Kendryte.
>
> If the experiment works out (which I think it does), I'd like to
> define interfaces for the unix platform spec to make something like
> this available.  My current plan for that is to have one DT node
> each for the IPI registers, timer cmp and time val register each
> as MMIO regions.  This would fit the current clint block but also
> allow other register layouts.  Is that something you'd be fine with?
> If not do you have another proposal?  (note that eventually the
> dicussion should move to the unix platform spec list, but now that
> I have you here we can at least brain storm a bit).

I agree that IPI mechanism should be standardized for RISC-V but I
don't support the idea of mandating CLINT as part of the UNIX
platform spec. For example, the AndesTech SOC does not use CLINT
instead they have PLMT for per-HART timer and PLICSW for per-HART
IPIs.

IMHO, we can also think of:
RISC-V Timer Extension - For per-HART timer access to M-mode
and S-mode
RISC-V IPI Extension - HART IPI injection

Regards,
Anup

Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9065A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0GHJfGDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfG3Nu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:50:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfG3Nu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:50:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so65887083wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7iKvPV9LFHWqoOOGTIb4owz/JIo887EqlnJgr1d4nw=;
        b=0GHJfGDW2+1fTzradLIxRNe68wCgVz7Su5dFoY1O20icu9FNPAkVtC6+y4atcRMxME
         LcAnnmyGc8smLgt4iLpxEspPujnp8HMheOwuMHP0pAMcloddLv1fs/DRKKFhRC2ac+Ne
         VW8ZbKiyM1GJPZezCkfglkHLjjVVNUQ8+LRo4iXCMgoKbb/f6yj1572GFFG1AzE+0QXF
         8S3O8nLPsanoO2A4C3oQBXFbiXfh5I7Wg5MAYYFo02lBtkJ+KR/UKV1UCkz9CUGqD5Kn
         x63CLAJYfZv61CF/+8VNBKxdFlwgE2WSAx/lyEkviTmfkW5V/lsduqB+wK24KIfF4388
         X5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7iKvPV9LFHWqoOOGTIb4owz/JIo887EqlnJgr1d4nw=;
        b=nsaWyrozx34YstCmw6zc39tCzbVhE7FOo/7LpoCz9fJ59PapY5tx/vypVbrGqelvF1
         SzdYN5bnKekY/wNKQiO9eiwwvahXsvVwKzCrImIjAey7lToVkqR1aGY1JFuxkZiOdrSr
         FbAk9Zs0cAX1uZSwpgoW73Y715rboh3OWXpJauKpYSXJrYFC/5PEeY3xWwKOmAihODGr
         c0b1iZKtwPEBeAznwJgZm4NNoNjWxUpD5eJRoJnkTYbMFHLTq0fbPVOXU/UWtfntwBvB
         O1r1Di8DCmDnsHdHpOLw9hi5pr9AB2k5R7ukE57/64UROSJh/iCrDWt0OT3aYWMAmXHo
         RKzg==
X-Gm-Message-State: APjAAAWYUVH1KEnTuUVyMLNbMQMwmWh/AzPatOgx0FPaWOiZCWKw+ONE
        QbrLvq7HmAld17dXzhXB1pccJB+UimB4H2LNMRI=
X-Google-Smtp-Source: APXvYqzRXwAqxGGy/gS1AN6Q4wfcCCsKG4LotfmFtE/HfO4p62K/RIkYnvqqEzbqc7z86kGIdpo2P3e9L0EefFqpksc=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr50794346wrw.323.1564494627045;
 Tue, 30 Jul 2019 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <72e9f668-f496-3fca-a1a8-a3c3122a3fd9@redhat.com>
 <CAAhSdy3Z6d2phRGo20eNWfa4onFwFtsOUPM+OCD465y0tvQ5wg@mail.gmail.com> <965cffdb-86e2-b422-9c23-345c7100fd88@redhat.com>
In-Reply-To: <965cffdb-86e2-b422-9c23-345c7100fd88@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 19:20:15 +0530
Message-ID: <CAAhSdy0Sy9YV5ymdFk0URLY4GvOkWaWOpC_Dju+1ada_yc=Pmw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 5:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/07/19 07:26, Anup Patel wrote:
> > Here's a brief TODO list which we want to immediately work upon after this
> > series:
> > 1. Handle trap from unpriv access in SBI v0.1 emulation
> > 2. In-kernel PLIC emulation
> > 3. SBI v0.2 emulation in-kernel
> > 4. SBI v0.2 hart hotplug emulation in-kernel
> > 5. ..... and so on .....
> >
> > We will include above TODO list in v2 series cover letter as well.
>
> I guess I gave you a bunch of extra items in today's more thorough
> review. :)

Thanks, your review comments are very useful. We will address all
of them.

>
> BTW, since IPIs are handled in the SBI I wouldn't bother with in-kernel
> PLIC emulation unless you can demonstrate performance improvements (for
> example due to irqfd).  In fact, it may be more interesting to add

I thought VHOST requires irqfd and we would certainly endup providing
in-kernel PLIC emulation to support VHOST.

> plumbing for userspace handling of selected SBI calls (in addition to
> get/putchar, sbi_system_reset and sbi_hart_down look like good
> candidates in SBI v0.2).

The get/putchar SBI v0.1 calls won't be encouraged going forward because
we already have earlycon implmentation in-place and Guest kernel can directly
write to UART registers for earlyprints.

If we still wanted to implement get/putchar calls then we would need a RISC-V
specific exit reason in KVM. We have tried to avoid RISC-V specific IOCTLs
or exit reason in this series.

>
> > We were thinking to keep KVM RISC-V disabled by default (i.e. keep it
> > experimental) until we have validated it on some FPGA or real HW. For now,
> > users can explicitly enable it and play-around on QEMU emulation. I hope
> > this is fine with most people ?
>
> That's certainly okay with me.
>

Thanks,
Anup

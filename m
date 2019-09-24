Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9E20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 05:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xk0WaUyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409020AbfIXFH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 01:07:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409007AbfIXFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 01:07:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so327264wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d47E32C9RUOC5wWI8ATuz+LPjAEghSrUhg7r5IgcGw=;
        b=xk0WaUyL1bcfquknkF16bbwNOlHNKes+nkQlDlLr2dbIuiGGKwWswlpRW/npj90Pbp
         z/MrEp/lBndbQrNq4ws8M1Js64R6OavvHdhzyDhYlGYMQIuFSZ031gDiODKzkZJUykM8
         Oa4zpJXbWUqNf0m7Rfr65UFEO9v0GA4CtOfdmhfn3hal9uv3KrdOEJZ6EdTJlyc5ksZD
         skdeBU7z+mE14MU6hxrVOoI1DonRXai40vjdsmQUsNwmmN12Sm9D5CE5EbNoe9QUb5eJ
         dehyr2pMmM+b3jY5L+j2gihyQn5h2oJzty8UFT8PW2+chfCN9Q9V2sFZUPg+LOTY34Zz
         RwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d47E32C9RUOC5wWI8ATuz+LPjAEghSrUhg7r5IgcGw=;
        b=fnGG+B1QbFVy1uOsBWH6lwAbBOgOZ7mbbsY/7sV60toh8GmJjB7ezWFFdgL8vvfjlx
         2kGSlI6TZnwtgSUhZsPnkr9J0NyyR92pF2Mx567Vj0q56Y1nsL0dwx0RRVZNhvgp4E34
         5MiY7+nqbph8o1Yu388+krgVX2w+nzL8E6iGdSbolu4hZC65TQBrPfcRVjxupx6IX6QK
         FIUlYvp3jNRtS0njxwukZQAo/uEiNWvHY5773HPQ2Bm9dn9nI6gdZhV2jN7udZ6CeQy/
         pAPkA52InHP+FTU7EcCsDNEPMI5mXNOqoPsqnGKw9oWP8O6I1T53rj6NffOvZvAcx/jv
         zfEw==
X-Gm-Message-State: APjAAAVrt4B2s7QOLPMK6SERtGZTEJpXuavxNlrMsksHqiRkqwQ9wX/W
        y1qlkqEYoFezNWdjOIArsOq65MypzYRgxcUcSZc0FQ==
X-Google-Smtp-Source: APXvYqwkgvLZ1ao9vw+cuFq1o7BDXNlJZMaWP1xTU3OzBpsnv6FrdOOWOJg+vki1pWF9gE3sE5XfxFfMzY+7t0S+mXc=
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr634403wro.330.1569301674793;
 Mon, 23 Sep 2019 22:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190904161245.111924-1-anup.patel@wdc.com> <20190904161245.111924-12-anup.patel@wdc.com>
 <8c44ac8a-3fdc-b9dd-1815-06e86cb73047@redhat.com> <CAAhSdy1-1yxMnjzppmUBxtSOAuwWaPtNZwW+QH1O7LAnEVP8pg@mail.gmail.com>
 <45fc3ee5-0f68-4e94-cfb3-0727ca52628f@redhat.com>
In-Reply-To: <45fc3ee5-0f68-4e94-cfb3-0727ca52628f@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 24 Sep 2019 10:37:43 +0530
Message-ID: <CAAhSdy29gi2d9c9tumtO68QbB=_+yUYp+ikN3dQ-wa2e-Lesfw@mail.gmail.com>
Subject: Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
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

On Mon, Sep 23, 2019 at 7:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/09/19 15:09, Anup Patel wrote:
> >>> +#ifndef CONFIG_RISCV_ISA_C
> >>> +                     "li %[tilen], 4\n"
> >>> +#else
> >>> +                     "li %[tilen], 2\n"
> >>> +#endif
> >>
> >> Can you use an assembler directive to force using a non-compressed
> >> format for ld and lw?  This would get rid of tilen, which is costing 6
> >> bytes (if I did the RVC math right) in order to save two. :)
> >
> > I tried looking for it but could not find any assembler directive
> > to selectively turn-off instruction compression.
>
> ".option norvc"?

Thanks for the hint. I will try ".option norvc"

Regards,
Anup

>
> Paolo

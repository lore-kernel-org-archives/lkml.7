Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD79C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE02089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561869159;
	bh=cQSFOfkpKMob0CUu8153N6DUVyC3npdxm62i1j4VpIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Khkz6zTZsbQQdRCN3u9ArYl4cG64apj2wIV7kG3lagjmqGB9VgJu5XvtjtSc7Y9RM
	 6pk28ASib2g4GA4XehWDQ9+sWleQZ1eGOvs6LtNyZASGN7cNr5MZwt/Wr1cFgi6ES+
	 xj8uBtqapZFvJDx7QalU8TpBQ3eSDKljFe3SUS48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfF3EaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 00:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfF3EaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 00:30:01 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E81F2089C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 04:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561868999;
        bh=cQSFOfkpKMob0CUu8153N6DUVyC3npdxm62i1j4VpIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j72oOEAif2V94f0mwKfr5J/PRx+YFli4yICxddcq/LIiS7JQ+YKk1YGF4PSgQDKL7
         IMJd+IOSbwJSo6k5b1N04qP590P8btcmtnruiRG/EpAmzvilpIrTFErZtfqeXBnnsi
         04dlqRLB1LypljThQz/jstMx1/Gu9frEnC0Vy7yo=
Received: by mail-wm1-f47.google.com with SMTP id n9so727523wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 21:29:59 -0700 (PDT)
X-Gm-Message-State: APjAAAU/Qs/LYBXjGZdXLOqVa/fkwm+vsg9nqnOdr3UIh3ajMZkQIcH1
        kgp3qsUv0KppIkqTIQn0e0sSp/43gkoFZtdIhC4=
X-Google-Smtp-Source: APXvYqykrDoGZznjGRXJXJkVCBwA9280hX7gYGYy3Dbo1kbGt1iT4Zj+H8TCZ/zglBC8rdfd2ydmBM/xQE7cDlA9Xmo=
X-Received: by 2002:a1c:6545:: with SMTP id z66mr12063849wmb.77.1561868998022;
 Sat, 29 Jun 2019 21:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com> <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com> <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com> <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
 <20190621141606.GF18954@arrakis.emea.arm.com> <CAJF2gTTVUToRkRtxTmtWDotMGXy5YQCpL1h_2neTBuN3e6oz1w@mail.gmail.com>
 <20190624153820.GH29120@arrakis.emea.arm.com>
In-Reply-To: <20190624153820.GH29120@arrakis.emea.arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Jun 2019 12:29:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRUzHUNV+nzECUp5n2L1akdy=Aovb6tSd+PNVnpasBrqw@mail.gmail.com>
Message-ID: <CAJF2gTRUzHUNV+nzECUp5n2L1akdy=Aovb6tSd+PNVnpasBrqw@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net,
        Atish Patra <Atish.Patra@wdc.com>, hch@infradead.org,
        paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, julien.thierry@arm.com,
        Will Deacon <will.deacon@arm.com>, christoffer.dall@arm.com,
        james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marinas,

Thx for the reply

On Mon, Jun 24, 2019 at 11:38 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:35:35AM +0800, Guo Ren wrote:
> > On Fri, Jun 21, 2019 at 10:16 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > BTW, if you find the algorithm fairly straightforward ;), see this
> > > bug-fix which took a formal model to identify: a8ffaaa060b8 ("arm64:
> > > asid: Do not replace active_asids if already 0").
> [...]
> > Btw, Is this detected by arm's aisd allocator TLA+ model ? Or a real
> > bug report ?
>
> This specific bug was found by the TLA+ model checker (at the time we
> were actually tracking down another bug with multi-threaded CPU sharing
> the TLB, bug also confirmed by the formal model).
Could you tell me the ref-link about "another bug with multi-threaded
CPU sharing the TLB" ?

In my concept, the multi-core asid mechanism is also applicable to
multi-thread shared TLB, but it will generate redundant tlbflush. From
the software design logic, multi-threaded is treated as multi-cores
without error, but performance is not optimized. So in my RFC PATCH:
[1], I try to reduce multi-threads' tlbflush in one CPU core with the
fixed cpu ID bitmap hypothesis.

1: https://lore.kernel.org/linux-csky/CAJF2gTQ0xQtQY1t-g9FgWaxfDXppMkFooCQzTFy7+ouwUfyA6w@mail.gmail.com/T/#m2ed464d2dfb45ac6f5547fb3936adf2da456cb65
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A88C4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E64821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567900390;
	bh=KU+yu1dnpjqMkvaxD0NQ/62kFYi8GAP69zuvLWhpBPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k980cCyRaJJQkfODQXWbINp+KygZm+Zbaa0g+vThhcBoASUcNCWVgf0C1u6ZDBoMv
	 Fh+St5ixnn9lYzM3TZi6R3sLIJDt+pB/pb56LADnNSlJFjFVBsn+P2K2sEZb0leLqS
	 e5n5LAUENJknFmq8ckFlgpYQpV+ShgLQZm/qQeJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfIGXxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 19:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfIGXxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 19:53:09 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F734206C3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2019 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567900388;
        bh=KU+yu1dnpjqMkvaxD0NQ/62kFYi8GAP69zuvLWhpBPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iQhzSJ+9oXgDhIW7PRJgS7OAd27+ApcmlwV1Pr1t7tIdVxFSSbNmEPtHB+EVkx/QI
         3oFy7UEQ8OJz3CxRjUYWmyWOwvSBH4uR+n5qkd1ZBcZeaqG5m2rMeo15JOhhtEIi6O
         gZUNlX9yNbmazWAWH7DCrTZAkCxjkeJuFftVnO9s=
Received: by mail-wm1-f53.google.com with SMTP id t9so10749522wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 16:53:08 -0700 (PDT)
X-Gm-Message-State: APjAAAV5zr6sGHvFNRXfr6UM5bVWv0h+XxAI0+rRIsXa3iWgMSPEiijn
        hCdCaQ6lfgIrJj+mkJLSb9kvudS7Z7UjmODUoWY=
X-Google-Smtp-Source: APXvYqz/EaoziXhxATPtaiz7WMpDkudp2uTSNKWYfbpcDLkqo0GVOyZavKTFmq2PKcMvW87cxTCwTetw/AbRtRbW9aM=
X-Received: by 2002:a1c:f007:: with SMTP id a7mr12784687wmb.172.1567900386906;
 Sat, 07 Sep 2019 16:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com> <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com> <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com> <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com> <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
In-Reply-To: <20190624104006.lvm32nahemaqklxc@willie-the-truck>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 8 Sep 2019 07:52:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Will Deacon <will@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        aou@eecs.berkeley.edu, james.morse@arm.com,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anup Patel <anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, gary@garyguo.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        christoffer.dall@arm.com, linux-riscv@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Will,

On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
> > I'll keep my system use the same ASID for SMP + IOMMU :P
>
> You will want a separate allocator for that:
>
> https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com

Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
system, because it's difficult to synchronize the IO_ASID when the CPU
ASID is rollover.
But we could still use hardware broadcast TLB invalidation instruction
to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.

Welcome to join our disscusion:
"Introduce an implementation of IOMMU in linux-riscv"
9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

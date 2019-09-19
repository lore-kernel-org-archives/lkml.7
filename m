Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E50C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE66821D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568900233;
	bh=4h3Wk30EhI1KisIg5rn7cH+Dc4+DOKJ7JCZLxO6zmPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CHIDVYruwd5hklF4fBYG2FZt5ZQYBWBmsxXVq9tharkXPVDWNHvGnh6GuRIjRM8Me
	 k/RRnYi+MxKi9Bl0GolyJi4c1STQrRX3h3q0R5eQgE1yfQ16cWjNgzWYVCdw5OltIF
	 wKUG0S36tw1pZKUqFqIxwMtuWWtHZ9PAY6krxo9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbfISNhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbfISNhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:37:12 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC4921D80
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568900232;
        bh=4h3Wk30EhI1KisIg5rn7cH+Dc4+DOKJ7JCZLxO6zmPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mwBzoNaTiK9xjLVihi6v8b+ryPsg0IP++84Wia1oIqwwNfxtQ14YDYKpBHJ3dYMni
         fBW0yG7v0NaSg/4OkKv0v7bY4ZNVgMqn10+8QuxFJes4isxMfpfRJSSSnElwMfLq/C
         aLk1/rm+0igwywEd+xuqNGYA8E4GRYk48izsxAtU=
Received: by mail-wr1-f47.google.com with SMTP id l3so3123172wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 06:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAULu0WkRxvLYozpx5pa67Lqk2HZjnxzLKesQp40UCwiV6IkJo0O
        4De/CxDn2tl8H4R+3BEi+nPSWoHXnjZ1sM0xPNw=
X-Google-Smtp-Source: APXvYqzlXvVrim8rTycGbIV+PmHAEsjEw4YXguoJ0i5mulID6kS2AA+pRkt/c/jlP2DTaZZMrey31vSOQlTtKW2gKOA=
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr6988060wrw.80.1568900230203;
 Thu, 19 Sep 2019 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e> <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190916181800.7lfpt3t627byoomt@willie-the-truck> <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 19 Sep 2019 21:36:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "julien.grall@arm.com" <julien.grall@arm.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 17, 2019 at 11:42 AM Anup Patel <Anup.Patel@wdc.com> wrote:

> >
> > With a reply stating that the patch "absolutely does not work" ;)
>
> This patch was tested on existing HW (which does not have ASID implementation)
> and tested on QEMU (which has very simplistic Implementation of ASID).
>
> When I asked Gary Guo about way to get access to their HW (in same patch
> email thread), I did not get any reply. After so many months passed, I now
> doubt the his comment "absolutely does not work".
> >
> > What exactly do you want people to do with that? It's an awful lot of effort to
> > review this sort of stuff and given that Guo Ren is talking about sharing page
> > tables between the CPU and an accelerator, maybe you're better off
> > stabilising Linux for the platforms that you can actually test rather than
> > getting so far ahead of yourselves that you end up with a bunch of wasted
> > work on patches that probably won't get merged any time soon.
>
> The intention of the ASID patch was to encourage RISC-V implementations
> having ASID in HW and also ensure that things don't break on existing HW.
>
> I don't see our efforts being wasted in trying to make Linux RISC-V feature
> complete and encouraging more feature rich RISC-V CPUs.
>
> Delays in merging patches are fine as long as people have something to try
> on their RISC-V CPU implementations.
>
I'm the supporter of that patch:
http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.patel@wdc.com/T/#u

Because it implicit hw broadcast tlb invalidation optimization.

Honestly it's not suitable for remote tlb flush with software IPI, but
it's still much better than current RISC-V's.

I'll try it on our hardware: 910. wait a moment :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DAC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B172213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfFXNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:17:05 -0400
Received: from verein.lst.de ([213.95.11.211]:55023 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfFXNRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:17:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D879268AFE; Mon, 24 Jun 2019 15:16:33 +0200 (CEST)
Date:   Mon, 24 Jun 2019 15:16:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v2
Message-ID: <20190624131633.GB10746@lst.de>
References: <20190624054311.30256-1-hch@lst.de> <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com> <20190624115428.GA9538@lst.de> <d4fd824d-03ff-e8ab-b19f-9e5ef5c22449@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fd824d-03ff-e8ab-b19f-9e5ef5c22449@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:08:50PM +0100, Vladimir Murzin wrote:
> True, yet my observation was that elf2flt utility assumes that address
> space cannot exceed 32-bit (for header and absolute relocations). So,
> from my limited point of view straightforward way to guarantee that would
> be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).
> 
> Also one of your patches expressed somewhat related idea
> 
> "binfmt_flat isn't the right binary format for huge executables to
> start with"
> 
> Since you said there is no support for compat/ilp32, probably I'm missing some
> toolchain magic?

There is no magic except for the tiny elf2flt patch, which for
now is just in the buildroot repo pointed to in the cover letter
(and which I plan to upstream once the kernel support has landed
in Linus' tree).  We only support 32-bit code and data address spaces,
but we otherwise use the normal RISC-V ABI, that is 64-bit longs and
pointers.

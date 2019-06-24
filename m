Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718D020674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfFXLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:48018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfFXLrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE242B;
        Mon, 24 Jun 2019 04:47:10 -0700 (PDT)
Received: from [10.1.32.158] (unknown [10.1.32.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7606B3F718;
        Mon, 24 Jun 2019 04:47:09 -0700 (PDT)
Subject: Re: RISC-V nommu support v2
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190624054311.30256-1-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com>
Date:   Mon, 24 Jun 2019 12:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624054311.30256-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/24/19 6:42 AM, Christoph Hellwig wrote:
> Hi all,
> 
> below is a series to support nommu mode on RISC-V.  For now this series
> just works under qemu with the qemu-virt platform, but Damien has also
> been able to get kernel based on this tree with additional driver hacks
> to work on the Kendryte KD210, but that will take a while to cleanup
> an upstream.
> 
> To be useful this series also require the RISC-V binfmt_flat support,
> which I've sent out separately.
> 
> A branch that includes this series and the binfmt_flat support is
> available here:
> 
>     git://git.infradead.org/users/hch/riscv.git riscv-nommu.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.2
> 
> I've also pushed out a builtroot branch that can build a RISC-V nommu
> root filesystem here:
> 
>    git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2
> 
> Changes since v1:
>  - fixes so that a kernel with this series still work on builds with an
>    IOMMU
>  - small clint cleanups
>  - the binfmt_flat base and buildroot now don't put arguments on the stack
> 
> 

Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
find it.

I do not know much about RISC-V architecture, so it is why I'm wondering how you deal
with that?

Cheers
Vladimir

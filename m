Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D6D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfFXNIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:08:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfFXNIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:08:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4FD344;
        Mon, 24 Jun 2019 06:08:53 -0700 (PDT)
Received: from [10.1.32.158] (unknown [10.1.32.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6A33F71E;
        Mon, 24 Jun 2019 06:08:51 -0700 (PDT)
Subject: Re: RISC-V nommu support v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190624054311.30256-1-hch@lst.de>
 <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com> <20190624115428.GA9538@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d4fd824d-03ff-e8ab-b19f-9e5ef5c22449@arm.com>
Date:   Mon, 24 Jun 2019 14:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624115428.GA9538@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 12:54 PM, Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 12:47:07PM +0100, Vladimir Murzin wrote:
>> Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
>> CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
>> find it.
> 
> There is no such thing in RISC-V.  I don't know of any 64-bit RISC-V
> cpu that can actually run 32-bit RISC-V code, although in theory that
> is possible.  There also is nothing like the x86 x32 or mips n32 mode
> available either for now.
> 
> But it turns out that with a few fixes to binfmt_flat it can run 64-bit
> binaries just fine.  I sent that series out a while ago, and IIRC you
> actually commented on it.
> 

True, yet my observation was that elf2flt utility assumes that address
space cannot exceed 32-bit (for header and absolute relocations). So,
from my limited point of view straightforward way to guarantee that would
be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).

Also one of your patches expressed somewhat related idea

"binfmt_flat isn't the right binary format for huge executables to
start with"

Since you said there is no support for compat/ilp32, probably I'm missing some
toolchain magic?

Cheers
Vladimir

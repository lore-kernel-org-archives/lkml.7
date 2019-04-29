Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916D21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pw+544LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfD2TwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:52:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28230 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2TwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556567540; x=1588103540;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iGR4Zs5nDuCr/SyO0IMhqYsZGxQL5/GTdmx0tD7WxoM=;
  b=pw+544LYKC28PsL/Z2N+0ID6D3bMTQ1G0ikp8/rI05eIYXW/gA3Gs0GH
   nEcSpgEskWzwGHOjImvTsdPGfs6vugv1RwFtF46ejff6obROGl5hJayCp
   F0WvRGxpZem1Ov0uWVqN2ROjv46pW9QsODbgwU2e3w2RGsNts5PMveKWc
   wW5VopU/kIzfkentNIijZ82tRSAQVTd43pVl4Z/f8/FKZ/GAWiFF+tdtH
   iQHVo4HsyWB9OkXuy2KMXNtv2bxV5kRpH5la4RI8E+yY6bX7QV/FpyLs9
   DysfIyGZahMn6VGNRPDf5FNImrkI++v2fxWdRzyTgT00vWzeHAZh0w9Yj
   g==;
X-IronPort-AV: E=Sophos;i="5.60,410,1549900800"; 
   d="scan'208";a="108822905"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 03:52:20 +0800
IronPort-SDR: skcBvZEAFKBWIz+0eofpg9whoUpuVYdGMYTU255UvfGAUlR3y4sfsH6XovlLbDS4jMlM6tBQKc
 m1uQNqu2r2TXG4xL1+f5D2bBJYZepYaD/0nw2MwLN+TXXkAYMwLlxLhfTk60NYnzw1BT9vWtM/
 7FdSEgHE9B70ksycQdLsCzDZd3Z9g6vIcuFhWOtfWw26D2dL2rFJ2QAQrmZQc85XlPs7DZyhtH
 pIf+36hORR2JoVKxC4X0p55gw4ZB/0Z9z2t6vvM78utWIK81zUyfIyzkRHz5t8KkaE3JAPeJ4A
 yhPVDnPBEQ56kqPAtgmt38Li
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Apr 2019 12:28:42 -0700
IronPort-SDR: WCTsEeq+jdWM9wWQFiffEKgZ2ajy+EgpnirMSVaJ0tEi4A8l36v+D7tfZ6G59yMlywONSSNZ1X
 n22P6upFjfVXOl7H4ZV47RVT7HgJAmFl2r5v64s4HTUvhSoe+XA4fqmcU6Y83wdC4eiadY8KCS
 1d1eUj5vmaac3eO0xjOVEiBdeFfClh/74oFrnoWCsCYXMaVdHGe+okInPBRTabZUbl23ghneos
 t+80OXpBGVIK59DaOffRqEzqU6jFoJlH/VbDehXFTeycX4DbkaXGACaVIIDJpLyKEZcrdMCTyM
 iS8=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2019 12:52:20 -0700
Subject: Re: [1/3] x86: Update DEBUG_TLBFLUSH options description.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20190410224449.10877-1-atish.patra@wdc.com>
 <20190410224449.10877-2-atish.patra@wdc.com>
 <20190411065617.GA29422@infradead.org>
 <580d95d1-224f-a372-c656-1d2cbb19d868@wdc.com> <20190414142709.GA569@zn.tnic>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <956163a3-9a9f-ac12-b429-eb592bce815b@wdc.com>
Date:   Mon, 29 Apr 2019 12:52:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414142709.GA569@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 7:29 AM, Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 01:14:54PM -0700, Atish Patra wrote:
>> On 4/10/19 11:56 PM, Christoph Hellwig wrote:
>>> Given that this option enables generic code (which you reuse for RISC-V
>>> later in this series) please also move the config option to
>>> mm/Kconfig, proabbly keyed off another ARCH_HAVE_DEBUG_TLBFLUSH
>>> symbol that the architecture can select.
>>>
>>
>> Sure.
> 
> And when you do that, instead of deleting the help text, make it
> generic. Otherwise, there's no explanation anymore, how that option is
> supposed to be used through tlb_flushall_shift.
> 
Not sure I am following you.
tlb_flushall_shift knob was removed by
commit e9f4e0a9fe27 ("x86/mm: Rip out complicated, out-of-date, buggy 
TLB flushing")


Regards,
Atish

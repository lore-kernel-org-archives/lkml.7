Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ACDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F402083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jj3TalP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDLHhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:37:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63210 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDLHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555054652; x=1586590652;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4i1iFfeZt6YxSlPujrp48FSX7+X7E5SqQB4adc6ZaKw=;
  b=Jj3TalP2KeN/HuFWD/5TF6h4LMEmLjJFMbJJtE+OBnNGLFAO/nFthOtG
   IwTOEwO68VprJf+qhAyvVUecCQx9F9GgOuRzHjzGfHeZB1S7wsJ2QYmuC
   9ihG0O63vtDqb06zyo6lOEuEsDjXfBg4XWlMJMg3qC4q3RL2agp43xPsQ
   3zkI77qxPiI6e0u6fmRhCXOcWKmcWhxj2rb8ngxgTQcaHCVg+XJtcLScB
   2IuJA+ekuBuQ+Z2rgouzWbZm4iSqFxepnxHcVtel/o9vnyWnup6/0mXQo
   c1FYgC38jtkjXfeVhH8tsdmvz+gWDNnDWh49Prek2/PZO0DRU67fi56I8
   A==;
X-IronPort-AV: E=Sophos;i="5.60,340,1549900800"; 
   d="scan'208";a="107002939"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2019 15:37:32 +0800
IronPort-SDR: mUoZIgyOd91Ricpz71FrvRYwLoxZeAq05/W5hupIL6rDe/MM/5xhC+cG7UWYvNpYsdg63Y6Rhn
 Vs+3DzKP398AoendhbCsfwoW/itmWji8Zc4cBI21KHL4BgkX+qOWQg2VWaA3bKnrifvftPbJvG
 y62sjkLfYtRLbYnIdXozDnpwSEsFOi3MSFLIS/XrXUbbT7TcSwWwaeiREZ26WW2MoPlBGcDrmb
 eFET03ySybtwjPrcLyiOCII0QPxZpRzmrkrQUaTvaXgqAdUdBnBoZ03qzc/N2FaRItBTzUBWwc
 dqI/X2ksL4SJplRnsB6DWMN/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Apr 2019 00:16:31 -0700
IronPort-SDR: iF1r/UCbhloslCnbOe+9HIzszn4YbELIc+/rUF+oCrKpllS7+/0AbTd03S+nkvMRPBtMPXQhFs
 +j44HuD4Ep+ipPL/wfS8/sma9uYeXCR3YFcQWSGAbxUA27Pmzai7ipTD/riilxl/cYSKLTFvRN
 QDL1txL3k0xG4ADS8U3NK3y/yBh4wTd/CpVNF+uxl0ev763/YUGtJoWvGknV6JPWZL5Qj/tqLv
 48H8DV5qoxoO1/unsCy6XV/1qt2BBovH0l5ypcrd+lgq3HzLbF3HNd9lSPOCa0RUE1e6GeK5tT
 UZ0=
Received: from 62z7jc2.ad.shared (HELO [10.86.51.194]) ([10.86.51.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Apr 2019 00:37:30 -0700
Subject: Re: [PATCH 1/6] arch: riscv: add support for building DTB files from
 DT source data
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
 <20190411114616.GA10032@infradead.org>
 <alpine.DEB.2.21.9999.1904111405470.19990@viisi.sifive.com>
 <3cf7f2d8-3039-7dd7-e243-77433b1f23a6@wdc.com>
 <alpine.DEB.2.21.9999.1904111618460.21321@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <491613fc-bdc7-0a37-2e7e-7189a615397e@wdc.com>
Date:   Fri, 12 Apr 2019 00:37:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1904111618460.21321@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 5:08 PM, Paul Walmsley wrote:
> On Thu, 11 Apr 2019, Atish Patra wrote:
> 
>> On 4/11/19 2:12 PM, Paul Walmsley wrote:
>>> On Thu, 11 Apr 2019, Christoph Hellwig wrote:
>>>
>>>> On Thu, Apr 11, 2019 at 01:42:59AM -0700, Paul Walmsley wrote:
>>>>> Similar to ARM64, add support for building DTB files from DT source
>>>>> data for RISC-V boards.
>>>>>
>>>>> This patch starts with the infrastructure needed for SiFive boards.
>>>>> Boards from other vendors would add support here in a similar form.
>>>>
>>>> What do we build it for?  We'd really need something like this:
>>>>
>>>> http://git.infradead.org/users/hch/misc.git/commitdiff/d6242aa147baf57e05e2932199c74d8d24b9926e
>>>> http://git.infradead.org/users/hch/misc.git/commitdiff/0cd5413c8094ab57b68e0629dacfed695f4c1ef1
>>>>
>>>> To actually use the DT files.
>>>
>>> Those patches might be useful - I have not reviewed them closely - but
>>> they are not necessary.
>>>
>>> The FSBL already supplies a DTB to Linux.  I assume the U-boot port works
>>> the same way.
>>>
>>
>> I am bit confused here. I thought the idea behind putting the the DTS in
>> kernel so that Kernel don't need to depend on DT passed from boot loaders.
> 
> Some users will want to do that - mostly embedded device integrators and
> kernel developers.  We should definitely support these use-cases.  So the
> basic idea behind Christoph's patch to do that is good (I have not yet
> reviewed the code nor tested it).
> 
> In fact, there has been an unofficial patch to do something similar for
> ARM for about a decade now.  But for various reasons, some technical, some
> managerial - it was never merged.  To be clear, I do agree that we should
> merge something like that for RISC-V.
> 


> However: the vast majority of users -- even embedded users -- will not use
> a kernel with a bundled DTB.  This is because it irrevocably ties that
> kernel binary to one specific board type.  I hope it is obvious why this
> would be a non-starter for Linux distributions, and, more generally,
> anyone who wants their kernels to be usable on multiple boards.  Those
> distributors would need to ship one kernel binary per board, or bloat
> their kernels with DTBs and come up with some new mechanism to select one.
> 

I agree with you completely. I was just suggesting to have the option to 
use the DTS in kernel similar Christoph's patch. It should not to be the 
default.

>> Currently, DTB passed from FSBL is modified by OpenSBI/BBL before passing to
>> U-Boot or Linux.
> 
> This should be avoided whenever possible.  I'd be interested in hearing
> what OpenSBI is doing now to the DTB; perhaps there is a case where it
> makes sense.  

The current DT modifications by OpenSBI.

1. Change hart status to "masked" from "okay".
2. M-mode interrupt masking in PLIC node.
3. Add a chosen node for serial access in U-Boot.

But in general, doing this makes development and maintenance
> quite difficult.  Considre that different operating systems that may use
> the same SBI layer may use different DT data formats, or may not even use
> DT at all.  And when the DT data format changes - as is happening now - a
> maintenance hassle is created, since then versions across multiple pieces
> of software may need to be synchronized.  It is also very disconcerting as
> a kernel developer to have multiple pieces of software modifying one's
> DTB.
> 

Again, we are on the same page. We prefer not have any DT modification 
in OpenSBI as well. Currently, that's not an option. But we would 
happily get rid of existing one if a reliable alternate solution is 
available.

> The DT data is meant to represent hardware fact.  DT is also used to pass
> in some non-hardware-related runtime configuration parameters, via the
> "chosen" node.  But that's about it.  So from that point of view, only the
> first-stage bootloader should be altering the DT data, and only then in
> very minimal ways.
> 
>> If Linux kernel can boot from the DTS contained within its source code as is,
>> that would be much more helpful.
> 
> If you are thinking about embedded system builders, and developers who
> only care about their test kernel being compatible with one board, I agree
> with you for those specific use-cases.  Almost everyone else will pass in
> a separate DTB, specific to the board they are using, from U-Boot or
> Coreboot or GRUB.
> 
>>> I haven't switched to U-boot yet for these driver tests, so I
>>> personally have been using the open-source FSBL
>>> (freedom-u540-c000-bootloader) with the following trivial patches
>>> applied:
>>>
>>> https://github.com/sifive/freedom-u540-c000-bootloader/tree/dev/paulw/supply-fsbl-dtb-v5.1-rc4
>>
>>> The fsbl/ux00_fsbl.dtb file can be symlinked to the kernel DTB output,
>>> e.g., ~/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dtb.
>>
>> This assumes that FSBL has to be rebuilt every time I want to change the DT. I
>> was hoping to avoid that.
> 
> The FSBL is on its way out.  It is just a short-term workaround until the
> various popular bootloader ports become more stable.  After that happens,
> it's likely that almost no one to use the current SiFive FSBLs.  We plan
> to transition our Freedom-U development environment away from it
> ourselves.
> 

Glad to know that.

> The point of what I wrote to Christoph earlier is simply that everyone is
> already using DTB data that is passed in from an early bootloader, whether
> they realize it or not.  So there is an existence proof that no additional
> patches are needed for the basics to function.  It may not be functioning
> well in some cases, and may need patching; but that is a separate matter.
> 

Ah okay.

Regards,
Atish
> 
> - Paul
> 


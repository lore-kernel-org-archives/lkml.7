Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BFC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997CC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfFGPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:11:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfFGPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:11:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE300B16;
        Fri,  7 Jun 2019 08:11:45 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A97A3F802;
        Fri,  7 Jun 2019 08:11:44 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Steve Capper <Steve.Capper@arm.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
 <a48bb02c-8f93-4e3b-085d-a6f0e5a1f3a0@arm.com>
 <66da4098-b221-408b-50ca-f3790b943965@redhat.com>
 <380b137b-a611-5c8d-3890-8021084f87fe@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2a4af3a0-1342-fdd2-1cfd-e37abb99d8bd@arm.com>
Date:   Fri, 7 Jun 2019 16:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <380b137b-a611-5c8d-3890-8021084f87fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

(sorry for the delay on this)

On 04/05/2019 13:53, Bhupesh Sharma wrote:
> On 04/03/2019 11:24 PM, Bhupesh Sharma wrote:
>> On 04/02/2019 10:56 PM, James Morse wrote:
>>> Yes the kernel code is going to move around, this is why the information we expose via
>>> vmcoreinfo needs to be thought through: something we would always need, regardless of how
>>> the kernel implements it.
>>>

>>> Pointer-auth changes all this again, as we may prefer to use the bits for pointer-auth in
>>> one TTB or the other. PTRS_PER_PGD may show the 52bit value in this case, but neither TTBR
>>> is mapping 52bits of VA.
>>>
>>>
>>>> So far, I have generally come across discussions where the following variations of the
>>>> address spaces have been proposed/requested:
>>>> - 48bit kernel VA + 48-bit User VA,
>>>> - 48-bit kernel VA + 52-bit User VA,
>>>
>>> + 52bit kernel, because there is excessive quantities of memory, and the kernel maps it
>>> all, but 48-bit user, because it never maps all the memory, and we prefer the bits for
>>> pointer-auth.
>>>
>>>> - 52-bit kernel VA + 52-bit User VA.
>>>
>>> And...  all four may happen with the same built image. I don't see how you can tell these
>>> cases apart with the one (build-time-constant!) PTRS_PER_PGD value.
>>>
>>> I'm sure some of these cases are hypothetical, but by considering it all now, we can avoid
>>> three more kernel:vmcoreinfo updates, and three more fix-user-space-to-use-the-new-value.
>>
>> Agree.
>>
>>> I think you probably do need PTRS_PER_PGD, as this is the one value the mm is using to
>>> generate page tables. I'm pretty sure you also need T0SZ and T1SZ to know if that's
>>> actually in use, or the kernel is bodging round it with an offset.
>>
>> Sure, I am open to suggestions (as I realize that we need an additional VA_BITS_ACTUAL
>> variable export'ed for 52-bit kernel VA changes).

(stepping back a bit:)

I'm against exposing arch-specific #ifdefs that correspond to how we've configured the
arch code's interactions with mm. These are all moving targets, we can't have any of it
become ABI.

I have a straw-man for this: What is the value of PTE_FILE_MAX_BITS on your system?
I have no idea what this value is or means, an afternoon's archaeology would be needed(!).
This is something that made sense for one kernel version, a better idea came along, and it
was replaced. If we'd exposed this to user-space, we'd have to generate a value, even if
it doesn't mean anything. Exposing VA_BITS_ACTUAL is the same.

(Keep an eye out for when we change the kernel memory map, and any second-guessing based
on VA_BITS turns out to be wrong)


What we do have are the hardware properties. The kernel can't change these.


>> Also how do we standardize reading T0SZ and T1SZ in user-space. Do you propose I make an
>> enhancement in the cpu-feature-registers interface (see [1]) or the HWCAPS interface
>> (see [2]) for the same?

cpufeature won't help you if you've already panic()d and only have the vmcore file. This
stuff needs to go in vmcoreinfo.

As long as there is a description of how userspace uses these values, I think adding
key/values for TCR_EL1.TxSZ to the vmcoreinfo is a sensible way out of this. You probably
need TTBR1_EL1.BADDR too. (it should be specific fields, to prevent 'new uses' becoming ABI)

This tells you how the hardware was configured, and covers any combination of TxSZ tricks
we play, and whether those address bits are used for VA, or ptrauth for TTBR0 or TTRB1.


> Any comments on the above points? At the moment we have to carry these fixes in the
> distribution kernels and I would like to have these fixed in upstream kernel itself.


Thanks,

James

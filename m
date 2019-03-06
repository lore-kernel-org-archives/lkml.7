Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE871C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfCFKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:14:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbfCFKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:14:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 9C83427E5CE
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
 <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
 <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com>
 <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
Message-ID: <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com>
Date:   Wed, 6 Mar 2019 10:14:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 23:23, Dan Williams wrote:
> On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> On 01/03/2019 20:41, Andrew Morton wrote:
>>> On Fri, 1 Mar 2019 09:25:24 +0100 Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>>
>>>>>>> Michal had asked if the free space accounting fix up addressed this
>>>>>>> boot regression? I was awaiting word on that.
>>>>>>
>>>>>> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..
>>>>
>>>> bot@kernelci.org is not person, it's a send-only account for
>>>> automated reports.  So no, it doesn't read emails.
>>>>
>>>> I guess the tricky point here is that the authors of the commits
>>>> found by bisections may not always have the hardware needed to
>>>> reproduce the problem.  So it needs to be dealt with on a
>>>> case-by-case basis: sometimes they do have the hardware,
>>>> sometimes someone else on the list or on CC does, and sometimes
>>>> it's better for the people who have access to the test lab which
>>>> ran the KernelCI test to deal with it.
>>>>
>>>> This case seems to fall into the last category.  As I have access
>>>> to the Collabora lab, I can do some quick checks to confirm
>>>> whether the proposed patch does fix the issue.  I hadn't realised
>>>> that someone was waiting for this to happen, especially as the
>>>> BeagleBone Black is a very common platform.  Sorry about that,
>>>> I'll take a look today.
>>>>
>>>> It may be a nice feature to be able to give access to the
>>>> KernelCI test infrastructure to anyone who wants to debug an
>>>> issue reported by KernelCI or verify a fix, so they won't need to
>>>> have the hardware locally.  Something to think about for the
>>>> future.
>>>
>>> Thanks, that all sounds good.
>>>
>>>>>> Is it possible to determine whether this regression is still present in
>>>>>> current linux-next?
>>>>
>>>> I'll try to re-apply the patch that caused the issue, then see if
>>>> the suggested change fixes it.  As far as the current linux-next
>>>> master branch is concerned, KernelCI boot tests are passing fine
>>>> on that platform.
>>>
>>> They would, because I dropped
>>> mm-shuffle-default-enable-all-shuffling.patch, so your tests presumably
>>> now have shuffling disabled.
>>>
>>> Is it possible to add the below to linux-next and try again?
>>
>> I've actually already done that, and essentially the issue can
>> still be reproduced by applying that patch.  See this branch:
>>
>>   https://gitlab.collabora.com/gtucker/linux/commits/next-20190301-beaglebone-black-debug
>>
>> next-20190301 boots fine but the head fails, using
>> multi_v7_defconfig + SMP=n in both cases and
>> SHUFFLE_PAGE_ALLOCATOR=y enabled in the 2nd case as a result
>> of the change in the default value.
>>
>> The change suggested by Michal Hocko on Feb 15th has now been
>> applied in linux-next, it's part of this commit but as
>> explained above it does not actually resolve the boot failure:
>>
>>   98cf198ee8ce mm: move buddy list manipulations into helpers
>>
>> I can send more details on Monday and do a bit of debugging to
>> help narrowing down the problem.  Please let me know if
>> there's anything in particular that would seem be worth
>> trying.
>>
> 
> Thanks for taking a look!
> 
> Some questions when you get a chance:
> 
> Is there an early-printk facility that can be turned on to see how far
> we get in the boot?

Yes, I've done that now by enabling CONFIG_DEBUG_AM33XXUART1 and
earlyprintk in the command line.  Here's the result, with the
commit cherry picked on top of next-20190304:

  https://lava.collabora.co.uk/scheduler/job/1526326

[    1.379522] ti-sysc 4804a000.target-module: sysc_flags 00000222 != 00000022
[    1.396718] Unable to handle kernel paging request at virtual address 77bb4003
[    1.404203] pgd = (ptrval)
[    1.406971] [77bb4003] *pgd=00000000
[    1.410650] Internal error: Oops: 5 [#1] ARM
[...]
[    1.672310] [<c07051a0>] (clk_hw_create_clk.part.21) from [<c06fea34>] (devm_clk_get+0x4c/0x80)
[    1.681232] [<c06fea34>] (devm_clk_get) from [<c064253c>] (sysc_probe+0x28c/0xde4)

It's always failing at that point in the code.  Also when
enabling "debug" on the kernel command line, the issue goes
away (exact same binaries etc..):

  https://lava.collabora.co.uk/scheduler/job/1526327

For the record, here's the branch I've been using:

  https://gitlab.collabora.com/gtucker/linux/tree/beaglebone-black-next-20190304-debug

The board otherwise boots fine with next-20190304 (SMP=n), and
also with the patch applied but the shuffle configs set to n.

> Do any of the QEMU machine types [1] approximate this board? I.e. so I
> might be able to independently debug.

Unfortunately there doesn't appear to be any QEMU machine
emulating the TI AM335x SoC or the BeagleBone Black board.

> Were there any boot *successes* on ARM with shuffling enabled? I.e.
> clues about what's different about the specific memory setup for
> beagle-bone-black.

Looking at the KernelCI results from next-20190215, it looks like
only the BeagleBone Black with SMP=n failed to boot:

  https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20190215/

Of course that's not all the ARM boards that exist out there, but
it's a fairly large coverage already.

As the kernel panic always seems to originate in ti-sysc.c,
there's a chance it's only visible on that platform...  I'm doing
a KernelCI run now with my test branch to double check that,
it'll take a few hours so I'll send an update later if I get
anything useful out of it.

In the meantime, I'm happy to try out other things with more
debug configs turned on or any potential fixes someone might
have.

Thanks,
Guillaume

> Thanks for the help!
> 
> [1]: https://wiki.qemu.org/Documentation/Platforms/ARM



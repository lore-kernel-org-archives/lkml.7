Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085A218B0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfCAIZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:25:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfCAIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:25:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 078D1260D0B
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Mark Brown <broonie@kernel.org>,
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
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
Date:   Fri, 1 Mar 2019 09:25:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 00:55, Dan Williams wrote:
> On Thu, Feb 28, 2019 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 26 Feb 2019 16:04:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> On Tue, Feb 26, 2019 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>
>>>> On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
>>>>
>>>>> On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
>>>>>> On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
>>>>>
>>>>>>>   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
>>>>>>>   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
>>>>>>>   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
>>>>>
>>>>>> Thanks.
>>>>>
>>>>>> But what actually went wrong?  Kernel doesn't boot?
>>>>>
>>>>> The linked logs show the kernel dying early in boot before the console
>>>>> comes up so yeah.  There should be kernel output at the bottom of the
>>>>> logs.
>>>>
>>>> I assume Dan is distracted - I'll keep this patchset on hold until we
>>>> can get to the bottom of this.
>>>
>>> Michal had asked if the free space accounting fix up addressed this
>>> boot regression? I was awaiting word on that.
>>
>> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..

bot@kernelci.org is not person, it's a send-only account for
automated reports.  So no, it doesn't read emails.

I guess the tricky point here is that the authors of the commits
found by bisections may not always have the hardware needed to
reproduce the problem.  So it needs to be dealt with on a
case-by-case basis: sometimes they do have the hardware,
sometimes someone else on the list or on CC does, and sometimes
it's better for the people who have access to the test lab which
ran the KernelCI test to deal with it.

This case seems to fall into the last category.  As I have access
to the Collabora lab, I can do some quick checks to confirm
whether the proposed patch does fix the issue.  I hadn't realised
that someone was waiting for this to happen, especially as the
BeagleBone Black is a very common platform.  Sorry about that,
I'll take a look today.

It may be a nice feature to be able to give access to the
KernelCI test infrastructure to anyone who wants to debug an
issue reported by KernelCI or verify a fix, so they won't need to
have the hardware locally.  Something to think about for the
future.

>> Is it possible to determine whether this regression is still present in
>> current linux-next?

I'll try to re-apply the patch that caused the issue, then see if
the suggested change fixes it.  As far as the current linux-next
master branch is concerned, KernelCI boot tests are passing fine
on that platform.

Guillaume

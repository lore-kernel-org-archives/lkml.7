Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E0420883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDAQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:36:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfDAQgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:36:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C1CA78;
        Mon,  1 Apr 2019 09:36:04 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDDB83F690;
        Mon,  1 Apr 2019 09:36:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
 <20190328131657.GA9056@bogus> <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
 <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <8e574cfa-29d9-0f0a-d670-c4869bd262c4@arm.com>
Date:   Mon, 1 Apr 2019 17:36:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 29/03/2019 14:11, Rob Herring wrote:
> On Thu, Mar 28, 2019 at 1:47 PM James Morse <james.morse@arm.com> wrote:
>> On 28/03/2019 13:16, Rob Herring wrote:
>>> On Tue, Mar 12, 2019 at 02:51:00PM +0530, Yash Shah wrote:
>>>> DT documentation for L2 cache controller added.

>>>> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
>>>> new file mode 100644
>>>> index 0000000..abce09f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
>>>> @@ -0,0 +1,31 @@
>>>> +SiFive L2 Cache EDAC driver device tree bindings
>>>> +-------------------------------------------------
>>>> +This driver uses the EDAC framework to report L2 cache controller ECC errors.
>>>
>>> Bindings are for h/w blocks, not drivers. (And Boris may want a single
>>> driver, but bindings should reflect the h/w, not what Linux (currently)
>>> wants.
>>
>> For h/w block compatibles and edac, I think all we need now is to ensure the DT contains
>> the three compatible strings: platform (if there is one), soc and ip-name (if its a
>> re-usable thing).
>> This is so that linux can pick the biggest of the three (usually platform) to probe the
>> driver from, as this lets us capture platform properties we only find out about later.
> 
> DT is not the only what to instantiate drivers. If the OS really wants
> to have a single driver for multiple h/w blocks, then it needs to
> instantiate a driver itself (based on the top-level compatible
> probably) and then that driver can find the DT nodes it needs itself.

I think this is where we are heading. (but I need to get my head round this top-level thing).

Can the OS do both, depending on the platform?
e.g. on a system with one component the driver runs 'standalone', whereas on a bigger
system with multiple components the same driver is used as a library by something else.

I don't see how this would work if the common component's DT entry looks the same on both
platforms. Wouldn't this depend on the order stuff is done in, or 'but not this one'
checks in the driver?


> In any case, it's all irrelevant to the DT binding. We don't design
> bindings around what some particular OS wants.

I agree.

What we want to do is spot the problems on the horizon so we either have the right
information in the DT today, or at least know what it looks like so we don't cause a
regression when a new platform makes previous behaviour generic/a-library.


Thanks,

James

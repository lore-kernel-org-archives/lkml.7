Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460EFC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E15C21655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLTMFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:05:49 -0500
Received: from ns.iliad.fr ([212.27.33.1]:51078 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLTMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:05:48 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0ED2E21875;
        Fri, 20 Dec 2019 13:05:44 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E7CB02186A;
        Fri, 20 Dec 2019 13:05:43 +0100 (CET)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220102218.GA2259862@kroah.com> <20191220102256.GB2259862@kroah.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5b12b473-bf9a-6dc9-838c-f9312eb10635@free.fr>
Date:   Fri, 20 Dec 2019 13:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220102256.GB2259862@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Dec 20 13:05:44 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 11:22, Greg Kroah-Hartman wrote:

> On Fri, Dec 20, 2019 at 11:22:18AM +0100, Greg Kroah-Hartman wrote:
>
>> On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
>>
>>> I keep thinking about the memory waste caused by the strict alignment requirement
>>> on arm64. Is there a way to inspect how much memory has been requested vs how much
>>> has been allocated? (Turning on SLAB DEBUG perhaps?)
>>>
>>> Couldn't there be a kmalloc flag saying "this alloc will not require strict
>>> alignment, so just give me something 8-byte aligned" ?
>>
>> Or you can not use the devm interface for lots of tiny allocations :)
> 
> Oh nevermind, "normal" kmalloc allocations are all aligned that way
> anyway, so that's not going to solve anything, sorry.

(For some context, and for what it's worth, my opinion is that device-managed
deallocation is the best thing since sliced bread.)

Typical devm use-case is:
1) user allocates a resource
2) user registers release_func+resource_context to devm

So typically, only 2 pointers (which is no issue when the alignment
requirement is 8 bytes). By nature, these are "small" allocations.

devm_kmalloc does not follow this pattern, it is a kind of optimization.
1) user does not allocate the resource (RAM)...
2) ...because the devm framework "merges" the user's memory request with
its own memory request for storing metadata -- as a memory allocator does
when it stores metadata for the request "in front of" the memory block.
(this is the reason why devm_kmalloc_release() is a noop)


(The following is just random thinking out loud)

If "fixing" the kmalloc strict alignment requirement on arm64 is too
hard, maybe it would be possible to shave some of the devm memory
waste by working with (chained) arrays of devm nodes, instead
of a straight-up linked list. (Akin to a C++ vector) Removal would
be expensive, but that's supposed to be a rare operation, right?

Regards.

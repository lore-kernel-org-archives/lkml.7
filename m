Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A23C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D088217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfKEUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:44:57 -0500
Received: from foss.arm.com ([217.140.110.172]:60796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEUo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:44:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37749A64;
        Tue,  5 Nov 2019 12:44:56 -0800 (PST)
Received: from [10.162.40.121] (a075563-lin.blr.arm.com [10.162.40.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F753FB4E;
        Mon,  4 Nov 2019 23:09:33 -0800 (PST)
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "deller@gmx.de" <deller@gmx.de>, "duwe@suse.de" <duwe@suse.de>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        James Morse <James.Morse@arm.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "svens@stackframe.org" <svens@stackframe.org>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <42c113ee-e7fc-3e94-cca0-f05f1c89fdb8@arm.com>
 <20191104125637.GB24108@willie-the-truck>
 <d9b738fa-b7c5-f1b2-3878-d7afa4ba7ba5@arm.com>
 <20191104140440.GJ45140@lakrids.cambridge.arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <3a0dd498-ffd0-3e47-c1b4-3e9dbfe935d8@arm.com>
Date:   Tue, 5 Nov 2019 12:36:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191104140440.GJ45140@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/19 7:34 PM, Mark Rutland wrote:
> On Mon, Nov 04, 2019 at 01:03:51PM +0000, Amit Kachhap wrote:
>>
>>
>> On 11/4/19 6:26 PM, Will Deacon wrote:
>>> On Sat, Nov 02, 2019 at 05:42:25PM +0530, Amit Daniel Kachhap wrote:
>>>> On 10/29/19 10:28 PM, Mark Rutland wrote:
>>>>> This series is a reworked version of Torsten's FTRACE_WITH_REGS series
>>>>> [1]. I've tried to rework the existing code in preparatory patches so
>>>>> that the patchable-function-entry bits slot in with fewer surprises.
>>>>> This version is based on v5.4-rc3, and can be found in my
>>>>> arm64/ftrace-with-regs branch [2].
>>>>>
>>>>> Patch 1 adds an (optional) ftrace_init_nop(), which the core code uses
>>>>> to initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
>>>>> symbol, and more cleanly separates the one-time initialization of the
>>>>> callsite from dynamic NOP<->CALL modification. Architectures which don't
>>>>> implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.
>>>>>
>>>>> Recently parisc gained ftrace support using patchable-function-entry.
>>>>> Patch 2 makes the handling of module callsite locations common in
>>>>> kernel/module.c with a new FTRACE_CALLSITE_SECTION definition, and
>>>>> removed the newly redundant bits from arch/parisc.
>>>>>
>>>>> Patches 3 and 4 move the module PLT initialization to module load time,
>>>>> which simplifies runtime callsite modification. This also means that we
>>>>> don't transitently mark the module text RW, and will allow for the
>>>>> removal of module_disable_ro().
>>>>>
>>>>> Patches 5 and 6 add some trivial infrastructure, with patch 7 finally
>>>>> adding FTRACE_WITH_REGS support. Additional work will be required for
>>>>> livepatching (e.g. implementing reliable stack trace), which is
>>>>> commented as part of patch 7.
>>>>>
>>>>> Patch 8 is a trivial cleanup atop of the rest of the series, making the
>>>>> code easier to read and less susceptible to config-specific breakage.
>>>> I tested the whole series with my latest in-kernel ptrauth patches [1]
>>>> and graph_tracer/function_graph_tracer works fine, So for the whole series,
>>>> Tested-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>>>>
>>>> Also I gave few minor comments in the individual patches. With those
>>>> comments,
>>>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> Oops sorry I meant,
>> Reviewed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> 
> Thanks!
> 
> I've added the Tested-by for the whole series, and the Reviewed-by for
> patches 4 and 7. I haven't added it for patch 1 just yet; please reply
> to my comment there if you'd still like to add a Reviewed-by.

Those were minor comments. Please go ahead and add the Reviewed-by's.
Thanks,
Amit

> 
> Mark.
> 

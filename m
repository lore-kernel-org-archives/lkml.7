Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC8C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71136206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfLSSpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:30 -0500
Received: from foss.arm.com ([217.140.110.172]:42266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfLSSp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBE141FB;
        Thu, 19 Dec 2019 10:45:27 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43C93F67D;
        Thu, 19 Dec 2019 10:45:26 -0800 (PST)
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
To:     Antonio Borneo <antonio.borneo@st.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, ambroise.vincent@arm.com
References: <20191127154428.191095-1-antonio.borneo@st.com>
 <20191204160407.GB17404@google.com>
 <6b5b74cede87a61d5f04f2a95bc4389830467fe9.camel@st.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <68b3b7db-d278-6cd2-f2b6-cbba05df6db4@arm.com>
Date:   Thu, 19 Dec 2019 18:45:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6b5b74cede87a61d5f04f2a95bc4389830467fe9.camel@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2019 00:00, Antonio Borneo wrote:
> At login:
> trace-cmd record -e preemptirq:irq_enable sleep 1
> trace-cmd report trace.dat | head
> and I incorrectly get only the offsets to _stext:
> cpus=1
>            sleep-197   [000]   280.378022: irq_enable:           caller=0x1afaS parent=0xc00091S
>            sleep-197   [000]   280.378026: irq_enable:           caller=0x54d34S parent=0x78e00000S
>            sleep-197   [000]   280.378029: irq_enable:           caller=0x1afaS parent=0xc00a84S
>            sleep-197   [000]   280.378032: irq_enable:           caller=0x263dS parent=0x78e00000S
> ...
> 
> With this patch I get the expected/right result:
> cpus=1
>            sleep-210   [000]   525.177583: irq_enable:           caller=trace_hardirqs_on_thunk parent=entry_SYSCALL_64_after_hwframe
>            sleep-210   [000]   525.177587: irq_enable:           caller=__do_page_fault parent=(nil)S
>            sleep-210   [000]   525.177590: irq_enable:           caller=trace_hardirqs_on_thunk parent=swapgs_restore_regs_and_return_to_usermode
>            sleep-210   [000]   525.177593: irq_enable:           caller=do_syscall_64 parent=(nil)S
> ...

FWIW Ambroise (in Cc) and I were staring at some irq enable/disable traces,
and encountered exactly this on a Pixel3 running a mainline kernel. With
Antonio's patch we got the expected result, so you can have:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

>> I am not comfortable with this patch at the moment, mainly because it will
>> increase the size of this rather high frequency event. But I'm not saying
>> there isn't an issue on 32-bit. Let's discuss more.
>>
> 
> Sure, the pressure on the trace buffer will increase on a 64 bit system, but in general it also has more memory than an embedded 32 bit system.
> The key point is, instead, can we feel safe with a 32 bit offset in a 64 bit system? Is there any guarantee a module is loaded within 32 bits offset from _stext?
> 

You're better placed than I to know if and when this is the case, but I
wouldn't use this in a production environment. To me this is more of a
debugging tool (and a really good one at that), so I am less concerned
about the memory overhead.

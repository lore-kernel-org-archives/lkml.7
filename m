Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1484C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15742087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfCLSTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:19:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCLSTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:19:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 189C8A78;
        Tue, 12 Mar 2019 11:19:00 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F195A3F59C;
        Tue, 12 Mar 2019 11:18:56 -0700 (PDT)
Subject: Re: [PATCH 00/14] entry: preempt_schedule_irq() callers scrub
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <e604601e-f8e1-a8b5-d364-69ca967996ce@synopsys.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a5b1605b-b3b3-7898-30ae-d993050e8c7a@arm.com>
Date:   Tue, 12 Mar 2019 18:18:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e604601e-f8e1-a8b5-d364-69ca967996ce@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 18:03, Vineet Gupta wrote:
[...]
>> Regarding that loop, archs seem to fall in 3 categories:
>> A) Those that don't have the loop
> 
> Please clarify that this is the right thing to do (since core code already has the
> loop) hence no fixing is required for this "category"
> 

Right, those don't need any change. I had a brief look at them to double
check they had the proper need_resched() gate before calling
preempt_schedule_irq() (with no loop) and they all seem fine. Also...

>> B) Those that have a small need_resched() loop around the
>>    preempt_schedule_irq() callsite
>> C) Those that branch to some more generic code further up the entry code
>>    and eventually branch back to preempt_schedule_irq()
>>
>> arc, m68k, nios2 fall in A)
> 

I forgot to include parisc in here.

[...]

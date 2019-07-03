Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15181C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E050821880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGCFfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:35:02 -0400
Received: from foss.arm.com ([217.140.110.172]:37998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfGCFfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:35:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FF42B;
        Tue,  2 Jul 2019 22:35:01 -0700 (PDT)
Received: from [10.162.42.95] (p8cg001049571a15.blr.arm.com [10.162.42.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14A2D3F718;
        Tue,  2 Jul 2019 22:36:52 -0700 (PDT)
Subject: Re: [DRAFT] mm/kprobes: Add generic kprobe_fault_handler() fallback
 definition
To:     Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <78863cd0-8cb5-c4fd-ed06-b1136bdbb6ef@arm.com>
 <1561973757-5445-1-git-send-email-anshuman.khandual@arm.com>
 <8c6b9525-5dc5-7d17-cee1-b75d5a5121d6@roeck-us.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <fc68afaa-32e1-a265-aae2-e4a9440f4c95@arm.com>
Date:   Wed, 3 Jul 2019 11:05:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8c6b9525-5dc5-7d17-cee1-b75d5a5121d6@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2019 06:58 PM, Guenter Roeck wrote:
> On 7/1/19 2:35 AM, Anshuman Khandual wrote:
>> Architectures like parisc enable CONFIG_KROBES without having a definition
>> for kprobe_fault_handler() which results in a build failure. Arch needs to
>> provide kprobe_fault_handler() as it is platform specific and cannot have
>> a generic working alternative. But in the event when platform lacks such a
>> definition there needs to be a fallback.
>>
>> This adds a stub kprobe_fault_handler() definition which not only prevents
>> a build failure but also makes sure that kprobe_page_fault() if called will
>> always return negative in absence of a sane platform specific alternative.
>>
>> While here wrap kprobe_page_fault() in CONFIG_KPROBES. This enables stud
>> definitions for generic kporbe_fault_handler() and kprobes_built_in() can
>> just be dropped. Only on x86 it needs to be added back locally as it gets
>> used in a !CONFIG_KPROBES function do_general_protection().
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> I am planning to go with approach unless we just want to implement a stub
>> definition for parisc to get around the build problem for now.
>>
>> Hello Guenter,
>>
>> Could you please test this in your parisc setup. Thank you.
>>
> 
> With this patch applied on top of next-20190628, parisc:allmodconfig builds
> correctly. I scheduled a full build for tonight for all architectures.

How did that come along ? Did this pass all build tests ?

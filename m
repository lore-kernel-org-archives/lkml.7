Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2284C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EBF20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfENRUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:20:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfENRUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:20:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773DF15AB;
        Tue, 14 May 2019 10:20:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2854E3F575;
        Tue, 14 May 2019 10:20:15 -0700 (PDT)
Subject: Re: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <20190510183556.24c33f02@donnerap.cambridge.arm.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3BFE@ORSMSX106.amr.corp.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <bbc6843c-74c6-9159-9746-ec7ec68c602b@arm.com>
Date:   Tue, 14 May 2019 18:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3BFE@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 10/05/2019 20:20, Yu, Fenghua wrote:
>> On Friday, May 10, 2019 10:36 AM
>> Andre Przywara [mailto:andre.przywara@arm.com] wrote:
>> On Sat,  9 Feb 2019 18:50:29 -0800
>> Fenghua Yu <fenghua.yu@intel.com> wrote:

>>> With more and more resctrl features are being added by Intel, AMD and
>>> ARM, a test tool is becoming more and more useful to validate that
>>> both hardware and software functionalities work as expected.
>>
>> That's very much appreciated! We decided to use that tool here to detect
>> regressions in James' upcoming resctrl rework series. While doing so we
>> spotted some shortcomings:

>> - There is some unconditional x86 inline assembly which obviously breaks
>> the build on ARM.
> 
> Will fix this as much as possible.
> 
> BTW, does ARM support perf imc_count events which are used in CAT tests?

I've never heard of these. git-grep says its a powerpc pmu...

(after a quick chat with Andre), is this a cache-miss counter?
If so, its a bit murky, (and beware, I don't know much about perf).
The arch code's armv8_pmu has a 'PERF_COUNT_HW_CACHE_MISSES' map entry, so yes...
... but if we're measuring this on a cache outside the CPU, we'd need an 'uncore' pmu
driver, so it would depend on what the manufacturer implemented.


I should admit that I'm expecting this selftest to test resctrl, and not depend on a lot
else. Couldn't it use the llc_occupancy value, 50% bitmap gives ~50% lower occupancy. Or
(some combination of) the mbm byte counters, (which would require a seeky workload to
cause repeat re-fills of the same line)...


Thanks,

James

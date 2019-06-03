Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E1DC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F333D249BE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfFCRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:19:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:47822 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFCRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:19:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 10:19:14 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jun 2019 10:19:14 -0700
Received: from [10.251.11.94] (kliang2-mobl.ccr.corp.intel.com [10.251.11.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5A9635804A1;
        Mon,  3 Jun 2019 10:19:13 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/6] Perf uncore support for Snow Ridge server
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, eranian@google.com, ak@linux.intel.com
References: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
 <20190603163420.GD3402@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4ba6aac7-1286-3307-dc5f-ebb42468a604@linux.intel.com>
Date:   Mon, 3 Jun 2019 13:19:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603163420.GD3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2019 12:34 PM, Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 05:53:42PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The patch series intends to enable perf uncore support for Snow Ridge
>> server.
>>
>> Here is the link for the uncore document.
>> https://cdrdv2.intel.com/v1/dl/getContent/611319
>>
>> Patch 1: Fixes a generic issue for uncore free-running counter, which
>> also impacts the Snow Ridge server.
>>
>> Patch 2-6: Perf uncore support for Snow Ridge server.
>>
>> Kan Liang (6):
>>    perf/x86/intel/uncore: Handle invalid event coding for free-running
>>      counter
>>    perf/x86/intel/uncore: Add uncore support for Snow Ridge server
>>    perf/x86/intel/uncore: Extract codes of box ref/unref
>>    perf/x86/intel/uncore: Support MMIO type uncore blocks
>>    perf/x86/intel/uncore: Clean up client IMC
>>    perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge
>>
>>   arch/x86/events/intel/uncore.c       | 122 +++++--
>>   arch/x86/events/intel/uncore.h       |  41 ++-
>>   arch/x86/events/intel/uncore_snb.c   |  16 +-
>>   arch/x86/events/intel/uncore_snbep.c | 601 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 737 insertions(+), 43 deletions(-)
> 
> Kan, we had horrible conflicts between this set and the topology
> s/pkg/die/ thing. I've attempted a rebase here:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/core
> 
> can you please double check?

There are two errors. I think they have been reported by 0-day.
Rest of the patches looks good.

The first one is from ("perf/x86/intel/uncore: Support MMIO type uncore 
blocks"). The fix is as below.

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index baee051..8453e60 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1201,7 +1201,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
  	/* Clear the references */
  	die = topology_logical_die_id(cpu);
  	uncore_box_unref(uncore_msr_uncores, die);
-	uncore_box_unref(uncore_mmio_uncores, pkg);
+	uncore_box_unref(uncore_mmio_uncores, die);
  	return 0;
  }


The other is from ("perf/x86/intel/uncore: Add IMC uncore support for 
Snow Ridge"). The fix is as below.

diff --git a/arch/x86/events/intel/uncore_snbep.c 
b/arch/x86/events/intel/uncore_snbep.c
index f4e04d8..b10a5ec 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4406,7 +4406,7 @@ static struct pci_dev *snr_uncore_get_mc_dev(int id)

  static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
  {
-	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->pkgid);
+	struct pci_dev *pdev = snr_uncore_get_mc_dev(box->dieid);
  	unsigned int box_ctl = uncore_mmio_box_ctl(box);
  	resource_size_t addr;
  	u32 pci_dword;




Thanks,
Kan


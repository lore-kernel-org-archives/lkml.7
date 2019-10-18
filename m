Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E897CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0EB21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504640AbfJRHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:31:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:58825 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394031AbfJRHbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:31:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 00:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,310,1566889200"; 
   d="scan'208";a="190288563"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2019 00:31:43 -0700
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, venkatg@codeaurora.org
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
 <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
 <2275bfdc-ff30-719e-ae78-8c8bd20b8c80@ti.com>
 <8fba4072-a252-7397-15b2-791e2619024d@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ce800827-d867-87a7-47fd-a65e92bd26db@intel.com>
Date:   Fri, 18 Oct 2019 10:30:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8fba4072-a252-7397-15b2-791e2619024d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/19 10:22 AM, Faiz Abbas wrote:
> Adrian,
> 
> On 16/10/19 5:46 PM, Faiz Abbas wrote:
>> Adrian,
>>
>> On 15/10/19 7:15 PM, Adrian Hunter wrote:
>>> On 15/10/19 10:55 AM, Faiz Abbas wrote:
>>>> Hi,
>>>>
>>>> On 15/10/19 12:08 AM, Faiz Abbas wrote:
>>>>> Add a write memory barrier to make sure that descriptors are actually
>>>>> written to memory before ringing the doorbell.
>>>>>
>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>> ---
>>>>>
>>>>> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
>>>>> I have been seeing after enabling command queuing for J721e.
>>>>> Also looking at memory-barriers.txt and this commit[1],
>>>>> it looks like we should be doing this before any descriptor write
>>>>> followed by a doorbell ring operation. It'll be nice if someone with more
>>>>> expertise in memory barriers can comment.
>>>>>
>>>>> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>>>>>     doorbell")
>>>>
>>>> So I see that cqhci_readl/writel() use readl/writel_relaxed() which
>>>> seems to be causing this issue. Should I just fix this by converting
>>>> those to readl/writel with memory barriers instead?
>>>
>>> Perhaps we could do both changes i.e. add wmb() and convert to non-relaxed
>>> readl/writel
>>>
>>
>> readl is implemented as  readl_relaxed(); __rmb();
>> and
>> writel is implemented as wmb(); writel_relaxed();
>>
>> I think another wmb() before writel will be redundant.
>>
>> Maybe this patch is good enough in itself.
>>
> 
> Do you agree?

Sure.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

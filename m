Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3E72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfJONqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:46:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:63354 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbfJONqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:46:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 06:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="185816087"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2019 06:46:43 -0700
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, venkatg@codeaurora.org
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
Date:   Tue, 15 Oct 2019 16:45:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 10:55 AM, Faiz Abbas wrote:
> Hi,
> 
> On 15/10/19 12:08 AM, Faiz Abbas wrote:
>> Add a write memory barrier to make sure that descriptors are actually
>> written to memory before ringing the doorbell.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>
>> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
>> I have been seeing after enabling command queuing for J721e.
>> Also looking at memory-barriers.txt and this commit[1],
>> it looks like we should be doing this before any descriptor write
>> followed by a doorbell ring operation. It'll be nice if someone with more
>> expertise in memory barriers can comment.
>>
>> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>>     doorbell")
> 
> So I see that cqhci_readl/writel() use readl/writel_relaxed() which
> seems to be causing this issue. Should I just fix this by converting
> those to readl/writel with memory barriers instead?

Perhaps we could do both changes i.e. add wmb() and convert to non-relaxed
readl/writel

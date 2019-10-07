Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D17A20835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJGUG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:06:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:42311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfJGUG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:06:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 13:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="223022355"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2019 13:06:26 -0700
Received: from [10.251.30.58] (kliang2-mobl.ccr.corp.intel.com [10.251.30.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B455B5803E4;
        Mon,  7 Oct 2019 13:06:25 -0700 (PDT)
Subject: Re: [PATCH 00/10] Stitch LBR call stack
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
 <20191007182435.GA97660@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ba3025a0-2161-b1d6-0a37-3445eebe7609@linux.intel.com>
Date:   Mon, 7 Oct 2019 16:06:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007182435.GA97660@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2019 2:24 PM, Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> Performance impact:
>> The processing time may increase with the LBR stitching approach
>> enabled. The impact depends on the number of samples with stitched LBRs.
>>
>> For sqlite's tcltest,
>> perf record --call-graph lbr -- make tcltest
>> perf report --stitch-lbr
>>
>> There are 4.11% samples has stitched LBRs.
>> Total number of samples:                        2833728
>> The number of samples with stitched LBRs        116478
>>
>> The processing time of perf report increases 6.8%
>> Without --stitch-lbr:                           55906106 usec
>> With --stitch-lbr:                              59728701 usec
>>
>> For a simple test case tchain_edit with 43 depth of call stacks.
>> perf record --call-graph lbr -- ./tchain_edit
>> perf report --stitch-lbr
>>
>> There are 99.9% samples has stitched LBRs.
>> Total number of samples:                        10915
>> The number of samples with stitched LBRs        10905
>>
>> The processing time of perf report increases 67.4%
>> Without --stitch-lbr:                           11970508 usec
>> With --stitch-lbr:                              20036055 usec
> 
> That cost seems pretty high, while the feature sounds useful - is there
> any way to speed this up?
> 

For each LBR entry, perf tool will calculate and generate an appended 
node for callchain_cursor.
The stitched LBR entries are from previous sample. It looks like we 
don't need to do the calculation again for them. That should speed up 
the whole process. I will do more test for it.

Thanks,
Kan

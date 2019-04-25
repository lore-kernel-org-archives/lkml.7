Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA93620679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfDYNOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:14:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:42898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfDYNOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:14:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 06:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="137353465"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2019 06:14:02 -0700
Received: from [10.254.82.46] (kliang2-mobl.ccr.corp.intel.com [10.254.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4CF645803FA;
        Thu, 25 Apr 2019 06:14:01 -0700 (PDT)
Subject: Re: [PATCH] perf stat: Add hint for SMI cost measurement
To:     Ingo Molnar <mingo@kernel.org>
Cc:     acme@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@gmail.com, lgoncalv@redhat.com,
        ak@linux.intel.com
References: <1556120792-35415-1-git-send-email-kan.liang@linux.intel.com>
 <20190425063910.GA85646@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9beeb53a-39ef-7e60-34b7-e2cfbe355a0e@linux.intel.com>
Date:   Thu, 25 Apr 2019 09:14:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425063910.GA85646@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2019 2:39 AM, Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> +static void smi_env_check(void)
>> +{
>> +	char *name;
>> +	size_t len;
>> +
>> +	if (sysfs__read_str(CPUIDLE_CUR_DRV, &name, &len)) {
>> +		pr_warning("Failed to check cstate status.\n");
> 
> What a meaningless message. What did we want to do, what happened, and
> why did it fail?
> 
>> +		return;
>> +	}
>> +
>> +	if (strncmp(name, "none", 4)) {
>> +		pr_warning("Cstate may cause drift between aperf and cycles. "
>> +			   "Please completely disable cstate, "
>> +			   "E.g. set idle=poll in grub\n");
> 
> Please keep user-visible strings in the same form that the user sees
> them, i.e. in a single line.

To avoid the line over 80 characters, the quoted string was split across 
lines in the code. But the string is shown as a single line when it is 
output for user.

Are you suggesting to ignore the 80 characters rule when printing 
user-visible strings?
Could you please confirm?

Thanks,
Kan

> 
> By doing that you'll also note a capitalization error.
> 
> Also what does 'Cstate may cause drift' mean? What aspect of cstates
> causes the drift - entering/exiting deeper cstates that are not C0? If so
> then say so.
> 
> Thanks,
> 
> 	Ingo
> 

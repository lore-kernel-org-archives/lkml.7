Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB5206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDOMmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1605C89C33;
        Mon, 15 Apr 2019 12:42:06 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F9745D717;
        Mon, 15 Apr 2019 12:42:05 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] perf/x86: descriptive failure messages for PMU init
References: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
        <20190415120444.GN11158@hirez.programming.kicks-ass.net>
Date:   Mon, 15 Apr 2019 08:42:04 -0400
In-Reply-To: <20190415120444.GN11158@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 15 Apr 2019 14:04:44 +0200")
Message-ID: <jpgo9571lur.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 15 Apr 2019 12:42:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Apr 12, 2019 at 03:09:17PM -0400, Bandan Das wrote:
>> 
>> There's a default warning message that gets printed, however,
>> there are various failure conditions:
>>  - a msr read can fail
>>  - a msr write can fail
>>  - a msr has an unexpected value
>>  - all msrs have unexpected values (disable PMU)
>> 
>> Also, commit commit 005bd0077a79 ("perf/x86: Modify error message in
>> virtualized environment") completely removed printing the msr in
>> question but these messages could be helpful for debugging vPMUs as
>> well. Add them back and change them to pr_debugs, this keeps the
>> behavior the same for baremetal.
>> 
>> Lastly, use %llx to silence checkpatch
>
> Yuck... if you're debugging a hypervisor, you can bloody well run your
> own kernel with additional print slattered around.
>
> The whole make an exception for virt bullshit was already pushing it,
> this is just insane.
>

The only virt specific parts are the pr_debugs which I can remove and
replace with unconditional pr_err()s as suggested by Jiri. Is that ok ?

Bandan

>> @@ -266,12 +282,30 @@ static bool check_hw_exists(void)
>>  	return true;
>>  
>>  msr_fail:
>> -	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
>> +	if (virt)
>>  		pr_cont("PMU not available due to virtualization, using software events only.\n");
>> -	} else {
>> -		pr_cont("Broken PMU hardware detected, using software events only.\n");
>> -		pr_err("Failed to access perfctr msr (MSR %x is %Lx)\n",
>> -		       reg, val_new);
>> +	switch (status) {
>> +	case READ_FAIL:
>> +		if (virt)
>> +			pr_debug("Failed to read perfctr msr (MSR %x)\n", reg);
>> +		else
>> +			pr_err("Failed to read perfctr msr (MSR %x)\n", reg);
>> +		break;
>> +	case WRITE_FAIL:
>> +		if (virt)
>> +			pr_debug("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
>> +				 reg, val, val_new);
>> +		else
>> +			pr_err("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
>> +				 reg, val, val_new);
>> +		break;
>> +	case PMU_FAIL:
>> +		/* fall through for default message */
>> +	default:
>> +		if (virt)
>> +			pr_debug("Broken PMU hardware detected, using software events only.\n");
>> +		else
>> +			pr_cont("Broken PMU hardware detected, using software events only.\n");
>>  	}

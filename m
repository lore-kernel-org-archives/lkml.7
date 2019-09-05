Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D85C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D1B206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfIEVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEVAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:00:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50D4C30083ED;
        Thu,  5 Sep 2019 21:00:14 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1C1C60610;
        Thu,  5 Sep 2019 21:00:13 +0000 (UTC)
Subject: Re: [PATCH v2 9/9] tools/power/x86/intel-speed-select: Fix memory
 leak
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, David Arcari <darcari@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20190905120311.15286-1-prarit@redhat.com>
 <20190905120311.15286-10-prarit@redhat.com>
 <f12560e59427ce7e038334a3b59bf084a748d998.camel@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <13983f13-098e-4390-c014-43b59c4e2f27@redhat.com>
Date:   Thu, 5 Sep 2019 17:00:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f12560e59427ce7e038334a3b59bf084a748d998.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 05 Sep 2019 21:00:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/19 3:42 PM, Srinivas Pandruvada wrote:
> On Thu, 2019-09-05 at 08:03 -0400, Prarit Bhargava wrote:
>> cpumasks are allocated by calling the alloc_cpu_mask() function and
>> are
>> never free'd.  They should be free'd after the commands have run.
>>
>> Fix the memory leaks by calling free_cpu_set().
> Good to fix this. But after one command execution the process will
> exit.
> 

I'm sorry, I misunderstood your comment.  Yes, the process will exit after one
command :)

P.

> Thanks,
> Srinivas
> 
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: David Arcari <darcari@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  tools/power/x86/intel-speed-select/isst-config.c | 16 +++++++++++---
>> --
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
>> b/tools/power/x86/intel-speed-select/isst-config.c
>> index 78f0cebda1da..59753b3917bb 100644
>> --- a/tools/power/x86/intel-speed-select/isst-config.c
>> +++ b/tools/power/x86/intel-speed-select/isst-config.c
>> @@ -603,6 +603,10 @@ static int isst_fill_platform_info(void)
>>  
>>  	close(fd);
>>  
>> +	if (isst_platform_info.api_version > supported_api_ver) {
>> +		printf("Incompatible API versions; Upgrade of tool is
>> required\n");
>> +		return -1;
>> +	}
>>  	return 0;
>>  }
>>  
>> @@ -1528,6 +1532,7 @@ static void cmdline(int argc, char **argv)
>>  {
>>  	int opt;
>>  	int option_index = 0;
>> +	int ret;
>>  
>>  	static struct option long_options[] = {
>>  		{ "cpu", required_argument, 0, 'c' },
>> @@ -1589,13 +1594,14 @@ static void cmdline(int argc, char **argv)
>>  	set_max_cpu_num();
>>  	set_cpu_present_cpu_mask();
>>  	set_cpu_target_cpu_mask();
>> -	isst_fill_platform_info();
>> -	if (isst_platform_info.api_version > supported_api_ver) {
>> -		printf("Incompatible API versions; Upgrade of tool is
>> required\n");
>> -		exit(0);
>> -	}
>> +	ret = isst_fill_platform_info();
>> +	if (ret)
>> +		goto out;
>>  
>>  	process_command(argc, argv);
>> +out:
>> +	free_cpu_set(present_cpumask);
>> +	free_cpu_set(target_cpumask);
>>  }
>>  
>>  int main(int argc, char **argv)
> 

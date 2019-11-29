Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 05:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C18215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 05:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfK2F7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 00:59:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:40140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfK2F7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 00:59:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29988ACE0;
        Fri, 29 Nov 2019 05:59:14 +0000 (UTC)
Subject: Re: [PATCH v2] xen/events: remove event handling recursion detection
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20191128084545.13831-1-jgross@suse.com>
 <b0a86e66-2366-ff94-e867-2fc5cfdae38d@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6483de2d-963c-3b5e-150a-641e070e3d0e@suse.com>
Date:   Fri, 29 Nov 2019 06:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b0a86e66-2366-ff94-e867-2fc5cfdae38d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.19 22:37, Boris Ostrovsky wrote:
> On 11/28/19 3:45 AM, Juergen Gross wrote:
>> -
>>   static void __xen_evtchn_do_upcall(void)
>>   {
>>   	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
>> -	int cpu = get_cpu();
>> -	unsigned count;
>> +	int cpu = smp_processor_id();
>>   
>>   	do {
>>   		vcpu_info->evtchn_upcall_pending = 0;
>>   
>> -		if (__this_cpu_inc_return(xed_nesting_count) - 1)
>> -			goto out;
>> -
>>   		xen_evtchn_handle_events(cpu);
>>   
>>   		BUG_ON(!irqs_disabled());
>>   
>> -		count = __this_cpu_read(xed_nesting_count);
>> -		__this_cpu_write(xed_nesting_count, 0);
>> -	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
>> -
>> -out:
>> +		rmb(); /* Hypervisor can set upcall pending. */
> 
> virt_rmb() perhaps then?

Yes, that's better.


Juergen


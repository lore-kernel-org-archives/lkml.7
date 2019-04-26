Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E7C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A582A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZL3tI1sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDZSmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:42:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54630 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDZSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:42:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3QIcrSi126001;
        Fri, 26 Apr 2019 18:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nr4ms0zKOtUTftVq7uaxaxErHXHaOyk0w2TTE0bII9M=;
 b=ZL3tI1sDsha7nj+hzH87IFZp87jqXpvT69LN5kqF2dQMrzWApQFtSKziFHwN/FuuwVlh
 eFwIJdZ7czh2wpTxzXcGNvfce1a2DHdwnwbDm/kUZk7lbHU6YC72ycAAEnpfBTO7KPYt
 0cxSBIZAaSZaGigUhrQ7AqGRjvBYdKSDvOU+/Dt0bBdxcGi+5DQMy/f37pbWrVfyMm2k
 pEU8GddaqLNbanCotW3E4oPBsWjEgnH3M0nusY0fjEfoPFrvs19VHfIaWgzQsMIyIp5B
 F+ayo5IgJcNGl8r3wzS9EwlsuPLVcwrk/vHgsVNeaDADakh7oo7YRlyAjMxIfGptwllk lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ryrxdfvqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 18:40:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3QIerTn146430;
        Fri, 26 Apr 2019 18:40:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s0dwg5nkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 18:40:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3QIemaU028948;
        Fri, 26 Apr 2019 18:40:48 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Apr 2019 11:40:48 -0700
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
 <20190426084222.GC126896@gmail.com>
 <20190426104328.GA18914@techsingularity.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <fbed0636-8e1f-ff3c-ef45-079497c844bb@oracle.com>
Date:   Fri, 26 Apr 2019 11:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190426104328.GA18914@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904260125
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=800 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904260126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/19 3:43 AM, Mel Gorman wrote:
> On Fri, Apr 26, 2019 at 10:42:22AM +0200, Ingo Molnar wrote:
>>> It should, but it's not perfect. For example, wake_affine_idle does not
>>> take sibling activity into account even though select_idle_sibling *may*
>>> take it into account. Even select_idle_sibling in its fast path may use
>>> an SMT sibling instead of searching.
>>>
>>> There are also potential side-effects with cpuidle. Some workloads
>>> migration around the socket as they are communicating because of how the
>>> search for an idle CPU works. With SMT on, there is potentially a longer
>>> opportunity for a core to reach a deep c-state and incur a bigger wakeup
>>> latency. This is a very weak theory but I've seen cases where latency
>>> sensitive workloads with only two communicating tasks are affected by
>>> CPUs reaching low c-states due to migrations.
>>>
>>>> Clearly it doesn't.
>>>>
>>> It's more that it's best effort to wakeup quickly instead of being perfect
>>> by using an expensive search every time.
>> Yeah, but your numbers suggest that for *most* not heavily interacting
>> under-utilized CPU bound workloads we hurt in the 5-10% range compared to
>> no-SMT - more in some cases.
>>
> Indeed, it was higher than expected and we can't even use the excuse that
> more resources are available to a single logical CPU as the scheduler is
> meant to keep them apart.
>
>> So we avoid a maybe 0.1% scheduler placement overhead but inflict 5-10%
>> harm on the workload, and also blow up stddev by randomly co-scheduling
>> two tasks on the same physical core? Not a good trade-off.
>>
>> I really think we should implement a relatively strict physical core
>> placement policy in the under-utilized case, and resist any attempts to
>> weaken this for special workloads that ping-pong quickly and benefit from
>> sharing the same physical core.
>>
> It's worth a shot at least. Changes should mostly be in the wake_affine
> path for most loads of interest.
Doesn't select_idle_sibling already try to do that by calling
select_idle_core? For our OLTP workload we infact found the cost of
select_idle_core was actually hurting more than it helped to find a fully
idle core, so a net negative.


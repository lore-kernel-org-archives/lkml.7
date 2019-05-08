Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95364C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675AD206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JlAmQv8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfEHSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:43:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55456 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:43:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48IXdtm057067;
        Wed, 8 May 2019 18:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uGWYm/aUXIQX70DcFxESw4cgkt3OUFJZRMcNw/SQoyo=;
 b=JlAmQv8A8r76XAAKM7LJS03w0XGc8beDrd6ZwahO/Qa44eTB6fAi5dCzuXp81kxOgR1e
 nteKz+jUzM9Dv+S7RyYh5VrqBduMCX++mpaximUkBgNOA4XUKwMLjc3HjBozSgW27vTd
 diJEG+oE6hkJiQc8EpydlYWgtUnpVAcNPP+GXvc7vHvz1hq6swPPv/6oe4nHKcx+w/gw
 iJVIBYEcMY6kKCTKH7sLmn01i6jn1j8cyLTejHuEZprF3G5Qif99rsOgSV+SMbXh+tSb
 oTV6tpDoPKaYSGHzz91yW7I69cAiJ+wEtfB6J5mJK46NxaC2ldP+hk5B/MR1FqyjV0sN QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2s94b0x3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 18:41:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48IfMYH162097;
        Wed, 8 May 2019 18:41:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s94aga53g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 May 2019 18:41:22 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x48IfGkZ029544;
        Wed, 8 May 2019 18:41:16 GMT
Received: from [10.132.91.213] (/10.132.91.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 11:41:15 -0700
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
To:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu>
 <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com>
 <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
 <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com>
Message-ID: <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
Date:   Wed, 8 May 2019 11:37:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/19 11:19 AM, Subhra Mazumdar wrote:
>
> On 5/8/19 8:49 AM, Aubrey Li wrote:
>>> Pawan ran an experiment setting up 2 VMs, with one VM doing a 
>>> parallel kernel build and one VM doing sysbench,
>>> limiting both VMs to run on 16 cpu threads (8 physical cores), with 
>>> 8 vcpu for each VM.
>>> Making the fix did improve kernel build time by 7%.
>> I'm gonna agree with the patch below, but just wonder if the testing
>> result is consistent,
>> as I didn't see any improvement in my testing environment.
>>
>> IIUC, from the code behavior, especially for 2 VMs case(only 2
>> different cookies), the
>> per-rq rb tree unlikely has nodes with different cookies, that is, all
>> the nodes on this
>> tree should have the same cookie, so:
>> - if the parameter cookie is equal to the rb tree cookie, we meet a
>> match and go the
>> third branch
>> - else, no matter we go left or right, we can't find a match, and
>> we'll return idle thread
>> finally.
>>
>> Please correct me if I was wrong.
>>
>> Thanks,
>> -Aubrey
> This is searching in the per core rb tree (rq->core_tree) which can have
> 2 different cookies. But having said that, even I didn't see any
> improvement with the patch for my DB test case. But logically it is
> correct.
>
Ah, my bad. It is per rq. But still can have 2 different cookies. Not sure
why you think it is unlikely?

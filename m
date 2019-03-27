Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B8E2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kteY/gOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfC0BFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:05:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfC0BFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:05:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R0xRfW011541;
        Wed, 27 Mar 2019 01:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xv7qfhVwgdgLQui6tb9/wDjghiE85riLDriiMP9tn7Q=;
 b=kteY/gOR+kVIO7T8CEa5hoNpegQdgsP0a9bmzHV4VzEd8BAKxIXXWDKDMGk5nJfJHe1D
 mzz4byHXWwhi0GlP0m/JfMoZ52iAM+xSzL0uw4gNb+j25vJ9sqg73Uypev6q6cSw6MaU
 3yG9qSexs7PresDUzLNCpqy3YsKJkBQpChqCm+gRO3i4Ne9v4GysaqPHshwU79ByOA2d
 fccaRCSiwwLxZYMfIcZwSn2BmUfZZ2rbrHu3LKfY7bKYpxvwZAoxR7/hdP4sqFlpAjd/
 ChhRPJUGhTFGku+4aPZ+wukhFtDx2wB8mcqHONTqBwRTu4Ima2CFC/zSPD1apMYgVHRY iQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g15ns4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 01:05:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2R15AGT007800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 01:05:10 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2R158rn022579;
        Wed, 27 Mar 2019 01:05:08 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 18:05:08 -0700
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
References: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
 <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
 <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
Message-ID: <af1e1aa1-7965-eb53-bbd9-079253eb83ba@oracle.com>
Date:   Tue, 26 Mar 2019 18:02:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/19 5:06 PM, Subhra Mazumdar wrote:
>
> On 3/21/19 2:20 PM, Julien Desfossez wrote:
>> On Tue, Mar 19, 2019 at 10:31 PM Subhra Mazumdar 
>> <subhra.mazumdar@oracle.com>
>> wrote:
>>> On 3/18/19 8:41 AM, Julien Desfossez wrote:
>>>
>> On further investigation, we could see that the contention is mostly 
>> in the
>> way rq locks are taken. With this patchset, we lock the whole core if
>> cpu.tag is set for at least one cgroup. Due to this, __schedule() is 
>> more or
>> less serialized for the core and that attributes to the performance loss
>> that we are seeing. We also saw that newidle_balance() takes 
>> considerably
>> long time in load_balance() due to the rq spinlock contention. Do you 
>> think
>> it would help if the core-wide locking was only performed when 
>> absolutely
>> needed ?
>>
> Is the core wide lock primarily responsible for the regression? I ran 
> upto patch
> 12 which also has the core wide lock for tagged cgroups and also calls
> newidle_balance() from pick_next_task(). I don't see any regression.  
> Of course
> the core sched version of pick_next_task() may be doing more but 
> comparing with
> the __pick_next_task() it doesn't look too horrible.
I gathered some data with only 1 DB instance running (which also has 52% 
slow
down). Following are the numbers of pick_next_task() calls and their avg 
cost
for patch 12 and patch 15. The total number of calls seems to be similar 
but the
avg cost (in us) has more than doubled. For both the patches I had put 
the DB
instance into a cpu tagged cgroup.

                              patch12 patch15
count pick_next_task         62317898 58925395
avg cost pick_next_task      0.6566323209   1.4223810108

Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C02070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUSXDQce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfCRIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:45:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfCRIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:45:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I8hZQj137057;
        Mon, 18 Mar 2019 08:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xa91qdU2jcL41lmq97BBHiaW3XQoiOKHNeWC7E7SKoQ=;
 b=HUSXDQceFfjEXr2lbJnzCk7wkOqapRJzovDLgJrmU1pDgEyUtTODs/w208v0aY1mtj4f
 gY1dZwCIZEdZNzG1KA50A1e1uTnmtz76Hij8WuZBho61al6FslRD3Ow21Wi+/xyUQHQO
 ct6tQ8RADN9cDhhRQv9vVC52F71quGBOIkTHupokavjEGgB0l4miuRp3M/p+fmRNqVrR
 5W7WCHz29VNv6mEsmFCcn4VfNz55M1oN212s4PtIZrCw331Da4tIZjiXhoWBmPOGgSu3
 LXyZyngk32OKr8dRuJuCTuXFmfTTX1Y2ajC0Q+nQVwzNMjU2n/RVHIQ5U3Q0Xy6AAyId xw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r8rjud4t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 08:45:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2I8itdt016537
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 08:44:56 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2I8iqV1002761;
        Mon, 18 Mar 2019 08:44:52 GMT
Received: from [10.191.3.14] (/10.191.3.14)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 01:44:52 -0700
Subject: Re: [PATCH 2/2] Revert "x86/hpet: Reduce HPET counter read
 contention"
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, x86@kernel.org
References: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com>
 <1552552932-21821-2-git-send-email-zhenzhong.duan@oracle.com>
 <20190315092529.GU5996@hirez.programming.kicks-ass.net>
 <09d5ca8b-9cee-c013-01b4-bd2e78672b57@redhat.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <ad2ab867-d39a-8d71-f76e-da820f9d2faa@oracle.com>
Date:   Mon, 18 Mar 2019 16:44:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <09d5ca8b-9cee-c013-01b4-bd2e78672b57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/15 22:17, Waiman Long wrote:
> On 03/15/2019 05:25 AM, Peter Zijlstra wrote:
>> On Thu, Mar 14, 2019 at 04:42:12PM +0800, Zhenzhong Duan wrote:
>>> This reverts commit f99fd22e4d4bc84880a8a3117311bbf0e3a6a9dc.
>>>
>>> It's unnecessory after commit "acpi_pm: Fix bootup softlockup due to PMTMR
>>> counter read contention", the simple HPET access code could be restored.
>>>
>>> On a general system with good TSC, TSC is the final default clocksource.
>>> So the potential performce loss is only at bootup stage before TSC
>>> replacing HPET, we didn't observe obvious delay of bootup.
>> The timeline here is:
>>
>>   - Len took out SKX from native_calibrate_tsc
>>     b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake Xeon")
>>
>>     This causes the TSC to run through the calibration code, which
>>     completes _after_ SMP bringup.
>>
>>   - This then caused HPET to be used during SMP bringup, which resulted
>>     in Waiman doing the patch you now propose removing.
>>
>>     Because large (multi-socket) SKX machines would barely boot.
>>
>>     f99fd22e4d4b ("x86/hpet: Reduce HPET counter read contention")
>>
>>   - Now, I figured that was all crazy to begin with, and introduced
>>     clocksource_tsc_early, such that we can run at the guestimate TSC
>>     frequency until we've completed calibration and then swap to the real
>>     TSC clocksource.
>>
>>     aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
>>     (and assorted fixes)
>>
>> This means that we now only use HPET for a very short time in early
>> boot, _IFF_ TSC is stable.
>>
>> Now, given the amount of wreckage we still see with TSC, I'm very
>> reluctant to revert this patch. Because the moment TSC goes out the
>> window, we're back on HPET, and this patch does make a huge difference.
>>
>> Yes, its sad, gross and nasty... but the same is true for TSC still being
>> a trainwreck.
>>
>> So NAK.
> I concur. In the uncontended case, the overhead is mostly just the
> additional cmpxchg instruction for acquiring the spinlock. Even then, it
> isn't significant when compared with the time needed to actually read
> from the HPET. Without that code, any fallback to HPET for whatever
> reason will likely see degradation in performance especially on systems
> with large number of CPUs.

Thank Peter and Waiman for reply.

I see, we still care the performance on a system with wreckage TSC.


So now we come back to the old question, do we care the softlockup

and the performance when pmtmr is chosed for whatever reason?

For which I had provide two different fixes:

https://lkml.org/lkml/2019/1/22/1172

and

https://lkml.org/lkml/2019/3/15/101

-- 
Thanks
Zhenzhong


Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6171EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AC12147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sfc16pQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfC0Oky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:40:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52460 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfC0Oky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:40:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2REcqxA078600;
        Wed, 27 Mar 2019 14:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=MMJmD4gN/frPdeUf7hnKvmHHeKbJ50Hyxlf7Lp1kR+c=;
 b=Sfc16pQTR0euR0VMDrw6DP6nbVcp06hLZFB/p2JGrgRYEAj77oG47UMSsesJmRpeQo/s
 cBGMdMu8oF3+3QIm9SBYm58l904XKtuT0csIyIk+7AuaELpUv8G2RsFp6swQ2+Jyr/P/
 FwEOg2fDnZJw374TRyXjzYYcIFMp22dDKYDVd+cSaOTNmt5Z+Ae4+TbYVVWeadLugoFK
 AK8CiEqD4QZuRZr/4jWUw24gpqtGovA25r5pTLoAnt5fG/qTsYGG0QqCgzDspI8WrGpe
 sqFnQObiPOo2D0RnOnzq4T/DAS/J5i110WPXBpM8ivikSGjnfyq5XRHvKg0d/Fmv7r59 Iw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g18xu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 14:40:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2REeSRI017541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 14:40:28 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2REeRLc024662;
        Wed, 27 Mar 2019 14:40:27 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 07:40:26 -0700
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
To:     Ryan Thibodeaux <thibodux@gmail.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
 <20190323114151.5cebf31b@sweethome> <20190325130530.56603806@luca64>
 <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
 <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
 <907547fa-a7e8-8dca-dabf-dd063705f196@oracle.com>
 <20190327100014.GA9663@centos-dev.localdomain>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <04ee9e67-5720-72df-9e2e-2ba42febf90f@oracle.com>
Date:   Wed, 27 Mar 2019 10:46:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190327100014.GA9663@centos-dev.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 6:00 AM, Ryan Thibodeaux wrote:
> On Tue, Mar 26, 2019 at 07:21:31PM -0400, Boris Ostrovsky wrote:
>> On 3/26/19 5:13 AM, Dario Faggioli wrote:
>>> On Mon, 2019-03-25 at 09:43 -0400, Boris Ostrovsky wrote:
>>>> On 3/25/19 8:05 AM, luca abeni wrote:
>>>>> The picture shows the latencies measured with an unpatched guest
>>>>> kernel
>>>>> and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary
>>>>> small
>>>>> value :).
>>>>> All the experiments have been performed booting the hypervisor with
>>>>> a
>>>>> small timer_slop (the hypervisor's one) value. So, they show that
>>>>> decreasing the hypervisor's timer_slop is not enough to measure low
>>>>> latencies with cyclictest.
>>>> I have a couple of questions:
>>>> * Does it make sense to make this a tunable for other clockevent
>>>> devices
>>>> as well?
>>>>
>>> So, AFAIUI, the thing is as follows. In clockevents_program_event(), we
>>> keep the delta between now and the next timer event within
>>> dev->max_delta_ns and dev->min_delta_ns:
>>>
>>>   delta = min(delta, (int64_t) dev->max_delta_ns);
>>>   delta = max(delta, (int64_t) dev->min_delta_ns);
>>>
>>> For Xen (well, for the Xen clock) we have:
>>>
>>>   .max_delta_ns = 0xffffffff,
>>>   .min_delta_ns = TIMER_SLOP,
>>>
>>> which means a guest can't ask for a timer to fire earlier than 100us
>>> ahead, which is a bit too coarse, especially on contemporary hardware.
>>>
>>> For "lapic_deadline" (which was what was in use in KVM guests, in our
>>> experiments) we have:
>>>
>>>   lapic_clockevent.max_delta_ns = clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
>>>   lapic_clockevent.min_delta_ns = clockevent_delta2ns(0xF, &lapic_clockevent);
>>>
>>> Which means max is 0x7FFFFF device ticks, and min is 0xF.
>>> clockevent_delta2ns() does the conversion from ticks to ns, basing on
>>> the results of the APIC calibration process. It calls cev_delta2ns()
>>> which does some scaling, shifting, divs, etc, and, at the very end,
>>> this:
>>>
>>>   /* Deltas less than 1usec are pointless noise */
>>>   return clc > 1000 ? clc : 1000;
>>>
>>> So, as Ryan is also saying, the actual minimum, in this case, depends
>>> on hardware, with a sanity check of "never below 1us" (which is quite
>>> smaller than 100us!)
>>>
>>> Of course, the actual granularity depends on hardware in the Xen case
>>> as well, but that is handled in Xen itself. And we have mechanisms in
>>> place in there to avoid timer interrupt storms (like, ahem, the Xen's
>>> 'timer_slop' boot parameter... :-P)
>>>
>>> And this is basically why I was also thinking we can/should lower the
>>> default value of TIMER_SLOP, here in the Xen clock implementation in
>>> Linux.
>> What do you think would be a sane value? 10us? Should we then still keep
>> this patch?
>>
>> My concern would be that if we change the current value and it turns out
>> to be very wrong we'd then have no recourse.
>>
>>
>> -boris
>>
> Speaking out of turn but as a participant in this thread, I would not
> assume to change the default value for all cases without significant
> testing by the community, touching a variety of configurations.
>
> It feels like changing the default has a non-trivial amount of 
> unknowns that would need to be addressed.
>
> Not surprisingly, I am biased to the approach of my patch which
> does not change the default but offers flexibility to all.


If we are to change the default it would be good to at least collect
some data on distribution of delta values in
clockevents_program_event(). But as I said, I'd keep the patch.

Also, as far as the comment describing TIMER_SLOP, I agree that it is
rather misleading.

I can replace it with /* Minimum amount of time until next clock event
fires */, I  can do it while committing so no need to resend.

-boris

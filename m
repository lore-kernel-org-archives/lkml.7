Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B16DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF5D21670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEAO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:57:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfEAO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:57:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41Euv03095966
        for <linux-kernel@vger.kernel.org>; Wed, 1 May 2019 10:57:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7cypsjy5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:57:47 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nathanl@linux.ibm.com>;
        Wed, 1 May 2019 15:57:46 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:57:44 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41Evh1A35913762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:57:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72088112062;
        Wed,  1 May 2019 14:57:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CDC7112061;
        Wed,  1 May 2019 14:57:43 +0000 (GMT)
Received: from localhost (unknown [9.80.206.5])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 May 2019 14:57:43 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/pseries: Remove limit in wait for dying CPU
In-Reply-To: <87v9yve02x.fsf@morokweng.localdomain>
References: <20190423223914.3882-1-bauerman@linux.ibm.com> <877ebbsb8u.fsf@linux.ibm.com> <87v9yve02x.fsf@morokweng.localdomain>
Date:   Wed, 01 May 2019 09:57:42 -0500
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19050114-0060-0000-0000-00000337074D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011029; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197068; UDB=6.00627825; IPR=6.00977922;
 MB=3.00026683; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-01 14:57:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-0061-0000-0000-00004929B429
Message-Id: <8736lyrzmh.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thiago,

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>> +		while (true) {
>>>  			cpu_status = smp_query_cpu_stopped(pcpu);
>>>  			if (cpu_status == QCSS_STOPPED ||
>>>  			    cpu_status == QCSS_HARDWARE_ERROR)
>>>  				break;
>>> -			cpu_relax();
>>> +			udelay(100);
>>>  		}
>>>  	}
>>
>> I agree with looping indefinitely but doesn't it need a cond_resched()
>> or similar check?
>
> If there's no kernel or hypervisor bug, it shouldn't take more than a
> few tens of ms for this loop to complete (Gautham measured a maximum of
> 10 ms on a POWER9 with an earlier version of this patch).

10ms is twice the default scheduler quantum...


> In case of bugs related to CPU hotplug (either in the kernel or the
> hypervisor), I was hoping that the resulting lockup warnings would be a
> good indicator that something is wrong. :-)

Not convinced we should assume something is wrong if it takes a few
dozen ms to complete the operation. AFAIK we don't have any guarantees
about the maximum latency of stop-self, and it can be affected by other
activity in the system, whether we're in shared processor mode, etc. Not
to mention smp_query_cpu_stopped has to acquire the global RTAS lock and
be serialized with other tasks calling into RTAS. So I am concerned
about generating spurious warnings here.

If for whatever reason the operation is taking too long, drmgr or
whichever application is initiating the change will appear to stop
making progress. It's not too hard to find out what's going on with
facilities like perf or /proc/pid/stack.


> Though perhaps adding a cond_resched() every 10 ms or so, with a
> WARN_ON() if it loops for more than 50 ms would be better.

A warning doesn't seem appropriate to me, and cond_resched should be
invoked in each iteration. Or just msleep(1) in each iteration would be
fine, I think.

But I'd like to bring in some more context -- here is the body of
pseries_cpu_die:

static void pseries_cpu_die(unsigned int cpu)
{
	int tries;
	int cpu_status = 1;
	unsigned int pcpu = get_hard_smp_processor_id(cpu);

	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
		cpu_status = 1;
		for (tries = 0; tries < 5000; tries++) {
			if (get_cpu_current_state(cpu) == CPU_STATE_INACTIVE) {
				cpu_status = 0;
				break;
			}
			msleep(1);
		}
	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {

		for (tries = 0; tries < 25; tries++) {
			cpu_status = smp_query_cpu_stopped(pcpu);
			if (cpu_status == QCSS_STOPPED ||
			    cpu_status == QCSS_HARDWARE_ERROR)
				break;
			cpu_relax();
		}
}

This patch alters the behavior of the second loop (the CPU_STATE_OFFLINE
branch). The CPU_STATE_INACTIVE branch is used when the offline behavior
is to use H_CEDE instead of stop-self, correct?

And isn't entering H_CEDE expected to be quite a bit faster than
stop-self? If so, why does that path get five whole seconds[*] while
we're bikeshedding about tens of milliseconds for stop-self? :-)

[*] And should it be made to retry indefinitely as well?


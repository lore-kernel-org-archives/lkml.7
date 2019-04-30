Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E83FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfD3T7i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 15:59:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfD3T7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 15:59:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UJmE6L046452;
        Tue, 30 Apr 2019 15:59:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s6v6728nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 15:59:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x3UE1AAI025463;
        Tue, 30 Apr 2019 14:03:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3t43s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 14:03:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3UJxRTa61735068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 19:59:27 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7857805E;
        Tue, 30 Apr 2019 19:59:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048AE7805F;
        Tue, 30 Apr 2019 19:59:24 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.212.9])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Apr 2019 19:59:24 +0000 (GMT)
References: <20190423223914.3882-1-bauerman@linux.ibm.com> <877ebbsb8u.fsf@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/pseries: Remove limit in wait for dying CPU
In-reply-to: <877ebbsb8u.fsf@linux.ibm.com>
Date:   Tue, 30 Apr 2019 16:59:18 -0300
Message-ID: <87v9yve02x.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Nathan,

Thanks for reviewing the patch!

Nathan Lynch <nathanl@linux.ibm.com> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> This can be a problem because if the busy loop finishes too early, then the
>> kernel may offline another CPU before the previous one finished dying,
>> which would lead to two concurrent calls to rtas-stop-self, which is
>> prohibited by the PAPR.
>>
>> Since the hotplug machinery already assumes that cpu_die() is going to
>> work, we can simply loop until the CPU stops.
>>
>> Also change the loop to wait 100 µs between each call to
>> smp_query_cpu_stopped() to avoid querying RTAS too often.
>
> [...]
>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index 97feb6e79f1a..d75cee60644c 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -214,13 +214,17 @@ static void pseries_cpu_die(unsigned int cpu)
>>  			msleep(1);
>>  		}
>>  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
>> -
>> -		for (tries = 0; tries < 25; tries++) {
>> +		/*
>> +		 * rtas_stop_self() panics if the CPU fails to stop and our
>> +		 * callers already assume that we are going to succeed, so we
>> +		 * can just loop until the CPU stops.
>> +		 */
>> +		while (true) {
>>  			cpu_status = smp_query_cpu_stopped(pcpu);
>>  			if (cpu_status == QCSS_STOPPED ||
>>  			    cpu_status == QCSS_HARDWARE_ERROR)
>>  				break;
>> -			cpu_relax();
>> +			udelay(100);
>>  		}
>>  	}
>
> I agree with looping indefinitely but doesn't it need a cond_resched()
> or similar check?

If there's no kernel or hypervisor bug, it shouldn't take more than a
few tens of ms for this loop to complete (Gautham measured a maximum of
10 ms on a POWER9 with an earlier version of this patch).

In case of bugs related to CPU hotplug (either in the kernel or the
hypervisor), I was hoping that the resulting lockup warnings would be a
good indicator that something is wrong. :-)

Though perhaps adding a cond_resched() every 10 ms or so, with a
WARN_ON() if it loops for more than 50 ms would be better.

I'll send an alternative patch.

--
Thiago Jung Bauermann
IBM Linux Technology Center

Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488FB21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfIRRcB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:32:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbfIRRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8IHM13G138918
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:31:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3r2e21w7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:31:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 18 Sep 2019 18:31:57 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 18:31:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8IHVsBP8192024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:31:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C1F2AE058;
        Wed, 18 Sep 2019 17:31:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAF8BAE045;
        Wed, 18 Sep 2019 17:31:53 +0000 (GMT)
Received: from localhost (unknown [9.85.70.166])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 17:31:53 +0000 (GMT)
Date:   Wed, 18 Sep 2019 21:54:09 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] pseries/hotplug: Change the default behaviour of
 cede_offline
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
        <87r24ew5i0.fsf@mpe.ellerman.id.au>
        <1568788924.kxcnnog4r7.naveen@linux.ibm.com>
        <877e65x2lk.fsf@mpe.ellerman.id.au>
In-Reply-To: <877e65x2lk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19091817-0016-0000-0000-000002ADAAD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091817-0017-0000-0000-0000330E564A
Message-Id: <1568822623.nyl7ya1i16.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Michael Ellerman wrote:
>>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>>>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>>>
>>>> Currently on Pseries Linux Guests, the offlined CPU can be put to one
>>>> of the following two states:
>>>>    - Long term processor cede (also called extended cede)
>>>>    - Returned to the Hypervisor via RTAS "stop-self" call.
>>>>
>>>> This is controlled by the kernel boot parameter "cede_offline=on/off".
>>>>
>>>> By default the offlined CPUs enter extended cede.
>>> 
>>> Since commit 3aa565f53c39 ("powerpc/pseries: Add hooks to put the CPU into an appropriate offline state") (Nov 2009)
>>> 
>>> Which you wrote :)
>>> 
>>> Why was that wrong?
>>> 
>>>> The PHYP hypervisor considers CPUs in extended cede to be "active"
>>>> since the CPUs are still under the control fo the Linux Guests. Hence, when we change the
>>>> SMT modes by offlining the secondary CPUs, the PURR and the RWMR SPRs
>>>> will continue to count the values for offlined CPUs in extended cede
>>>> as if they are online.
>>>>
>>>> One of the expectations with PURR is that the for an interval of time,
>>>> the sum of the PURR increments across the online CPUs of a core should
>>>> equal the number of timebase ticks for that interval.
>>>>
>>>> This is currently not the case.
>>> 
>>> But why does that matter? It's just some accounting stuff, does it
>>> actually break something meaningful?
>>
>> Yes, this broke lparstat at the very least (though its quite unfortunate 
>> we took so long to notice).
> 
> By "so long" you mean 10 years?
> 
> Also I've never heard of lparstat, but I assume it's one of these tools
> that's meant to behave like the AIX equivalent?

Yes, and yes. lparstat is part of powerpc-utils.

> 
> If it's been "broken" for 10 years and no one noticed, I'd argue the
> current behaviour is now "correct" and fixing it would actually be a
> breakage :)

:)
More on this below...

> 
>> With SMT disabled, and under load:
>>   $ sudo lparstat 1 10
>>
>>   System Configuration
>>   type=Shared mode=Uncapped smt=Off lcpu=2 mem=7759616 kB cpus=6 ent=1.00 
>>
>>   %user  %sys %wait    %idle    physc %entc lbusy  vcsw phint
>>   ----- ----- -----    -----    ----- ----- ----- ----- -----
>>   100.00  0.00  0.00     0.00     1.10 110.00 100.00 128784460     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128784860     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128785260     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128785662     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786062     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786462     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786862     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128787262     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128787664     0
>>   100.00  0.00  0.00     0.00     1.07 107.00 100.00 128788064     0
> 
> What about that is wrong?

The 'physc' column represents cpu usage in units of physical cores.  
With 2 virtual cores ('lcpu=2') in uncapped, shared processor mode, we 
expect this to be closer to 2 when fully loaded (and spare capacity 
elsewhere in the system).

> 
>> With cede_offline=off:
>>   $ sudo lparstat 1 10
>>
>>   System Configuration
>>   type=Shared mode=Uncapped smt=Off lcpu=2 mem=7759616 kB cpus=6 ent=1.00 
>>
>>   %user  %sys %wait    %idle    physc %entc lbusy  vcsw phint
>>   ----- ----- -----    -----    ----- ----- ----- ----- -----
>>   100.00  0.00  0.00     0.00     1.94 194.00 100.00 128961588     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128961988     0
>>   100.00  0.00  0.00     0.00      inf   inf 100.00 128962392     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128962792     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963192     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963592     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963992     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128964392     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128964792     0
>>   100.00  0.00  0.00     0.00     1.91 191.00 100.00 128965194     0
>>
>> [The 'inf' values there show a different bug]
>>
>> Also, since we expose [S]PURR through sysfs, any tools that make use of 
>> that directly are also affected due to this.
> 
> But again if we've had the current behaviour for 10 years then arguably
> that's now the correct behaviour.

That's a fair point, and probably again points to this area getting less 
tested. One of the main reasons for this being caught now though, is 
that there are workloads being tested under lower SMT levels now. So, I 
suspect no one has been relying on this behavior and we can consider 
this to be a bug.


Thanks,
Naveen


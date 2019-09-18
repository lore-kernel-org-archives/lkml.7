Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4C820640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIRGxC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:53:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfIRGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:53:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8I6mcsc135389
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:53:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v3cekds8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:52:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 18 Sep 2019 07:52:58 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 07:52:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8I6qsBs42533330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 06:52:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0FAA4054;
        Wed, 18 Sep 2019 06:52:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C648CA4064;
        Wed, 18 Sep 2019 06:52:53 +0000 (GMT)
Received: from localhost (unknown [9.199.38.30])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 06:52:53 +0000 (GMT)
Date:   Wed, 18 Sep 2019 12:22:48 +0530
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
In-Reply-To: <87r24ew5i0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19091806-0012-0000-0000-0000034D719A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091806-0013-0000-0000-00002187EE3A
Message-Id: <1568788924.kxcnnog4r7.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>>
>> Currently on Pseries Linux Guests, the offlined CPU can be put to one
>> of the following two states:
>>    - Long term processor cede (also called extended cede)
>>    - Returned to the Hypervisor via RTAS "stop-self" call.
>>
>> This is controlled by the kernel boot parameter "cede_offline=on/off".
>>
>> By default the offlined CPUs enter extended cede.
> 
> Since commit 3aa565f53c39 ("powerpc/pseries: Add hooks to put the CPU into an appropriate offline state") (Nov 2009)
> 
> Which you wrote :)
> 
> Why was that wrong?
> 
>> The PHYP hypervisor considers CPUs in extended cede to be "active"
>> since the CPUs are still under the control fo the Linux Guests. Hence, when we change the
>> SMT modes by offlining the secondary CPUs, the PURR and the RWMR SPRs
>> will continue to count the values for offlined CPUs in extended cede
>> as if they are online.
>>
>> One of the expectations with PURR is that the for an interval of time,
>> the sum of the PURR increments across the online CPUs of a core should
>> equal the number of timebase ticks for that interval.
>>
>> This is currently not the case.
> 
> But why does that matter? It's just some accounting stuff, does it
> actually break something meaningful?

Yes, this broke lparstat at the very least (though its quite unfortunate 
we took so long to notice).

With SMT disabled, and under load:
  $ sudo lparstat 1 10

  System Configuration
  type=Shared mode=Uncapped smt=Off lcpu=2 mem=7759616 kB cpus=6 ent=1.00 

  %user  %sys %wait    %idle    physc %entc lbusy  vcsw phint
  ----- ----- -----    -----    ----- ----- ----- ----- -----
  100.00  0.00  0.00     0.00     1.10 110.00 100.00 128784460     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128784860     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128785260     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128785662     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786062     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786462     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128786862     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128787262     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128787664     0
  100.00  0.00  0.00     0.00     1.07 107.00 100.00 128788064     0


With cede_offline=off:
  $ sudo lparstat 1 10

  System Configuration
  type=Shared mode=Uncapped smt=Off lcpu=2 mem=7759616 kB cpus=6 ent=1.00 

  %user  %sys %wait    %idle    physc %entc lbusy  vcsw phint
  ----- ----- -----    -----    ----- ----- ----- ----- -----
  100.00  0.00  0.00     0.00     1.94 194.00 100.00 128961588     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128961988     0
  100.00  0.00  0.00     0.00      inf   inf 100.00 128962392     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128962792     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963192     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963592     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128963992     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128964392     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128964792     0
  100.00  0.00  0.00     0.00     1.91 191.00 100.00 128965194     0

[The 'inf' values there show a different bug]

Also, since we expose [S]PURR through sysfs, any tools that make use of 
that directly are also affected due to this.


- Naveen


Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F03720659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfLFJOP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:14:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfLFJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:14:15 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB696wQ1052973
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 04:14:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9vda6ww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 04:14:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 6 Dec 2019 09:14:11 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 09:14:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB69E8sr38338590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 09:14:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A0C9AE051;
        Fri,  6 Dec 2019 09:14:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD41DAE056;
        Fri,  6 Dec 2019 09:14:07 +0000 (GMT)
Received: from localhost (unknown [9.124.35.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 09:14:07 +0000 (GMT)
Date:   Fri, 06 Dec 2019 14:44:06 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] pseries: Track and expose idle PURR and SPURR ticks
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
        <87r21ju3ud.fsf@linux.ibm.com>
        <48823589-b105-0da3-e532-f633ade8f0d9@linux.vnet.ibm.com>
        <87k17au4rw.fsf@linux.ibm.com> <1575566328.nhfi897fmd.naveen@linux.ibm.com>
In-Reply-To: <1575566328.nhfi897fmd.naveen@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19120609-0016-0000-0000-000002D21208
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120609-0017-0000-0000-000033341B13
Message-Id: <1575623305.dgcux6u43j.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_02:2019-12-04,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao wrote:
> Hi Nathan,
> 
> Nathan Lynch wrote:
>> Hi Kamalesh,
>> 
>> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
>>> On 12/5/19 3:54 AM, Nathan Lynch wrote:
>>>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>>>>>
>>>>> Tools such as lparstat which are used to compute the utilization need
>>>>> to know [S]PURR ticks when the cpu was busy or idle. The [S]PURR
>>>>> counters are already exposed through sysfs.  We already account for
>>>>> PURR ticks when we go to idle so that we can update the VPA area. This
>>>>> patchset extends support to account for SPURR ticks when idle, and
>>>>> expose both via per-cpu sysfs files.
>>>> 
>>>> Does anything really want to use PURR instead of SPURR? Seems like we
>>>> should expose only SPURR idle values if possible.
>>>> 
>>>
>>> lparstat is one of the consumers of PURR idle metric
>>> (https://groups.google.com/forum/#!topic/powerpc-utils-devel/fYRo69xO9r4). 
>>> Agree, on the argument that system utilization metrics based on SPURR
>>> accounting is accurate in comparison to PURR, which isn't proportional to
>>> CPU frequency.  PURR has been traditionally used to understand the system
>>> utilization, whereas SPURR is used for understanding how much capacity is
>>> left/exceeding in the system based on the current power saving mode.
>> 
>> I'll phrase my question differently: does SPURR complement or supercede
>> PURR? You seem to be saying they serve different purposes. If PURR is
>> actually useful rather then vestigial then I have no objection to
>> exposing idle_purr.
> 
> SPURR complements PURR, so we need both. SPURR/PURR ratio helps provide 
> an indication of the available headroom in terms of core resources, at 
> maximum frequency.

Re-reading this today morning, I realize that this isn't entirely 
accurate. SPURR alone is sufficient to understand core resource 
utilization.

Kamalesh is using PURR to display non-normalized utilization values 
(under 'actual' column), as reported by lparstat on AIX. I am not 
entirely sure if it is ok to derive these based on the SPURR busy/idle 
ratio.

- Naveen


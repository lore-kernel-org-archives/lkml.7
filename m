Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B03C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfDXKex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:34:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfDXKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:34:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OAXcnK114589
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:34:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2k57j1fa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:34:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Wed, 24 Apr 2019 11:34:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 11:34:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OAYbhp60227612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 10:34:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B5EFA405D;
        Wed, 24 Apr 2019 10:34:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6834A404D;
        Wed, 24 Apr 2019 10:34:34 +0000 (GMT)
Received: from [9.145.184.124] (unknown [9.145.184.124])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 10:34:34 +0000 (GMT)
Subject: Re: [PATCH v12 04/31] arm64/mm: define
 ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, akpm@linux-foundation.org,
        mhocko@kernel.org, peterz@infradead.org, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-5-ldufour@linux.ibm.com>
 <20190416142710.GA54515@lakrids.cambridge.arm.com>
 <4ef9ff4b-2230-0644-2254-c1de22d41e6c@linux.ibm.com>
 <20190416144156.GB54708@lakrids.cambridge.arm.com>
 <20190418215113.GD11645@redhat.com>
 <73a3650d-7e9f-bc9e-6ea1-2cef36411b0c@linux.ibm.com>
 <20190423161931.GE56999@lakrids.cambridge.arm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Wed, 24 Apr 2019 12:34:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423161931.GE56999@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042410-0016-0000-0000-00000272F61E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042410-0017-0000-0000-000032CF66F9
Message-Id: <e270e50f-8afe-9007-1759-f576aa4c08c9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2019 à 18:19, Mark Rutland a écrit :
> On Tue, Apr 23, 2019 at 05:36:31PM +0200, Laurent Dufour wrote:
>> Le 18/04/2019 à 23:51, Jerome Glisse a écrit :
>>> On Tue, Apr 16, 2019 at 03:41:56PM +0100, Mark Rutland wrote:
>>>> On Tue, Apr 16, 2019 at 04:31:27PM +0200, Laurent Dufour wrote:
>>>>> Le 16/04/2019 à 16:27, Mark Rutland a écrit :
>>>>>> On Tue, Apr 16, 2019 at 03:44:55PM +0200, Laurent Dufour wrote:
>>>>>>> From: Mahendran Ganesh <opensource.ganesh@gmail.com>
>>>>>>>
>>>>>>> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
>>>>>>> enables Speculative Page Fault handler.
>>>>>>>
>>>>>>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>>>>>>
>>>>>> This is missing your S-o-B.
>>>>>
>>>>> You're right, I missed that...
>>>>>
>>>>>> The first patch noted that the ARCH_SUPPORTS_* option was there because
>>>>>> the arch code had to make an explicit call to try to handle the fault
>>>>>> speculatively, but that isn't addeed until patch 30.
>>>>>>
>>>>>> Why is this separate from that code?
>>>>>
>>>>> Andrew was recommended this a long time ago for bisection purpose. This
>>>>> allows to build the code with CONFIG_SPECULATIVE_PAGE_FAULT before the code
>>>>> that trigger the spf handler is added to the per architecture's code.
>>>>
>>>> Ok. I think it would be worth noting that in the commit message, to
>>>> avoid anyone else asking the same question. :)
>>>
>>> Should have read this thread before looking at x86 and ppc :)
>>>
>>> In any case the patch is:
>>>
>>> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
>>
>> Thanks Mark and Jérôme for reviewing this.
>>
>> Regarding the change in the commit message, I'm wondering if this would be
>> better to place it in the Series's letter head.
>>
>> But I'm fine to put it in each architecture's commit.
> 
> I think noting it in both the cover letter and specific patches is best.
> 
> Having something in the commit message means that the intent will be
> clear when the patch is viewed in isolation (e.g. as they will be once
> merged).
> 
> All that's necessary is something like:
> 
>    Note that this patch only enables building the common speculative page
>    fault code such that this can be bisected, and has no functional
>    impact. The architecture-specific code to make use of this and enable
>    the feature will be addded in a subsequent patch.

Thanks Mark, will do it this way.


> Thanks,
> Mark.


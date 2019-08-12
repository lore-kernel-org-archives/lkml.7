Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB88C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB55206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfHLVoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:44:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbfHLVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:44:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CLhAia056358;
        Mon, 12 Aug 2019 17:43:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubep3bb1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 17:43:53 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7CLhLfU057132;
        Mon, 12 Aug 2019 17:43:53 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubep3bb15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 17:43:53 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7CLZOGc031449;
        Mon, 12 Aug 2019 21:43:52 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 2u9nj6a4vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 21:43:52 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CLhphE44564940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 21:43:51 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0888112064;
        Mon, 12 Aug 2019 21:43:51 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F087F112062;
        Mon, 12 Aug 2019 21:43:48 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.165.146])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Aug 2019 21:43:48 +0000 (GMT)
References: <20190806052237.12525-1-bauerman@linux.ibm.com> <20190806052237.12525-9-bauerman@linux.ibm.com> <875zn2sgqs.fsf@concordia.ellerman.id.au>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 08/16] powerpc/pseries/svm: Use shared memory for LPPACA structures
In-reply-to: <875zn2sgqs.fsf@concordia.ellerman.id.au>
Date:   Mon, 12 Aug 2019 18:43:45 -0300
Message-ID: <87sgq6gium.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> LPPACA structures need to be shared with the host. Hence they need to be in
>> shared memory. Instead of allocating individual chunks of memory for a
>> given structure from memblock, a contiguous chunk of memory is allocated
>> and then converted into shared memory. Subsequent allocation requests will
>> come from the contiguous chunk which will be always shared memory for all
>> structures.
>>
>> While we are able to use a kmem_cache constructor for the Debug Trace Log,
>> LPPACAs are allocated very early in the boot process (before SLUB is
>> available) so we need to use a simpler scheme here.
>>
>> Introduce helper is_svm_platform() which uses the S bit of the MSR to tell
>> whether we're running as a secure guest.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/svm.h | 26 ++++++++++++++++++++
>>  arch/powerpc/kernel/paca.c     | 43 +++++++++++++++++++++++++++++++++-
>>  2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
>> new file mode 100644
>> index 000000000000..fef3740f46a6
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/svm.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * SVM helper functions
>> + *
>> + * Copyright 2019 Anshuman Khandual, IBM Corporation.
>
> Are we sure this copyright date is correct?

I may be confused about which year the copyright refers to. I thought it
was the year when the patch was committed. If it is the first time the
patch was published then this one should be 2018.

--
Thiago Jung Bauermann
IBM Linux Technology Center

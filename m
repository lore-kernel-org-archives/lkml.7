Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B50206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfLQKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:15:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727161AbfLQKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:15:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHADlG8135879;
        Tue, 17 Dec 2019 05:15:42 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe8bdgb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 05:15:42 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBHAE9mF138395;
        Tue, 17 Dec 2019 05:15:41 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe8bdgaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 05:15:41 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBHABIlT026419;
        Tue, 17 Dec 2019 10:15:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2wvqc6j5a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:15:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBHAFeSV35717406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 10:15:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35C6BAE05F;
        Tue, 17 Dec 2019 10:15:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCD1AAE05C;
        Tue, 17 Dec 2019 10:15:37 +0000 (GMT)
Received: from [9.204.201.20] (unknown [9.204.201.20])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 10:15:37 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] mm/mmu_gather: Avoid multiple page walk cache
 flush
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217071713.93399-2-aneesh.kumar@linux.ibm.com>
 <20191217085854.GW2844@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <32404765-ad4f-6612-d1a9-43f9acdc8a62@linux.ibm.com>
Date:   Tue, 17 Dec 2019 15:45:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217085854.GW2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=957 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:28 PM, Peter Zijlstra wrote:
> On Tue, Dec 17, 2019 at 12:47:13PM +0530, Aneesh Kumar K.V wrote:
>> On tlb_finish_mmu() kernel does a tlb flush before  mmu gather table invalidate.
>> The mmu gather table invalidate depending on kernel config also does another
>> TLBI. Avoid the later on tlb_finish_mmu().
> 
> That is already avoided, if you look at tlb_flush_mmu_tlbonly() it does
> __tlb_range_reset(), which results in ->end = 0, which then triggers the
> early exit on the next invocation:
> 
> 	if (!tlb->end)
> 		return;
> 

Is that true for tlb->fulmm flush?

-aneesh

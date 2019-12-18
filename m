Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC51C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6F20715
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRFXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:23:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52832 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfLRFXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:23:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI5JZ4U124022;
        Wed, 18 Dec 2019 00:23:03 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wy90nyumd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 00:23:02 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBI5K0Rf139517;
        Wed, 18 Dec 2019 00:23:02 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wy90nyuky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 00:23:02 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBI5CBIU020780;
        Wed, 18 Dec 2019 05:23:01 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 2wvqc6uau9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 05:23:00 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBI5Mxoj65536450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 05:22:59 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD74136055;
        Wed, 18 Dec 2019 05:22:59 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B021D13604F;
        Wed, 18 Dec 2019 05:22:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.35.117])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 05:22:56 +0000 (GMT)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] mm/mmu_gather: Invalidate TLB correctly on batch allocation failure and flush
In-Reply-To: <20191217123544.GI2827@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com> <20191217090914.GX2844@hirez.programming.kicks-ass.net> <3d250b04-a78d-20a7-d41e-50e48e08d1cb@linux.ibm.com> <20191217123544.GI2827@hirez.programming.kicks-ass.net>
Date:   Wed, 18 Dec 2019 10:52:53 +0530
Message-ID: <874kxymclu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=2
 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912180041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Dec 17, 2019 at 04:18:40PM +0530, Aneesh Kumar K.V wrote:
>> On 12/17/19 2:39 PM, Peter Zijlstra wrote:
>> > On Tue, Dec 17, 2019 at 12:47:12PM +0530, Aneesh Kumar K.V wrote:
>> > > Architectures for which we have hardware walkers of Linux page table should
>> > > flush TLB on mmu gather batch allocation failures and batch flush. Some
>> > > architectures like POWER supports multiple translation modes (hash and radix)
>> > > and in the case of POWER only radix translation mode needs the above TLBI.
>> > > This is because for hash translation mode kernel wants to avoid this extra
>> > > flush since there are no hardware walkers of linux page table. With radix
>> > > translation, the hardware also walks linux page table and with that, kernel
>> > > needs to make sure to TLB invalidate page walk cache before page table pages are
>> > > freed.
>> > 
>> > > Based on changes from Peter Zijlstra <peterz@infradead.org>
>> > 
>> > AFAICT it is all my patch ;-)
>> 
>> Yes. I moved the changes you had to upstream. I can update the From: in the
>> next version if you are ok with that?
>
> Well, since PPC isn't broken per finding the invalidate in
> __p*_free_tlb(), lets do these things on top of the patches I proposed
> here. Also, you mnight want to run benchmarks to see if the movement of
> that TLBI actually helps (I'm thinking the cost of the PTESYNC might add
> up).

Upstream ppc64 is broken after the commit: a46cc7a90fd8
("powerpc/mm/radix: Improve TLB/PWC flushes").

Also the patches are not adding any extra TLBI on either radix or hash.

Considering we need to backport this to stable and other distributions,
how about we do this early patches in your series before the Kconfig rename?
This should enable stable to pick them up with less dependencies. 

-aneesh

Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C03C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F93A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfHVGoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:44:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfHVGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:44:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M6fpMr025271
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:44:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhmdfb4uw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:44:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 22 Aug 2019 07:44:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 07:44:10 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7M6i99W54853656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 06:44:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5D114C050;
        Thu, 22 Aug 2019 06:44:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C73384C044;
        Thu, 22 Aug 2019 06:44:08 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Aug 2019 06:44:08 +0000 (GMT)
Date:   Thu, 22 Aug 2019 09:44:07 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chester Lin <clin@suse.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Gary Lin <GLin@suse.com>, Joey Lee <JLee@suse.com>
Subject: Re: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
References: <20190822034425.25899-1-clin@suse.com>
 <20190822035920.GA27154@linux-8mug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822035920.GA27154@linux-8mug>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082206-4275-0000-0000-0000035BC212
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082206-4276-0000-0000-0000386DE709
Message-Id: <20190822064406.GC18872@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:59:42AM +0000, Chester Lin wrote:
> On Thu, Aug 22, 2019 at 11:45:34AM +0800, Chester Lin wrote:
> > adjust_lowmem_bounds() checks every memblocks in order to find the boundary
> > between lowmem and highmem. However some memblocks could be marked as NOMAP
> > so they are not used by kernel, which should be skipped while calculating
> > the boundary.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  arch/arm/mm/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 426d9085396b..b86dba44d828 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1181,6 +1181,9 @@ void __init adjust_lowmem_bounds(void)
> >  		phys_addr_t block_start = reg->base;
> >  		phys_addr_t block_end = reg->base + reg->size;
> >  
> > +		if (memblock_is_nomap(reg))
> > +			continue;
> > +
> >  		if (reg->base < vmalloc_limit) {
> >  			if (block_end > lowmem_limit)
> >  				/*
> > -- 
> > 2.22.0
> >
> 
> Hi Russell, Mike and Ard,
> 
> Per the discussion in the thread "[PATH] efi/arm: fix allocation failure ...",
> (https://lkml.org/lkml/2019/8/21/163), I presume that the change to disregard
> NOMAP memblocks in adjust_lowmem_bounds() should be separated as a single patch.
> 
> Please let me know if any suggestion, thank you.

Let's add this one to the series: 

From 06a986e79d60c310c804b3e550bd50316597aec5 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 22 Aug 2019 09:27:40 +0300
Subject: [PATCH] arm: ensure that usable memory in bank 0 starts from a
 PMD-aligned address

The calculation of memblock_limit in adjust_lowmem_bounds() assumes that
bank 0 starts from a PMD-aligned address. However, the beginning of the
first bank may be NOMAP memory and the start of usable memory
will be not aligned to PMD boundary. In such case the memblock_limit will
be set to the end of the NOMAP region, which will prevent any memblock
allocations.

Mark the region between the end of the NOMAP area and the next PMD-aligned
address as NOMAP as well, so that the usable memory will start at
PMD-aligned address.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4495a26..25da9b2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1177,6 +1177,22 @@ void __init adjust_lowmem_bounds(void)
 	 */
 	vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
 
+	/*
+	 * The first usable region must be PMD aligned. Mark its start
+	 * as MEMBLOCK_NOMAP if it isn't
+	 */
+	for_each_memblock(memory, reg) {
+		if (!memblock_is_nomap(reg)) {
+			if (!IS_ALIGNED(reg->base, PMD_SIZE)) {
+				phys_addr_t len;
+
+				len = round_up(reg->base, PMD_SIZE) - reg->base;
+				memblock_mark_nomap(reg->base, len);
+			}
+			break;
+		}
+	}
+
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
-- 
2.7.4


-- 
Sincerely yours,
Mike.


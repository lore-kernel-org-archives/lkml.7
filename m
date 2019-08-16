Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F84BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38872173B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfHPBpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:45:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbfHPBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:45:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G1gKGh031448
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 21:45:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udfac79eu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 21:45:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 16 Aug 2019 02:45:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 02:45:45 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G1jiem52625546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 01:45:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F95042041;
        Fri, 16 Aug 2019 01:45:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED31342042;
        Fri, 16 Aug 2019 01:45:43 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 01:45:43 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C7F43A01EB;
        Fri, 16 Aug 2019 11:45:42 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Aug 2019 11:45:42 +1000
In-Reply-To: <366f94bd-c61b-d454-b202-d3feb81a14c3@c-s.fr>
References: <20190815041057.13627-1-alastair@au1.ibm.com>
         <20190815041057.13627-5-alastair@au1.ibm.com>
         <366f94bd-c61b-d454-b202-d3feb81a14c3@c-s.fr>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081601-0028-0000-0000-0000039037CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081601-0029-0000-0000-000024524FF1
Message-Id: <9fa2526f6ba1cecffb85b1fa5199f7a616e5fa91.camel@au1.ibm.com>
Subject: RE: [PATCH 4/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 09:36 +0200, christophe leroy wrote:
> 
> Le 15/08/2019 à 06:10, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > When presented with large amounts of memory being hotplugged
> > (in my test case, ~890GB), the call to flush_dcache_range takes
> > a while (~50 seconds), triggering RCU stalls.
> > 
> > This patch breaks up the call into 16GB chunks, calling
> > cond_resched() inbetween to allow the scheduler to run.
> 
> Is 16GB small enough ? If 890GB takes 50s, 16GB still takes about 1s.
> I'd use 1GB chuncks to remain below 100ms.
> 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/mm/mem.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > index 5400da87a804..fb0d5e9aa11b 100644
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned
> > long start, unsigned long end)
> >   	return -ENODEV;
> >   }
> >   
> > +#define FLUSH_CHUNK_SIZE (16ull * 1024ull * 1024ull * 1024ull)
> 
> Can we use SZ_16GB ?
Sure, I'll go with 1GB as you recommended above

> > +
> >   int __ref arch_add_memory(int nid, u64 start, u64 size,
> >   			struct mhp_restrictions *restrictions)
> >   {
> >   	unsigned long start_pfn = start >> PAGE_SHIFT;
> >   	unsigned long nr_pages = size >> PAGE_SHIFT;
> > +	unsigned long i;
> >   	int rc;
> >   
> >   	resize_hpt_for_hotplug(memblock_phys_mem_size());
> > @@ -120,7 +123,11 @@ int __ref arch_add_memory(int nid, u64 start,
> > u64 size,
> >   			start, start + size, rc);
> >   		return -EFAULT;
> >   	}
> > -	flush_dcache_range(start, start + size);
> > +
> > +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> > +		flush_dcache_range(start + i, min(start + size, start +
> > i + FLUSH_CHUNK_SIZE));
> 
> Isn't the line a bit long (I have not checked).
> 
> > +		cond_resched();
> > +	}
> >   
> >   	return __add_pages(nid, start_pfn, nr_pages, restrictions);
> >   }
> > @@ -131,13 +138,18 @@ void __ref arch_remove_memory(int nid, u64
> > start, u64 size,
> >   	unsigned long start_pfn = start >> PAGE_SHIFT;
> >   	unsigned long nr_pages = size >> PAGE_SHIFT;
> >   	struct page *page = pfn_to_page(start_pfn) +
> > vmem_altmap_offset(altmap);
> > +	unsigned long i;
> >   	int ret;
> >   
> >   	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
> >   
> >   	/* Remove htab bolted mappings for this section of memory */
> >   	start = (unsigned long)__va(start);
> > -	flush_dcache_range(start, start + size);
> > +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> > +		flush_dcache_range(start + i, min(start + size, start +
> > i + FLUSH_CHUNK_SIZE));
> > +		cond_resched();
> > +	}
> > +
> >   	ret = remove_section_mapping(start, start + size);
> >   	WARN_ON_ONCE(ret);
> >   
> > 
> 
> Christophe
> 
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par
> le logiciel antivirus Avast.
> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.avast.com_antivirus&d=DwIDaQ&c=jf_iaSHvJObTbx-siA1ZOg&r=cT4tgeEQ0Ll3SIlZDHE5AEXyKy6uKADMtf9_Eb7-vec&m=TBT2NNM2DXqDWHhSb_WdFPcfAjYk9hP2cvGksF001cQ&s=XURKAOQQ4h3_RhJlezSguD2kpSitAF-uBhQqVZLU4GU&e= 
> 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819


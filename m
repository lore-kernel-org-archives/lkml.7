Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B4B2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgAIIpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:45:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728574AbgAIIpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:45:24 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0098gOcW122127
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 03:45:22 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe00w9ujf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:45:22 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 9 Jan 2020 08:45:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 08:45:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0098jGQ647644814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 08:45:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B38CAE055;
        Thu,  9 Jan 2020 08:45:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90F07AE05A;
        Thu,  9 Jan 2020 08:45:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Jan 2020 08:45:15 +0000 (GMT)
Date:   Thu, 9 Jan 2020 10:45:13 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meelis Roos <mroos@linux.ee>, Jeroen Roovers <jer@gentoo.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] parisc: fix map_pages() to actually populate upper
 directory
References: <20200108125852.19823-1-rppt@kernel.org>
 <20200109065055.GA13038@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109065055.GA13038@ls3530.fritz.box>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 20010908-4275-0000-0000-00000396092D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010908-4276-0000-0000-000038A9F851
Message-Id: <20200109084513.GA11067@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 09, 2020 at 07:50:55AM +0100, Helge Deller wrote:
> > The commit d96885e277b5 ("parisc: use pgtable-nopXd instead of
> > 4level-fixup") converted PA-RISC to use folded page tables, but it missed
> > the conversion of pgd_populate() to pud_populate() in maps_pages()
> > function. This caused the upper page table directory to remain empty and
> > the system would crash as a result.
> >
> > Using pud_populate() that actually populates the page table instead of
> > dummy pgd_populate() fixes the issue.
> > ...
> > diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> > index ddca8287d43b..354cf060b67f 100644
> > --- a/arch/parisc/mm/init.c
> > +++ b/arch/parisc/mm/init.c
> > @@ -401,7 +401,7 @@ static void __init map_pages(unsigned long start_vaddr,
> >  			pmd = (pmd_t *) __pa(pmd);
> >  		}
> >
> > -		pgd_populate(NULL, pg_dir, __va(pmd));
> > +		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
> >  #endif
> 
> Wouldn't the untested patch below be more clean?
> 
> Helge
> 
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index ddca8287d43b..73de58f31f5f 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -387,6 +387,8 @@ static void __init map_pages(unsigned long start_vaddr,
>  #if PTRS_PER_PMD == 1
>  		pmd = (pmd_t *)__pa(pg_dir);
>  #else
> +		p4d_t *p4d;
> +		pud_t *pud;
>  		pmd = (pmd_t *)pgd_address(*pg_dir);
> 
>  		/*
> @@ -401,7 +403,9 @@ static void __init map_pages(unsigned long start_vaddr,
>  			pmd = (pmd_t *) __pa(pmd);
>  		}
> 
> -		pgd_populate(NULL, pg_dir, __va(pmd));
> +		p4d = p4d_offset(pg_dir, vaddr);
> +		pud = pud_offset(p4d, vaddr);
> +		pud_populate(NULL, pud, __va(pmd));
>  #endif
>  		pg_dir++;

I've tried to keep the changes to minimum :)
Otherwise I'd go with something even more surgical:

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 354cf060b67f..94baa4382c29 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -351,7 +351,6 @@ static void __init map_pages(unsigned long start_vaddr,
 			     unsigned long start_paddr, unsigned long size,
 			     pgprot_t pgprot, int force)
 {
-	pgd_t *pg_dir;
 	pmd_t *pmd;
 	pte_t *pg_table;
 	unsigned long end_paddr;
@@ -372,8 +371,6 @@ static void __init map_pages(unsigned long start_vaddr,
 
 	end_paddr = start_paddr + size;
 
-	pg_dir = pgd_offset_k(start_vaddr);
-
 #if PTRS_PER_PMD == 1
 	start_pmd = 0;
 #else
@@ -384,50 +381,30 @@ static void __init map_pages(unsigned long start_vaddr,
 	address = start_paddr;
 	vaddr = start_vaddr;
 	while (address < end_paddr) {
-#if PTRS_PER_PMD == 1
-		pmd = (pmd_t *)__pa(pg_dir);
-#else
-		pmd = (pmd_t *)pgd_address(*pg_dir);
+		pgd_t *pgd = pgd_offset_k(vaddr);
+		p4d_t *p4d = p4d_offset(pgd, vaddr);
+		pud_t *pud = pud_offset(p4d, vaddr);
 
-		/*
-		 * pmd is physical at this point
-		 */
-
-		if (!pmd) {
+#if CONFIG_PGTABLE_LEVELS == 3
+		if (pud_none(*pud)) {
 			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
 					     PAGE_SIZE << PMD_ORDER);
 			if (!pmd)
 				panic("pmd allocation failed.\n");
-			pmd = (pmd_t *) __pa(pmd);
+			pud_populate(NULL, pud, pmd);
 		}
-
-		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
 #endif
-		pg_dir++;
 
-		/* now change pmd to kernel virtual addresses */
-
-		pmd = (pmd_t *)__va(pmd) + start_pmd;
+		pmd = pmd_offset(pud, vaddr);
 		for (tmp1 = start_pmd; tmp1 < PTRS_PER_PMD; tmp1++, pmd++) {
-
-			/*
-			 * pg_table is physical at this point
-			 */
-
-			pg_table = (pte_t *)pmd_address(*pmd);
-			if (!pg_table) {
-				pg_table = memblock_alloc(PAGE_SIZE,
-							  PAGE_SIZE);
+			if (pmd_none(*pmd)) {
+				pg_table = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 				if (!pg_table)
 					panic("page table allocation failed\n");
-				pg_table = (pte_t *) __pa(pg_table);
+				pmd_populate_kernel(NULL, pmd, pg_table);
 			}
 
-			pmd_populate_kernel(NULL, pmd, __va(pg_table));
-
-			/* now change pg_table to kernel virtual addresses */
-
-			pg_table = (pte_t *) __va(pg_table) + start_pte;
+			pg_table = pte_offset_kernel(pmd, vaddr);
 			for (tmp2 = start_pte; tmp2 < PTRS_PER_PTE; tmp2++, pg_table++) {
 				pte_t pte;
 				pgprot_t prot;
 

-- 
Sincerely yours,
Mike.


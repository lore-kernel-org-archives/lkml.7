Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B32220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCFOGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:06:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726800AbfCFOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:06:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26E0x8d122316
        for <linux-kernel@vger.kernel.org>; Wed, 6 Mar 2019 09:05:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r2dkxqk9u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:05:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Mar 2019 14:05:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Mar 2019 14:05:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x26E5hx116777316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 14:05:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBE911C04C;
        Wed,  6 Mar 2019 14:05:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC5A111C04A;
        Wed,  6 Mar 2019 14:05:41 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Mar 2019 14:05:41 +0000 (GMT)
Date:   Wed, 6 Mar 2019 16:05:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
References: <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
 <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com>
 <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030614-0008-0000-0000-000002C945FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030614-0009-0000-0000-00002235507C
Message-Id: <20190306140529.GG3549@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:14:47AM +0000, Guillaume Tucker wrote:
> On 01/03/2019 23:23, Dan Williams wrote:
> > On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> > 
> > Is there an early-printk facility that can be turned on to see how far
> > we get in the boot?
> 
> Yes, I've done that now by enabling CONFIG_DEBUG_AM33XXUART1 and
> earlyprintk in the command line.  Here's the result, with the
> commit cherry picked on top of next-20190304:
> 
>   https://lava.collabora.co.uk/scheduler/job/1526326
> 
> [    1.379522] ti-sysc 4804a000.target-module: sysc_flags 00000222 != 00000022
> [    1.396718] Unable to handle kernel paging request at virtual address 77bb4003
> [    1.404203] pgd = (ptrval)
> [    1.406971] [77bb4003] *pgd=00000000
> [    1.410650] Internal error: Oops: 5 [#1] ARM
> [...]
> [    1.672310] [<c07051a0>] (clk_hw_create_clk.part.21) from [<c06fea34>] (devm_clk_get+0x4c/0x80)
> [    1.681232] [<c06fea34>] (devm_clk_get) from [<c064253c>] (sysc_probe+0x28c/0xde4)
> 
> It's always failing at that point in the code.  Also when
> enabling "debug" on the kernel command line, the issue goes
> away (exact same binaries etc..):
> 
>   https://lava.collabora.co.uk/scheduler/job/1526327
> 
> For the record, here's the branch I've been using:
> 
>   https://gitlab.collabora.com/gtucker/linux/tree/beaglebone-black-next-20190304-debug
> 
> The board otherwise boots fine with next-20190304 (SMP=n), and
> also with the patch applied but the shuffle configs set to n.
> 
> > Were there any boot *successes* on ARM with shuffling enabled? I.e.
> > clues about what's different about the specific memory setup for
> > beagle-bone-black.
> 
> Looking at the KernelCI results from next-20190215, it looks like
> only the BeagleBone Black with SMP=n failed to boot:
> 
>   https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20190215/
> 
> Of course that's not all the ARM boards that exist out there, but
> it's a fairly large coverage already.
> 
> As the kernel panic always seems to originate in ti-sysc.c,
> there's a chance it's only visible on that platform...  I'm doing
> a KernelCI run now with my test branch to double check that,
> it'll take a few hours so I'll send an update later if I get
> anything useful out of it.
> 
> In the meantime, I'm happy to try out other things with more
> debug configs turned on or any potential fixes someone might
> have.

ARM is the only arch that sets ARCH_HAS_HOLES_MEMORYMODEL to 'y'. Maybe the
failure has something to do with it...

Guillaume, can you try this patch:

diff --git a/mm/shuffle.c b/mm/shuffle.c
index 3ce1248..4a04aac 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -58,7 +58,8 @@ module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
  * For two pages to be swapped in the shuffle, they must be free (on a
  * 'free_area' lru), have the same order, and have the same migratetype.
  */
-static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order)
+static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order,
+						  struct zone *z)
 {
 	struct page *page;
 
@@ -80,6 +81,9 @@ static struct page * __meminit shuffle_valid_page(unsigned long pfn, int order)
 	if (!PageBuddy(page))
 		return NULL;
 
+	if (!memmap_valid_within(pfn, page, z))
+		return NULL;
+
 	/*
 	 * ...is the page on the same list as the page we will
 	 * shuffle it with?
@@ -123,7 +127,7 @@ void __meminit __shuffle_zone(struct zone *z)
 		 * page_j randomly selected in the span @zone_start_pfn to
 		 * @spanned_pages.
 		 */
-		page_i = shuffle_valid_page(i, order);
+		page_i = shuffle_valid_page(i, order, z);
 		if (!page_i)
 			continue;
 
@@ -137,7 +141,7 @@ void __meminit __shuffle_zone(struct zone *z)
 			j = z->zone_start_pfn +
 				ALIGN_DOWN(get_random_long() % z->spanned_pages,
 						order_pages);
-			page_j = shuffle_valid_page(j, order);
+			page_j = shuffle_valid_page(j, order, z);
 			if (page_j && page_j != page_i)
 				break;
 		}
 

-- 
Sincerely yours,
Mike.


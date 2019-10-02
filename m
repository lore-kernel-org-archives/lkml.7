Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD9C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F92D215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfJBX2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:28:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfJBX2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:28:02 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92NRZpX030203
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 19:28:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vd1gxx0uu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 19:28:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 3 Oct 2019 00:27:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 00:27:55 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x92NRs1U52756704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 23:27:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5623DA4051;
        Wed,  2 Oct 2019 23:27:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B399FA404D;
        Wed,  2 Oct 2019 23:27:53 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Oct 2019 23:27:53 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 94120A0193;
        Thu,  3 Oct 2019 09:27:51 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Oct 2019 09:27:53 +1000
In-Reply-To: <20191002151416.42bc2e8228fdefc6eb802abc@linux-foundation.org>
References: <20191001004617.7536-1-alastair@au1.ibm.com>
         <20191001004617.7536-2-alastair@au1.ibm.com>
         <01def17b-1df8-a63a-4cfc-91e99614a2f0@redhat.com>
         <20191002151416.42bc2e8228fdefc6eb802abc@linux-foundation.org>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100223-0008-0000-0000-0000031D780B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100223-0009-0000-0000-00004A3C7D2C
Message-Id: <bd5ec80607a18ac225e494c7279fcb731790f902.camel@au1.ibm.com>
Subject: RE: [PATCH v7 1/1] memory_hotplug: Add a bounds check to __add_pages
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-02 at 15:14 -0700, Andrew Morton wrote:
> On Tue, 1 Oct 2019 11:49:47 +0200 David Hildenbrand <david@redhat.com
> > wrote:
> 
> > > @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn,
> > > unsigned long nr_pages,
> > >  	return 0;
> > >  }
> > >  
> > > +static int check_hotplug_memory_addressable(unsigned long pfn,
> > > +					    unsigned long nr_pages)
> > > +{
> > > +	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> > > +
> > > +	if (max_addr >> MAX_PHYSMEM_BITS) {
> > > +		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS +
> > > 1)) - 1;
> > > +		WARN(1,
> > > +		     "Hotplugged memory exceeds maximum addressable
> > > address, range=%#llx-%#llx, maximum=%#llx\n",
> > > +		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
> > > +		return -E2BIG;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * Reasonably generic function for adding memory.  It is
> > >   * expected that archs that support memory hotplug will
> > > @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long
> > > pfn, unsigned long nr_pages,
> > >  	unsigned long nr, start_sec, end_sec;
> > >  	struct vmem_altmap *altmap = restrictions->altmap;
> > >  
> > > +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	if (altmap) {
> > >  		/*
> > >  		 * Validate altmap is within bounds of the total
> > > request
> > > 
> > 
> > I actually wanted to give my RB to v7, not v6 :)
> > 
> 
> Given that check_hotplug_memory_addressable() is now static, I'll
> assume that the old [2/2]
> mm-add-a-bounds-check-in-devm_memremap_pages.patch is now obsolete.
> 

Yes, please ignore that whole series.

> From: Alastair D'Silva <alastair@d-silva.org>
> Subject: mm/memremap.c: add a bounds check in devm_memremap_pages()
> 
> The call to check_hotplug_memory_addressable() validates that the
> memory
> is fully addressable.
> 
> Without this call, it is possible that we may remap pages that is not
> physically addressable, resulting in bogus section numbers being
> returned
> from __section_nr().
> 
> Link: 
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20190917010752.28395-2D3-2Dalastair-40au1.ibm.com&d=DwICAg&c=jf_iaSHvJObTbx-siA1ZOg&r=cT4tgeEQ0Ll3SIlZDHE5AEXyKy6uKADMtf9_Eb7-vec&m=pVid6q3tQNfU2PQborLw8oYmNm9naF133dZ8AJ5lW9A&s=51ZuQa-kwRu8vW9vt5OgxjaIMWm4_n-aqp5xMSdkI4k&e=
>  
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/memremap.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/mm/memremap.c~mm-add-a-bounds-check-in-devm_memremap_pages
> +++ a/mm/memremap.c
> @@ -185,6 +185,11 @@ void *memremap_pages(struct dev_pagemap
>  	int error, is_ram;
>  	bool need_devmap_managed = true;
>  
> +	error = check_hotplug_memory_addressable(res->start,
> +						 resource_size(res));
> +	if (error)
> +		return ERR_PTR(error);
> +
>  	switch (pgmap->type) {
>  	case MEMORY_DEVICE_PRIVATE:
>  		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
> _
> 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819


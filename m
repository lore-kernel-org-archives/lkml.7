Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21849C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51C220872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfI0GeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:34:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22078 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbfI0GeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:34:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8R6WCpO150520
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:34:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w26ngfu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:34:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 27 Sep 2019 07:34:02 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 07:33:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8R6XvJm41615862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 06:33:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26BBDAE057;
        Fri, 27 Sep 2019 06:33:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82FC9AE055;
        Fri, 27 Sep 2019 06:33:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 06:33:56 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 839C5A00F9;
        Fri, 27 Sep 2019 16:33:54 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Sep 2019 16:33:54 +1000
In-Reply-To: <10237d54-f182-be5d-1b83-3d0780d71671@redhat.com>
References: <20190926013406.16133-1-alastair@au1.ibm.com>
         <20190926013406.16133-2-alastair@au1.ibm.com>
         <8e00cf16-76b9-6655-86b6-288b454d6fe5@redhat.com>
         <20190926074312.GD20255@dhcp22.suse.cz>
         <10237d54-f182-be5d-1b83-3d0780d71671@redhat.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092706-0008-0000-0000-0000031B8EA0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092706-0009-0000-0000-00004A3A2C77
Message-Id: <d657209bee931c30c0da3889a17495043d805e9c.camel@au1.ibm.com>
Subject: RE: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 09:46 +0200, David Hildenbrand wrote:
> On 26.09.19 09:43, Michal Hocko wrote:
> > On Thu 26-09-19 09:12:50, David Hildenbrand wrote:
> > > On 26.09.19 03:34, Alastair D'Silva wrote:
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > 
> > > > On PowerPC, the address ranges allocated to OpenCAPI LPC memory
> > > > are allocated from firmware. These address ranges may be higher
> > > > than what older kernels permit, as we increased the maximum
> > > > permissable address in commit 4ffe713b7587
> > > > ("powerpc/mm: Increase the max addressable memory to 2PB"). It
> > > > is
> > > > possible that the addressable range may change again in the
> > > > future.
> > > > 
> > > > In this scenario, we end up with a bogus section returned from
> > > > __section_nr (see the discussion on the thread "mm: Trigger bug
> > > > on
> > > > if a section is not found in __section_nr").
> > > > 
> > > > Adding a check here means that we fail early and have an
> > > > opportunity to handle the error gracefully, rather than
> > > > rumbling
> > > > on and potentially accessing an incorrect section.
> > > > 
> > > > Further discussion is also on the thread ("powerpc: Perform a
> > > > bounds
> > > > check in arch_add_memory")
> > > > https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20190827052047.31547-2D1-2Dalastair-40au1.ibm.com&d=DwICaQ&c=jf_iaSHvJObTbx-siA1ZOg&r=cT4tgeEQ0Ll3SIlZDHE5AEXyKy6uKADMtf9_Eb7-vec&m=p9ZS4kSnvF0zq81jcCFd2nYj1zfTMvfbApCtmKI2KNA&s=yif-duzz_RESW3LUyU_0kkmefRAnKWjjn_p5Et-9B2g&e= 
> > > > 
> > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > ---
> > > >  mm/memory_hotplug.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > > index c73f09913165..212804c0f7f5 100644
> > > > --- a/mm/memory_hotplug.c
> > > > +++ b/mm/memory_hotplug.c
> > > > @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long
> > > > pfn, unsigned long nr_pages,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int check_hotplug_memory_addressable(unsigned long pfn,
> > > > +					    unsigned long
> > > > nr_pages)
> > > > +{
> > > > +	unsigned long max_addr = ((pfn + nr_pages) <<
> > > > PAGE_SHIFT) - 1;
> > > > +
> > > > +	if (max_addr >> MAX_PHYSMEM_BITS) {
> > > > +		WARN(1,
> > > > +		     "Hotplugged memory exceeds maximum
> > > > addressable address, range=%#lx-%#lx, maximum=%#lx\n",
> > > > +		     pfn << PAGE_SHIFT, max_addr,
> > > > +		     (1ul << (MAX_PHYSMEM_BITS + 1)) - 1);
> > > > +		return -E2BIG;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Reasonably generic function for adding memory.  It is
> > > >   * expected that archs that support memory hotplug will
> > > > @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned
> > > > long pfn, unsigned long nr_pages,
> > > >  	unsigned long nr, start_sec, end_sec;
> > > >  	struct vmem_altmap *altmap = restrictions->altmap;
> > > >  
> > > > +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > >  	if (altmap) {
> > > >  		/*
> > > >  		 * Validate altmap is within bounds of the
> > > > total request
> > > > 
> > > 
> > > I know Michal suggested this, but I still prefer checking early
> > > instead
> > > of when we're knees-deep into adding of memory.
> > 
> > What is your concern here? Unwinding the state should be pretty
> > straightfoward from this failure path.
> 
> Just the general "check what you can check early without locks"
> approach. But yeah, this series is probably not worth a v5, so I can
> live with this change just fine :)
> 
> 

I'm going to spin a V5 anyway - where were you suggesting?

> -- 
> 
> Thanks,
> 
> David / dhildenb

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819


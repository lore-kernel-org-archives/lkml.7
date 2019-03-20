Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F9D218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCTKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfCTKNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDF302D7E0;
        Wed, 20 Mar 2019 10:13:21 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 243D35D71C;
        Wed, 20 Mar 2019 10:13:20 +0000 (UTC)
Date:   Wed, 20 Mar 2019 18:13:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190320101318.GP18740@MiWiFi-R3L-srv>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320073540.12866-2-bhe@redhat.com>
 <20190320075649.GC13626@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320075649.GC13626@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 10:13:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 03/20/19 at 09:56am, Mike Rapoport wrote:
 > @@ -697,16 +697,17 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  	ret = sparse_index_init(section_nr, nid);
> >  	if (ret < 0 && ret != -EEXIST)
> >  		return ret;
> > -	ret = 0;
> > -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > -	if (!memmap)
> > -		return -ENOMEM;
> > +
> >  	usemap = __kmalloc_section_usemap();
> > -	if (!usemap) {
> > -		__kfree_section_memmap(memmap, altmap);
> > +	if (!usemap)
> > +		return -ENOMEM;
> > +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > +	if (!memmap) {
> > +		kfree(usemap);
> 
> If you are anyway changing this why not to switch to goto's for error
> handling?

I update code change as below, could you check if it's OK to you?

Thanks
Baoquan

From 39b679b6f34f6acbc05351be8569d23bae3c0458 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 15 Mar 2019 16:03:52 +0800
Subject: [PATCH] mm/sparse: Optimize sparse_add_one_section()

Reorder the allocation of usemap and memmap since usemap allocation
is much smaller and simpler. Otherwise hard work is done to make
memmap ready, then have to rollback just because of usemap allocation
failure.

Meanwhile update the error handler to cover usemap allocation failure
too.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index a99e0b253927..0e842b924be6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -699,20 +699,21 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	ret = sparse_index_init(section_nr, nid);
 	if (ret < 0 && ret != -EEXIST)
 		return ret;
-	ret = 0;
-	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
-	if (!memmap)
-		return -ENOMEM;
+
 	usemap = __kmalloc_section_usemap();
-	if (!usemap) {
-		__kfree_section_memmap(memmap, altmap);
+	if (!usemap)
 		return -ENOMEM;
+	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
+	if (!memmap) {
+		ret = -ENOMEM;
+		goto out2;
 	}
 
+	ret = 0;
 	ms = __pfn_to_section(start_pfn);
 	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
 		ret = -EEXIST;
-		goto out;
+		goto out2;
 	}
 
 	/*
@@ -724,11 +725,11 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	section_mark_present(ms);
 	sparse_init_one_section(ms, section_nr, memmap, usemap);
 
+	return ret;
 out:
-	if (ret < 0) {
-		kfree(usemap);
-		__kfree_section_memmap(memmap, altmap);
-	}
+	__kfree_section_memmap(memmap, altmap);
+out2:
+	kfree(usemap);
 	return ret;
 }
 
-- 
2.17.2


Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49445C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2394D2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560538840;
	bh=9luYIMc1miTz2FraniCesV9+ZaFoX/edSHhy+mT9JIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pdKStL9tfnEAbXAJqcP8nmSBJqj4RnAUyzZGlQCioaOtRa//OyQ35+lxnvUdLQwfl
	 pCh5RdaVRACbvXEX1G54+jig8/CyVs92OX4VP8+eLkfKamgUdEyOF/tB33Tr6DVdR2
	 2i0SdYMMaS3lHK9bho+LPlvnpcDNpZxdlua/1Yfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfFNTAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNTAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:00:38 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09DD21473;
        Fri, 14 Jun 2019 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560538837;
        bh=9luYIMc1miTz2FraniCesV9+ZaFoX/edSHhy+mT9JIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vyoR8waOE1q5W/EKmFkQ9Obg/5StU3mMk8E+LGCQxdywY0BsyK2eX1sdrt42y9dRV
         wYeOCumqHytulVpdq9L/T+kBFZ7QQeib24BW3MLVlfdYP1kco4m9Vt74OTz/3IltiR
         zqJDvkwvBiUrUZcglCfj5SjZmdUbtzRIl2y26arw=
Date:   Fri, 14 Jun 2019 12:00:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1 1/6] mm: Section numbers use the type "unsigned long"
Message-Id: <20190614120036.00ae392e3f210e7bc9ec6960@linux-foundation.org>
In-Reply-To: <20190614100114.311-2-david@redhat.com>
References: <20190614100114.311-1-david@redhat.com>
        <20190614100114.311-2-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 12:01:09 +0200 David Hildenbrand <david@redhat.com> wrote:

> We are using a mixture of "int" and "unsigned long". Let's make this
> consistent by using "unsigned long" everywhere. We'll do the same with
> memory block ids next.
> 
> ...
>
> -	int i, ret, section_count = 0;
> +	unsigned long i;
>
> ...
>
> -	unsigned int i;
> +	unsigned long i;

Maybe I did too much fortran back in the day, but I think the
expectation is that a variable called "i" has type "int".

This?



s/unsigned long i/unsigned long section_nr/

--- a/drivers/base/memory.c~mm-section-numbers-use-the-type-unsigned-long-fix
+++ a/drivers/base/memory.c
@@ -131,17 +131,17 @@ static ssize_t phys_index_show(struct de
 static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	unsigned long i, pfn;
+	unsigned long section_nr, pfn;
 	int ret = 1;
 	struct memory_block *mem = to_memory_block(dev);
 
 	if (mem->state != MEM_ONLINE)
 		goto out;
 
-	for (i = 0; i < sections_per_block; i++) {
-		if (!present_section_nr(mem->start_section_nr + i))
+	for (section_nr = 0; section_nr < sections_per_block; section_nr++) {
+		if (!present_section_nr(mem->start_section_nr + section_nr))
 			continue;
-		pfn = section_nr_to_pfn(mem->start_section_nr + i);
+		pfn = section_nr_to_pfn(mem->start_section_nr + section_nr);
 		ret &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
 	}
 
@@ -695,12 +695,12 @@ static int add_memory_block(unsigned lon
 {
 	int ret, section_count = 0;
 	struct memory_block *mem;
-	unsigned long i;
+	unsigned long section_nr;
 
-	for (i = base_section_nr;
-	     i < base_section_nr + sections_per_block;
-	     i++)
-		if (present_section_nr(i))
+	for (section_nr = base_section_nr;
+	     section_nr < base_section_nr + sections_per_block;
+	     section_nr++)
+		if (present_section_nr(section_nr))
 			section_count++;
 
 	if (section_count == 0)
@@ -823,7 +823,7 @@ static const struct attribute_group *mem
  */
 int __init memory_dev_init(void)
 {
-	unsigned long i;
+	unsigned long section_nr;
 	int ret;
 	int err;
 	unsigned long block_sz;
@@ -840,9 +840,9 @@ int __init memory_dev_init(void)
 	 * during boot and have been initialized
 	 */
 	mutex_lock(&mem_sysfs_mutex);
-	for (i = 0; i <= __highest_present_section_nr;
-		i += sections_per_block) {
-		err = add_memory_block(i);
+	for (section_nr = 0; section_nr <= __highest_present_section_nr;
+		section_nr += sections_per_block) {
+		err = add_memory_block(section_nr);
 		if (!ret)
 			ret = err;
 	}
_


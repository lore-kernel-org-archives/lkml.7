Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD87C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D960621917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553211111;
	bh=Gi1NwFF1jjAP8sT6BNJl7CUEMWuYqs7Ow0+0dfyLChk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=z/GTUFyOd7DskpJ3RAZz4VkKvIE0t8Ht3AUHRGbAAh8g6qviK2cGU6WiJJGMi2Dck
	 C9PHR7xfR3EslkCz8VEywROauXZZu6cma2vsooKRCMZY76t7mw7LIGeXh8KE2R97SC
	 r/L+NhjY4F1vZxp2pEDHFS7F08OAtrhCp9NAXEJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCUXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:31:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCUXbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:31:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA19EF39;
        Thu, 21 Mar 2019 23:31:48 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:31:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm: page_mkclean vs MADV_DONTNEED race
Message-Id: <20190321163147.cc2ff090a7388cdb7030eed0@linux-foundation.org>
In-Reply-To: <20190321040610.14226-1-aneesh.kumar@linux.ibm.com>
References: <20190321040610.14226-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 09:36:10 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> MADV_DONTNEED is handled with mmap_sem taken in read mode.
> We call page_mkclean without holding mmap_sem.
> 
> MADV_DONTNEED implies that pages in the region are unmapped and subsequent
> access to the pages in that range is handled as a new page fault.
> This implies that if we don't have parallel access to the region when
> MADV_DONTNEED is run we expect those range to be unallocated.
> 
> w.r.t page_mkclean we need to make sure that we don't break the MADV_DONTNEED
> semantics. MADV_DONTNEED check for pmd_none without holding pmd_lock.
> This implies we skip the pmd if we temporarily mark pmd none. Avoid doing
> that while marking the page clean.
> 
> Keep the sequence same for dax too even though we don't support MADV_DONTNEED
> for dax mapping

What were the runtime effects of the bug?

Did you consider a -stable backport?

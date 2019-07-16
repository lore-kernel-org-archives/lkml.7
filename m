Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB8EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241FB21743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563314451;
	bh=MZiI+dn9mTuyzIwRcV9Xmn9Ls3mvI60j/scPusuitoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MApn9CRkVYZdw90l2mwXHZF/QtbkEWCoyF7aaZFyQqyIDw4kMnzmMeWDqiRGKXrje
	 zRHc/+NDbK2sB9KCmg730mKt/gg9N6TxkhXkUZQwOk2mx9xZUkX7kvk2YHlzVQwBMK
	 VKnluz7IA6G+7gn65S5AH/uacPpZ1u5MoAl0ldxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfGPWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbfGPWAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:00:49 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459DC217D9;
        Tue, 16 Jul 2019 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563314448;
        bh=MZiI+dn9mTuyzIwRcV9Xmn9Ls3mvI60j/scPusuitoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSWiZuBkMQon8Lef5PmzojoSZZ9fRe2jegeNSZnEenhkD8cdTCQlE6EJpSJoBqgjy
         wUCAz9PwWcsuoV7ZdQqEhoN9Mox91kVFBCk9L9u6wGxpu+qMlGIrkxCGHu/x3UMAnl
         J8ebYbD6PKGFHh6l70c9iZEJlyazzO5W9LuTVRLw=
Date:   Tue, 16 Jul 2019 15:00:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
Message-Id: <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
In-Reply-To: <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
        <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
        <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
        <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
        <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 21:56:43 +0000 Nadav Amit <namit@vmware.com> wrote:

> > ...and is constant for the life of the device and all subsequent mappings.
> > 
> >> Perhaps you want to cache the cachability-mode in vma->vm_page_prot (which I
> >> see being done in quite a few cases), but I don’t know the code well enough
> >> to be certain that every vma should have a single protection and that it
> >> should not change afterwards.
> > 
> > No, I'm thinking this would naturally fit as a property hanging off a
> > 'struct dax_device', and then create a version of vmf_insert_mixed()
> > and vmf_insert_pfn_pmd() that bypass track_pfn_insert() to insert that
> > saved value.
> 
> Thanks for the detailed explanation. I’ll give it a try (the moment I find
> some free time). I still think that patch 2/3 is beneficial, but based on
> your feedback, patch 3/3 should be dropped.

It has been a while.  What should we do with

resource-fix-locking-in-find_next_iomem_res.patch
resource-avoid-unnecessary-lookups-in-find_next_iomem_res.patch

?

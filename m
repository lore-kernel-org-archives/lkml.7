Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5130520882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554300361;
	bh=kt9EpWriMgDfPUuGdrcmXBkBttVsLYPPV13t5vDyPJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v5Mtejo0aqMJ4h9p/l+EGvGvX/HrJWW2cWeoLPrmR46WpWZkNUteYVxaq0VmRQuZT
	 jbUGqVxVj82QyUleqIs+nXZdWldbnGQOQ7am2az1OT3/hRG91fm0L0FcjnaipIfAo5
	 W4Ge5B++LmocNWSG7RMnkWuSRXU2P0vH0dNXLST4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCOF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:05:59 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA612075E;
        Wed,  3 Apr 2019 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554300358;
        bh=kt9EpWriMgDfPUuGdrcmXBkBttVsLYPPV13t5vDyPJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPAvSDwVE9F29TVI8VNL/P6VOwMZjCYoONy6pKtWj7EeTGzDqociN3D0J5aoU1LSa
         g3+5aFWunoRj8yW43svG2Dxst4AtR1HIcyIz9UWSr/IUDGXlTx2O8yNGbQHwb9HSIB
         lts3A2SyWR2/+LtCcL2jKD83OjS4CAdFn40920X4=
Date:   Wed, 3 Apr 2019 16:05:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     sashal@kernel.org, osalvador@suse.de, chrubis@suse.cz,
        kirill@shutemov.name, aquini@redhat.com, rientjes@google.com,
        vbabka@suse.cz, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [4.14-stable PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
Message-ID: <20190403140556.GE8633@kroah.com>
References: <1554160580-5848-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554160580-5848-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 07:16:20AM +0800, Yang Shi wrote:
> commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 upstream
> 
> When MPOL_MF_STRICT was specified and an existing page was already on a
> node that does not follow the policy, mbind() should return -EIO.  But
> commit 6f4576e3687b ("mempolicy: apply page table walker on
> queue_pages_range()") broke the rule.
> 
> And commit c8633798497c ("mm: mempolicy: mbind and migrate_pages support
> thp migration") didn't return the correct value for THP mbind() too.
> 
> If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it
> reaches queue_pages_to_pte_range() or queue_pages_pmd() to check if an
> existing page was already on a node that does not follow the policy.
> And, non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
> MPOL_MF_MOVE_ALL was specified.
> 
> Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
> 
> [akpm@linux-foundation.org: tweak code comment]
> Link: http://lkml.kernel.org/r/1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com
> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Acked-by: Rafael Aquini <aquini@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  mm/mempolicy.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)

All 3 of these now queued up, thanks.

greg k-h

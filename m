Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30331C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280C2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565208632;
	bh=Jx7y/Ln14SESvaQs28ji2Po6nmIukoITtbZFc+CJc+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aoqTfDoZKFpXQdY71N7SonBDW2wbxrllIy4SyXopWKDOI6/VRcKz1KpaR/wEmiH2l
	 ulC86JHsLfhzhMGptegRtRB1K4aT+E/Zn+o6OmgSLLf33CBSTHOsqR1iWErRYbDUA5
	 N0fxVRPnvXtnwwOqtN8IVTQxvnjRC+Xyt2Xj/5Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfHGUKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfHGUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:10:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C1021922;
        Wed,  7 Aug 2019 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565208630;
        bh=Jx7y/Ln14SESvaQs28ji2Po6nmIukoITtbZFc+CJc+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afz14CARnD4KLD2Z5M0+ZTfbOtpHoXYlolGDnDkCNGSkIWv5zbksHxBVq/TE0vpoO
         ATEyB6ZOp/MmuNOpdZ2f3Q5WKgAYPaN2KpyqOCBnvEJrYjfDqmRDcgfShQN1aeYPyC
         6Rbexj2erKrr2x2qb4cEdspf+G4+gdgiWdtMeVJA=
Date:   Wed, 7 Aug 2019 13:10:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: linux-next: Tree for Aug 7 (mm/khugepaged.c)
Message-Id: <20190807131029.f7f191aaeeb88cc435c6306f@linux-foundation.org>
In-Reply-To: <DCC6982B-17EF-4143-8CE8-9D0EC28FA06B@fb.com>
References: <20190807183606.372ca1a4@canb.auug.org.au>
        <c18b2828-cdf3-5248-609f-d89a24f558d1@infradead.org>
        <DCC6982B-17EF-4143-8CE8-9D0EC28FA06B@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019 16:59:14 +0000 Song Liu <songliubraving@fb.com> wrote:

> Hi Randy,
> 
> > On Aug 7, 2019, at 8:11 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > On 8/7/19 1:36 AM, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> Changes since 20190806:
> >> 
> > 
> > on i386:
> > 
> > when CONFIG_SHMEM is not set/enabled:
> > 
> > ../mm/khugepaged.c: In function ‘khugepaged_scan_mm_slot’:
> > ../mm/khugepaged.c:1874:2: error: implicit declaration of function ‘khugepaged_collapse_pte_mapped_thps’; did you mean ‘collapse_pte_mapped_thp’? [-Werror=implicit-function-declaration]
> >  khugepaged_collapse_pte_mapped_thps(mm_slot);
> >  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Thanks for the report. 
> 
> Shall I resend the patch, or shall I send fix on top of current patch?

Either is OK.  If the difference is small I will turn it into an
incremental patch so that I (and others) can see what changed.


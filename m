Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A6C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3E2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563229383;
	bh=qowy83W6RFvg6VqaYACFtXRIkdAHGeDCXOAft24WRvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iBvhE8lMiymNTL3OUWaVX+MZaZw5f2OPS1SzDV9aM8ueg2OrvAXt5tofxNJLzI9T0
	 B4ZnzrzP+VnKiddQLrnC6XvXq5zhb5QW5kuzPw2AkbfvSKYlcD6VTHL50MWx6BcWi8
	 No9gBOUEAT6ODDCsQrF30BNTZMoLjvsh0c2jBzCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbfGOWW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfGOWW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:22:56 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B979F2086C;
        Mon, 15 Jul 2019 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563229376;
        bh=qowy83W6RFvg6VqaYACFtXRIkdAHGeDCXOAft24WRvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkmBCeRaDfmgqQJm6EUYlFqqZGiYyyfY1mzj2gjr+jFh4CjW1oamupAM7hmpVT2BS
         u5OIh16oPoioZcQnt8Aiexb4tNadEDeZZj4IEyb3rCxDONNLuwQPAnqX9I4xCh9bLh
         eow7nebDEBLAoDIhhYoyvp2198l8D0/CoU3+MlOU=
Date:   Mon, 15 Jul 2019 15:22:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 0/2] mm: mempolicy: fix mbind()'s inconsistent
 behavior for unmovable pages
Message-Id: <20190715152255.027e2e368e16eb0a862eb9df@linux-foundation.org>
In-Reply-To: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019 08:20:07 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> 
> Changelog
> v2: * Fixed the inconsistent behavior by not aborting !vma_migratable()
>       immediately by a separate patch (patch 1/2), and this is also the
>       preparation for patch 2/2. For the details please see the commit
>       log.  Per Vlastimil.
>     * Not abort immediately if unmovable page is met. This should handle
>       non-LRU movable pages and temporary off-LRU pages more friendly.
>       Per Vlastimil and Michal Hocko.
> 
> Yang Shi (2):
>       mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
>       mm: mempolicy: handle vma with unmovable pages mapped correctly in mbind
> 

I'm seeing no evidence of review on these two.  Could we please take a
look?  2/2 fixes a kernel crash so let's please also think about the
-stable situation.

I have a note here that Vlastimil had an issue with [1/2] but I seem to
hae misplaced that email :(


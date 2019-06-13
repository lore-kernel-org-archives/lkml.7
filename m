Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5892C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9076A2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444962;
	bh=GXivTwKQk8Y+X5xE03CN8fthnLjjz3AlLtUYgE6QieY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xsMZQ+YYODIsgKV0ixnvM8d97fZroc0wUQ+/dJldbqkHGSsmzMgocqSFOQ8izdHUI
	 a780542NXf+PkpJ4736pVBhdtMTQv9xtb+DqwUf2immypZ2CpoThIhot+Ql6FCg79T
	 rYqGaHZ0PpntY7AD32L9qiqT8jka5+6u0weWxpV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393087AbfFMQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbfFMByv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:54:51 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68BF208CA;
        Thu, 13 Jun 2019 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560390891;
        bh=GXivTwKQk8Y+X5xE03CN8fthnLjjz3AlLtUYgE6QieY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r8JdgWt24mLYxAVnydiRtAdlx+xRwCOlsBeGXcMQy1oJV3B/cDxN+OnDejmpSyIV6
         RcIibyipNA+YGPuxHDsGF+U/AKFps7DbsQDuq1Fpc/BUfIrexokv2IP71eCmwXk283
         fI0rscTQw/skUc8NwPguKxlABRXZDgasoljgBWxA=
Date:   Wed, 12 Jun 2019 18:54:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@arm.com, osalvador@suse.de, mhocko@suse.com,
        mark.rutland@arm.com
Subject: Re: [PATCH V5 - Rebased] mm/hotplug: Reorder
 memblock_[free|remove]() calls in try_remove_memory()
Message-Id: <20190612185450.73841b9f5af3a4189de6f910@linux-foundation.org>
In-Reply-To: <67f5c5ad-d753-77d8-8746-96cf4746b3e0@redhat.com>
References: <36e0126f-e2d1-239c-71f3-91125a49e019@redhat.com>
        <1560252373-3230-1-git-send-email-anshuman.khandual@arm.com>
        <20190611151908.cdd6b73fd17fda09b1b3b65b@linux-foundation.org>
        <5b4f1f19-2f8d-9b8f-4240-7b728952b6fe@arm.com>
        <67f5c5ad-d753-77d8-8746-96cf4746b3e0@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 08:53:33 +0200 David Hildenbrand <david@redhat.com> wrote:

> >>> ...
> >>>
> >>>
> >>> - Rebased on linux-next (next-20190611)
> >>
> >> Yet the patch you've prepared is designed for 5.3.  Was that
> >> deliberate, or should we be targeting earlier kernels?
> > 
> > It was deliberate for 5.3 as a preparation for upcoming reworked arm64 hot-remove.
> > 
> 
> We should probably add to the patch description something like "This is
> a preparation for arm64 memory hotremove. The described issue is not
> relevant on other architectures."

Please.  And is there any reason to merge it separately?  Can it be
[patch 1/3] in the "arm64/mm: Enable memory hot remove" series?

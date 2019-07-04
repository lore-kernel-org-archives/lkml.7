Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB2C46495
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E897218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562274842;
	bh=L5uTJJm8cS0jNeSEyq9UQDrpRWA/RzoGfVSTvhzwtI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MtHl4DjCibE1n4BtytX1p1bCoB65thK6qnpoGINKtLDD6d6br4MvbSbeWxMXKKP7Y
	 Grh2xO0CRDR9w6bjylQ5jL3ekMW1mPYEKjlKseb7iS4fcbeD8RID+B27Rddp6Dzz9H
	 sxH9yBSiJe8Obr9sTykAaKsnyvde2UWN/6GR5fcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGDVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfGDVOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:14:00 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C3021850;
        Thu,  4 Jul 2019 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562274839;
        bh=L5uTJJm8cS0jNeSEyq9UQDrpRWA/RzoGfVSTvhzwtI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+QKnk1QjgZhVbE+BLtQhirvztvvdNVrrXLB8pJs5cNBFXmtAcyrr2FU/Gr6TYhFG
         a4RrGuNX9zgnsXHc3yAQk9TvTV7v0/u6KWK1iH3Hr8SvUC+EhKoU6ibelBN/fTzBCf
         3Yyp+elIXhTbmdvHshxgTH40BD/iCrymubuF9R5g=
Date:   Thu, 4 Jul 2019 14:13:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-Id: <20190704141358.495791a385f7dd762cb749c2@linux-foundation.org>
In-Reply-To: <de2286d9-6f5c-a79c-dcee-de4225aca58a@arm.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
        <20190626073533.GA24199@infradead.org>
        <20190626123139.GB20635@lakrids.cambridge.arm.com>
        <20190626153829.GA22138@infradead.org>
        <20190626154532.GA3088@mellanox.com>
        <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
        <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
        <20190704195934.GA23542@mellanox.com>
        <de2286d9-6f5c-a79c-dcee-de4225aca58a@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 21:54:36 +0100 Robin Murphy <robin.murphy@arm.com> wrote:

> >> mm-clean-up-is_device__page-definitions.patch
> >> mm-introduce-arch_has_pte_devmap.patch
> >> arm64-mm-implement-pte_devmap-support.patch
> >> arm64-mm-implement-pte_devmap-support-fix.patch
> > 
> > This one we discussed, and I thought we agreed would go to your 'stage
> > after linux-next' flow (see above). I think the conflict was minor
> > here.
> 
> I can rebase and resend tomorrow if there's an agreement on what exactly 
> to base it on - I'd really like to get this ticked off for 5.3 if at all 
> possible.

I took another look.  Yes, it looks like the repairs were simple.

Let me now try to compile all this...

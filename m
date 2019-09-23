Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8162089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGLyerk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393456AbfIWLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:17:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfIWLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PrfvG5lASzOHsHIuucJ4dzCmRMrt8S+zkD146kE7phs=; b=RGLyerk6UElv6qSpGN0c0FW7q
        kMKg1eaW7b05u2cT5VcW2vCT5cSUevZ5E3Aydhx85RuhhviaHmO5wtCOGdiz4Tuj/2Q11pahTKv8w
        NK9W1MCdrm6uYiWK/W3wAiPaiXnuzt5+oGf28B2OKGiEzG2iUpWwYGmX1UPCYmdEdDQ77NuZQ00na
        AbMnEAjqo1W5GAFtAU1o3XOoSDAeO5EY/eApYfcql6hlZx/2x8LEwOaEl/AvekC49Jbwy2ROUjftX
        gkcr3QfbnXsAtU7wAZyPnuBFpuNT6czwM/rS5oE8bLLTvZRkmkRZOFsJehYJloVhlOzKFX6OF1Tf0
        Y0exW65cw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCMLh-00026n-K4; Mon, 23 Sep 2019 11:17:45 +0000
Date:   Mon, 23 Sep 2019 04:17:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        mhocko@suse.com, david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V8 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20190923111745.GG15392@bombadil.infradead.org>
References: <1569217425-23777-1-git-send-email-anshuman.khandual@arm.com>
 <1569217425-23777-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569217425-23777-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:13:45AM +0530, Anshuman Khandual wrote:
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void free_hotplug_page_range(struct page *page, size_t size)
> +{
> +	WARN_ON(!page || PageReserved(page));

WARN_ON(!page) isn't terribly useful.  You're going to crash on the very
next line when you call page_address() anyway.  If this line were

	if (WARN_ON(!page || PageReserved(page)))
		return;

it would make sense, or if it were just

	WARN_ON(PageReserved(page))

it would also make sense.

> +	free_pages((unsigned long)page_address(page), get_order(size));
> +}

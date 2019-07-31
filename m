Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC56C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ACB20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564589455;
	bh=WCCv3Aec470dqenJ3D0yJXfNnDANp7cVqdAtXPLEgsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BTn20FAJyM4A6yzDAGLPwMrQ00GlkkKE8Vr01P4aX6p1kYT2Oq+WB2vrY5xD1K+44
	 3ngT2p39oFGhPwg0b90ckW/m4fFwK/m5O7cDspVEsd0DHUdg7B49aFyC9If7p4UIKZ
	 M8WhNhb3Oib7t5D98yOlVkJluit03CtOhhufkpXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfGaQKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfGaQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:10:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDEF5206A3;
        Wed, 31 Jul 2019 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564589453;
        bh=WCCv3Aec470dqenJ3D0yJXfNnDANp7cVqdAtXPLEgsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0oO6ADuBpn0GsCzed/V3vKsIofX8heKLLg1altER77SX8nvqgWsXXTEM1v+taPPH
         EIwclnx482U7aJLNBxzEszh8K/nBVMDE9WWJ3rSKcTQBSk8H0adilY4q0TaGfAK9h8
         GAMdp9Q3T2fvoMqUn4p9KL2EwGx5PxfqoHpuEndc=
Date:   Wed, 31 Jul 2019 17:10:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/2] mm/sparsemem: Add vmem_altmap support in
 vmemmap_populate_basepages()
Message-ID: <20190731161047.ypye54x5c5jje5sq@willie-the-truck>
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
 <1561697083-7329-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561697083-7329-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:14:42AM +0530, Anshuman Khandual wrote:
> Generic vmemmap_populate_basepages() is used across platforms for vmemmap
> as standard or as fallback when huge pages mapping fails. On arm64 it is
> used for configs with ARM64_SWAPPER_USES_SECTION_MAPS applicable both for
> ARM64_16K_PAGES and ARM64_64K_PAGES which cannot use huge pages because of
> alignment requirements.
> 
> This prevents those configs from allocating from device memory for vmemap
> mapping as vmemmap_populate_basepages() does not support vmem_altmap. This
> enables that required support. Each architecture should evaluate and decide
> on enabling device based base page allocation when appropriate. Hence this
> keeps it disabled for all architectures to preserve the existing semantics.

This commit message doesn't really make sense to me. There's a huge amount
of arm64-specific detail, followed by vague references to "this" and
"those" and "that" and I lost track of what you're trying to solve.

However, I puzzled through the code and I think it does make sense, so:

Acked-by: Will Deacon <will@kernel.org>

assuming you rewrite the commit message.

However, this has a dependency on your hot remove series which has open
comments from Mark Rutland afaict.

Will

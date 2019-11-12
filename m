Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C621C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE8206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573567671;
	bh=207eGjlW0XcCmIjmHwi93swFFqBqCKyh8crCpl4htco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g1c4XTmKJPMociBBUnABhw1k0w/yGCTD5lSziNxvbpe6oX76KxtPlzbsWg+5uOw5K
	 +WhpvGaq6eQv+zoff1zdr3Hd/2IKaG/4y9AmLLgR+nvtS5ghy7pNXEAnJwxsfHz68Q
	 jzsiG5zexrY+HTWcFbTpWDJXHFYKQhDmN33Wg0s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKLOHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfKLOHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:07:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC8C206B6;
        Tue, 12 Nov 2019 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573567669;
        bh=207eGjlW0XcCmIjmHwi93swFFqBqCKyh8crCpl4htco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sA3PDOS8rY/aV2VAXBWyvRZtJgXixVfUQyvApHv8yAUFAba3r54slZNa7RhiH3qvZ
         5fHI2+cdUegZ30K5jgtirtL8H0gFUmLIwodU7lJvdLU1oUX7fc7QjMM5HByDmdrHY9
         nKVL93X3IOqi96h+jxYTYIXaUMs0XZS3KgjFP4+Q=
Date:   Tue, 12 Nov 2019 15:07:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra: Fix superfluous IRQ error message
Message-ID: <20191112140746.GA1333127@kroah.com>
References: <20191011083459.11551-1-jonathanh@nvidia.com>
 <20191014132458.GG422231@ulmo>
 <f5cd4647-4349-f20c-bc16-da9291fc9329@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5cd4647-4349-f20c-bc16-da9291fc9329@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:02:02PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 14/10/2019 14:24, Thierry Reding wrote:
> > On Fri, Oct 11, 2019 at 09:34:59AM +0100, Jon Hunter wrote:
> >> Commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> >> platform_get_irq*()") added an error message to avoid drivers having
> >> to print an error message when IRQ lookup fails. However, there are
> >> some cases where IRQs are optional and so new optional versions of
> >> the platform_get_irq*() APIs have been added for these cases.
> >>
> >> The IRQs for Tegra HSP module are optional because not all instances
> >> of the module have the doorbell and all of the shared interrupts.
> >> Hence, since the above commit was applied the following error messages
> >> are now seen on Tegra194 ...
> >>
> >>  ERR KERN tegra-hsp c150000.hsp: IRQ doorbell not found
> >>  ERR KERN tegra-hsp c150000.hsp: IRQ shared0 not found
> >>
> >> The Tegra HSP driver deliberately does not fail if these are not found
> >> and so fix the above errors by updating the Tegra HSP driver to use
> >> the platform_get_irq_byname_optional() API.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >>  drivers/mailbox/tegra-hsp.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Perhaps Greg should pick up this patch because he's carrying the patch
> > that adds the platform_get_irq_byname_optional() patch for v5.5.
> > 
> > Greg, would you prefer a copy of this in your mailbox, or does the
> > following patchwork link suffice:
> > 
> > 	http://patchwork.ozlabs.org/patch/1175012/
> > 
> > Either way, this patch:
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > 
> > Thierry
> 
> Are you OK to pick this up? Do you need Jassi's ACK as well?

Sorry, I'll take it as-is, it should be fine.

greg k-h

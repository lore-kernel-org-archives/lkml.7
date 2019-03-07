Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D647C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7F20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551971582;
	bh=D7BrNuxfHTyHSyWpvWGnodH230k4QXJFgIyaERjFPDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t8Ez4zk7os9rx9naJOhQjiYt52v4zJjEWvE7SXCs6u8Qtku01lm6zkmhqapOSV3u1
	 uXX7gjcDlLJ3hwTxS7w7nePys+6JtPpKVSrVOkOFE2mti/XPm6yq2jrtE2igBW69sB
	 HEdEApyduct84mNgarBEnKQJYJqZpEb4+qCHcMsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfCGPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FBE20840;
        Thu,  7 Mar 2019 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551971579;
        bh=D7BrNuxfHTyHSyWpvWGnodH230k4QXJFgIyaERjFPDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jv0AWxmjlLbkf1LWMZ4jVq4tWYr0oyDu9JRA3bMpQxWdjNGSqRnMcttwiFozjmRzE
         9D4AR3EDgBLpKroj4/SSR9E6DKr05EOhax33Zegk5UT0OT4RVw9jx47euuXsA7FEvR
         cdO0ww/h8wDzXaWUp6YpkKHoaAv0QgUOJNVR3zlI=
Date:   Thu, 7 Mar 2019 16:12:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Message-ID: <20190307151257.GA25053@kroah.com>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
 <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
 <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
 <6e64e564-aa6c-4193-1f57-ebf88d6932d5@arm.com>
 <1b24a2dc-e9a3-f293-8dd1-360896a554e6@huawei.com>
 <ebc665cc-31c5-4ecd-6c48-6d14962b1f0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc665cc-31c5-4ecd-6c48-6d14962b1f0c@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:52:55PM +0000, Robin Murphy wrote:
> Hi John,
> 
> On 07/03/2019 14:45, John Garry wrote:
> [...]
> > Hi guys,
> > 
> > Any idea what happened to this fix?
> 
> It's been in -next for a while (commit 376991db4b64) - I assume it will land
> shortly and hit stable thereafter, at which point somebody gets to sort out
> the manual backport past 4.20.

It's already in Linus's tree, I'll go try to do the stable backporting
now...

greg k-h

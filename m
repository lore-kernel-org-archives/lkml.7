Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49D3206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hj8S/NLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfLRNFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:05:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfLRNFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:05:19 -0500
Received: from zn.tnic (p200300EC2F0B8B004C237F05E7CC242C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:4c23:7f05:e7cc:242c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 294541EC0591;
        Wed, 18 Dec 2019 14:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576674318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=epS/Q4CPQrHIq8og5sJ81MAlwOHLeJ852bCwbKG3HlE=;
        b=hj8S/NLnZgwgxQAGDp/qAmGctiufUh18t5TnnCY6L4gAsr1LBBIlVd0tGYHE7kW+3qUYsv
        0t8Y64bxA6pVY1QqbyejtVI21mw8HyIP6JUfyAzl95KSKemN7hvqOgw+cHm3+3zi+EdPmO
        qLcZwlLs4e9bhyrOiqnpSXlwNHOTsfE=
Date:   Wed, 18 Dec 2019 14:05:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     John Garry <john.garry@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Message-ID: <20191218130510.GF24886@zn.tnic>
References: <20191218062129.7400-1-rrichter@marvell.com>
 <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
 <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:55:04PM +0000, Robert Richter wrote:
> I leave that to the maintainer as he is editing the SOB chain anyway.
> The patch would be sent to the stable list already which may cause
> confusion.

I haven't looked at it yet but I'd prefer if this patch went the normal
way and landed in stable only eventually so that it gets some testing by
people in linux-next first.

It is not a trivial patch and we did break EDAC with recent rework so
I'd prefer if we take it slowly here and do more extensive testing
before we expose it to the world.

Also, how does this patch play with your cleanup? I'm guessing this
patch goes first and then the cleanup...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

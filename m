Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3F822CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567590667;
	bh=cWumTrUCWby2RFMQQ87i5+/dEWefDyNawluwiyL0n3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yt9vUq2pO/KeiECwXQTRSMjgOdcr1IRCtX09fQMJ0wrkPQNfQcYczeuJ9Wss09GaM
	 oMs9OtYINeSzMYqm9E4FpkXOVSDbPmB94ZFidVWcbTPTAFEkHCFbo2l0fsRFRxlq60
	 Sb4iJ5t4yAo7qu+3em36cUZsaTn2V0WDA7CgTApw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfIDJvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDJvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:51:05 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3ACF22CF7;
        Wed,  4 Sep 2019 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567590664;
        bh=cWumTrUCWby2RFMQQ87i5+/dEWefDyNawluwiyL0n3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq05tX4MsH75NEnfoomECduDUpW2wgJt/to/w0nCfJX3GyJx2fdZxyrIs6XDUmTRO
         bVrzmOsP03hofoZ+aKx8Ta7FWzNVpvjjjj//h1N2YrnyBho2cog9/jYfuefO4489kL
         TESY896jfACtG/BoceM+AOuwziakfG1yMbHS1yGI=
Date:   Wed, 4 Sep 2019 15:19:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/5] dmaengine: ti: edma: Multicore usage related fixes
Message-ID: <20190904094956.GT2672@vkoul-mobl>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-19, 15:56, Peter Ujfalusi wrote:
> Hi,
> 
> When other cores want to use EDMA for their use cases Linux was not playing
> nicely.
> By design EDMA is supporting shared use with shadow regions. Linux is using
> region0, others can be used by other cores.
> 
> In order to not break multicore shared usage of EDMA:
> - do not reset paRAM slots which is not allocated for Linux (reserved paRAM
>   slots)
> - Only reset region0 access registers, do not touch other regions
> - Add option for reserved channels which should not be used by Linux in a similar
>   fashion as we already have for reserved paRAM slots.

Applied 1 to 3, thanks

-- 
~Vinod

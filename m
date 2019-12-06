Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E76FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7035D24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575654965;
	bh=IeiSscRuUwpcU/kAIShm5XFn2jzqzIym266sdGO0B4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yJFuXfSfiXq/YHivS1e2oRFXVB5ZEP+BnzNUpoCIbj7JY/q2f9DR5ldTR5YMm/V59
	 CAUNTEtvOlB5jr95586XnUx5NFvj5QXcALTF3jxGjIm/GR/wHyjaVH3v8GeYKEZBq+
	 6+r+6Dsy/Ejmc6lVeIwDZ7p1gj9UI2Y0qZrukudM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFR4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFR4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:56:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4995D24673;
        Fri,  6 Dec 2019 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575654963;
        bh=IeiSscRuUwpcU/kAIShm5XFn2jzqzIym266sdGO0B4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmWSJ3MeKrcW2bpYd6s3Ygl7u9mly6QPM3f4XROY8jlw4AVcf4PmijRTXrcumjVn3
         lYNzDhug0GFgHPE8J11h8F8zat7IitFCbX2TfpLPciTwbO6D9osmqSTSQ5vdyqrizD
         BXBh5PJqF4gMwHdVJGCDW9WIFSL/aLciWzy/S340=
Date:   Fri, 6 Dec 2019 18:56:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, sboyd@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, allison@lohutok.net,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
Message-ID: <20191206175600.GB186026@kroah.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <e94e56bc-2b4c-5d95-002a-073c9272537d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94e56bc-2b4c-5d95-002a-073c9272537d@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 09:49:49AM -0800, Sowjanya Komatineni wrote:
> Thanks Greg.
> 
> Sorry, Will send this patch separately (out of this series) with stable tag
> to get this applied to stable kernels once review is done for this series.

Why not just properly add the tag in the original patch when it gets
merged?  That's how everyone else does it :)

This isn't new, it's been happening this way for 12+ years now...

thanks,

greg k-h

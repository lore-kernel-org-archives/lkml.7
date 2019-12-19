Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F093C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0888B21655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576776908;
	bh=s5oaspOL57PeyHvJJ2IZujrmMyDV5G1RgW/jNsRFpcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T7+XAnIxLAq4mlpYQWdaznPHJ40FT4y6v/CqjGRxEJZa/sd0jOcnY2EDAgXrXbDOM
	 AHlxURNz5/keiM8GzZ8LzzXNJzhNigohNnFfZVotf5DKYqnKHo4RP27OnQxc0VdH5O
	 hkBcqMNXglBL5XLyNgxSr9V+lLfxeS+oe4ISJpQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLSRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfLSRfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:35:06 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492B6227BF;
        Thu, 19 Dec 2019 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576776905;
        bh=s5oaspOL57PeyHvJJ2IZujrmMyDV5G1RgW/jNsRFpcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeu9sc1zY3qe/XYURcfyADyDRQSTY4m2jgc72uJjDA9qYqsqBUeapVh15uArYh1Pz
         /j2mksn7HnCACdYISyc8+X3B8RSXfCmgNGfo6CFlQdR8YvP+RNFi4eBFnFfrcL5c0b
         brTHvQUO3hWECeyPuRkD51cWKHNHIIaUCg9yeyjY=
Date:   Thu, 19 Dec 2019 12:35:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 128/350] spi: pxa2xx: Set
 controller->max_transfer_size in dma mode
Message-ID: <20191219173504.GN17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-89-sashal@kernel.org>
 <20191211104738.GA3870@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191211104738.GA3870@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:47:38AM +0000, Mark Brown wrote:
>On Tue, Dec 10, 2019 at 04:03:53PM -0500, Sasha Levin wrote:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> [ Upstream commit b2662a164f9dc48da8822e56600686d639056282 ]
>>
>> In DMA mode we have a maximum transfer size, past that the driver
>> falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
>> Falling back to PIO for big transfers defeats the point of a dma engine,
>> hence set the max transfer size to inform spi clients that they need
>> to do something smarter.
>
>This won't fix anything by itself, this asks other code to change how it
>behaves which may or may not work in older kernels.

I'll drop it then, thanks!

-- 
Thanks,
Sasha

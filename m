Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBADC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ABD2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567077725;
	bh=iMGiL1QA5nv51IfhWJcMMYZrBzmgReLmriJMg96pxjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VQaAZ1aZxpbFv9glKecpfZLcEufs2dHAF9wf6F7vfTfRpYe3P/Yrxd+CkPbhWd5Be
	 DQ+NAYBxmnrHmYP/JVG5GP6N6WjSCpacUVfYMpOWmUYcXIdkd5yGOJozAZv11jt8mh
	 gTWAbkxztG83FyKYvbSfpxxE2n+jghOhUBn/vKaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfH2LWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfH2LWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:22:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFE920674;
        Thu, 29 Aug 2019 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567077723;
        bh=iMGiL1QA5nv51IfhWJcMMYZrBzmgReLmriJMg96pxjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZF1iEO5eKri0J0FPT6gHVUzK1xtD8HaecoihJcIJ9sGJzToVSyeiVFyVrRH+LHGS
         O9UZqHDlLWRZAQRHFbooo2PqiyItRIuUvY0vDBeRxkLcaiQCYzt3CM7iAhOZ24D3TM
         9FWu3EgZ6hSyFZxyAe4vwjRnFlWIjQfpuXfBQVAY=
Date:   Thu, 29 Aug 2019 13:22:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 1/2 RESEND] usb: core: phy: add support for PHY
 calibration
Message-ID: <20190829112201.GA23823@kroah.com>
References: <20190808094128.27213-1-m.szyprowski@samsung.com>
 <CGME20190808094146eucas1p2a5a88ce5e7a87d47c4bcececab4df9a5@eucas1p2.samsung.com>
 <20190808094128.27213-2-m.szyprowski@samsung.com>
 <a380a635-e036-1a18-bc0f-947931f8735c@samsung.com>
 <20190828204146.GA21235@kroah.com>
 <e801e7a4-f525-baae-4c02-d271db308b5f@samsung.com>
 <20190829102113.GA20823@kroah.com>
 <91b0a341-e561-43f5-3daa-c6aaf33e3287@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b0a341-e561-43f5-3daa-c6aaf33e3287@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:27:34PM +0200, Marek Szyprowski wrote:
> Hi Greg,
> 
> On 2019-08-29 12:21, Greg Kroah-Hartman wrote:
> > On Thu, Aug 29, 2019 at 07:26:50AM +0200, Marek Szyprowski wrote:
> >> Hi Greg,
> >>
> >> On 2019-08-28 22:41, Greg Kroah-Hartman wrote:
> >>> On Mon, Aug 26, 2019 at 10:55:33AM +0200, Marek Szyprowski wrote:
> >>>> Hi Greg
> >>>>
> >>>> On 2019-08-08 11:41, Marek Szyprowski wrote:
> >>>>> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
> >>>>> done after every USB HCD reset. Generic PHY framework has been already
> >>>>> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
> >>>>> phy: add calibrate method"). This patch adds support for it to generic
> >>>>> PHY handling code in USB HCD core.
> >>>>>
> >>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
> >>>>> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> >>>> Greg: any chance to give it this a try in -next? If not, maybe You can
> >>>> point someone whose review will help?
> >>> Ah crap, this is me, not the PHY maintainer :(
> >>>
> >>> Can you resend this and I will be glad to review it.  But it would also
> >>> be good to get Felipe's review as well.
> >> No problem, I will resend it again in a few minutes. Felipe already
> >> acked it: https://lkml.org/lkml/2019/8/8/460
> > I don't see the resend, did I miss it?
> 
> I looks so: https://lkml.org/lkml/2019/8/29/31

Got it now, thanks.

greg k-h

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6877920863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JkwusLut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfCYK0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:26:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51638 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i/dGCf71cqBarbVkvLDKse6m1paYOC5pSFEdRoC6Q3c=; b=JkwusLutfp/9cnc3arV/XuhPn
        qd1iWBFbPbOcDct049ces1dweEmJYMIKBVP2ZfXAbHtQ2tTsGLz3YbTzklr5JeYaR7uGa5xduETwx
        Xyrlasb/SIWEfm2+QUMG368rLfJyyUatcDoNNnz6Xk4spYrMuFhESZ+jeYQXtgbK8XB2BBfLA6h5v
        BfBIS61lJ8yVwGQzOPOPsdoF3o0RqNHundnnTS0Jmi68wcFz3gdZWIRauwTddtt6KcNgmUfoAGVOZ
        5OqzjnEkNz+T2JbJeD59F56KUlMIr/Z6mwigP35utGmEJq1M8cbLgQtXSBNP1lurYUa45lsnXBDdU
        ZYytzw9Cw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55208)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h8MoQ-0001vI-R4; Mon, 25 Mar 2019 10:26:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h8MoL-00031u-UX; Mon, 25 Mar 2019 10:26:33 +0000
Date:   Mon, 25 Mar 2019 10:26:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Peter Chen <hzpeterchen@gmail.com>
Cc:     Michal Nazarewicz <mina86@mina86.com>, peter.chen@nxp.com,
        fugang.duan@nxp.com, linux-usb@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Why CMA allocater fails if there is a signal pending?
Message-ID: <20190325102633.v6hkvda6q7462wza@shell.armlinux.org.uk>
References: <CAL411-pwHq4Df-FsBu=Vzd4CR6Pzee2yR579hHeZuh8T7fBNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL411-pwHq4Df-FsBu=Vzd4CR6Pzee2yR579hHeZuh8T7fBNJA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:37:09PM +0800, Peter Chen wrote:
> Hi Michal & Marek,
> 
> I meet an issue that the DMA (CMA used) allocation failed if there is a user
> signal, Eg Ctrl+C, it causes the USB xHCI stack fails to resume due to
> dma_alloc_coherent
> failed. It can be easy to reproduce if the user press Ctrl+C at
> suspend/resume test.

It has been possible in the past for cma_alloc() to take seconds or
longer to allocate, depending on the size of the CMA area and the
number of pinned GFP_MOVABLE pages within the CMA area.  Whether that
is true of today's CMA or not, I don't know.

It's probably there to allow such a situation to be recoverable, but
is not a good idea if we're expecting dma_alloc_*() not to fail in
those scenarios.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

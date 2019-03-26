Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E31C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BDC2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553586558;
	bh=YF7dloFa2bOTAX4bLqn6FbttEBk6HLFO5NmGovpqGU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xrSSZ/ZBbG3ZJ/89KpIu1NUez7/XsGVFBWgO68qbBg/tczhCUReBLSmXmiguMIU1Q
	 EgjozGWljGdM68K6jd85P27p365foYOD0VTmzGhcmayFK9aCBCfpm1ydp7rTpsh2Su
	 SMNRc9kX+bGwV0pwRHIu0FL7NTQnwaFblAucbwM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZHtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:49:16 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C88820828;
        Tue, 26 Mar 2019 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553586555;
        bh=YF7dloFa2bOTAX4bLqn6FbttEBk6HLFO5NmGovpqGU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lm+YN/+Bwi++rlupeJmej+gAuj4rya8ltoZWkpJ6S18Z8pMOIOOTUAPk0ybis4BQh
         +Rh5Cxk+6HJKwsN8ei49AdGh4Z9I72fpjup+sQf3ASLmD2n0bluun+18GwqtVVScnI
         qwyfSuv4LscHpqgddZg7Q+nzSstRF9nbvjQ0TOYk=
Date:   Tue, 26 Mar 2019 16:49:12 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: sunxi: Fix USB host init fail on v5.1-rc1
Message-ID: <20190326074912.GA1705@kroah.com>
References: <20190322085108.18693-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322085108.18693-1-wens@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:51:06PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> As previously reported [1], USB EHCI/OHCI hosts are broken on Allwinner
> SoCs on v5.1-rc1. This is partially triggered by commit b97a31348379
> ("usb: core: comply to PHY framework"), and partially due to how the
> Allwinner USB PHY driver handles phy_set_mode for non-OTG PHYs.
> 
> This series fixes this in both places.
> 
> Patch 1 makes phy-sun4i-usb accept PHY_MODE_USB_HOST for non-OTG PHYs.
> 
> Patch 2 makes the usb core fall back to setting the mode
> PHY_MODE_USB_HOST if set_mode with PHY_MODE_USB_HOST_SS fails. If that
> fails then the failure path is the same as before. This should make it
> so existing USB 3.0 drivers are affected.
> 
> The patches don't have any dependencies on each other, and could go in
> through separate branches. However this affects usability of USB input
> devices and Ethernet dongles, I'd rather they go in sooner than later.

I'll take them both now, thanks.

greg k-h

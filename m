Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9212BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631422133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MzdwI+mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJAVuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:50:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44598 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfJAVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jIjsg0TW67zqsAw0Oa22lYtg1aF0/fv+VgAHd2QxUcc=; b=MzdwI+mJT11ZS8s1wHPkZTXzy
        oPyWJHG5eLHE2BYQrc0++VKEHuRkwKJt/G9HCJABzNhdxb8Yk+x3j/1K6ehjE40ZTJ5FSMgRpi8vc
        6WYqdfAwi7kp3tFyidWRg7JP+mMuXO5VbY6sklVdGRmEzmFsZCVjHRlv2y6IuXOJXGCA2hggxECts
        vTgwV5GfcQKYfqeu8EEeIA9VM79Joh+jgXF+U7lS4MxAf+M8B4/jnSxNIKFe4exvHEL64qAkWS2mE
        66lQ45R3wM8ChMnct98x2UludqAbBV6fQXerFvhI46Lu2+sNUbQqLJzAf89+WzxTjaGv+qePlSa03
        ZzsVIk97Q==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46430)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFQ2f-0004vu-GU; Tue, 01 Oct 2019 22:50:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFQ2c-00005z-J8; Tue, 01 Oct 2019 22:50:42 +0100
Date:   Tue, 1 Oct 2019 22:50:42 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        thor.thayer@linux.intel.com
Subject: Re: [PATCH] ARM: drivers/amba: release the resource to allow for
 deferred probe
Message-ID: <20191001215042.GO25745@shell.armlinux.org.uk>
References: <20191001214026.21718-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001214026.21718-1-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:40:26PM -0500, Dinh Nguyen wrote:
> With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe", the amba bus driver needs to be deferred probe because the
> reset driver is probed later than the amba bus. However with a deferred
> probe, the call to request_resource() in the driver returns -EBUSY. The
> reason is the driver has not released the resource from the previous probe
> attempt.
> 
> This patch releases the resource when amba_device_try_add() returns
> -EPROBE_DEFER. This allows the deferred probe to continue.
> 
> Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
> amba bus probe")
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/amba/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index f39f075abff9..f246b847c991 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -535,6 +535,7 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
>  
>  	if (ret == -EPROBE_DEFER) {
>  		struct deferred_device *ddev;
> +		release_resource(&dev->res);

This is in the wrong place, and misses more serious leaks.

>  		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
>  		if (!ddev)

What we have is bad error cleanup code in amba_device_try_add().
Consider what would happen if dev_pm_domain_attach() inside that
function were to return with -EPROBE_DEFER with your patch in
place - we would call release_resource() twice on the same
resource.  Clearly, that's incorrect.

The problem is that an error from
of_reset_control_array_get_optional_shared() just returns, leaving
everything that amba_device_try_add() already did still in place.
So, for example, a subsequent call to amba_device_try_add() will
remap the resource, leaking the previous mapping.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

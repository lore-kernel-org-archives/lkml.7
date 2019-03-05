Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8652C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9149220848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dL+AEf9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCELky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:40:54 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42606 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfCELky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cjsHhJalwzEJjk0J0bDWA/Eixzr743EMPJ6TG/6uaXs=; b=dL+AEf9MLmtrfMMiukk7SACDO
        Xd07FMEw79yWf6CYjG69/qBVG7zIuC9JYfHaUlIYuw/gWjYREw/g2Lx9+ZaV5WNMjRZ2eip8Hrp4/
        aEHOXbsN648ABsa27LNJJW6mZSVGZocnqqtLrKDecC3GShXt1iDI2P9SDUvxwiSsWSHbIBSV9z4Cy
        4RCMRnDaCwpXwQiwT6fYFkdT7zEDqN4wZTqjf4mMegLec+ex3FQ64IPHbbqhHjqj0HvgHNeGsuuGw
        yc5PO9iTgi5GJmIpTiX400d52UMiN2zRBT21HdSkP4EP6Tqgg04FbL5rTsZGkOH0B7mNqoGikeqex
        Nv3hp4Gtw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54946)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h18RH-0000yE-2J; Tue, 05 Mar 2019 11:40:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h18RF-0003AN-13; Tue, 05 Mar 2019 11:40:49 +0000
Date:   Tue, 5 Mar 2019 11:40:48 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190305114048.egpbeddy4pqbwl5b@shell.armlinux.org.uk>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:33:52PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.

I question this.  Your reasoning is that the node is no longer used
so the reference count needs to be put.

However, in all these cases, data is read from the nodes properties
and the device remains in-use for the life of the kernel.  There is
a big difference here.

With normal drivers, each device is bound to their associated device
node associated with the device.  When the device node goes away, then
the corresponding device goes away too, which causes the driver to be
unbound from the device.

However, there is another class of "driver" which are the ones below,
where they are "permanent" devices.  These can never go away, even if
the device node refcount hits zero and the device node is freed - the
device is still present and in-use in the system.  So, having the
device node refcount hit zero is actually a bug: what that's saying
is the system device (eg, SCU) has gone away.  If you somehow were to
remove the SCU from the system, you'd end up severing the connection
between the CPU cores and the rest of the system - obviously resulting
in a dead system!

So, what is the point of dropping these refcounts for devices that can
never go away - and thus their associated device_node should also never
go away?

> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"
> 
>  arch/arm/mach-actions/platsmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 4fd479c..1a8e078 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -107,6 +107,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  
>  	timer_base_addr = of_iomap(node, 0);
> +	of_node_put(node);
>  	if (!timer_base_addr) {
>  		pr_err("%s: could not map timer registers\n", __func__);
>  		return;
> @@ -119,6 +120,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  
>  	sps_base_addr = of_iomap(node, 0);
> +	of_node_put(node);
>  	if (!sps_base_addr) {
>  		pr_err("%s: could not map sps registers\n", __func__);
>  		return;
> @@ -132,6 +134,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
>  		}
>  
>  		scu_base_addr = of_iomap(node, 0);
> +		of_node_put(node);
>  		if (!scu_base_addr) {
>  			pr_err("%s: could not map scu registers\n", __func__);
>  			return;
> -- 
> 2.9.5
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

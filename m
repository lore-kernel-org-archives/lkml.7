Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556FDC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E3A24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576776103;
	bh=W+DNykC37RqfPj4trEBzgzpFECNymEArMcSSbX63dz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oJ5kJgEoitUH0/kc7613ZHS0VEN1zbvb2PMXXDavb/NlmuepE6Ot6gKKYSaEYiM6r
	 GJOnEIKZJNvFZKB0OmGJwgmRVUEOWAwBD7GGZwvreNL7nLtzvwJ2XOdD+lGCJ1pnsl
	 AYSUIPqpHdWsr6O28yyOJekdUrU8MwJBwNVmpf5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLSRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLSRVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:21:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD88227BF;
        Thu, 19 Dec 2019 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576776101;
        bh=W+DNykC37RqfPj4trEBzgzpFECNymEArMcSSbX63dz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puTIlALeKB1hcYSZhniRoqvABUQ7gJoFBGPj7Yw2j7iGPP7IJEZP4eflOkSfRIoyz
         /bGGWJzEInJbpPKXdpjn9OCaEwtzqgxhbi7poPoJAHla600iid8NOM4r5r6cS9hFeW
         suugbyReFtb072k5ERmxPQon4ywZShZVNsBimX5I=
Date:   Thu, 19 Dec 2019 18:21:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 2/3] misc: xilinx_flex: Add support for the flex noc
 Performance Monitor
Message-ID: <20191219172139.GB2092676@kroah.com>
References: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
 <469d8bdde24055e01141b79a936dbd64c2481cc2.1575609926.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469d8bdde24055e01141b79a936dbd64c2481cc2.1575609926.git.shubhrajyoti.datta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:09:57AM +0530, shubhrajyoti.datta@gmail.com wrote:
> +/**
> + * xflex_remove - Driver remove function
> + * @pdev: Pointer to the platform_device structure
> + *
> + * This function frees all the resources allocated to the device.
> + *
> + * Return: 0 always
> + */

No need for kerneldoc documentation for static functions.

> +static int xflex_remove(struct platform_device *pdev)
> +{
> +	sysfs_remove_groups(&pdev->dev.kobj, xflex_groups);

Your attribute groups can, and should, be automatically created by the
driver core.  Set the driver's dev_groups pointer and that will happen
for you.

thanks,

greg k-h

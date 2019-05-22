Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE18C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7539217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558528039;
	bh=+GF+6gGeAQLWS1PYEAHsBHfgN/elXRl0cT8VNN1Tgx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ibtEQwbNFoIRDi03Hs+mnS3hl25Uuj2ILyQqWiEgxQWS4l7cELVIwiqaExBhmPu5M
	 98SWHl06R5R6LIw9lIC6EL9Ybf60xB6G6G8ebKCnC6I74rCtZ0+B74nZVIvGLr53ro
	 5l3omX0c1AtidCDkE9gwRwfUNpNvq+QZr8QoeSfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfEVM1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVM1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:27:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841F42173C;
        Wed, 22 May 2019 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558528037;
        bh=+GF+6gGeAQLWS1PYEAHsBHfgN/elXRl0cT8VNN1Tgx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syKJ/UmP+vT0+IRYzgr2Wo3ixVdN4xYncKvArjFwyMD41phUE0QTjx/8ziCeFWhLv
         g930YWcEFQZqxD42eMd5igKRZmDQhNr5qNugSAym1pFDD/A/UMU0jDNWVuGRilv1O0
         Yh+I/8tDVW7i+/diu55IaQd/PoyJwn/kp/HZbLkE=
Date:   Wed, 22 May 2019 14:27:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/6] staging: kpc2000: make kconfig symbol 'KPC2000'
 select dependencies
Message-ID: <20190522122714.GA2270@kroah.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
 <932843299b814f3a22dd176771b46be14ceefeea.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932843299b814f3a22dd176771b46be14ceefeea.1558526487.git.gneukum1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:13:57PM +0000, Geordan Neukum wrote:
> The kpc2000 core makes calls against functions which are conditionally
> exported upon the kconfig symbols 'MFD_CORE' and 'UIO' being selected
> Therefore, in order to guarantee correct compilation, the 'KPC2000'
> kconfig symbol (which brings in that code) must explicitly select its
> hard dependencies.
> 
> Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
> ---
>  drivers/staging/kpc2000/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
> index fb5922928f47..8992dc67ff37 100644
> --- a/drivers/staging/kpc2000/Kconfig
> +++ b/drivers/staging/kpc2000/Kconfig
> @@ -3,6 +3,8 @@
>  config KPC2000
>  	bool "Daktronics KPC Device support"
>  	depends on PCI
> +	select MFD_CORE
> +	select UIO

depends on is better than select.  There's a change to depend on UIO for
this code already in my -linus branch which will show up in Linus's tree
in a week or so.

Are you sure we need MFD_CORE as well for this code?  Why hasn't that
been seen on any build errors?

thanks,

greg k-h

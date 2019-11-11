Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D32190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573486805;
	bh=fIMS1YCPUO+d4NLi94WgM6DC/eRYtzSD8x7U2/QuiQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vzR84fmZ/rpWAMzmS7t3f0BJTw5qnWGIBmo0qp8EXRpvtTY01W7Zorb3tNjKBxiBK
	 Oq+zjk/W/xXteVsm2OC0sbKtsoYJoLhe8jwY5ynFkFnhhbn/9ITrVak41By2k6G0k9
	 1MAn4XVvSOIedS+xrwabJi52cpfVcjT6FUxLtIoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfKKPkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:40:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57D22196E;
        Mon, 11 Nov 2019 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573486803;
        bh=fIMS1YCPUO+d4NLi94WgM6DC/eRYtzSD8x7U2/QuiQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zp6k4XU7wY4KEfsrdTGJ3QbS7/ydrxCFaPi4ky5+hjFqCqymmtiKfH0BmU+dCixYv
         RV3rqMCVH8jycSEIfwUWOJbs2fn7eEECn9ITOX63fykqBS/dN5A5651lbCOvvjmC5V
         OqCGiNGZpFlBXgP9+VFeMf0IPc1FIgqEQM6zvOCg=
Date:   Mon, 11 Nov 2019 16:40:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devel@driverdev.osuosl.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/octeon: Fix test build on MIPS
Message-ID: <20191111154001.GA813474@kroah.com>
References: <20191110175620.20290-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110175620.20290-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 09:56:20AM -0800, Guenter Roeck wrote:
> mips:allmodconfig fails to build.
> 
> drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_poll':
> drivers/staging/octeon/ethernet-defines.h:30:38: error:
> 	'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared
> 
> Octeon defines are only available if CONFIG_CPU_CAVIUM_OCTEON
> is enabled. Since the driver uses those defines, we have to use
> the dummy defines if this flag is not enabled.
> 
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/staging/octeon/octeon-ethernet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
> index a8a864b40913..70848c6c86ec 100644
> --- a/drivers/staging/octeon/octeon-ethernet.h
> +++ b/drivers/staging/octeon/octeon-ethernet.h
> @@ -14,7 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/phy.h>
>  
> -#ifdef CONFIG_MIPS
> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
>  
>  #include <asm/octeon/octeon.h>
>  

Already in my tree, sorry for the delay, will show up in 5.5-rc1 and get
backported to 5.4.y

thanks,

greg k-h

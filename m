Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E98C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43AF20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415272;
	bh=BCNtmtnXSyauSW3OSwKnokYEzBhAlTALHeBzASg9ZA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VsEm6mV8K6FCWCvamOCY/ht/erfxsHLnEYWLhwkXsDiW+04gKte7A6e6EgPHLek8X
	 vQodkoHiXK8gCjfo/ZhWTf6vDnDQgmNPR060ztxCypYANZT6jMUpkRqnB4wYIGYlQf
	 vj0asGTEzMOT6hJf59XjvyGN8rA2wn3hZyfTZsLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfDPLrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbfDPLrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7996420821;
        Tue, 16 Apr 2019 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415268;
        bh=BCNtmtnXSyauSW3OSwKnokYEzBhAlTALHeBzASg9ZA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yh9MB96QXlxcC7rxrZls89yHa2xpgn+hm2ZP00yLMNPBFoREPdxSbT5Y3v4SgHKF5
         XJWcgXem+VKVvOpe/kxQyT33dWpfiQAw0vm26DpFTI/l96rA2fgp8WJT/ANt8tk8TI
         sXC0gEHDgxtX+GIVr58e5gHlmpEb3EOSZgp5JeVc=
Date:   Tue, 16 Apr 2019 13:18:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Himadri Pandya <himadri18.07@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: replace symbolic permissions with octal
 permissions
Message-ID: <20190416111848.GA9823@kroah.com>
References: <20190410102848.12986-1-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410102848.12986-1-himadri18.07@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:58:48PM +0530, Himadri Pandya wrote:
> Resolve checkpatch warning for using symbolic permissions by replacing
> them with octal permissions.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> index 1d0eed66a7f4..28dc422d388c 100644
> --- a/drivers/staging/gasket/gasket_sysfs.h
> +++ b/drivers/staging/gasket/gasket_sysfs.h
> @@ -75,7 +75,7 @@ struct gasket_sysfs_attribute {
>  
>  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
>  	{                                                                      \
> -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> +		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
>  		.data.attr_type = _attr_type                                   \
>  	}

This has been rejected many times in the past as the real solution is to
use __ATTR_RO here.

thanks,

greg k-h

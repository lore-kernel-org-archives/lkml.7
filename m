Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF2C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C991204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558596145;
	bh=MgxRvVPRCiTGlpJ7u3mhvNbCKBa13fkTjRD8hITHO6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uzkgss0cbeuRt/d35irb6yEUFGxv6zfciubNjBlmApbl8yle3kdlnsjgrhdCMeAmT
	 S6vG0RxdDjeUsDjPcmcCLnWZEH2JFwmmeHE7aY1jt2wOyqojgMGmcGwPi9B2pk/kUr
	 lOnIiUhK/qBbi+qBK3DhZXtuhAbAZtwEA9wjFCDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfEWHWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:22:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACC4204EC;
        Thu, 23 May 2019 07:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596142;
        bh=MgxRvVPRCiTGlpJ7u3mhvNbCKBa13fkTjRD8hITHO6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0my/NfK77yM68KWwcJCV6hickLW+wqgNuvXwMNHKBRKG//R75yAzP8xwcQ/YO5mn
         h0vQOQoQ3+N9feBcYaEfCNckrZ7hCxY51D4OK2Rj+BNS2fWbdD/I1AP1g8cCVDQRyU
         z0eOM8AVOkhGNedqPmV+rZmxtO6OXBZwzrW3zIqM=
Date:   Thu, 23 May 2019 09:22:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove unnecessary variables
Message-ID: <20190523072220.GC24998@kroah.com>
References: <20190523063504.10530-1-nishka.dasgupta@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523063504.10530-1-nishka.dasgupta@yahoo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:05:01PM +0530, Nishka Dasgupta wrote:
> In the functions export_reset_0 and export_reset_1 in arcx-anybus.c,
> the only operation performed before return is passing the variable cd
> (which takes the value of a function call on one of the parameters) as
> argument to another function. Hence the variable cd can be removed.
> Issue found using Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishka.dasgupta@yahoo.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> index 2ecffa42e561..e245f940a5c4 100644
> --- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> +++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> @@ -87,16 +87,12 @@ static int anybuss_reset(struct controller_priv *cd,
>  
>  static void export_reset_0(struct device *dev, bool assert)
>  {
> -	struct controller_priv *cd = dev_get_drvdata(dev);
> -
> -	anybuss_reset(cd, 0, assert);
> +	anybuss_reset(dev_get_drvdata(dev), 0, assert);
>  }

While your patch is "correct", it's not the nicest thing.  The way the
code looks today is to make it obvious we are passing a pointer to a
struct controller_priv() into anybuss_reset().  But with your change, it
looks like we are passing any random void pointer to it.

So I'd prefer the original code please.

Also, you forgot to cc: Sven on this patch, please always use the output
of scripts/get_maintainer.pl.

thanks,

greg k-h

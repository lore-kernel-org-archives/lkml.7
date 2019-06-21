Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3018C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA212083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561125832;
	bh=bAd9RSgxnQbh9QhY94/GPs+DJutctfaBKOnc7qBa8NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aXI5vM3Zgtj3ohNtYk6V+BYytw95kvaOPgUjivPen6Dwk2YCqBiuvVfTg6gnQikce
	 pgZnehEslnxTe7LWNue6cg05rYKYUZ9XTSzvdCeksIMJrid7F2sE1JZ958QmTSh3Nf
	 FdmlxPdUOsfKP+Y+tgk61NmSy0GwjRgYNd0+7x+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFUODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUODv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:03:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891872075E;
        Fri, 21 Jun 2019 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561125830;
        bh=bAd9RSgxnQbh9QhY94/GPs+DJutctfaBKOnc7qBa8NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDdczVXpJtWEoP6wDxIKV62OkLkdOKzp7b65d/63pq1+/9RXSh0wFfARernJNZdhn
         gR0tEFJdNtDUsESalYHNwj3w2DCi5l1vGwo+Q7fBwZiIzooHgsbtIzKhqaTzBSCSH0
         U/7lr9DZb2mORFud5nZ0ap6wyq3LrhOddwOKuD7g=
Date:   Fri, 21 Jun 2019 16:03:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <20190621140347.GA7011@kroah.com>
References: <20190614094311.24024-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614094311.24024-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with the value -EINVAL however
> this value is never read and ret is being re-assigned later on. Hence
> the initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/lkdtm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index bba093224813..92df35fdeab0 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -390,7 +390,7 @@ static int __init lkdtm_module_init(void)
>  {
>  	struct crashpoint *crashpoint = NULL;
>  	const struct crashtype *crashtype = NULL;
> -	int ret = -EINVAL;
> +	int ret;
>  	int i;
>  
>  	/* Neither or both of these need to be set */
> -- 
> 2.20.1
> 

With this patch now applied, I get this build warning:
drivers/misc/lkdtm/core.c: In function lkdtm_module_init:
drivers/misc/lkdtm/core.c:467:9: warning: ret may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret;
         ^~~

So are you _sure_ it shouldn't be initialized?

thanks,

greg k-h

Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849AC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E4D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560188743;
	bh=iTsWKW80NMdI1sl6GMRAqcWlRjLeTmiHmWnxx8Wra+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oUWuPlAtyvm+Aud6iUFlgmEa7US6apZ170bH88flkwVJPnC9U2ONVeq1sRhhQMYEv
	 DK85/y2QRzjuJOEDK5aHwl8I7gIgswKgtRIrI4q5U/oixEXD9hGRISWvd0us/uE2BW
	 bjzrFCCFkpVwS3vqH8DPVcoRc/PcJuUPmAqh8+cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfFJRpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbfFJRpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:45:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCBC02082E;
        Mon, 10 Jun 2019 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560188741;
        bh=iTsWKW80NMdI1sl6GMRAqcWlRjLeTmiHmWnxx8Wra+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jshzf/WLHSR49+gRi5JpHR8ieW0RCb7o3tL2s/Qtl8SNwd93d76Ww07lTUifUmWMP
         2oa5YYaeIpCJ3H5lIEz+b0GmssK9fz3eY/ZajgFag0xkGGHlfKXkJXfpZMrap17awl
         Wtv6URezgXYyVBTp7CFtpf6UyajJ1hxL/jILpYpg=
Date:   Mon, 10 Jun 2019 19:45:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
Message-ID: <20190610174538.GA10617@kroah.com>
References: <20190604174412.13324-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604174412.13324-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:44:12AM +0900, Masahiro Yamada wrote:
> This function never attempts to allocate memory, so returning -ENOMEM
> looks weird to me. The reason of the failure is there is no more space
> in the given kobj_uevent_env structure.
> 
> No caller of this function relies on this functing returning a specific
> error code, so just change it to return -ENOSPC. The intended change,
> if any, is the error number displayed in log messages.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  lib/kobject_uevent.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7998affa45d4..5ffd44bf4aad 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
>   * @env: environment buffer structure
>   * @format: printf format for the key=value pair
>   *
> - * Returns 0 if environment variable was added successfully or -ENOMEM
> + * Returns 0 if environment variable was added successfully or -ENOSPC
>   * if no space was available.
>   */
>  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> @@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>  
>  	if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
>  		WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> -		return -ENOMEM;
> +		return -ENOSPC;

As Rafael says, changing this for no good reason is not a good idea,
sorry.  Let's live with it as-is unless you can show some place where
this specific error value is causing problems.

thanks,

greg k-h

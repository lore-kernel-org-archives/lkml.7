Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36613C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117F8217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PDzWNDJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfFTSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:16:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfFTSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:16:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so2102867pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VUfn1IOEl9rD06WsT02+mqNYFppRegXo3iWeR3nXox0=;
        b=PDzWNDJmo14cyT5iiWirFxCbttBGQcs6+m6znSmNqWkbpH9CQvnWemOOGcn8NzWSaY
         Me/Btlvf1i4v5Az6LCxb27WLi+/N2yWCGZM4+wHVmriX/AbDcLibJm2fqVPIUgxSzzjI
         LBIKQN7uIIL0XSbRDkSMx0ehxU1ZfnoZx0TaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VUfn1IOEl9rD06WsT02+mqNYFppRegXo3iWeR3nXox0=;
        b=n0GQoetK3QRviuhzEWDcuX/kaUn/v/Sy90XK7ftkfACQUAzKFtCAWT/5ohR5dHhXZr
         ZMiq9G99UtE/T41tK6RuEdAgqOqlmNzUWgKRwIu4YFJxMfd5V87hZH9D1+kVzlZfUKzY
         KpqXbxwOcHoenIugo26cesPnbe82Z650QkuqVHHDyjVydviD4leaXrOF5wLEqfyNHbqH
         RUsTT57d8MYSxD9TB34uXNkYFg4tVAW5XRYODl5c8VS5+t+g4zS6fX01n8LFOXMrCHj1
         d5+Ps5k5D29N+MpewmRHBqA/SJS1DWGwpOgX18JvgM3q3e1/GpA0VBJc1IHkKYYe7Ua4
         tKHw==
X-Gm-Message-State: APjAAAUSjlYRsG/PgsL/49euHDP9iB8y7oX/IK9GtFod63qNSld4DDBP
        ZiwjHdyQ/WnATHOlhcFRfIgY8w==
X-Google-Smtp-Source: APXvYqw79XlOckNLsRwzTUGfUfSvKWCIsmZtm9ZMQM+GdS+4jaUOmnAbOXIYsSXrzSkx6Fl0/HRCVA==
X-Received: by 2002:a17:90a:36a9:: with SMTP id t38mr990899pjb.19.1561054565839;
        Thu, 20 Jun 2019 11:16:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm147481pfw.97.2019.06.20.11.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 11:16:05 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:16:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: no need to check return value of debugfs_create
 functions
Message-ID: <201906201115.37C12233AB@keescook>
References: <20190612152033.GA17290@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612152033.GA17290@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:20:33PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks; applied to my for-next/pstore tree.

-Kees

> ---
>  fs/pstore/ftrace.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index b8a0931568f8..fd9468928bef 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -120,27 +120,13 @@ static struct dentry *pstore_ftrace_dir;
>  
>  void pstore_register_ftrace(void)
>  {
> -	struct dentry *file;
> -
>  	if (!psinfo->write)
>  		return;
>  
>  	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
> -	if (!pstore_ftrace_dir) {
> -		pr_err("%s: unable to create pstore directory\n", __func__);
> -		return;
> -	}
> -
> -	file = debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir,
> -				   NULL, &pstore_knob_fops);
> -	if (!file) {
> -		pr_err("%s: unable to create record_ftrace file\n", __func__);
> -		goto err_file;
> -	}
>  
> -	return;
> -err_file:
> -	debugfs_remove(pstore_ftrace_dir);
> +	debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir, NULL,
> +			    &pstore_knob_fops);
>  }
>  
>  void pstore_unregister_ftrace(void)
> -- 
> 2.22.0
> 

-- 
Kees Cook

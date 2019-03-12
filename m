Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E33CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BAD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4ngTZIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCLAHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:07:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36832 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:07:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so792988edi.3;
        Mon, 11 Mar 2019 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8tEF18obpwebhbJcolXJ0nMK1ingClUAVWsSzjRXx4=;
        b=P4ngTZIFileSEFNm4RsrkxXCXiF26PhEOluRXC9pPT/ChkPyYp7VYF4/7h6F0hXnhZ
         nbiSmUHGsvms9l1LBlwnH0aKSSZ2RO4MPV78fNZfYF/Wwqlh8BCTf1VqHI8YPOwxuhJa
         BPQGoFmkJzWKksFhWekVzI9nXyM3/oSMfPadwuSvdXuaur/3Gc6e1YG0ez1OQ9bUE3q+
         l0wOrMFB5rsv0Tyd98qNu/xXgyhA1mlnLHGz8KSCbelyZpKDbmSeiRrFQGoe+0Rq9jff
         KIc3Dvhhe9xLhp/GXihlNFdo9eWGbaoowvOPT9SfoOIykd4Zi1nYXNObgeXktabvIa72
         rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8tEF18obpwebhbJcolXJ0nMK1ingClUAVWsSzjRXx4=;
        b=ejhnI7zcl1lQCzVF8ssCOfYgOrFZYUX9d8IA+Lzh6mWy263iUsiBRXUvcS6pWzqad6
         fGfsw2lGMprOVnmVittK/h7c9QeuU+K9SkZKdCjq/Igp3NNC1tqy+jU7mYmXJEWywTeY
         Hk3uiYOQytWKq6tbo60MZVLXud5Aq61oy2BjolZKEfBgj2LLf7QRv7EBUEYp7H1Ua9xF
         pxyAVnuKzqe62L5eiVoQ77CnoyKGxJxzH1Nv44BeApAYxrxbaUjj2DPcHO4x0eDHM4tI
         H6MTbQu/llhpyFEneYQdktKT+JL3FnDIf7nBnwkn+gkITUbmEWUIh42K4Z3PbYK3hM9H
         k4wQ==
X-Gm-Message-State: APjAAAUEt5eXVS8iU3piMpQQ4sqTbVKAKInT0cbMljeMGiPu6ZxciqMh
        vJ/AsI5M/ldPU48SsnjHGYE=
X-Google-Smtp-Source: APXvYqximPiu8ahTKzkKussj/1/MEYQ6Yf8vquFycQ/jcU98pMUN01jb61fTIGoN4VGWR8fQBXaqaQ==
X-Received: by 2002:a50:92d0:: with SMTP id l16mr990563eda.153.1552349234929;
        Mon, 11 Mar 2019 17:07:14 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id t9sm5102888edb.13.2019.03.11.17.07.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 17:07:13 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:07:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ACPI / sysfs: Restructure get_status
Message-ID: <20190312000712.GA32298@archlinux-ryzen>
References: <20190307173802.3448-1-natechancellor@gmail.com>
 <1766077.IDCbULq7Lr@aspire.rjw.lan>
 <3133462.vhohJv2aGS@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3133462.vhohJv2aGS@aspire.rjw.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:56:27PM +0100, Rafael J. Wysocki wrote:
> On Monday, March 11, 2019 11:46:14 PM CET Rafael J. Wysocki wrote:
> > On Thursday, March 7, 2019 6:38:02 PM CET Nathan Chancellor wrote:
> > > When building with -Wsometimes-uninitialized, Clang warns:
> > > 
> > > drivers/acpi/sysfs.c:667:13: warning: variable 'result' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > > 
> > > Clang can't determine that all cases are covered by the two separate if
> > > statements. We could combine then to look like this:
> > > 
> > >     int result;
> > > 
> > >     if (...) {
> > >         ...
> > >     } else if {
> > >         ...
> > >     } else {
> > >         result -EINVAL;
> > >     }
> > > 
> > >     return result;
> > > 
> > > However, at that point, we can further simplify this function by only
> > > using result when absolutely needed and just direct returning the value
> > > of the function.
> > > 
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/388
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/acpi/sysfs.c | 13 ++++---------
> > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > > index 41324f0b1bee..6ed785cadad9 100644
> > > --- a/drivers/acpi/sysfs.c
> > > +++ b/drivers/acpi/sysfs.c
> > > @@ -651,23 +651,18 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
> > >  static int get_status(u32 index, acpi_event_status *status,
> > >  		      acpi_handle *handle)
> > >  {
> > > -	int result;
> > > -
> > > -	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> > > -		return -EINVAL;
> > > -
> > >  	if (index < num_gpes) {
> > > -		result = acpi_get_gpe_device(index, handle);
> > > +		int result = acpi_get_gpe_device(index, handle);
> > >  		if (result) {
> > >  			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
> > >  					"Invalid GPE 0x%x", index));
> > >  			return result;
> > >  		}
> > > -		result = acpi_get_gpe_status(*handle, index, status);
> > > +		return acpi_get_gpe_status(*handle, index, status);
> > >  	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> > 
> > In principle, it would suffice to replace the "else if (...)" with "else"
> > to fix the Clang warning AFAICS, but that's not the only issue with this
> > function.
> > 

Correct, that would be the simplest fix for the warning.

> > > -		result = acpi_get_event_status(index - num_gpes, status);
> > > +		return acpi_get_event_status(index - num_gpes, status);
> > >  
> > > -	return result;
> > > +	return -EINVAL;
> > >  }
> > >  
> > >  static ssize_t counter_show(struct kobject *kobj,
> > 
> > Namely, it confuses errno with acpi_status and may cause the latter to be
> > returned to user space in certain situations which should never be done.
> > 
> > So, I'd prefer to apply something like the (untested so far) patch below.
> 
> Actually, acpi_get_event_status() returns acpi_status too, so something like
> this rather:
> 
> ---
>  drivers/acpi/sysfs.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/acpi/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sysfs.c
> +++ linux-pm/drivers/acpi/sysfs.c
> @@ -648,26 +648,29 @@ static void acpi_global_event_handler(u3
>  	}
>  }
>  
> -static int get_status(u32 index, acpi_event_status *status,
> +static int get_status(u32 index, acpi_event_status *ret,
>  		      acpi_handle *handle)
>  {
> -	int result;
> +	acpi_status status;
>  
>  	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
>  		return -EINVAL;
>  
>  	if (index < num_gpes) {
> -		result = acpi_get_gpe_device(index, handle);
> -		if (result) {
> +		status = acpi_get_gpe_device(index, handle);
> +		if (ACPI_FAILURE(status)) {
>  			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
>  					"Invalid GPE 0x%x", index));
> -			return result;
> +			return -ENXIO;
>  		}
> -		result = acpi_get_gpe_status(*handle, index, status);
> -	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> -		result = acpi_get_event_status(index - num_gpes, status);
> +		status = acpi_get_gpe_status(*handle, index, ret);
> +	} else {
> +		status = acpi_get_event_status(index - num_gpes, ret);
> +	}
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
>  
> -	return result;
> +	return 0;
>  }
>  
>  static ssize_t counter_show(struct kobject *kobj,
> 

Seems reasonable. There are no warnings from this.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thank you for the reply and patch!

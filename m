Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B4C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D500A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4yIyei7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFVXzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:55:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36789 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:55:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so5437485pfl.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjQZBQwyRup4ZgjZsTGkIfrR8oSEkQFDWOMWBVdqA8o=;
        b=b4yIyei7kCqChIwyxRMK9L2ScXhNbiV5AdZTg09Edgu8KuQbWRTRVCYFKjoNewPdOz
         GGrNefQqTdQpIn4q+uEzPYYYwByaxqq37l9rrIWGR3STOs0jz+fmlDhNVpuLvmt3ZV8I
         JZAFPjyK43uqRTd+i/Z+dKZdF9+DE9UOgi7WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjQZBQwyRup4ZgjZsTGkIfrR8oSEkQFDWOMWBVdqA8o=;
        b=PpDqfaI8tUUoDwZKyUetNlYMU11EvUrSjDQ7tqvF/xOJhg5KKxcwEZ9FRHdDF2hrcD
         xEfLTeqamgkvhhYoYNYs/pggvCi9harCJ0fLatphHqIQehrIqJwdBJAL7hbc7KgarA3J
         wWeX6r7iR1uk50MYUhA6nbJyNlq1l6rFfAZwr1ZifmYCfKqodzEwIlwnTV/nLwoLKusn
         gAWHqIYRMJrqVbxuFg3IOxO8t9jwv3sx4s3fz7gv0+ziprWW9PcgmaLZE48UTnUm8dpt
         Egp298uB6kKf/2Peg++O4n12VMEhTNdlpb3gMTgvh/ZmL43EMt/Xwi+ZYyJvqI/JbKPc
         BA6w==
X-Gm-Message-State: APjAAAXo35cHWFGEffsALLZlMKlykN5nNgr8ClFfKshV9jGiLjgSTNUO
        fXtUYPkvTgHIncP1ymxZad4nFA==
X-Google-Smtp-Source: APXvYqwCftLX0UgaC1rEy9spKbtRqZLuHoR6VhCBTygFCd8hIqS2ssNtG3ogQusKUf+bck5JAubdiA==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr24581635pgb.93.1561247701888;
        Sat, 22 Jun 2019 16:55:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm14146254pjh.1.2019.06.22.16.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:55:01 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:55:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Subject: Re: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
Message-ID: <201906221654.99E7598@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-11-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-11-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:39PM -0700, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: rjw@rjwysocki.net
> Cc: pavel@ucw.cz
> cc: linux-pm@vger.kernel.org
> ---
>  include/linux/security.h     | 1 +
>  kernel/power/hibernate.c     | 3 ++-
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 00a31ab2e5ba..a051f21a1144 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -85,6 +85,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_DEV_MEM,
>  	LOCKDOWN_KEXEC,
> +	LOCKDOWN_HIBERNATION,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index abef759de7c8..3a9cb2d3da4a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -32,6 +32,7 @@
>  #include <linux/ctype.h>
>  #include <linux/genhd.h>
>  #include <linux/ktime.h>
> +#include <linux/security.h>
>  #include <trace/events/power.h>
>  
>  #include "power.h"
> @@ -70,7 +71,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
>  
>  bool hibernation_available(void)
>  {
> -	return (nohibernate == 0);
> +	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
>  }
>  
>  /**
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 08fcd8116db3..ce5b3da9bd09 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>  	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
> +	[LOCKDOWN_HIBERNATION] = "hibernation",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook

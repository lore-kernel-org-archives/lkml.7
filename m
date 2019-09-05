Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F303206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FGMHra+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfIEUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:53:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40259 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIEUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:53:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so2125517pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zC0/57npOmt+dOpZmEb/ZyaW4qHXbxDhalCy6UVFU7Q=;
        b=FGMHra+lvE2SSwC9Z/lkwAAeP8xs2E+lrrvEzwdjnfzAs4mh4ikvYacBY8OeByIBxe
         ym/15OYgVjRtw1BS0/EC1gmsg6Gf48I7OdX7eRuJvqOFApmBOrAnSd5Kq+n6zRGtzdx2
         6+h6s6DcXYIhFlvo1olIDgjzsHoGmKH9Srrgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zC0/57npOmt+dOpZmEb/ZyaW4qHXbxDhalCy6UVFU7Q=;
        b=DsBuJ1nnVdlsnBB91yzf0Hv4X1qJY1xKaOYrj53tq5HBJ/a9TIt6cKmEcD31VdweTi
         rSTJ7sL8AgTqIHj05ZfqFNwJms/uncV+yFw7Jtu+kiKXQK7j4ufYnyt7I05E5zrKVSAs
         PtmUckE+o0c5hSWumTsU9MyJ1N7E5bv6sGyWXn85M+4dx/y8dbThvjqXmR8qoeet/SRl
         fpv/0Bpbr1C6VTdSgY1rauZT4DNtmSnpuCC7Fwrr0O0Y+sfUHU2N6Da9rIe/C1igjxrJ
         i4iysJb5aSzmwOWNp4KYSUcZb3zxrpXIagxnoVKU6Vg0jZn1SROan8HAGwJvbLQNUP0m
         WhnQ==
X-Gm-Message-State: APjAAAVmmVY14IUA6Vb+EDiuLuqIh1pbNBHUcEXfNwq3XnrOuGUUOUyx
        mtn/4dFWdz0SsPk4Q/i6usbqcA==
X-Google-Smtp-Source: APXvYqzDDeOXKIhEbitMJqFPcWuGHxXdaazfPczjFoZEt+rWmSnZ7h55GJQB5jL/4cvjAtYY0/MxSA==
X-Received: by 2002:a17:90a:cb88:: with SMTP id a8mr5905991pju.111.1567716825766;
        Thu, 05 Sep 2019 13:53:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm3241807pfm.97.2019.09.05.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 13:53:45 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:53:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] rtl8192*: display ESSIDs using %pE
Message-ID: <201909051352.89D121A4@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:25PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Everywhere else in the kernel ESSIDs are printed using %pE, and I can't
> see why there should be an exception here.

I would expand this rationale slightly: using "n" here makes no sense
because they are already NUL-terminated strings. The "n" modifier could
only be used with string_escape_mem() which takes a "length" argument.

Regardless:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  drivers/staging/rtl8192e/rtllib.h              | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 2dd57e88276e..096254e422b3 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -2132,7 +2132,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
>  		return escaped;
>  	}
>  
> -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
>  	return escaped;
>  }
>  
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index d36963469015..3963a08b9eb2 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -2426,7 +2426,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
>  		return escaped;
>  	}
>  
> -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
>  	return escaped;
>  }
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook

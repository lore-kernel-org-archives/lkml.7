Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9062C48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8218E2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLCoWdQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFVXsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:48:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43210 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:48:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so5411408pfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lh0bykVQFvQflkOokSve4pshtQHLBmvnAZFm1p4jA6c=;
        b=GLCoWdQPNqLP7jC9lBJEDXfyIeqdR7aqTbk7x33CpSoVuPAPgl0DbubPyjI+2W+Mii
         Qd7amH/qTcG/+Z238gjmt3SaUnbUJHANMD0VEISMPFObriujKaIZ1MHUWesFkcDYbG9T
         szzis3rxVUVlC08Psjvccv5xp2HpffSAueRDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lh0bykVQFvQflkOokSve4pshtQHLBmvnAZFm1p4jA6c=;
        b=JxUwXM9hrVolADYZAZyI4mWxNcllp46UGxHx2i2pWPWEcMvQafAywzoBOv3Cv7t9Bk
         DpAIXjmWOBvAiSz372PSg+xl7GxWaE2oUt5GYPpSyyJpps3cNvSYJBtGXphytFJiYEta
         lMTkskRqcYiKjeES5zt9n5wu69stwRr905wJhn5CdzDy0LzpUp/gC4SvyhBkSDgsRVYQ
         WEkbKskKeD1BrYnouMDlbd8mKZ+ALFaLa60hwjaJS6eWk6D3V69+AzfJnAI+TMNXe7x1
         dnxZxdKjbMKysMT0n36bAdTYv+eD4CyH3jg7ROxJHXRb/32KmFCvULkv+N4AmD4ENsNf
         Xh1Q==
X-Gm-Message-State: APjAAAUFmOik6wzAXY2ogQ29IpWWnLxqTfEeMoP+wX4UtHCa9o5CWj4z
        s72pz/ai6nMJf0I14hJmEnfp2Q==
X-Google-Smtp-Source: APXvYqz/YGqSay35+ZDL2BdcLtDDiqJMjqj9CqoKrM6ZuWgSRgoAdzR27bWfzZV8zVRHDWBN5GH1gg==
X-Received: by 2002:a17:90a:32c7:: with SMTP id l65mr3440052pjb.1.1561247298707;
        Sat, 22 Jun 2019 16:48:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm6818221pff.128.2019.06.22.16.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:48:17 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:48:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH V34 04/29] Enforce module signatures if the kernel is
 locked down
Message-ID: <201906221647.181A170A1B@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-5-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:33PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> If the kernel is locked down, require that all modules have valid
> signatures that we can verify.
> 
> I have adjusted the errors generated:
> 
>  (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
>      ENOKEY), then:
> 
>      (a) If signatures are enforced then EKEYREJECTED is returned.
> 
>      (b) If there's no signature or we can't check it, but the kernel is
> 	 locked down then EPERM is returned (this is then consistent with
> 	 other lockdown cases).
> 
>  (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
>      the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
>      return the error we got.
> 
> Note that the X.509 code doesn't check for key expiry as the RTC might not
> be valid or might not have been transferred to the kernel's clock yet.
> 
>  [Modified by Matthew Garrett to remove the IMA integration. This will
>   be replaced with integration with the IMA architecture policy
>   patchset.]
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---
>  include/linux/security.h     |  1 +
>  kernel/module.c              | 38 +++++++++++++++++++++++++++++-------
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c808d344ec75..46d85cd63b06 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -82,6 +82,7 @@ enum lsm_event {
>   */
>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
> +	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/module.c b/kernel/module.c
> index 0b9aa8ab89f0..6aa681edd660 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2763,8 +2763,9 @@ static inline void kmemleak_load_module(const struct module *mod,
>  #ifdef CONFIG_MODULE_SIG
>  static int module_sig_check(struct load_info *info, int flags)
>  {
> -	int err = -ENOKEY;
> +	int ret, err = -ENODATA;
>  	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +	const char *reason;
>  	const void *mod = info->hdr;
>  
>  	/*
> @@ -2779,16 +2780,39 @@ static int module_sig_check(struct load_info *info, int flags)
>  		err = mod_verify_sig(mod, info);
>  	}
>  
> -	if (!err) {
> +	switch (err) {
> +	case 0:
>  		info->sig_ok = true;
>  		return 0;
> -	}
>  
> -	/* Not having a signature is only an error if we're strict. */
> -	if (err == -ENOKEY && !is_module_sig_enforced())
> -		err = 0;
> +		/* We don't permit modules to be loaded into trusted kernels
> +		 * without a valid signature on them, but if we're not
> +		 * enforcing, certain errors are non-fatal.
> +		 */
> +	case -ENODATA:
> +		reason = "Loading of unsigned module";
> +		goto decide;
> +	case -ENOPKG:
> +		reason = "Loading of module with unsupported crypto";
> +		goto decide;
> +	case -ENOKEY:
> +		reason = "Loading of module with unavailable key";
> +	decide:
> +		if (is_module_sig_enforced()) {
> +			pr_notice("%s is rejected\n", reason);
> +			return -EKEYREJECTED;
> +		}
>  
> -	return err;
> +		ret = security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +		return ret;

return security_locked_down(LOCKDOWN_MODULE_SIGNATURE); ? Means no need
to add "ret". Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> +
> +		/* All other errors are fatal, including nomem, unparseable
> +		 * signatures and signature check failures - even if signatures
> +		 * aren't required.
> +		 */
> +	default:
> +		return err;
> +	}
>  }
>  #else /* !CONFIG_MODULE_SIG */
>  static int module_sig_check(struct load_info *info, int flags)
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 8e39b36b8f33..25a3a5b0aa9c 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
>  
>  static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
> +	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook

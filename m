Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1438BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90DA208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1lSnOGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfJJUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:50:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:50:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so4658866pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQ6pH3t2+nQt0O+s8wT+9M4vXr25VmlPpLaWlsXlGXw=;
        b=d1lSnOGsbxK8JQPtiK7qB8XjTUXyl3oZz+s8gWdvArdeQuGrhSWrxxVqhQaVZBHuud
         OQyyQYDuEBbtwKcKBVqfp+qsiH2x8KRVreXYUk48jLnU5BN6r3xnmwO9u/4OTKtpntyU
         H2B5wUC8P4hHUCa+CewEc4rfGooEB4AiSwDZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQ6pH3t2+nQt0O+s8wT+9M4vXr25VmlPpLaWlsXlGXw=;
        b=rvCfq7mMiaCIgFOh6VzCCM6v1t+Nu8+18qk76UpE7Os1janoQ01NtUDgEn892VGsLF
         LbVe4LpHMXvLrnxrU2cOeZIkd4GhSZlSi5H5YSbdkJblPV1D4nnMC/B3E7w+Sejwinju
         iGLblEVJOoRFbjen4ZzI99UdGArdRa7TRSvG/LNBLyHFOVR6dAtBLw5Pc0Fap2HOJrTM
         h7DSdS0fR1gk1BALBERSMQZBGw/olMKVsHSym7ugiCSY5VT5ZjyCSjMNbLy0SqFty/Gb
         kr2L2K7LmtutZkV0fkCAlmj8g2DEwI4dDSjkF889xgLlZKHx1WRwWONKF+X5lPsDGGGX
         U+HQ==
X-Gm-Message-State: APjAAAWBgO+kh/7fbfNJR555t01EGLF4fVeBtLaWEyq+CaXMQAjDmUgg
        RZOvUicWmhhf9yOhr3CmIX+waA==
X-Google-Smtp-Source: APXvYqzpd8lfsXXWfCE6lVUPbLfAoxclgHEQWIzIhep8aHnHrUFaDd4gioUzPGIfQtiMPEUJP+74dg==
X-Received: by 2002:a63:5fd0:: with SMTP id t199mr12988146pgb.369.1570740642047;
        Thu, 10 Oct 2019 13:50:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm5684711pjs.9.2019.10.10.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:50:41 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:50:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 10/10] drivers/lkdtm: Remove references to
 CONFIG_REFCOUNT_FULL
Message-ID: <201910101350.FD2B60A5A@keescook>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-11-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007154703.5574-11-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:47:03PM +0100, Will Deacon wrote:
> CONFIG_REFCOUNT_FULL no longer exists, so remove all references to it.

Same thing: I think this can be collapsed into patch 8.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/misc/lkdtm/refcount.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
> index abf3b7c1f686..de7c5ab528d9 100644
> --- a/drivers/misc/lkdtm/refcount.c
> +++ b/drivers/misc/lkdtm/refcount.c
> @@ -119,7 +119,7 @@ void lkdtm_REFCOUNT_DEC_ZERO(void)
>  static void check_negative(refcount_t *ref, int start)
>  {
>  	/*
> -	 * CONFIG_REFCOUNT_FULL refuses to move a refcount at all on an
> +	 * refcount_t refuses to move a refcount at all on an
>  	 * over-sub, so we have to track our starting position instead of
>  	 * looking only at zero-pinning.
>  	 */
> @@ -202,7 +202,6 @@ static void check_from_zero(refcount_t *ref)
>  
>  /*
>   * A refcount_inc() from zero should pin to zero or saturate and may WARN.
> - * Only CONFIG_REFCOUNT_FULL provides this protection currently.
>   */
>  void lkdtm_REFCOUNT_INC_ZERO(void)
>  {
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook

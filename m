Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E5EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11464206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEbudfEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbfIEVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:17:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44737 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIEVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:17:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so2141022pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UIRtWL98QY7LQCCdEU+L5v6PUGcyGbsiZsUBWNy9eQ4=;
        b=eEbudfEF6neRn1gT0xh0aAkTpqGoCMlJB9O5rTKm9acSrTEXdKWtPk33cPifM5g6k3
         GZbq5NnlA807jkM3lQuO9Z/QaxJ3QeCEx+/crZSI9REJn7aBcIttEuhV7fA3wYqibDgv
         FMiXA6sqfjLYieHp21VQRbWSOvw4ffDdIkLcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UIRtWL98QY7LQCCdEU+L5v6PUGcyGbsiZsUBWNy9eQ4=;
        b=DZNBNOVPUzjF2jRbYsySBG6U+dEElw5rubQMou69BKR5/idVH0pKmdP05v3cOL54Ok
         qubSIt/K1aARYyoiqzHkbAZUHFmNUd4iO7gOT/z1hHXw+a6WMVC81rGwKBrWssqBTiZ8
         z9vzpBjefuB73ccgmjerawqu6JILvlNvQahkKgwAGJZSd7Q8spqKiR7h0BgSELhBR6zZ
         /apiXn66bffopSIV6tjSmZu6DYT18bh/pLOGqygtCIY7+PzGpjNRv87/p6C9Kw0V30r0
         AaLcv8K7ctn3jIEJc/lSH3Dyk/IRHeMaingdYoKLUFbAWZ88tPf6gCR11E+5Uf0Lsp5u
         lTpA==
X-Gm-Message-State: APjAAAVqQU+ViTpX7ePTHM6PSxqq+fIZZ0XM5DW3Uj6ls4r6DKC5nzgF
        TwsDWkiey1rBohUNS+X7a0XdntVr/4I=
X-Google-Smtp-Source: APXvYqxil/9JhgnFLSMY7nNDIRI9VhMzTmtcNzIddNIVEdT7r8hU3805QipX3phx57LusXkxX2j82w==
X-Received: by 2002:a65:6415:: with SMTP id a21mr4791629pgv.98.1567718232797;
        Thu, 05 Sep 2019 14:17:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm3598106pfm.157.2019.09.05.14.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 14:17:11 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:17:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] thunderbolt: show key using %*s not %*pE
Message-ID: <201909051416.973A701E@keescook>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-2-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-2-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:26PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> %*pEp (without "h" or "o") is a no-op.  This string could contain
> arbitrary (non-NULL) characters, so we do want escaping.  Use %*pE like
> every other caller.

Agreed on all counts. pEp is actively resulting in NO escaping, which is
a bug here.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  drivers/thunderbolt/xdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> index 5118d46702d5..4e17a7c7bf0a 100644
> --- a/drivers/thunderbolt/xdomain.c
> +++ b/drivers/thunderbolt/xdomain.c
> @@ -636,7 +636,7 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
>  	 * It should be null terminated but anything else is pretty much
>  	 * allowed.
>  	 */
> -	return sprintf(buf, "%*pEp\n", (int)strlen(svc->key), svc->key);
> +	return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);
>  }
>  static DEVICE_ATTR_RO(key);
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook

Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B16C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52720840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T58x2tWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfDBGTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:19:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBGTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:19:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so6024280pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8gu7tF2H48PC2ZU6ArYdszsIEmwGQ0GUmf+KduUzoZk=;
        b=T58x2tWIz7djUKa6qFfmmNwlJpDem22xewk3c7B+/P15yw1gMelvYKv0BhaEP11/2h
         UfDE/dpdN/RlPnyNy4onkE9I9vg2Lm1lhTTtW889ZC+SWvO1v6/eUOdC4w05q86Kb4jq
         bAMx7M5BYtscdtJKttEElAj5QjNH3cONg9exYrk35K0kahdXsPLL/RZrYKFzgzBFnrG4
         he56MLVIiCf17ipo/tACYg3KdyTF/YqEyfTsDK8wFxvCtqL6dOQkh2B/Uoaz2LKK7bMK
         crUmNYgs1QvX92apVt06gMrT1D1FhmSFyQjwHEkYMAb+TzZby2d21LHmIDxCGk/3YLYo
         bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8gu7tF2H48PC2ZU6ArYdszsIEmwGQ0GUmf+KduUzoZk=;
        b=QsHii+yOdzatFs29Ehi2Tvu/Ky4vvFNMvwM0fx2KJCzp60kKeuHPHvg9s40H10Egjg
         giH9L/dsCOGEAN/biVr1jC1JldCDChTcmhJYVOmVWFDFhnaz34ksG0l3vcuOLi2Proj0
         xsVvEevVRGKhwzwJrtpvFdBi3EQeMc90VCT6Rls/d2xw9hRllFHLjwQOAb1irHCd99UT
         zNjAKILA+Mg3NoSqUQr236+m0rOLO+7i7CkDD5aRDDCGuPLdODqGUNLVECj4B2WPhQKK
         4jDg0NNGE0k1lqVzExv1lV+KZ8Q2HQ6VDQZcwBg4mlEe/qtYvGed2JoX8dTL50lGKhS4
         uc5w==
X-Gm-Message-State: APjAAAWo+UugKmseamzJEid6713yYp3wzfEkviMhFK9zK774wQkPG3QO
        zQ6ql9EV9BcQjEcOl0GrYBungw==
X-Google-Smtp-Source: APXvYqzV9wfLFBCAIXItC/MgwNRXUCQYRDy8aZ1pbbDWr5dblaqZ7TYkAIxp6qy3kdoxEP64lmtNpg==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr5737267pgr.360.1554185971267;
        Mon, 01 Apr 2019 23:19:31 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u4sm38474534pgn.12.2019.04.01.23.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:19:30 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:19:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
Subject: Re: [PATCH 1/4] Add support for SUNIX Multi-I/O board
Message-ID: <20190402061925.GU4187@dell>
References: <20190319120723.3691-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319120723.3691-1-saumah@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019, Morris Ku wrote:

> Add Kconfig and Makefile entry.
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  mfd/Kconfig  | 5 +++++
>  mfd/Makefile | 2 ++
>  2 files changed, 7 insertions(+)

Can you send this set again please.  There are some basic issues with
it, which would make reviewing difficult.

Please use `git format-patch` and `git send-email` to create and
submit your patches.  Use the following flags; --annotate, --compose
and --thread to ensure the patches are sent a) pinned to each other so
they do not become spread throughout people's inboxes and b) a cover
letter is provided which should contain a summary of what you are
trying to achieve.

The diff should be based from the root directory, not 'drivers', such
that the diff should read "drivers/mfd/*".

> diff --git a/mfd/Kconfig b/mfd/Kconfig
> index 76f9909c..efbb3ef1 100644
> --- a/mfd/Kconfig
> +++ b/mfd/Kconfig
> @@ -1916,5 +1916,10 @@ config RAVE_SP_CORE
>  	  Select this to get support for the Supervisory Processor
>  	  device found on several devices in RAVE line of hardware.
>  
> +config SUNIX
> +	tristate "SUNIX Multi-I/O Board Driver"
> +	help
> +	  Support for SUNIX Multi-I/O controller.
> +
>  endmenu
>  endif
> diff --git a/mfd/Makefile b/mfd/Makefile
> index 12980a4a..b70f44de 100644
> --- a/mfd/Makefile
> +++ b/mfd/Makefile
> @@ -241,4 +241,6 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>  obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> +obj-$(CONFIG_SUNIX)	+= sunix/
> +
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA326C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741452189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O3+Y3ZW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfH1U3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:29:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41177 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfH1U32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:29:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so505261pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yateJugCPSF8njDi9fdr5h/+mPhX4yUVZiaRVX6sSbM=;
        b=O3+Y3ZW+pgmTbbfbLjgxYPi/pQLhcWgGZnQr+PwTH/4ruGATMCcXXygSrz9Hr1y5rI
         kwkJ9ymED64fWBTG92mv3n1w09SojuCDnylNbuI8C0+QKgzIUA+c26fWvkaxlGLt2oJS
         4OMBrQQeeEjaMq4X3C5yxKImhltMptEW26RKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yateJugCPSF8njDi9fdr5h/+mPhX4yUVZiaRVX6sSbM=;
        b=MtTHsp0xh/FODXn6eYyoOL+ZPs1v0u0E4Qb45IuqaIiB8yBWlSwJYhkK6ecEgqD0Xa
         FtXvoeZNRwMBQKG/t0gK7EFLSdXjWGAMxXlI+blDJxRQ9r+RMcc/fa38TpBFsghxqWTM
         hGj9bjQ4wyl2IudzujBlkVakaTZm2xbxHK2Zle9Hp4t6UP3CNMkrcRRU91EWmmP5hGFH
         eW/lGY8NCLHBbaMlzejxUrqeYeJAaXiZq6UBPX2qPqA3X3vNssPA8+Px3b2VU3o9I7ve
         PjhZciU8S//PGkCNj79oiYG2FaS/uNQmTdlGchz+RamMsJtosXUHyfVJa7T9eSNKwOvt
         emag==
X-Gm-Message-State: APjAAAWs5/EZlTVcHpk78f9r0OI2jXerR0wIPD345cfAN2AE09w01xN3
        j0at/BwYqKdF9XOK8eINq/cvjQ==
X-Google-Smtp-Source: APXvYqy2pTTJ+b5oIPerAwtfnu+s6rduaT5ag5DYpiV5bmoUjYzdCreWp897PRFv/0BWknZ2B5qcyA==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr4998106pgl.420.1567024167722;
        Wed, 28 Aug 2019 13:29:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm42911pgf.55.2019.08.28.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:29:26 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:29:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK
Message-ID: <201908281328.EF648562@keescook>
References: <20190827173619.170065-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827173619.170065-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:36:19AM -0600, Raul E Rangel wrote:
> lkdtm/bugs.c:94:2: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
>   pr_info("Calling function with %d frame size to depth %d ...\n",
>   ^
> THREAD_SIZE is defined as a unsigned long, cast CONFIG_FRAME_WARN to
> unsigned long as well.
> 
> Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Thanks for the update! (Greg, can you take this instead?)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
> Changes in v2:
> - Correctly cast CONFIG_FRAME_WARN so the type is consistent.
> 
>  drivers/misc/lkdtm/bugs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 1606658b9b7e..24245ccdba72 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -22,7 +22,7 @@ struct lkdtm_list {
>   * recurse past the end of THREAD_SIZE by default.
>   */
>  #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
> -#define REC_STACK_SIZE (CONFIG_FRAME_WARN / 2)
> +#define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
>  #else
>  #define REC_STACK_SIZE (THREAD_SIZE / 8)
>  #endif
> @@ -91,7 +91,7 @@ void lkdtm_LOOP(void)
>  
>  void lkdtm_EXHAUST_STACK(void)
>  {
> -	pr_info("Calling function with %d frame size to depth %d ...\n",
> +	pr_info("Calling function with %lu frame size to depth %d ...\n",
>  		REC_STACK_SIZE, recur_count);
>  	recursive_loop(recur_count);
>  	pr_info("FAIL: survived without exhausting stack?!\n");
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 

-- 
Kees Cook

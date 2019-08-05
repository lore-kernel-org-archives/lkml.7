Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD020C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LiShrSwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfHEUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:18:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35269 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:18:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so5021741pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnMFby6cuMGYKUzIgGV11jAhA9K8cooCmYdmv8dL38I=;
        b=LiShrSwdcJpHceuBpSDfF+8pv9O7akLw1+A5ugFbC6pxOsHvP7HsCixegf9LvvhIQk
         F641xHQC0ZSmuxurQksXXlPdfVdCh5V9vx4ummJlmFcmL4qr/apVxpvNwsxTvF3ae35E
         e9F3d6V7cA753k7mqlbxuF88LJmLKSteiN9e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnMFby6cuMGYKUzIgGV11jAhA9K8cooCmYdmv8dL38I=;
        b=E5U1e8ocmv1gNAqEAztk2xvigBi4E+a0FWnY2YLuHcsZPkmMAqiKCMX3XGBVWRhk0p
         m4jjGeTej9BATCRH3qNPBZ1a6upHMRxSWKf+9C7tagRAn9b+GflsGELJh7+5F488vnfn
         AnzRZTVN6EUG7Z0VvcaiYaDwWklVrNSLRpNUibKvg/qjZH/2v3HY55tBPKEv5JPLA8aX
         uyhdb1q1iptkJqLVZrjOBO9da6TlkxNBj5r8Clt4bk2G0/Oykk1homWTTFBO7FMwGzf+
         9DC0JuXgNbTlBjmOqE7Maq++fs1n4iKi/hdp3GIo3YAHleuEOjLFC7fwrouThWUDNoOc
         /j/Q==
X-Gm-Message-State: APjAAAVoUkoxfjAvUoHeAIkp80AVxdEZQFqZEkYDI/LJguz8xxPqxz6s
        NpOscoztJZnCpUnRy7ZqiKBQig==
X-Google-Smtp-Source: APXvYqweLun+wrNksbm9Lbw7Q9yPpj9rLg5VuTi3f6zYmIoFGAGK7AIaAoVvqPNPgbhrpN5vJumUpA==
X-Received: by 2002:a17:90a:bf92:: with SMTP id d18mr20458772pjs.128.1565036296585;
        Mon, 05 Aug 2019 13:18:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7sm15233198pjq.15.2019.08.05.13.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:18:15 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:18:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARC: unwind: Mark expected switch fall-throughs
Message-ID: <201908051318.5B1EB8106@keescook>
References: <20190805193232.GA12826@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805193232.GA12826@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:32:32PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: haps_hs_defconfig arc):
> 
> arch/arc/kernel/unwind.c:827:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arc/kernel/unwind.c:836:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arc/kernel/unwind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index c2663fce7f6c..445e4d702f43 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -826,7 +826,7 @@ static int processCFI(const u8 *start, const u8 *end, unsigned long targetLoc,
>  			case DW_CFA_def_cfa:
>  				state->cfa.reg = get_uleb128(&ptr.p8, end);
>  				unw_debug("cfa_def_cfa: r%lu ", state->cfa.reg);
> -				/*nobreak*/
> +				/* fall through */
>  			case DW_CFA_def_cfa_offset:
>  				state->cfa.offs = get_uleb128(&ptr.p8, end);
>  				unw_debug("cfa_def_cfa_offset: 0x%lx ",
> @@ -834,7 +834,7 @@ static int processCFI(const u8 *start, const u8 *end, unsigned long targetLoc,
>  				break;
>  			case DW_CFA_def_cfa_sf:
>  				state->cfa.reg = get_uleb128(&ptr.p8, end);
> -				/*nobreak */
> +				/* fall through */
>  			case DW_CFA_def_cfa_offset_sf:
>  				state->cfa.offs = get_sleb128(&ptr.p8, end)
>  				    * state->dataAlign;
> -- 
> 2.22.0
> 

-- 
Kees Cook

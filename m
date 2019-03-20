Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B3820850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0SRsq/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCTTLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:11:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43545 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:11:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id m35so2940459ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mwcvuXQc2Zy4FWiwaPp8T82t32CWbPyz9MfQQvjfrco=;
        b=l0SRsq/NhQTRYl20LmqsSzTUzVIawGy0JqG4FDemOFYxNHXIwqIXsJJvO8etvlefRJ
         0j0sw4fUGy10j86Y+PgoBC7w9RGDdhIAVyBdYNGB5GkpPkCfVIcDvDNJL4DZ9ovsLQel
         /vjPsajWoVOn/bGqy0Wso06sqsAnzEH+jCnssWJUdR4Gh8bHO9FbTTZHTdXOFNUgktZK
         JDoK/ZUecTvpfRvXq5TySy45VogVlcwfn/vhEC1chZaX47L4hxK5NN5omJSt5psZkKDU
         lrqMKHBiK1clpxDoxroMhGt50ZbOs7cGRgCBDThk+hdur6j1X2CGhPmdqn126/92sIM7
         PZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mwcvuXQc2Zy4FWiwaPp8T82t32CWbPyz9MfQQvjfrco=;
        b=qvdMnZ3e9QOLT1ZPEbJHyerFb1tmZuh9ENlX758YCH9s0JWlCVsF2ZZUsbuyhCdzJq
         wuO3XTqmp0h7Lb2kexz0o1Uej/0DcUO4NMcrZUl54kIN7X1E4DZIv64vMs3Gn0atHp87
         +xbCE7qKuxZs1jfofozbBKy8gDuMJGi6RyjgcMxsdRAXWYZyPQaThqJ3Z4LyZAbIWETW
         g57m4WFM+j8VqfmGCsRSAPY0VryzDYN8/7N4j02HArwD5XmTTvckyGdW/HB1IfJCxtnU
         MwnJe98UFmH7iRhkFOqy1cX3sLeHQXsw9dwQOlOnuwTRAQnct36YkpkVIc1gR7XazrON
         bHOA==
X-Gm-Message-State: APjAAAVNgzsXWC8bXvjnjUOWxlFQGVooIVrE7NlrPM0v4LlXN3FlsZPJ
        V27V/zD2/dJRR2hYjsasqsg=
X-Google-Smtp-Source: APXvYqxq+YIMPp6D4M8uApHdiQH0o8EeFLXWOFq2HVRWaUp8NRKiKZCUrY1dLGPi5BucDc3Biv4dCA==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr9099535edv.274.1553109080843;
        Wed, 20 Mar 2019 12:11:20 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l15sm572644ejn.77.2019.03.20.12.11.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 12:11:20 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:11:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] soc: mediatek: pwrap: Zero initialize rdata in
 pwrap_init_cipher
Message-ID: <20190320191118.GE28744@archlinux-ryzen>
References: <20190307225650.23001-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307225650.23001-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:56:51PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/soc/mediatek/mtk-pmic-wrap.c:1358:6: error: variable 'rdata' is
> used uninitialized whenever '||' condition is true
> [-Werror,-Wsometimes-uninitialized]
> 
> If pwrap_write returns non-zero, pwrap_read will not be called to
> initialize rdata, meaning that we will use some random uninitialized
> stack value in our print statement. Zero initialize rdata in case this
> happens.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/401
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> I don't know if this is better or to just restructure the if statement
> below (I'm not an expert in this code so I'll leave that up to the
> maintainers to decide).
> 
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 8236a6c87e19..2f632e8790f7 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1281,7 +1281,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
>  static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  {
>  	int ret;
> -	u32 rdata;
> +	u32 rdata = 0;
>  
>  	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
>  	pwrap_writel(wrp, 0x0, PWRAP_CIPHER_SWRST);
> -- 
> 2.21.0
> 

Gentle ping (if there was a response to this, I didn't receive it). I
know I sent it in the middle of a merge window so I get if it slipped
through the cracks.

Thanks,
Nathan

Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EECC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6005A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsjFuiT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfF0Nsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:48:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33757 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Nsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:48:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so7135982wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wE1PAp4MHXALqCCVusUAqoCtyEzbEOvw3nFbp39o+9U=;
        b=RsjFuiT9rMad5Q9PIoyVIM7BSFrPdPoqZnQzdHKlydHUP69gx1nq9MYzIiacZkcPmh
         Zn7CdU/0HbeBV6hglksqYyijhTbIdorSrlmwOv1qEhc+XDMMGklFdzvPgtuNcwTYFj+W
         hDTngUkvknNqed6xqDLnvymmPtU30R81sTFgoPzoxhxH9AYkx5DRBaTlzH586IhoEq7G
         bpIBmLWFep8yNlqxGRmQdxojJT6PJIXgLF52KQJmcWB4j5LDMVHSwsc3iImEkP4QBCs0
         jLjAR3GQInnyuEsKDZyvsaKysSPDgsjqFMSjsFUiQnwA73v5fkoEtoA/O94/x0PfOTrZ
         b2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wE1PAp4MHXALqCCVusUAqoCtyEzbEOvw3nFbp39o+9U=;
        b=NIupxM+0StL5h0iWr0b1Qpj0ax3JAMpQ9EgHeTRFHKfqGhfceZXZqPxvxj+QU5zy4r
         hxs5OSF6UuvDAlgSTa9X1HGsQ41FAMXhxkj59+9xEN+fZ4Zbi03KgoBuOpijqPn9L1i/
         XoHvQBYTjsQSEeufyS/C8bvJKVs01uWFGL/nFEN4Sxb/lNYSI9gNuU/aW4S1U5YIxsHM
         2Nb/PunNRrERUvI+XFyFje2C/io4LqUV1TmWTgYJuP7S5AaifYl5+3ImPVr1aASQyUu6
         +ARSif3guS1YfXH2Vzu6Or+1uDpbEG2juaJU/LAFRemjpdg6VY0PqJrgsgPaQzRnG7l6
         6r/A==
X-Gm-Message-State: APjAAAW7/bCgir1PLd+555IrcRKWhd8s+noIzg21c1Hk5hvMgzzXD+1j
        rnxJb42WvcaHOsu2I1Gc2WlE2g==
X-Google-Smtp-Source: APXvYqy6pxzkEm1GFr8Ojt5atRppKQODIgFO8CkGNkxitxJs+DxYnmKnRFL/jbGBUXzzRgTMpdVwpQ==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr3364766wmb.19.1561643310573;
        Thu, 27 Jun 2019 06:48:30 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id s188sm6942557wmf.40.2019.06.27.06.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:48:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:48:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd: hi655x-pmic: Fix missing return value check
 for devm_regmap_init_mmio_clk
Message-ID: <20190627134828.GH2000@dell>
References: <20190626133007.591-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626133007.591-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Axel Lin wrote:

> Since devm_regmap_init_mmio_clk can fail, add return value checking.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Chen Feng <puck.chen@hisilicon.com>
> ---
> This was sent on https://lkml.org/lkml/2019/3/6/904
> 
>  drivers/mfd/hi655x-pmic.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

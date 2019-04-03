Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A70C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021C21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6gYcTAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDCHia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:38:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45114 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:38:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so7860402pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bwZEAU+yFxhm2H2aMollO1wnI7VEpqtENFneXRhtryE=;
        b=j6gYcTAORkwBlBras89o6VQu2uFUVtKT/rYPB1xGe3Vcz8GS463n1QEGvJDJ0XMJUM
         E9JiTX1bGEkY10IWtSDa4xkvG5b7ccFzqecEgamXPCAcqGAk94Bu8q6qKEMjvWTC62oY
         F+Csqd2SQQA5NQU4uLVMopVZMEOexQOC17KNbQFZYPH3guEZdUHSy5v+82EAsFaud0cX
         kHI4CoEtV/d2UgGzQ80UtcWF6eRaK2IdIroSJk50/TpbGm18fAKee/uMhDhEL+m1fgp/
         eLkgxugNNNXAeK7v0REerGhsJZHHPK8y1mX2GFSwfOXnLMu/M6w2JObe1U35mbAHz+Ib
         PI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bwZEAU+yFxhm2H2aMollO1wnI7VEpqtENFneXRhtryE=;
        b=BRy/Gs6iPJo8j3dbzLU2vBdLAJprFHiXSso/cvTwC6YGRVB/pCKAESCCj4Wet7579L
         NntH1Eboj26Gzxqt7fYjgYrbPW2yEuv5syKI+QpWYkMUZ5jwULVf8Wt8cHPUT7mY5Ryr
         lGXtuES/WJdzIguowjd2F/pwy0qa7ll+jm60Ile5xP3zlaOCiJTRzP+Q1thZsLEFD3yO
         2cayHlubJaiXNiKSyhucbK9O9syogVSYZ8uljLG/31W9kbg50+TWyIvl9hQSl4JIQHNt
         KJa6FacP/P9TQz2EofqqeOu8NPsFs99yhoNWoemp7o78CYKubTSqSHN3UcXrWZyZnA75
         XxIA==
X-Gm-Message-State: APjAAAXn2IxV1jc3N9Adw2iyjGRxL5v5enJTRwJvZWbOlr5vxnaYLH/7
        gsgkBIkeXMj0PAm02PwGOwiZQzrug9GbCQ==
X-Google-Smtp-Source: APXvYqy2oGs1XoFfN6ZEt5Des+nREmdsgJ69yWUoGTvXWGzrdZEyKCuUYZf5u7xC6pjk+evsW3YP/A==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr68329163pfm.179.1554277109072;
        Wed, 03 Apr 2019 00:38:29 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id b7sm46913185pfj.67.2019.04.03.00.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:38:28 -0700 (PDT)
Date:   Wed, 3 Apr 2019 08:38:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: Allow to compile with COMPILE_TEST
Message-ID: <20190403073824.GB11301@dell>
References: <20190322091650.5189-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322091650.5189-1-maxime.ripard@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019, Maxime Ripard wrote:

> Since this driver only has a dependency on ARCH_SUNXI just because it
> doesn't make any sense to run it on something else, we can definitely
> enable it through COMPILE_TEST as well to get some build coverage.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

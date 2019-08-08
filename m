Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5AEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F832187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdjZsTf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfHHHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:32:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43352 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbfHHHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:32:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so19260217wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3YWeeONpn3kFjgXjqVxK5rhO6iGNIdqgi9iiTkhqk4E=;
        b=hdjZsTf2RU0z/QEpg484A2Q/YkuXiyYQ6hG9jchmH3l2BIEbmVV7VnSY4qWhfC0Qw+
         CH9gle7f4Yb/X+Wzp4ptf8K0O6elLfRPsW6jhDx6DFKOt9qEJkZKUbEMng+BDXP6uMxC
         gq8dhtGkfhFnI3NMle5AFR33QIOQ//qfNagulljPJ4dXvODvPeTzmJDoaYcwyOSjxx/K
         Go9Vk4o8iIQ+mV/SoBUcqqHodSl7Gzyqe5mT+58s7wvqWSYuWB9EJ+YXuReHUH8lTg+S
         /r+7H15N1Zn2WdEMbGqiwHEIelD5AkIc1pbAJ59iLX7Sy8VekZCT/RQReK98f0pStNHD
         YUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3YWeeONpn3kFjgXjqVxK5rhO6iGNIdqgi9iiTkhqk4E=;
        b=c5FcZtHWGEnE2I/KEcVeAaEN4MEa2dM2iiOqBmS1mt4gp7oL9Ddrybru/uh1Z5vZmP
         /3CQrnDjOcFsM3FeVa411yj4ljpkVK4UtrSezak4DmcHQdCl+n657//2kBZjgZS9ekLX
         LAg/AiHsxaWZX42Zp2iqxa3hAD3MCa8QFl2irfs25uILNFzkFPOWdmP69ipNmhZNL6m8
         d3VBElTjPrCWo7RRzERfr5mmKF97SpNEYNdQNIBp8k9en2mCnoMzZuTYhuGn8YRWJ+Ig
         pN+zK1w4BvumRYvzFxTUetXODc+a90hTvC6NsdhV9Z9gUMbUjxQwe3GAWMVUNr/uiO4j
         f30A==
X-Gm-Message-State: APjAAAW3Ys62+m4zROupPuZnWsLgFpimxILAMa39cKrgX4nAkli5obW1
        yDNW9NdSWlnC8+hWMehgla1YGQ==
X-Google-Smtp-Source: APXvYqyOCEm/r7tnoj7aXoWm6m4nMP79YC/UVxxGxoFrmtJi9d9zHFdWug+OgSU386/6lXAScggVkg==
X-Received: by 2002:adf:d1b4:: with SMTP id w20mr8320212wrc.301.1565249546980;
        Thu, 08 Aug 2019 00:32:26 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id n9sm143092362wrp.54.2019.08.08.00.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 00:32:25 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:32:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mfd: ab3100: no need to check return value of
 debugfs_create functions
Message-ID: <20190808073224.GK4739@dell>
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190706164722.18766-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jul 2019, Greg Kroah-Hartman wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mfd/ab3100-core.c | 45 ++++++---------------------------------
>  drivers/mfd/ab3100-otp.c  | 21 ++++++------------
>  2 files changed, 13 insertions(+), 53 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

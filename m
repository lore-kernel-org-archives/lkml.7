Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5394FC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204752072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFmw+lIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgAGBi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:38:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33664 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGBi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:38:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so22539042pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LbxwARlz1ko3GWGQvzOFEv5MYg9xQq+ABogjlwJafkI=;
        b=CFmw+lImzip0yS8uJHgBucjs8+wZAbSug4hsHCBoGUlc4ylZunBXcX6c/NV3OD7OAl
         fi3inLrLTgvQDZZ9fZBeCwIkraXefcod7rG0f2WazGjw8pg6X07BAon7qcyQXySENw04
         woFk6JT0HvR8Pq/BCjmnH6tFrxwoOEXDrBPoVO6bJdUdyhEylp9T3gTZAuR1i57xcpM3
         RVGgsMiFsdfEbJP6Vv2km7ShVE2iVce4lYH4e8KlDQRfjg0KqW5r4bvjUjMr349+bnnc
         9J9j2nYyvOhp/JIXTKMKUmBN5qxnwegT2FkzAE8D+Ezmpmf+zAWIkSFaW2PZa9c1xf42
         tUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbxwARlz1ko3GWGQvzOFEv5MYg9xQq+ABogjlwJafkI=;
        b=n1gBZPzTJlqUCZ8DOkDmUCgxZ8bEJ9fhasgTJJ9cR9KzVPM5pF7v7kFiK01pCNrR8g
         ArRgK2yIsL5H9JXJh1b1fsoMOhppq2JK49ypCKftZnUbc7mP8PIDUX0mbvowRY08x7he
         uPMk2kmAjxIE6DEx0psc1WO95iqaEXV+jtJ+NhHhp4AgT95cYdw6hKAmdFYk2vuV0jej
         1Wr0n1oyzlkyTN2u2/Z9c06SVimEbKEEfpInhSxBLvtldGiHm2mw7/kGgIfIiqULhBfi
         MuymZDlgCY36bM8wN3maNmYazU7/2FW9bVSdlikfj/C97SqJumwToOd/sfnhtQsrc0Ve
         cVfQ==
X-Gm-Message-State: APjAAAUIrOmKRAg5OGYNZwQXpfAxnj6aR538MzdbbWby3wtpA8rnlbvY
        1VoEWeE0GQjH37pWf2xzsDdRmg==
X-Google-Smtp-Source: APXvYqxyvnxOxTcCe0dn7YHNv+cO5CLCfjxIjbcJ9S11/+aDP3p7Wq3EfQWT8J3xyOp5WDNaI9y5FQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr45559857pjz.135.1578361107419;
        Mon, 06 Jan 2020 17:38:27 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm81049002pfg.34.2020.01.06.17.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:38:26 -0800 (PST)
Date:   Mon, 6 Jan 2020 17:38:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: Kconfig: Set CONFIG_RESET_QCOM_AOSS as tristate
Message-ID: <20200107013823.GG1214176@minitux>
References: <20200107010350.58657-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107010350.58657-1-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jan 17:03 PST 2020, John Stultz wrote:

> Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
> to allow for the driver to be loaded from a modules.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3ad7817ce1f0..45e70524af36 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,7 +99,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_QCOM_AOSS
> -	bool "Qcom AOSS Reset Driver"
> +	tristate "Qcom AOSS Reset Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  This enables the AOSS (always on subsystem) reset driver
> -- 
> 2.17.1
> 

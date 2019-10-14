Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDAE2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8uBglN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfJNH1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:27:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40668 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbfJNH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:27:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so18379914wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q5BHsZHxaQuBnsC0n/rsVoiaHAm2VXfTTXiC030BJgs=;
        b=K8uBglN/gYVEhhG9uvD0jxpL+kBC7VMC3W6M/I1GYQtLwoF+9PBzncmew5ihD7lRR/
         TNfGGegf5VdqF1Bz+s6k/sVm2IVvUeOPyQsiHPQ0px5gkz9Rd9s6Pm6s0Rnl8GdvL1pt
         sCt23Tm3/dh+zeCrWdDNF2Mxmt3Ok4iwrRpVu3+vJCEi4yulCnHktAiOkCRJjIFBcq9m
         eKdm5Op2XTuFc4d0ys4Jqpxa6y1uZlSo9BAgkCq7WwhELcX0kF2OB+OB+k7UhSEjrxU+
         QrLa9LQ8Urk0ltRsYf74NGzLUvIPrvWYHhtlZuuLXN7ZVXrtxOxZGzYVJ4z+xf+D/Q6m
         CMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q5BHsZHxaQuBnsC0n/rsVoiaHAm2VXfTTXiC030BJgs=;
        b=PW8Z/wE0sRgk/VbMiuctPPiUSWjMgfRa+Ijnvo9XvWLGs0OL0Tx8fwuOV8z1BpGRzP
         YvwNuEHkbJ65pDPPEYKz9QW6Yb67kr3OE9lk1vsho6GsD+d2zG69DDS2D7aI6p+Zn5Ks
         AnHUxI0H8DzMKgPkOCT/VM0losQMamlysJ8j6jVUDe/fVD37hJZoIJDEg7wZTHEsfCj7
         BMPZmToqyhuFFMhcEj8N3+KhP6EsoKnJbj0Q46zSCNDCzNj46ROhB15kLDGcgbey9iQb
         UViQN4rXGpgWCzHsEN371wCe96qNQj/1gypNswOfK8P1AIPqeoVwcoZgk+qp1E6y2WQc
         V0GQ==
X-Gm-Message-State: APjAAAWyCVgCrke2PLPioQspG6z9zAiLNz0zl8fNy0er8Tv99CnEPQC7
        Y8uscrsfpRhZA68fXjxMyOl5vg==
X-Google-Smtp-Source: APXvYqwDm2Pu3gF5wLWhDaqvm22UpUh6vWq/BlOq37ZQHR6R8Ub8u3VH4fE0xrIa7I5M58b1ImJhUQ==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr20624080wrv.8.1571038067578;
        Mon, 14 Oct 2019 00:27:47 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id n3sm7073653wrr.50.2019.10.14.00.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:27:47 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:27:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: switch to power-of-2 base for
 fixed-point math
Message-ID: <20191014072745.GH4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008120327.24208-5-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> Using a power-of-2 instead of power-of-10 base makes the computations
> much cheaper. 2^16 is safe; retval never becomes more than 2^48 +
> 2^32/2. On a 32 bit platform, the very expensive 64/32 division at the
> end of cie1931() instead becomes essentially free (a shift by 32 is
> just a register rename).
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

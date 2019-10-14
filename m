Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3FECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53582064A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAeR6xlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfJNH1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:27:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJNH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:27:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so18361040wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Lsu4fhje736plADrPfFak7Hyuvi8ToLdp9rnCK4hwgE=;
        b=QAeR6xlIwruriMfHuFp2cv0YcQ7dfUCPQKWO3lSStColxpeElXzjO1pIuQnkS1TUZN
         cty42z8g8KK99VaGUqB/ZKPZqONUVjGeeKHaO7U/ZeaPF/37YP+WnTh+wZVEllLcTG7w
         JQWbBUZoVWjxcHApwBnUGZGGLTX9yOvDPZDrs9WfgOL76QsRx9nGg4GgBGDJNp7H0VNL
         ndbPJ0Tv48BYDmb3RoNgWP2uo3DBciF1dy4MU724NcdBreSG4GtL9V6VplxrcEZdM5bi
         d5sPeIPQDBqskiN+LDOq4H1eHwwsSO34kxUg/hgSYldiDuEN2bNCl0bBPIeHsn8M84kI
         c+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Lsu4fhje736plADrPfFak7Hyuvi8ToLdp9rnCK4hwgE=;
        b=Iu7fl9HOrH6Qpff7CrL/GRekyVPOsasiGtWzoteJ2c3wHIiANVv9glxKv/5gEFjiZ0
         3G69LCwakF+SCCoTDjVFYCxbeV/SqjGgXHvN+Z9vEcsZwRS2UiJOJfyu3P92bKHOBe/g
         XT88P6byJQP+UjO7TDB+h+LEOa+Z6A4qfIpG2qFXvAvmvEulcyjxqWHphVS0UVqxKo94
         WR50UQCicCWM03s+mv0DO4p97YPYNv2oddkq0Q4Kfny8gPM38krXui+c96U43Hr13a9s
         W0iMBcAmmXDfLM4BOShHkxflJl5ApRpXnlPIxnKObHuWZhRHwaiB5f9P/XUbq+7Fv8+1
         VIRA==
X-Gm-Message-State: APjAAAUq71ziR7mnJyTbEw+qe+RstWi87L5UY90zb+ItBNWDUfStMoes
        uhACJveTOUgUlh5fDnDoj3QJyZ5ncWk=
X-Google-Smtp-Source: APXvYqzw9fkcyJEo4AQK7M4LJ3HxW6G4IjmVLs+xsK03nZjv0Pw9xmGK1kAVONlnHG2VAyBzoqVlSg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr23614156wrm.375.1571038056779;
        Mon, 14 Oct 2019 00:27:36 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id f20sm14187442wmb.6.2019.10.14.00.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:27:36 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:27:34 +0100
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
Subject: Re: [PATCH v2 3/4] backlight: pwm_bl: drop use of int_pow()
Message-ID: <20191014072734.GG4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-4-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008120327.24208-4-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> For a fixed small exponent of 3, it is more efficient to simply use
> two explicit multiplications rather than calling the int_pow() library
> function: Aside from the function call overhead, its implementation
> using repeated squaring means it ends up doing four 64x64
> multiplications.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D9C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A62070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oj0Jvcy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfFRLl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:41:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41826 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfFRLl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:41:26 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so5589080uar.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KJ/mbtjWxEj5MP1XyOb+hi3sJFxAYeTiBlH7+rKjBw=;
        b=Oj0Jvcy1EjGWCZ2drPqpV8MC8IWxyJsJ5yrszqB5G7ypZWX6xjHSPhq+EmnSEMmBkA
         W5btJYDAus5uYs9mvsazJDQJOn8LtaXdDRedfiVsOErIC86HYpZJ7XMyS63dNkbaCTsW
         D43J3fDMekgVPFtPMmHKqXfhNYXhGtiuFzLoO5LmAf8jsPkZhWiSRzeQ38ooW7v0ssUW
         Grf0qoymC+PLqxcPSr0GIJT2qaJJMRUqKkNNFPl5kJ2Y3tT4NIRVbbZa0GML9zezCcSk
         u9cafd9vWLCZ0faMJi9qoIc+TzTJ9134f/5fM+2j7wFRzf1zIKhVlDTMcVqySMG6/jYm
         JmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KJ/mbtjWxEj5MP1XyOb+hi3sJFxAYeTiBlH7+rKjBw=;
        b=jnP+gbXlZS85lMv8qup1ZhRDTG7xRUg7vKR6OAj6tqVRXr3zJy4PBtKCokcCypnB2a
         QucwhTtWPdF0+BSUYy+O+stoVZA/rVdUQNPTeUR+p0wV4Fr1fFcVrHHS+zXf1fGjoJuM
         ZbZlL8xKPROK04sgzD1qlB1FnJD5xFijLmtsd/9fisaVROiCR7u+TDixHmwQ/UdyCYgz
         qVGf9J/4+3hbFmyhbl9tXrpl5idnrno6BpQmOhT2G/ZDi+ITMBR6sYjRuJu7BNv4Ccr1
         bK7/4ZTYpA7ZPLI6nHr8ebhtKC7jvp0CTobl1l66Lf8BDHoJYQDPWva2n+hPAAEksES3
         AIYw==
X-Gm-Message-State: APjAAAXcb3wV5KeKAQILr59rIrb+E3NkAa8YVa6nMDBbPZNjpmU+Y9v4
        GUVQuGCXAwRwir4j1VqyJTUtJQvKNuTyDKnkdf3H3g==
X-Google-Smtp-Source: APXvYqw6KNkfm7vjNQTJr9tp7fXdM5vH/0wbCaE4rKVXICQx5xxkwwB3IAGJWH/0TtMEK2287zIeLRjxmgLRyElBJrU=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr63582057vsp.35.1560858085439;
 Tue, 18 Jun 2019 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617201014.84503-1-rrangel@chromium.org> <20190617201014.84503-3-rrangel@chromium.org>
In-Reply-To: <20190617201014.84503-3-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jun 2019 13:40:49 +0200
Message-ID: <CAPDyKFr8=W9PYEYB7DuKisBVZ4nTF5ibJN5_OqoEPPbRURTWtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
> of SDHCI_CTRL_DMA_MASK.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb3..89fd96596a1f7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -89,7 +89,7 @@
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
>  #define   SDHCI_CTRL_ADMA3     0x18
> -#define   SDHCI_CTRL_8BITBUS   0x20
> +#define  SDHCI_CTRL_8BITBUS    0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
>

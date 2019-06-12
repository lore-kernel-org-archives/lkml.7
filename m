Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E02C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE49F208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMNltOgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfFLNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:43:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39030 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFLNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:43:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id n2so10251501vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOmrgQcD/lSti5Qh71Stv0ataNYNESHJ6g2zB80MgJE=;
        b=RMNltOgIPJ7TW0YTQcEvULo3TkaGMhgixILLxsUTZMlg9hB7LkUbXLV2fswn8bp9iV
         /qsCdg7+H/mCTIMBUjdCMjunQzyV8BGnZCjx5jXwTL2w0tYWSQaX85mGSJDjlc8ZrTjc
         QM06q/bkY+nEXMCaas2Ic6iWzjUBkwVwaMLnV8vfeIr9zynmLRpV+9Lgh1qcRIWtADev
         8arL8t1ohG7hYAd8GbnrQDiryPih9sBqegBBCvrUkwJvzvY4IytC+5U1B2LOUphZ4VcO
         OpOydkAWoY1hBCkqcxl4NB38GWn4Q0SkBTH+5oBjCkQq07dXtAdlIXRg4oUJKdY1V8dV
         z64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOmrgQcD/lSti5Qh71Stv0ataNYNESHJ6g2zB80MgJE=;
        b=Uah1vAUdko3VmmPHPBCcYl0bvAW7xuLcgHfAQnIGMvuALq8qp4P4My0nOINUSBaPai
         /1YYfpGuGobRUTqAxPnSsVLFzxemTcZ8naXK1yjLXKGHBSHfqDLI5bG0YYfhPJfh4Exb
         woh8z21aeEqZI9s9kMQ6QUjZLYe5z8r/ztzjOrbWbW6K93dqfu14s0PD+KoiHYwyWNLE
         YUgIuk3t5go93Qgya1xYtFXT0PCVhZqGoS6aNCNjH9NkaOdDC3reZuG6RoTX1mGghKit
         OReYyxZ2dGOibqWG1lo/p+SXR8KHleHiDS4t6sfG4xd1rIlHq2y3pD/i8rMNuacvPIs3
         Iqxw==
X-Gm-Message-State: APjAAAUQTBby8APc1cn0yP/EAfO0axyOSgHUSF8bqpqlAQ4GF5nwQkm9
        +vjBbEPLfhlmWs97xtqkeB7Y7+VVY4804EtUB+6pSQ==
X-Google-Smtp-Source: APXvYqzBzSRapUWvVQUQ4WKVQvhfEDjlTToobgTaZsocNytd3GbbujFaPYU62UQMMnPDC9VWRraClJHmnwqtNxHu5rA=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr10810132vsp.165.1560347006610;
 Wed, 12 Jun 2019 06:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190610185354.35310-1-rrangel@chromium.org> <20190610185354.35310-3-rrangel@chromium.org>
In-Reply-To: <20190610185354.35310-3-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jun 2019 15:42:50 +0200
Message-ID: <CAPDyKFo9U7ChoEQC1QFaW9cXLYQ-Q2UrYyH0KqJd_reyka3zvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 20:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The value is referring to SDHCI_HOST_CONTROL, not SDHCI_CTRL_DMA_MASK.

Perhaps re-phrase this changelog as to mention that you are removing a
white-space to fix alignment, as that was not so obvious.

Kind regards
Uffe

>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
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
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>

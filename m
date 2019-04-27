Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688EBC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E39206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pqJjLkPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfD0T4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:56:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42201 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0T4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:56:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so2517277oig.9;
        Sat, 27 Apr 2019 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9nFnukBcztno5ri1jckznxdxHQ3aJXeM2a654Thfkg=;
        b=pqJjLkPMqbgnK0WJSuUEYoescitzjb1Y5b/H0EwqnX8QLW3N70rXY3yBmwus37t7AR
         RGNVUdlWeRelnxVCZSDO3RwjZZBwxx0P43u3KowXf2HhTHZpUYUolqPkNhPtyMb9aRNI
         L7t2EpWcD0N3dzK77WjF6XxJHHSVJFua2cnXjBrP4+UD9aOtlUa0l8JpGJdpaeIRyg26
         if7yIGDJ4INPztRn61axvg6ZEyPoaWA9sW/nTRXeVfO/ndLirOs4QJ57Gce/KUeYUkQo
         kl23mt4Z4Bs5LxZ6na7ACY838U3V6ROJLytWQK5N+3ouSbAHS4FP3xiO13+D7wluPbWm
         fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9nFnukBcztno5ri1jckznxdxHQ3aJXeM2a654Thfkg=;
        b=VARR3VkXmdlYBOu2KFxSc1M/5RcWhpJ2D/55OMDhHNA0a03aEtO7oKr6017KPxMTyB
         htXWOIBzqOCp0K1tAjgPAPd1BR4o1DBtlXM6Do1FDWK1yo9/dUZk/9jzUL+qb7TUmjEH
         SWUivmIqfpg+pyqNVIY9OldHwmrBgYkIkaYuG7foiKHKtlOKWlWsFRi7sh00ynalCg2W
         ugFVWRPiuzV8lFnUjUE/oyA0kcQEU5zpxC5PqXGBo/DBHhV+F04UGVDYySEskP0ejnCE
         w6CZ549xuTWFPRPerE3vyFqFpcm0rM1MLkhXH3cZdS9xaGkGiPQnk0dS+N45CGlcgsX8
         CZQw==
X-Gm-Message-State: APjAAAVI6uR5rS/hH0KRnHK6JM2RMpxyX+eCjxIsDCzwZ7NcMi6Wkh9h
        J4g42+LBGBknyeCHX4WhrVxkoj8vfVpyq24MkyA=
X-Google-Smtp-Source: APXvYqy0qMwct+wA0tOyVb0ib4pQidtKK2ChUuSi3sBBjQlTS45HArmHzDL/yFiOGi7O2oxB/idSFkqNbQPHEUW/Fvg=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr11444991oif.47.1556394974763;
 Sat, 27 Apr 2019 12:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-4-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 21:56:03 +0200
Message-ID: <CAFBinCC8hfFXXPhRP6A=wXpTrB=3=re=k_E-Ge+mStcjuLxCMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mmc: meson-gx: correct irq flag
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is no reason for another device to request the MMC irq. It should
> only be used the MMC device, so remove IRQ_SHARED and replace by
> IRQ_ONESHOT as we don't the irq to fire again until the irq thread is
> done
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I'm doing the same thing (for the same purpose) in the meson-mx-sdio driver:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

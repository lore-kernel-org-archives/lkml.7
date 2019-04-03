Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7479C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DCB20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUiJmYM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDCDaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:30:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43234 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCDaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:30:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so10543433lfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EycNriYjwJdfqXXv0zmrBRUI/N1/oUdP1yxmKxxmwgQ=;
        b=zUiJmYM464TEDwiRMx908t2xgzCFWtUxuxpbgyU5kfkwRBAkV9ceUDmzb1BtHhaM4i
         zfttFJb34zaZiVX0G4IrsNr1AYmC922yDPXCZiRDQmKKDhiLF5rA5N/+rsg4nLDJz9AT
         +/uHkNyR/TU06gJxJ4YffjUEtONjq3WCkPDMvJgbkHrNx4RnP4dJ+DU40vpxO4V9CieB
         NblKjYa3tCKTsW/jhP2+XGbS3HJjqGDabdcmL34eaNNIiSJaNeDAUw1C41fx9WvHD8ee
         YWunbSapoHLeIvRdSkeTG5mRJ8usWwmB5fghILin71qvqeY0Sah9H+LDCbQa3J6eU54w
         kkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EycNriYjwJdfqXXv0zmrBRUI/N1/oUdP1yxmKxxmwgQ=;
        b=TOMulOnnMNfSVGKJHhuSm9l3ek8oy/Y6syO1BxLf6YWcBIkENYvbgpU8HSYqa+bprU
         jrGtdkJq0rcLleQ1fad0887+xGf1Q9+yXNyuszh1GOVvirpCCZkTDU0SMMKlM+vENhK2
         /rvqs7Y5ueeaZRPdOGBqXPzOFpye4nkeyPL7AQENgpJtaOL1Tn78HrFI4znO02FHrZyK
         sjXm8MwA0uU0hGKkLWQIAdyj7XsWwi8lHVp1WB3na1BdYQwFBDpOTshMZaCXVb2ZE8cB
         pTUdP+tacYISU728VMth2uFeUXLUZF/gML1d6WnPYpz0YLh2rKje9FxwYVKo0RQ1CqD+
         LCXw==
X-Gm-Message-State: APjAAAWIpfihZlHofLRGAlxPUrTTITHCLGgP7RGcj0fOUV6+Oit9iaOs
        jdb3s/b249IDYL6cxQS3whTAorNZzeFgr4jZ1wsgbw==
X-Google-Smtp-Source: APXvYqwxKg79uA2YzBBQp3TejhmhwwqN/5LQ+KbYBnAYs1m8RobzXlBhFySUrbIhjCAbNmcKw1KZknTUqLij7j+aCm4=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr22974835lfi.122.1554262220184;
 Tue, 02 Apr 2019 20:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-23-git-send-email-info@metux.net> <1552333701-22712-1-git-send-email-info@metux.net>
In-Reply-To: <1552333701-22712-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:30:07 +0700
Message-ID: <CACRpkdZJO6mBvgz_i+ioiiMtmRpDVR1wPg3uX3EbhGHTPACE0w@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: octeon: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 2:48 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij

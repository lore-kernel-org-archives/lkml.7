Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7576A2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kl3jlrGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfCEVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:03:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34561 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:03:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so8728338oty.1;
        Tue, 05 Mar 2019 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUWk/Ui9VaBHISE1nUlsCptcugL6TakwNnD+Y51zUfU=;
        b=kl3jlrGdjMZn7VHG24cpLmVXYj9Av653FMroKzrbgvYcRehDsk6vsQewAaQNG0ztMM
         VNu6XZLP54VCNEKz9xnuZl9OTdScBeXOSxevYiYzmfZKIuNsC6RXmR2SB2hYySHDAXV7
         MHRHlsteR1ebUzVz31bA1Y9xGWNmnfHuIBF9R/2S9JklHt2UdYiAzWjLrt9A3nHWYYCr
         jQiHkN4QJ/Qm485bpFEiLPztsOuIrPbyd2YKgsO+JfmB4w0KDVD37PZ5hWpthvS6c3hd
         U7hcKQd4kyhApC/ijyGT3vfN3REXKx+rwHuA4kI86yTi8ZY7HfQ7pog6MnZyMTheBmT/
         Xa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUWk/Ui9VaBHISE1nUlsCptcugL6TakwNnD+Y51zUfU=;
        b=GhFQBxGgen+UMA71cT1v6XHCqA4GQ9cqzZ4AeEmmmBQkJa0ORGXquQaeMB8CjfLfu7
         9Mbs3CunDODc892d+HuNTO37gM/vmmQZcLD7l5stElAFEIHwlCDdIJqEsrAWjpJK3+sx
         ey4z6F5EVB+ULIJ7CeRuG9m9R1MkjOr71Tow1XqG8IOMvsQYJG8KC1eoHTV7DM+/JE98
         S00ubaljLXS19AfcjCPHzZMwY1wgHCkIcMNtkSh9NpKgZxh1J7wtusVTD0K8LhWfxnUG
         WgYjmU20UP3apg/dnXk04aUsr+l/oNTo7uTCiVG149U/sSuEHqvpU6moP4hHCvJHVt9y
         PseA==
X-Gm-Message-State: APjAAAVDbGdESSpEVpNNyA5VcA/kxF7kXV7omgbI0vatbPCjtKvceDn6
        SMz3uzCJ9n0Ba24hzDNsgHLl/mKpVVp1gBwNd3M=
X-Google-Smtp-Source: APXvYqxdg/NeLXGofavhFOBicKYHoqTa6V0cb4Dhyoath7+pL7M+C7VOfjxGlcLQwMQQLE/yU7HU7/IcSSWJqmm563o=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr2155595oti.348.1551819778869;
 Tue, 05 Mar 2019 13:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190304111217.882-1-narmstrong@baylibre.com> <20190304111217.882-3-narmstrong@baylibre.com>
In-Reply-To: <20190304111217.882-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 22:02:48 +0100
Message-ID: <CAFBinCCfEDBcaXt=FBJ8hNwpq1CQ=tuCyXpd6fxHqiEfTwt9Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: meson-saradc: add support for Meson G12A
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 12:12 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the SAR ADC driver for the Amlogic Meson-G12A SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

this new compatible string will be especially useful when we want to
add "buffer" support which was reworked in the IP block with G12A

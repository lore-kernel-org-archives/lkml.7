Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF99C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CB82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Rv35xrv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHUSCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:02:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:02:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so1942689pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ubzr14D/m7NN4Gig+J49yEfObSCnRlFHpZMQCxBRrVE=;
        b=Rv35xrv1gcfayU9R+qpmA5rQGMwtfLgnRrLjmQlH51d9QkX0YDczI+50P0E1BoCsNr
         HXcgtPIvxKBSh9TZjiFurL+mwdWWx6RUI/yCQOaPlsFZ4yMkzqpaoRVEQcMeZk+qlGgI
         hRYTF+OmFOX22XlupG67mIr/N5Orwjlc3P5piwe45L2/wNqoXyFFu257j8F/TtFUm1EV
         qMKbbxF0xBV39nThclx3/qg+0roqn8ekes/qhsJMELrev+j0UtLh+Xu3tgMRwyk8ewle
         I+hr4KQ6nWsyHa5+3d4j9zi2TSDc8DN/sG0HkR3u0Kp3jZL10YcL3s5QRdgao2SZpWN8
         GDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ubzr14D/m7NN4Gig+J49yEfObSCnRlFHpZMQCxBRrVE=;
        b=ADV5mf5l3ifRODrGuO5lAExA2mKqEPOCI9pHA8m38Axct1C/6ywmfRxs6xF2yu7xjY
         tcvxwyG4ouvIc/JsDgbr4tMVhBGKl+HYpSofPg8mq7iUbo15sJG3V46UgZ5PMgFfipVG
         NB3jkX1dYFRAdP++zCK9FTqYvC8EQszGriDTZJVi5vXZW6R+a82EYPupTtjkWYYjkuyY
         2juIFyWa/Z3lDfnOKY6Dfr+YyIgyu/dr6ffK+TIdmoXatAiadWrgolriK9FJCuV7M72J
         D4WPcF89Z+K7CmX0kqnQHPnDQvqj1Axu4IdjlxrIUVmPjYS/AExwYzc1sc18PN/Pq7xq
         YVFg==
X-Gm-Message-State: APjAAAV529zJbCwJ9WduH48RPioQsyQw3HgEinb1yMP1HJMuAJ3O51X0
        4sJQR7OYkKIgYlKyKdY3g6UP2g==
X-Google-Smtp-Source: APXvYqzlmjNDEJBXLF4y15j0jF5pl7SHAfLJmB9j2o+pnjNpIbZCoiTyxhWaFefXMOPZ/JAxPpq7qQ==
X-Received: by 2002:aa7:8c57:: with SMTP id e23mr26690422pfd.48.1566410534247;
        Wed, 21 Aug 2019 11:02:14 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y16sm35101574pfc.36.2019.08.21.11.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 11:02:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, balbi@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables
In-Reply-To: <20190821133518.9671-1-narmstrong@baylibre.com>
References: <20190821133518.9671-1-narmstrong@baylibre.com>
Date:   Wed, 21 Aug 2019 11:02:12 -0700
Message-ID: <7h7e76bdnf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> When going in suspend, in Device mode, then resuming back leads
> to the following:
>
> unbalanced disables for USB_PWR_EN
> WARNING: CPU: 0 PID: 163 at ../drivers/regulator/core.c:2590 _regulator_disable+0x104/0x180
> Hardware name: Amlogic Meson G12A U200 Development Board (DT)
> [...]
> pc : _regulator_disable+0x104/0x180
> lr : _regulator_disable+0x104/0x180
> [...]
> Call trace:
>  _regulator_disable+0x104/0x180
>  regulator_disable+0x40/0x78
>  dwc3_meson_g12a_otg_mode_set+0x84/0xb0
>  dwc3_meson_g12a_irq_thread+0x58/0xb8
>  irq_thread_fn+0x28/0x80
>  irq_thread+0x118/0x1b8
>  kthread+0xf4/0x120
>  ret_from_fork+0x10/0x18
>
> This disables the regulator if enabled on suspend, and the reverse on
> resume.
>
> Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

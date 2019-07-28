Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E7C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0152075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4gmEPa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfG1KA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 06:00:29 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37591 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfG1KA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 06:00:28 -0400
Received: by mail-lf1-f44.google.com with SMTP id c9so39921344lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5pBCLZQz90BrGcUD2I4KEUNjM1YGzNjZn8GbrFYE54=;
        b=s4gmEPa+MSse8G/JQ3TVW6Wq7NmcNzaUl6/rZymOwbWBLSQqL7jA2FDZWocTsV0eB2
         wIX0YfUEq2E8JUVl3WCTfiAZmRXRl/gzyDQM84i8T3B92WOTOUhZ21dJk/M97mXx4apw
         tMYrxvXJibhZCztKD2Rj/8Hc/OfA4YajHY1W9D/D6nTmUsRBnvf2MaiVaaPzPcVu1Br/
         0wU4J/K+Zxia5WR307Lbl0o6efQ0liqjW6dT/Pi6i2qYtfrZFGOaY8tgEZFBvHpDSJDl
         8RYHkXfsufIYgIQEnZPcpAk04Q6AQnQfT+plBspfWyZlrAScyYsR6gWGgN+sZVUqv6dj
         Ug7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5pBCLZQz90BrGcUD2I4KEUNjM1YGzNjZn8GbrFYE54=;
        b=kMBG4clYuMhHgktkXSunfLYRJXN+QMEHvD9qYF+coU90QgvmRHt6Y8l2OCCSbQVph2
         SWG3qWJeIIWJEWyKV0h0a/l8+ICU0ddfoa1RIdZ1pQ0ztAgBZ0aAgeg2hT9TCuVHoSJL
         anx5EPzb5B0/uVIIRtPA+h5piQ4n22/HsTmsXmr+EowazNUK9GYEkJtOyrYoWxK1AiWu
         8QWY6yJbaJyiukIzhIMfi2ZEgc9iWjSHAWa1byxFcxo3ysiFlh8V51FhUdLcKgcTrXKJ
         Vh/pJ7C2BVT6j79A7JeEDrQRgwQ1skg1Ht+lbLJn7Lr4r9fomS/8NSUiHtpPyfecwAj3
         tivQ==
X-Gm-Message-State: APjAAAWbBUXe9EAbkjtVdFQ4MBn0Cjj2jtjM0i70GTkVwx/wJAH2GxIK
        dEDIZ3rW0yFgA/rnjvDdzJQ3DQCwu6yGtW6tiePA7A==
X-Google-Smtp-Source: APXvYqxBERF293e15i4oX5SWRbPMOfqKEJuOzLHoaUrl9EoMvgRMl7sq8s8LAW8jZQcqDMBCNmWB002/Dgpd16Pyzww=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr47219184lfh.92.1564308025871;
 Sun, 28 Jul 2019 03:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190629123306.12519-1-colin.king@canonical.com>
In-Reply-To: <20190629123306.12519-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Jul 2019 12:00:14 +0200
Message-ID: <CACRpkdYaVT_j5Ky-nd8_1F0mG3yqBWaQ_ju8g2zSb1O+565ozw@mail.gmail.com>
Subject: Re: [PATCH][next] gpio: bd70528: remove redundant assignment to
 variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 2:33 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Variable ret is being initialized with a value that is never read
> and ret is being re-assigned a little later on. The assignment is
> redundant and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij

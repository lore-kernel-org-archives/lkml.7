Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1048120830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdNGNGrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDCDhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:37:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37768 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDCDhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:37:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so212945lfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snI+7je57/RSvL0LvzU2B2WLbbihGABJQIazIEJj4fo=;
        b=BdNGNGrzMsETOwx24TOiFitnJq/no9gM0N3nyjdI8tTCSDjqIR4mTSwmp7JpLo+R6u
         F4T22poyvPj8zywXGDnueNEQ/Juti01a9rNoyLnOFWe2dhpjWeMbC3tdJ78JjXE97QCw
         Wmip6Lk4uqPDBLHfPOPWjKBvHYtaeTdNOyWpnWpxVwbI10KeHQ2EwehDiSA1oKU9+df/
         3II+qBrknEw03fJ5DbTerh86almhAvkDEsvyzucShNVWrYcQbQCCMK4ABejT/qyLg9Q+
         LrazvnzaVJ3db/4ZX/cGRsnufN7pwgrzzzV8/ykvwvcZZCrgwWOjCWqZU3w1/U5sAp2T
         fGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snI+7je57/RSvL0LvzU2B2WLbbihGABJQIazIEJj4fo=;
        b=to+Q4zRW4nZ+tPHXtbuLJLSc4vca6uHg91j3tzHonAXtJgHQAK3+8aOkWyCoEmzqn6
         NRrlhNx2xwh7QFxB/TXNkvMYWw8/VQC6gLCGY2rVTKEtuRZ96Qi5YBwYyYZCPlTX63Ex
         2Abqvhe4CFCNim/VuFyd2tHlGBXG38fGmMQ7d5yk68lAXKrpZR/x7RyraZFtGY/u1pBF
         TSy0nGlKjKn20DmGJF7DEw3X5ORVzmWk8gopHRv8WGLjdHCArQVaFDUNamkjksTMB56O
         E6ig6p1Fak+d+9CaQYFY5k5SeYZQGSi++ZXU7lHzVnvCunGnb4z694H3AFMF9okjN/8p
         DWHg==
X-Gm-Message-State: APjAAAXWq/8HxC/jkYPp0atOCMRBEuhTN0yyWTYidn8+ZEnUF56zYIzC
        DZ5OCeo3dDYZq68RTN0PpIlDBohJuhc+3/VcNADuhQ==
X-Google-Smtp-Source: APXvYqzINru2dIM0vAUoq8UjORczdZUxvRGCM8BcT2bj8R11Up1mNZbaKxvourP9a+v4g1Jf4JBby4Vw8x6U5gRRlmw=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr37537835lfy.128.1554262652232;
 Tue, 02 Apr 2019 20:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552382374-28789-1-git-send-email-info@metux.net> <1552382374-28789-8-git-send-email-info@metux.net>
In-Reply-To: <1552382374-28789-8-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:37:20 +0700
Message-ID: <CACRpkdYVCTzQJ+pXH6qzaB3mu9=-LVNhp04Wxxgd=R4r7hkePg@mail.gmail.com>
Subject: Re: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:19 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

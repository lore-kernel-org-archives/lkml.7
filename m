Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1FC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C53217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="CAZimfyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfH0CoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:44:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45273 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0CoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:44:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so15830007qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALo2se9tgrniPYFX0bT5iHmGVqO3QJBoqA7cFuqMpl4=;
        b=CAZimfyOfJedLHvcojyTMfYruy39wvxx93L0GI5uTcacgiOJ5Yyq3FhPYe5FsZYH5+
         3N+gayRbTKKzDCzQVjXSOMeMFSjyLJJQ690yPjhMZ4lx07xno4x/He/iZRGX20OchrA6
         fU9ebrvx40TVb3Cf7rMcDMu4Vct5X73lRwBHWCllYlsoSxEIe5iWeeZbGdFpYqX7K4KU
         vY4mKhhY9GS4hjmDpWsGXrgzh6IalziEVe/k+N4SAfjIv/wVSxra+211EVjNUgz1tnOi
         4/mek9IjGrvAPxJYPTSBBJ3NzS6pHfe/NKHBmYjrjLpDDDI3rFiozfMan+mNmnDEXeYG
         Soxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALo2se9tgrniPYFX0bT5iHmGVqO3QJBoqA7cFuqMpl4=;
        b=NO4l8Ic/v3dafr7b0/5ZlVPzgaaznRHLD72P5eyFr5eIWvf8+fDT24rP+NE2SvZM3f
         3feQCsx2S3G0uMvVzROQ3zueHpr7hH/+/6q1shF/BOQRD+Z+O5rhx6U5oNpgNv/wpj7Q
         50WLwuZjcEl95+IBlqABUB9CIv955cKeSV5ZJspu02NUN+qah4KwEeVn6LnTUVRLRr2c
         XVX/hSdZRUl4SneKTHhshX17ohrCgNPbYhWGAcyBLPVmg12gcWASiwAH7S21RwVJdyjj
         fOt53O1HU3s/uyYz7gbuLxpe9DeqwWiV9VEB8/STvd64Xr5GzU+SPK30Rj3L+BEr2wDx
         U2eg==
X-Gm-Message-State: APjAAAUnBXpz+W7CyS1527M3uWIA16gU86G+atTKylKXWbpL78mZOUvH
        lcsWmGjMqK4fttHXMl7RKigIA48O0XMq2f5UQ20QaQ==
X-Google-Smtp-Source: APXvYqwH+1nJX9BnF0hTAr/iGIJOtgC/Q1ezZWHVlFvR/hRfCSoovtViAX4vZ6I4zlpbyh8ByWX3OxkmBe/RXzSfkRU=
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr19215266qkg.478.1566873849070;
 Mon, 26 Aug 2019 19:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153900.25969-1-katsuhiro@katsuster.net>
In-Reply-To: <20190826153900.25969-1-katsuhiro@katsuster.net>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 27 Aug 2019 10:43:58 +0800
Message-ID: <CAD8Lp44a0i2Z9YV0tOKB=QuoZzU-ALSqTr_X8XaMVrGbw-DfQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: es8316: fix headphone mixer volume table
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:39 PM Katsuhiro Suzuki
<katsuhiro@katsuster.net> wrote:
>
> This patch fix setting table of Headphone mixer volume.
> Current code uses 4 ... 7 values but these values are prohibited.
>
> Correct settings are the following:
>   0000 -12dB
>   0001 -10.5dB
>   0010 -9dB
>   0011 -7.5dB
>   0100 -6dB
>   1000 -4.5dB
>   1001 -3dB
>   1010 -1.5dB
>   1011 0dB
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Reviewed-by: Daniel Drake <drake@endlessm.com>

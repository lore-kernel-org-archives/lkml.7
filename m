Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CD2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXO/EwKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1Ip0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:45:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39046 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1Ip0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:45:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so13891456lfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VOmEm5K04vWbQ2l+72yNvPSeFo3+7LnA906Ryblkpw=;
        b=WXO/EwKP8KEJ++Jhoxlga+tHjsb5QQqMf2XP9NljzGGYqXky3VPzeSCXM1wHpQc4jJ
         +cjmkbygR1VCuemCziTSsOypdaIcgTUPTOmKdK8iApgWH5Pf+p9q8FpM1vaDPg+NbRMg
         rDKSbmrhANR0G0+waRI280Qgz0RMyEJ07u0HRONb7lgseklCe0ZDVV8nqi1zmsQ4ur55
         85CNkY2nl5Y9Gu1q7LtKgYLCK7kO88S7FC0OyrAQGJp9QgUSdsR3bzPLrgdl96CMyQuk
         idbf8wk4O1FA+iaQWUyc5Hpio2p765424/rjgGRpgjZJjogLOfRMa6UCpNPI8xC+1zJy
         q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VOmEm5K04vWbQ2l+72yNvPSeFo3+7LnA906Ryblkpw=;
        b=qEW6dqOsu6d9jd+gu2gCdL0EOLBwIy4v3Ccn3tj40d1ZppFu2+6j7ee9GuFF5USne1
         CYaEnKnSNVUt9mMN+OgdPxbAA4hBWq06FK4aCuhL0sfFuZQfkwn8eRX9hgTNpzE+jYtN
         rkARMSd6KuATyyLrnLcrds+j4VK39xWgS9QwLZcGH5CuFrHGSTxzUo/844c5EGd9twst
         DUkgNpA5Ju0wAX0Sv1GgctohTfjMNLAh1tCFBE/rU8kv2+AZAe6RgY9PHtzAxGRZFUN1
         Ch7pqNfK5IgtF0VqgVA1xe/y5N8lKeI4wWDMjT9CeErtvIShVEcJ4hVfiWuVbpfFF4GA
         4bDA==
X-Gm-Message-State: APjAAAXvPABJKOvF0wf9vdz3MX+/aVozR+PhJz6b+Lkb1MgaZIsVf2W5
        6zKcRZ790Y4L9zR9PijQhJmBuEDWsh2VXr0nQGR70A==
X-Google-Smtp-Source: APXvYqxTvYIP1dmooWeXzZi4SJCWIlRrpTF/nExWAU3fqYB71spv0WzoKeq+wsuMB/CY94xrgHl2E12zlzb5qJiatJk=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr3232015lfh.152.1559033125238;
 Tue, 28 May 2019 01:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com> <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
 <CAMuHMdUF1Csi1ZMccOj=kurijMLcA6G+TP_spsE+fnMvZR71Vw@mail.gmail.com> <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
In-Reply-To: <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 10:45:13 +0200
Message-ID: <CACRpkdb-Dv614V7STLRMpiLkmb_7NVyKnh2oUi=7Rx366tmZ-A@mail.gmail.com>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:36 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> > Can't you mark this as a known issue, to prevent spending cycles on the
> > same bisection, and sending out more bisection reports for the same
> > issue?
>
> Not really, so I've disabled bisections in the linux-gpio tree
> and a few other maintainers' trees for now.  I'll see if we can
> come up with a more systematic way of suppressing bisections in
> similar cases (i.e. the issue has been fixed in mainline later
> than the base commit for the branch being tested).

I think this is what the zeroday autobuilder does because
they never seem to show this problem. Thanks for looking
into it!

Yours,
Linus Walleij

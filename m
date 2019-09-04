Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75052C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4778C22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhRvMHhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfIDOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:37:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:37:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so11348463pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CaC26YQBbs++2LlEGrT8hc5InQ6jt1lO4oP+jQbo+4=;
        b=lhRvMHhKgBm1PhW5YBzZk3QZWD0LIQg6cOaGJFKLMq8Mnd6w4KgZIiAHf50nbo9xhi
         SuoO6m+VMe3I9zG3rJp1TrqOstdiv5kf5JLs9VGrscoB/IPlo1WEdupFrLa4CI9wfp05
         tm/5Yusnpdj+eJVLa0gxHihikGCgaKT/WeZ4I27xXatqSniZQJn95Y6Cu4l/7CPN1kNw
         4mnbBQQQihbtiA2Amj5vfI+QxFxsbGZCsZpn5AXQmlwnX880YB0EIT5r/aZBGZNb6+a2
         KI8h15rroiib8t4s0NwkdF+RGHJY5AkYNCT9JzXU1sAYdGvEncmWSWBe8g2MgaN60+wF
         rFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CaC26YQBbs++2LlEGrT8hc5InQ6jt1lO4oP+jQbo+4=;
        b=BSiEf6WODKxoasZqXZB9K0ofF0O/cNEJK/BfoacMc/J9TCgqoVyGF/x+rQHp+WQVR9
         yYgRwr0tmISyo+ud4/R3x+nHG+Bl4KQhPKBAXs2Mo1PZKNBmvqFA7c2SAfzymCKwdyom
         V6vZRgqwSvN3NCiXyPVHr6+WmZemPElRMJ7fukrks51qNCqUJPrraxItC/Sl8AuRd3KE
         fXpHV+ZgqKxxuTYuzW3SynUTZocmoLGCiCrlEA1bxuGXcYFCkhYokDfUWA+V4sUdsDMi
         0uIAR6aeCPaK1k9+fPSzzxcoKy5yeDC447D1ybuVoiqXu9f/7f1ieEvSqDcNldI1KsRZ
         CMZA==
X-Gm-Message-State: APjAAAXmMtW06t0xGaVffKUfs2PX9Wum5XrQYYoUiZaTwk6I66RO+blg
        9CFsu/AWTAUlLtrLDGNDMe3bpuVxNQzQbqquGLF/HZH1
X-Google-Smtp-Source: APXvYqyZI6XJ+nXCD/369CCkMaViohyIPk8rgyHpVtu6GqeKZ94m+IIC+qjyXskEfjhPXSp3sqhdAxD2FCSLALCyNcU=
X-Received: by 2002:a17:90a:bf01:: with SMTP id c1mr5430039pjs.30.1567607858001;
 Wed, 04 Sep 2019 07:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190903165322.20791-1-katsuhiro@katsuster.net> <20190903165322.20791-2-katsuhiro@katsuster.net>
In-Reply-To: <20190903165322.20791-2-katsuhiro@katsuster.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Sep 2019 17:37:26 +0300
Message-ID: <CAHp75Vcm0yus5GpZEttdr_C07gmQXeNJ16gb_TFLUTvGkc164w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: es8316: add clock control of MCLK
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 7:54 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>
> This patch introduce clock property for MCLK master freq control.
> Driver will set rate of MCLK master if set_sysclk is called and
> changing sysclk by board driver.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>


> +       if (es8316->mclk) {

You don't need this if clock has been requested as optional
(clk_get_optional() or so).

> +               ret = clk_set_rate(es8316->mclk, freq);
> +               if (ret)
> +                       return ret;
> +       }

> +       es8316->mclk = devm_clk_get(component->dev, "mclk");
> +       if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +       if (IS_ERR(es8316->mclk)) {
> +               dev_err(component->dev, "clock is invalid, ignored\n");
> +               es8316->mclk = NULL;
> +       }

devm_clk_get_optional()

> +       if (es8316->mclk) {

Ditto as above.

> +               ret = clk_prepare_enable(es8316->mclk);
> +               if (ret) {
> +                       dev_err(component->dev, "unable to enable clock\n");
> +                       return ret;
> +               }
> +       }

> +       if (es8316->mclk)

Ditto.

> +               clk_disable_unprepare(es8316->mclk);
> +}


-- 
With Best Regards,
Andy Shevchenko

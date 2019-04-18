Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFB217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N5FPiGcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbfDRUyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:54:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36876 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389754AbfDRUyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:54:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so2664282oif.4;
        Thu, 18 Apr 2019 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5oCZP96kysA4+CsYMa2NY+MrmDfUa/rZvfN/Hagbfo=;
        b=N5FPiGcDBEonviaNIvKsKqkTigq0VeXh8fjdqzHgHXYWf3do5a3dopc0kTk58fpvkU
         X1pvrIB6V3w3P6lRHr6MsOv4s5rPInmXl8GTXx/ma0uE6adLgKSzq26WpiBYpZCPNF1e
         Y4ZTw4S11lA6uO2hP3UFjsxUw4a/8WkdHoArJxVwSJwNGsgYy5dam+nOl+FPxGJq8gZo
         Wg0hIHqr2bRoN0WAT+cdXJeTCmc9cteAoW0rHuPHYsF6MFs0RsQLU4/GZUOW1wyK+unt
         ImGFBnM2fWyFXD5idvMujwzqp2nEMbXhSxdbHs0hqcCJ1BnvUkopSmN563RK9xlsS8ar
         1+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5oCZP96kysA4+CsYMa2NY+MrmDfUa/rZvfN/Hagbfo=;
        b=pBcH84nlEiQfLZBU1/O+ux1djlWnkKfcL6atrcRYGfeP50rNwUa6hrI91y3Wr3De6u
         KyqxqKnC0PLFyKTYL7FfNcoaV1qKZozoyzaagQNbjw1NHvdHkDrKycLdyhEx590KAkYb
         Vc4YGIzPHfwYN6FuOW/VwI1A4v1qB1yWhIa3ERZIbScrE4svU02RN/xCaRgIURYMjgtM
         X9w2m0ZH+fbTfDkaW8jPPq0V5BchlAOsgW/+Je+tUUKcewjoMWgIyNUz9I0pV9QxYKan
         OqZoVFuKdwta3zAnih7stKTIKu8NYOe2f+q+L9UfcwIZyQfVNb7tZh7ld0dtEt61sSNs
         UfLQ==
X-Gm-Message-State: APjAAAWrVLyBw4Y2oRfAIg3leKk/Mz/5ZQXr4DGQPLqdKzxbEa5h3rwa
        IuDo/pFXCQ6sXt81zDObvs/xnwy2dqNUkeyOmdQ=
X-Google-Smtp-Source: APXvYqzZi065lzAyGg2kjLFhqeyVvmKBOY1v0x0QdLN6L7njzHzkaT+W3GtjBPv8bHYI4mXR7fPAxubHuPiU1s0DV20=
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr3288928oih.15.1555620844042;
 Thu, 18 Apr 2019 13:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-6-jbrunet@baylibre.com>
 <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com> <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
In-Reply-To: <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 22:53:53 +0200
Message-ID: <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
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

Hi Jerome,

On Thu, Apr 18, 2019 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > Activating DDR in the Amlogic mmc controller, among other things, will
> > > divide the output clock by 2. So by activating it with clock on, we are
> > > creating a glitch on the output.
> > >
> > > Instead, let's deal with DDR when the clock output is off, when setting
> > > the clock.
> > >
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.
>
> The error I see in your logs is with eMMC and hs200, not SD card.
sorry, I should have been more clear that there are two errors:
eMMC, this is what I have been seeing for a while on my Khadas VIM2
(it's probably not related to this patch):
  mmc1: mmc_select_hs200 failed, error -84
  mmc1: error -84 whilst initialising MMC card

however, then there's this other error:
  print_req_error: I/O error, dev mmcblk0, sector 0 flags 0
  Buffer I/O error on dev mmcblk0, logical block 0, async page read
as result of this the partition table cannot be read and my kernel
cannot find the rootfs.

> Either way, There is something I don't really get. eMMC should not go through
> any DDR mode to reach HS200 (which is an SDR mode), neither should SD to reach
> HS.
>
> All this does is flipping the DDR bit (when necessary) when clock if off for
> the mmc device, avoiding a glitch on clk line.
>
> This patch should not make any difference for SDR only setup, Maybe I missed
> something, but I don't see how it could make anything different for SDR only.
>
> I (repeatedly) tested both vim1 and vim2, without seeing this issue, so I can't
> debug this. I'll need more detail to progress, something does not make sense here.
please let me know from which part of the driver do you want debug logs


Regards
Martin

Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C806FCA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6E20717
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a+MdlyvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfKDWbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:31:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43186 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:31:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so3610890oie.10;
        Mon, 04 Nov 2019 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/geFBMEqf7twdLKHSVdVT6FyWVKwx2NVIgtA+twsQkE=;
        b=a+MdlyvEiOU8aVaiBQk7eZ1yzA7XLzs5bUKhswBKAOj829P1WsrId1fjxcmSMHq8gj
         NspcXXwicor7YnC+bnT8Xxk+tmbIiLz10bUdTlShG1kpID8r4HDiZQGeEbDUGE6LwMaU
         dj9FsHVklDGCuQGMM3cJWuIeRBzXzY1LdoKQk6RtWq6FAoGwHuCDXcXU083BhStrehgo
         44ejbg2Ezjdd82Ei9VCASuj382uI5TGCAnogkliUyv97kHZWOfQcNHDgXk8w4uGUQFi+
         10StfI7b/HKvJ2jmqQjin2gdn4ehUBykG4EMkTjlhV+U9jrXVqeKQoCUsKuuXQXDcRIK
         ZTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/geFBMEqf7twdLKHSVdVT6FyWVKwx2NVIgtA+twsQkE=;
        b=StVs7HG1dMoc8IM3MZ5tPLR6GX2mSOSCawAszsLN6X4zorBpQZEU6FTqOSZGD7i512
         7q7x7UppOZkoctR3yMvE68vVM3BQp7FN4SgR2uxa2Ii9Xq3+JtsiV5HTiQN+0aHiFnSX
         y4lceymmce4o6M3kfDXBRXoYQIoCVVIm0EG/mBKuJOfT/T7MbGyYYaAieMFzg8UCfiIq
         sHrDVWIG2Rllr98xV7ddEuAk15B8eBzZ+pNjjQv75pjWUMsUo3+Wlm0evtaT5/GHWfpw
         Z9Enn0O9pH1G5UMR8fmXkGwd70S1V8TogKSyGFEZhIKnXOAd9u0CRSc+zbLMPmE2SyjY
         UTpw==
X-Gm-Message-State: APjAAAUF+YWc0f0hujR6oy3wX56WyoHHN2UaVcRSAw/jSkwh356xbFqZ
        c7bXqdERDCG52s9Rc90uYEjN1d+HUqEEWt5ZwQ4=
X-Google-Smtp-Source: APXvYqybWUfbZG4teeG01ZGKiXx9fDn+U4FWS4zJB69jNiVVHd20K3CuTz1NkqytBEFVmmei8TQlnR7feaE38XUb+tk=
X-Received: by 2002:aca:504d:: with SMTP id e74mr1229364oib.140.1572906703760;
 Mon, 04 Nov 2019 14:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
 <20191027161805.1176321-4-martin.blumenstingl@googlemail.com> <1jd0e83vyp.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jd0e83vyp.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Nov 2019 23:31:32 +0100
Message-ID: <CAFBinCC5RSkK_8Ww3LjAxG9tLL6Jik1uy3Y8CkEBqXRRKUsa4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: meson: meson8b: change references to the XTAL
 clock to use the name
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Nov 4, 2019 at 9:08 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 27 Oct 2019 at 17:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > The XTAL clock is an actual crystal which is mounted on the PCB. Thus
> > the meson8b clock controller driver should not provide the XTAL clock.
> >
> > The meson8b clock controller driver must not use references to
> > the meson8b_xtal clock anymore before we can provide the XTAL clock
> > via OF. Replace the references to the meson8b_xtal.hw by using
> > clk_parent_data.name = "xtal" (along with index = -1) because this works
> > regardless how the XTAL clock is registered (either as fixed-clock in
> > the .dtb or - if missing - when registered in the meson8b clock
> > controller driver).
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/clk/meson/meson8b.c | 73 ++++++++++++++++++++-----------------
> >  1 file changed, 39 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> > index d376f80e806d..b785b67baf2b 100644
> > --- a/drivers/clk/meson/meson8b.c
> > +++ b/drivers/clk/meson/meson8b.c
> > @@ -97,8 +97,9 @@ static struct clk_regmap meson8b_fixed_pll_dco = {
> >       .hw.init = &(struct clk_init_data){
> >               .name = "fixed_pll_dco",
> >               .ops = &meson_clk_pll_ro_ops,
> > -             .parent_hws = (const struct clk_hw *[]) {
> > -                     &meson8b_xtal.hw
> > +             .parent_data = &(const struct clk_parent_data) {
> > +                     .name = "xtal",
> > +                     .index = -1,
>
> if I got correctly, when transitioning to DT, you can specify both
> "fw_name" and "name". CCF should try to get the clock through DT and
> fallback to global name matching if not available
thank you for the hint - I may even get away with just setting fw_name
if I understand clk_core_get() correctly.
I'll try that during the weekend and report back


Martin

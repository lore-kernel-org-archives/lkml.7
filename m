Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BFCECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E859D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmxLnnlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404116AbfJPIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:41:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35624 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391805AbfJPIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so16754207lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5rCHjs55GhS0d4QwWMR+IRXm4cU7A5acMAqOom+agM=;
        b=cmxLnnlv3X8JzjYTOrMqk+TrttOUQO+7Ws5eEWIRsEywSi1lz7WA6MOWF2jvS2WjdU
         kNnUvK2cVJU0uIxO8GhtsUwz7YRYCcSD4sc5HojMnTJHNi7TV/4LE0IDtg48eW6tv4EZ
         yp0HfIdJ3n5GCBA/L3alVcWo6V6kJ0OkrWiyeEiCV+GqXCr+1HCkWjqYygrdRdst0E/s
         Jw0IuQIhHHnjpLvdhnWnk2MEqsxtjlmE0E7FyNcMmIeJWuHqQMjPcMkbaaQ1Yx6fRUuw
         p5rWDLQWh+mWjmnGrmjPilU4K8yetyUqCqxz6D/6lCKowZu9tOEzyy1oZ17LVeq65OFv
         NAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5rCHjs55GhS0d4QwWMR+IRXm4cU7A5acMAqOom+agM=;
        b=h66bY2AT6iJ/sA3qQgZw9GitHpxp5iA7lroZFfYtb01yk4DE7DuIGpRS6C7Xalt5mJ
         4MvDrez9E3f+eU16y0vM8+4qSmEg53rzLkB2druxuaoegMekdupmu53YTDUzF0MNJsan
         qijtujSBW1UVV9IWMhOgVUWlaaTckP64HKPOXIg2TZevyrb5JoLgoM0CM4QoR617X+Y8
         PDyOZC0q5+HdsGYE+YIRflQQpfTA9XeQNfAGnjGuQKy/wCI+o8wbDfPAs/lPU91Nfl2+
         GdNXX6wN91h9Uxf2y00KLGXsCAjv5ktOA176jxgSZmU1KDnoMyWVQWuC7KjXDBN1jQCa
         S6Lw==
X-Gm-Message-State: APjAAAXzRP2vwTfoWcdpbkHAPTbbHSBxw8MMvYFcjm5gjPNPsUC4CgG3
        8WSzVEgfti1GvWQeni74AEKd0lM8kebdrQlRVAY=
X-Google-Smtp-Source: APXvYqwMqRyrV6KURGxOk+nK8zfx8iulHbs2fxXoCl2l6ahgWaJLEk4ZRRTnkB348AtFsLAoa2OCoYz7BbpqTULv2UM=
X-Received: by 2002:ac2:5610:: with SMTP id v16mr23568149lfd.93.1571215303287;
 Wed, 16 Oct 2019 01:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191016070740.121435-1-codekipper@gmail.com> <20191016070740.121435-2-codekipper@gmail.com>
 <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
In-Reply-To: <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 16 Oct 2019 10:41:31 +0200
Message-ID: <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel select offset
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 10:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > On the newer SoCs the offset is used to set the mode of the
> > connection. As it is to be used elsewhere then it makes sense
> > to move it to the main structure.
>
> Elsewhere where, and to do what?
Thanks...How does this sound?

As it is to be used to set the same offset for each TX data channel in use
during multi-channel audio then let's move it to the main structure.

BR,
CK
>
> Maxime

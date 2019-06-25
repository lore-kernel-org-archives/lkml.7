Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9102C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815732063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2V0fCvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFYNwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:52:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44398 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfFYNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:52:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so12660000lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iPCXBWydY7xCYkvB8WzAfUNgl288BVJPxiE7eymZwc=;
        b=g2V0fCvjO8+3g8khRYtLAnbQ17g4lqT6qVl4M0mCKmKWq+YJk1oLO9Zg92WOT9LoK3
         OJ0TbgMvhLM3u8/sWKSIZnczTTXm3pxHjZ4hcg2+xP0SHdqLuUhWnjCO/nyI7mCxfOZe
         pF55T17XglR3n4eL9/x16BxWXrtrXiwjNXvgCiX343miHdOa3JauxcHH2Pd3VPLIUbju
         dBu/T9IuBycyeZef+ZDn9NmJB//VdJvSTJAMDSW+w5UCFyoprRYxlkFYYs2xjZMCWpWd
         RF5Hj9cmTdbwLsAbZTQBlRpUofp+ZrJLl6R3kfCA1vvdesl9yKlln8Lfu898J7b2oa5c
         iQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iPCXBWydY7xCYkvB8WzAfUNgl288BVJPxiE7eymZwc=;
        b=fS7+pOpziwCazuazzXHYUKppzDxg7mleYhqVxex1z+rdOAvePA2KJtSCJQRoLo/RTb
         SkyhS81uiLaw9yd401kBtT2JiA9HgYr3RdaNtvMxP3qjuId6M7nmfaXIiRXH8k67hyf8
         0eNjhNVWdlx6nK2VANFFAoQ+76cxg9Hz6SN0Z96HtsUgoxkHBg+rgAlSL6WCagV1mj+F
         y5VgGma5oUUt7vNS7R4Q/PzMbbErUnyyu9XRsEDmMBN3nSNiKNR0QYg63sh94ynCh1Jp
         MntuQCSEyC/cJcbLjie+131TkjimKSfP4Hr7OhIr6LsORwDdAfn5yJ58yoM4enqRjXUA
         uLcQ==
X-Gm-Message-State: APjAAAX7GtBhq0OJSCoJ1V+p75VZ0oWTPc7Rzy+OrBeOstxBs0yvDDZn
        lNppiQr7PgYQoGzEtT7gvSyQdAQOdmhkYCJ8Hf1uRA==
X-Google-Smtp-Source: APXvYqys2XmtNKJMpGTxiNNF5eq3ErgW9CVtNHeSeJ6lfHCqj5xUU5+RhbLY8XHHRGOBrv8+Gr2dB9NfGnaPQOSPrJ4=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr14173585lfu.141.1561470742590;
 Tue, 25 Jun 2019 06:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190429035515.73611-1-drinkcat@chromium.org> <20190429035515.73611-3-drinkcat@chromium.org>
 <CAGp9LzqyRQ0knQ8+NanTAC0VVqBudAFPuCQJiyymmabaT1Hyfw@mail.gmail.com>
In-Reply-To: <CAGp9LzqyRQ0knQ8+NanTAC0VVqBudAFPuCQJiyymmabaT1Hyfw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:52:10 +0200
Message-ID: <CACRpkdZmNug21=6rz9U8-G5ONPywjCh6_y8-=msY+Y8WvZEm5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Update cur_mask in mask/mask ops
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 6:20 AM Sean Wang <sean.wang@kernel.org> wrote:

> The change is worth rewording the commit message you added above as an instance
> and adding Fixes tag as a fixup to mean you're fixing the existing
> problem in the driver.
>
> And then Acked-by: Sean Wang <sean.wang@kernel.org>

I'm waiting for an updated version of this patch.

Yours,
Linus Walleij

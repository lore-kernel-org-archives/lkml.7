Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC79120818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRma6EWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfEPMrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:47:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43701 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEPMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:47:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id z6so2111257qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W184LUt3OLZpc35GbIgyfbdRWYWzS470rOoUrNJBmxU=;
        b=TRma6EWmVqtTh6oyWeOyXuXYl+5HLkiD+FLBf6YYv1n3LTrxOJcXtDjC9qMNgWV3IM
         9/L3ct4DLiJQOWk/6Vr+Zcmy4GqUrvJkXz80l5T6lMeDYVdK+B2rz9KW/QoYjrG5fcXu
         dYY57kMN4S4l7szDwWKXb9Qsvi5JOUOtVT/i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W184LUt3OLZpc35GbIgyfbdRWYWzS470rOoUrNJBmxU=;
        b=gAkWxqSg9cJqOZr740JqOUGBFoVXsWJ8Y7L9AVOKjzVhJcWhuPE8TTSvBbYA6/h1y4
         xyYnLxZp4bUOifjsGBSKYSFwTZRaytYYO1cC2rT5wA0bTriKM4kkFtafaK7tWhfTUbOo
         JXMzD6CulzLB6GoK1KAe0siAxfHXrMH3ZqTzVObQXFEmJowOG+sL2jg0ITEHTtkzhg+3
         gF0oHc1ksiaGwzXgtezQpA0QpAgxFw4EVTFOHA/nMvtPKcQ2CSVwM8PhLiiBWyLd9SON
         hfFQEPF18bkd9IQS4XjZqmvJ+bQEySkPg8+gtLzKPmIhiN5stoZZ1uhSBW1hWz50suaT
         sJew==
X-Gm-Message-State: APjAAAXL0dluIyENa18Wj2BFLOAOczdaRlIzGsPIZ31Ivc7/fFlBuOZi
        hEm3cCpkRam0BpsG46jnJGI+VfN6d+OsFEWN4xxTJw==
X-Google-Smtp-Source: APXvYqybed54iK4vV+PN2Aj3PjQ2Py6dcAunCb38T+fR74fZCjJqmxhGgna5I/pOr2f8Y6E05PAXezd/gE5bKfmgw6I=
X-Received: by 2002:ae9:f818:: with SMTP id x24mr37963214qkh.329.1558010863680;
 Thu, 16 May 2019 05:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190508073331.27475-1-drinkcat@chromium.org> <CACRpkdZb73vNyepcfjzEGAopc7BBxde_N1wxn7PSJ3aGC0=Gig@mail.gmail.com>
In-Reply-To: <CACRpkdZb73vNyepcfjzEGAopc7BBxde_N1wxn7PSJ3aGC0=Gig@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 16 May 2019 20:47:32 +0800
Message-ID: <CANMq1KAOeuDCZEvV2A18nUts3WP2MbhUpY7gQ+vk0oTOz8TRQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: mt8183: Add support for wake sources
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 7:55 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, May 8, 2019 at 9:33 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > This adds support for wake sources in pinctrl-mtk-common-v2, and
> > pinctrl-mt8183. Without this patch, all interrupts that are left
> > enabled on suspend act as wake sources (and wake sources without
> > interrupt enabled do not).
> >
> > Changes since v1:
> >  - Move changes from mtk-common-v2 to mtk-pinctrl-paris, as
> >    recommended by Sean, to keep better separation between eint
> >    and pinctrl-common features.
> >
> > Nicolas Boichat (2):
> >   pinctrl: mediatek: Add pm_ops to pinctrl-paris
> >   pinctrl: mediatek: mt8183: Add mtk_pinctrl_paris_pm_ops
>
> All seems to look fair to me, but I need some official ACK from
> Sean on these.
>
> I see there is some discussion on a related patch set which
> also has two patches so I am a but confused how mature the
> two patch sets are? Are they at all related?

They are somewhat related, but I don't think this depends on the other series.

This series adds support for wake on mt8183, and makes it similar to,
say, mt8173.

The other patch series fixes issues that affect all mtk pinctrl
variants (i.e. I think mt8173 pinctrl on current mainline has similar
issues). It's not impossible that the answer to the other series is
that we need to refactor code, but in that case, if we merge this
first, we'd just have to clean up one more pinctrl variant.

Thanks,

> Yours,
> Linus Walleij

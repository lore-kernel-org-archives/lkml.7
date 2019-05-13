Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2047DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EEC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ihynEujh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEMUVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:21:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45101 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEMUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:21:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id n7so5314154uap.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuySUmJX7+xhfDb6fBuwBVyhUWbe9FHoL+dr16R0laQ=;
        b=ihynEujhHl0/kFd3e4X0WXi48xxh859HdVja7bEkA31bUjpl/penK1wa0zlw5r7dST
         JtzGce+FT5rp2fnJ/Cqp2xmViQjF8M1Pj5+MB7JlP63y4F3a5wwpu4tkLrs4Vudh/TIi
         inSG2Zfqn4/s2yGu+Vl3yRbG9RjwYr6RoklNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuySUmJX7+xhfDb6fBuwBVyhUWbe9FHoL+dr16R0laQ=;
        b=WzB7rmpST1WC2r/46EohYbdqLmvN9SkuotyR/vm+9X6NlwwIYo2dEfN3184stmS16S
         qkpVRMHIy//U/Iy0MRSxFuZ8lN8bBgNOmqniAZh20/YhEoc5AUyJNXNbacjNQ5GMXFj8
         W8abHubtMC0d+p40MzroVgOpRdSFJvWN75E5t+ESB1sY4RKpXh3C1Y50wv3lG2UzFiWI
         YYIjI+itU4m4A6gCIIcH+ujwsWpEV6d2pgzrhsI1R+6bUp6McWiIif+GkH+tSq5mF04n
         uex3PKxTW3gjoNpRegvoGnlbh5A9iNf/SExuwmpqevjYfDYdSaNlL1rOQOrtfeK4Hql1
         23Ew==
X-Gm-Message-State: APjAAAUD1q8v/0L9Ni8KhN2szX/6z+oTKHt1AuLtFmHQ6oqte/TeUcm3
        y68i09BwLYZrd0GAB1Hs5CK1n8T7wSY=
X-Google-Smtp-Source: APXvYqy/0MhpqdR34E0Z48yc9ehAGbjP+C9pDE2fj21ze699B80gjXaiimnrM2W03olR1zUECYuBkQ==
X-Received: by 2002:ab0:7019:: with SMTP id k25mr12705348ual.49.1557778895958;
        Mon, 13 May 2019 13:21:35 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 9sm1964424vkk.43.2019.05.13.13.21.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:21:35 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id y6so8887043vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:21:35 -0700 (PDT)
X-Received: by 2002:a67:b348:: with SMTP id b8mr6727835vsm.144.1557778894709;
 Mon, 13 May 2019 13:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-5-dianders@chromium.org>
 <20190512074538.GE21483@sirena.org.uk> <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
 <20190513160153.GD5168@sirena.org.uk> <CAD=FV=Xm-2oxit7doVAYJr28c-xHqUdt9PQC=WYpYfsAyUxuaw@mail.gmail.com>
 <20190513164738.GE5168@sirena.org.uk>
In-Reply-To: <20190513164738.GE5168@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 13:21:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkkKRJN+Vv6+nf8EjXoCuO-0MG923v-0HKPMYg=mdZww@mail.gmail.com>
Message-ID: <CAD=FV=XkkKRJN+Vv6+nf8EjXoCuO-0MG923v-0HKPMYg=mdZww@mail.gmail.com>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 13, 2019 at 9:47 AM, Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 13, 2019 at 09:03:28AM -0700, Doug Anderson wrote:
> > On Mon, May 13, 2019 at 9:02 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > I'm not saying the other changes aren't helping, I'm saying that it's
> > > not clear that this revert is improving things.
>
> > If I add a call to force the pumping to happen on the SPI thread then
> > the commit I'm reverting here is useless though, isn't it?
>
> Well, I'm not convinced that that change is ideal anyway and it does
> leave you vulnerable to further changes in the SPI core pushing things
> out to calling context which feels like it isn't going to be helping
> robustness.

OK.  Here's my plan: in v2 I've still included this revert and you can
see how things look.  If you hate it as much as you think you will
then let me know and I'll send a v3 that avoids to forcing and re-adds
the realtime thread to cros_ec.

One note just so you're aware: For my particular device I'm not nearly
as concerned with latency / throughput as I am concerned with
transfers not getting interrupted once started.  I've added this
explicitly in the commit message now, too.  :-)


-Doug

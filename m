Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61397C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA90205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBg4iX5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfLKSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:04:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43059 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfLKSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:04:14 -0500
Received: by mail-io1-f68.google.com with SMTP id s2so23602758iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lk2kHwOIGMIgDPaSWiDXXQawNgoxO/02PTT5MTHKBSk=;
        b=oBg4iX5BFblswDGY+ml4KpSu9P9MZzXv04sTj8aWJf/VNEZfCNpb1QRgyiF4L+TAhq
         vRmS0y1d6uDaeh07IjDEuYCwYKbW/ysvqPeXzgbvXkAczQYlCltxJedTvXM+OTPEFvu/
         XneacJuDxO1F0RmpEFe5D17tm1Gpq2YxaFOK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lk2kHwOIGMIgDPaSWiDXXQawNgoxO/02PTT5MTHKBSk=;
        b=OEk/qOX+FW4OsWGQTCoy/m3GkGLLWxHE696ztzj9MkDCJUVPkAYzXZAGlwQLzvb1pz
         eswI9dJAor/2v9DMtQiLwoPGmm1SeC4F0sMZlsSv10iwz34DVjsBT9nUOsNp/JrR6f4y
         /7H8uxPfwrN2xQUa6qBniiQ0WAnL9oaM+6oSaAvw6EqJ35Ch2444RPNCjjZhl7AYdBGx
         6718Er//X1tlClRqjXdtLfj8BdhF0mB4hvpfNQF/wj1PGbgDxNWeFeWlH5T5Sh/cB3rH
         8sCx8ZSTFIEn7dGeVL049o247qBm6yypTLYZN/AhASpZvofTO5oiwf5uJl1Ga/UoQI+Y
         WD/A==
X-Gm-Message-State: APjAAAV7FuncONQsNIjYYSFEoWuJpqwb2gJC75FV148z4V4snrUCBr+/
        ENuwuLtjKqth63oqJ2QZtEP23ViCK1Q=
X-Google-Smtp-Source: APXvYqwaN3nLHsu/llF1bkSmTdyIngsMJZNzW6pm2r/X9jao6Xe+yfhC7AmrUpNID9pCrdecoiCjtg==
X-Received: by 2002:a05:6602:2346:: with SMTP id r6mr3769426iot.133.1576087454106;
        Wed, 11 Dec 2019 10:04:14 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id m18sm671456ioj.74.2019.12.11.10.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:04:13 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id x1so23622138iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:04:13 -0800 (PST)
X-Received: by 2002:a6b:5503:: with SMTP id j3mr3620512iob.142.1576087452757;
 Wed, 11 Dec 2019 10:04:12 -0800 (PST)
MIME-Version: 1.0
References: <1576041834-23084-1-git-send-email-rnayak@codeaurora.org>
 <0101016ef36a9118-f2919277-effa-4cd5-adf8-bbc8016f31df-000000@us-west-2.amazonses.com>
 <20191211063829.GC3143381@builder> <0101016ef3c8e061-462507db-9d6f-4ead-8740-73b08ed97574-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef3c8e061-462507db-9d6f-4ead-8740-73b08ed97574-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 10:04:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHaFYsqt+3-jgJo8JWKxfRvgR_D-qP5e=TGq8h_f43EA@mail.gmail.com>
Message-ID: <CAD=FV=VHaFYsqt+3-jgJo8JWKxfRvgR_D-qP5e=TGq8h_f43EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: sc7180: Add new qup functions
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        LinusW <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 11:07 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> On 12/11/2019 12:08 PM, Bjorn Andersson wrote:
> > On Tue 10 Dec 21:24 PST 2019, Rajendra Nayak wrote:
> >
> >> on sc7180 we have cases where multiple functions from the same
> >> qup instance share the same pin. This is true for qup02/04/11 and qup13.
> >> Add new function names to distinguish which qup function to use.
> >>
> >> The device tree files for this platform haven't landed in mainline yet,
> >> so there aren't any users upstream who should break with this change
> >> in function names, however, anyone using the devicetree files that were
> >> posted on the lists and using these specific function names will need
> >> to update their changes.
> >
> > I don't think this paragraph adds value to the git log, but the patch
> > looks good.
>
> Right, I should have mentioned that bit after the --- so its not in the
> changelog :/
>
> Linus, do you want me to resend with that paragraph moved below --- ?

Personally I find this type of info useful even in the changelog
itself.  Without it someone inspecting this change would wonder why it
was OK to change the device tree bindings without an attempt at
backward compatibility.  I suppose they could always go back to the
mailing list and track down the history, but why is it bad to be in
the changelog?

In any case, if everyone hates it in the change log I won't stand in
the way, so regardless of which way folks go on that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

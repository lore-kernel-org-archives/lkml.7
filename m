Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5218E2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6cnK+73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLJUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:41:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35906 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfLJUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:41:19 -0500
Received: by mail-io1-f67.google.com with SMTP id a22so5303199ios.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFg8ZEWJIN7vey53mkr4mIFmYCyQyvthzeZbaGJwPkw=;
        b=a6cnK+73982+3Kq5xHFk7AV6S2kIJzbXAeQjdiuU/quDeRHtvjScGn9NdiBzAl+ehr
         YObqKIw+0lJPMEvJ2S4WKhnhjyPdQmeaAfUXnzZrpkSItd5rvp+KOq19FUd9FR3Xc07s
         PSqfT0D1aQ/Apqo1M8znUmPBZWMMbjplC9MMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFg8ZEWJIN7vey53mkr4mIFmYCyQyvthzeZbaGJwPkw=;
        b=Q04QJSciGjhjmYA2N4h1hwboT9ntE1OINLx2PqcOX8+uTrsEMfmfch/y1kvIGKryFU
         PTbBfT0rw1JYJxcG3vldVKMKIVwDQnmC9OD4ARiShvxA7qg4Kl668ZSHyAo9ycYV3uqn
         AmW+Ab1TgVmCj0JN2iTVc8bYGTTiACkghRZT6PuQa5zF3abfOVgLuon5dSuVXalV0i83
         L40pJ4pzPep4EYRQI405YEAQ31cm49pby5/Tfw8qUt0QYEoV73rd07zhojjO2QHGEddA
         3hF4kaGmdKeF03IkEoZ5eU3fThHK8n5HwgOW017ro5Rm6W+2QufpCMjEWsCgSGRQy+yh
         xwVg==
X-Gm-Message-State: APjAAAX2C1SyZHCGNuPPzUN+YI7LTKop5hN9hOdsN5y9cCxxVgEzjm9J
        sfrDY0BmyYrpUb80bwdQ2KRW1FAamh4=
X-Google-Smtp-Source: APXvYqwt20k9VNe12CsjJGP82mmp8e7sS4iFjYRjBRWY2qgoXc1H/tBA4WT6OGPu4mHdNT63vNdYmA==
X-Received: by 2002:a05:6602:2541:: with SMTP id j1mr26974099ioe.239.1576010478790;
        Tue, 10 Dec 2019 12:41:18 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id b15sm1216241ilo.37.2019.12.10.12.41.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:41:17 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id z193so20267370iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:41:17 -0800 (PST)
X-Received: by 2002:a6b:be84:: with SMTP id o126mr25960550iof.269.1576010477101;
 Tue, 10 Dec 2019 12:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20191108092824.9773-1-rnayak@codeaurora.org> <20191108092824.9773-14-rnayak@codeaurora.org>
 <CAD=FV=VUoj1egZqw9koNHDPBCCEh_XZ5nZAPNKcnya2UACG8hw@mail.gmail.com> <0101016eef5f3e37-2ab48ced-3543-4680-82f8-2c1950b012cd-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eef5f3e37-2ab48ced-3543-4680-82f8-2c1950b012cd-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Dec 2019 12:41:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgqcO0zELnopP9DXSqc-AZpJVwT24CDxrt_P39eWK9Lg@mail.gmail.com>
Message-ID: <CAD=FV=UgqcO0zELnopP9DXSqc-AZpJVwT24CDxrt_P39eWK9Lg@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] arm64: dts: sc7180: Add qupv3_0 and qupv3_1
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 2:33 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> On 12/6/2019 5:55 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Nov 8, 2019 at 5:29 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>
> >> From: Roja Rani Yarubandi <rojay@codeaurora.org>
> >>
> >> Add QUP SE instances configuration for sc7180.
> >>
> >> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sc7180-idp.dts | 146 +++++
> >>   arch/arm64/boot/dts/qcom/sc7180.dtsi    | 675 ++++++++++++++++++++++++
> >>   2 files changed, 821 insertions(+)
> >
> > Comments below could be done in a follow-up patch if it makes more sense.

Just to note: looks like your patch is now landed in the Qualcomm
maintainer tree, so I'll look for the fixes in a follow-up patch.  :-)

-Doug

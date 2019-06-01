Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE8C28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CED27050
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNJY/3yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFAAFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 20:05:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36635 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFAAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:05:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so6895997wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8wl8Ebr+tk3zdpRQhTbcjzF7wVJuwWPREKgkot9nSU=;
        b=WNJY/3yWFpK+ZSv7Sxw4R3kUbleuB6gvBougV0etbg8DpJcU4ZBc5RQKwXJzf6ih8/
         ihAgNSuoaYELwpfeBMVRfqiKXP1yormx16Tl5sx0yli8Qh3KuJTVHD/1L5r1KMvjlSkT
         aqbw4BpqU2oYWkcmoEvoPDDG4jNuIAAs9VOHhM+i/9riLzEBzZA9AA0wkeCsY3Ebdj+s
         wD88tcTcr4KudgeppRszfgbrcFEPUVvpSulgAfcl+gdeajNaTtSPnjuOTv1N+XeickCA
         ML1DAXzB3sh80l02yfMPxJH6qXWtsNIhJI6z07eXniTB0Cj4V0UuZa09o9o0Qv68b44w
         KANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8wl8Ebr+tk3zdpRQhTbcjzF7wVJuwWPREKgkot9nSU=;
        b=fIn1qb7N0a4MBjR0ulIPQp2kx9Hoox8qxNfsE70y6Z7cxyQz17L35pHshbvlr3ZTfl
         llKRyJDrdTWxZmx64ffyIC1vELYVx167xylHN9aSemBWlgzKWCzQ2IYkEDFsMswIAyt6
         E/ktJvhf0WWzNW6fI/hYqyaMscKEIMrjTliWgQZGl4w1wP5HxIIvMPOIRXCI7/pdrJ6q
         G/tGPMrDEwO7zS2EGkcnkWwSAe3almzeGdYuAnulzMn/8WJWPXmenVwGPcgLOINsKBgz
         um/cxn4eS+KJaa7BTyzAlB/D5k9QHfj2rLugK0ABD/BLuL2IMNCVQoYIZo8cRgUUa0c5
         878A==
X-Gm-Message-State: APjAAAXIEJxQgxauyuLnOgQiPvDehq9+9RRs7KNhTHQURjckcWn4pVqW
        WR7lOadEANSw3v+ziwneNQ58ZZTfNwMr+WurKPaU9w==
X-Google-Smtp-Source: APXvYqx6IqRo6a9cOKueKjJoBvf6m40KnlPpQdf6c682eEXGzCyVjaUTixWO7j8FalDLH0+SUsUPfSsPHlP05rS3Z50=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr1080859wme.173.1559347542656;
 Fri, 31 May 2019 17:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190531234734.102842-1-john.stultz@linaro.org>
 <20190531234734.102842-2-john.stultz@linaro.org> <20190531235302.GD25597@minitux>
In-Reply-To: <20190531235302.GD25597@minitux>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 31 May 2019 17:05:30 -0700
Message-ID: <CALAqxLXAdu63roX0WgXHqOwrr2dyJV+Oh06SSu8D+LqUOE3gng@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] reset: qcom-pon: Add support for gen2 pon
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 4:53 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 31 May 16:47 PDT 2019, John Stultz wrote:
>
> > Add support for gen2 pon register so "reboot bootloader" can
> > work on pixel3 and db845.
> >
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: David Brown <david.brown@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Amit Pundir <amit.pundir@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi |  2 +-
> >  drivers/power/reset/qcom-pon.c       | 15 ++++++++++++---
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index d3ca35a940fb..051a52df80f9 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -39,7 +39,7 @@
> >               #size-cells = <0>;
> >
> >               pm8998_pon: pon@800 {
> > -                     compatible = "qcom,pm8916-pon";
> > +                     compatible = "qcom,pm8998-pon";
> >
> >                       reg = <0x800>;
> >                       mode-bootloader = <0x2>;
>
> We want to take this through arm-soc and the rest through Sebastian's
> tree, so please provide the dts update in a separate commit.

Sure. I wasn't sure if tracking the change in a separate patch was
worth it for such a trivial oneliner, but that's fine, I'll split it
out.

thanks for the review!
-john

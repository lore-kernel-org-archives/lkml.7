Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736402146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFn7VKlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfLQGVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:21:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39656 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQGVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:21:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so105542pfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwHTfnJaI9qnMvf2gSHfOz3OAkZOCzCGX5TYMPhWqUA=;
        b=dFn7VKlHM/jteR5MfqGleAz/hb1y6mlIHXAhvp1Jq7TNAdwfpl0D30IIVXK32ytp6Q
         +YAo0OOlee56Yr5UTweg+CKiB565URXCbLnmw4B8JBfXVDOngHrK8DX0OPk6m5eVc0nE
         b9VPMLnT2AxEfHM/z5N53rqS/4C2J1ciUc/x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwHTfnJaI9qnMvf2gSHfOz3OAkZOCzCGX5TYMPhWqUA=;
        b=tpjtFnx/6Fh69ElM5+vvLNcmnDC0igOgFC00lP+AUEZUnG7i3cqKsKAOxzbxfvHBj2
         jbvjWrMdO25IPa+VXZuFR5u2J9+PriWVrfrr72BiGXm1MeIurAtCR8xEBv1czGujO+tt
         6I81s59YxyUuu8ry+DV5Wc+JbtPG9zSAoNYcyN9qjpiAFtPyf0nw94gpPh//VOrir1Vc
         cwWBdWJKld+JehLlvghh8azrWyCkc+M6hHQMFTTQ7WNzBbS3aykeBCbhNf5wItVCJACA
         jPba9s3Zz13fNc6htvT9t7Ly0XNfzZ7w7dpwW9ai/Qj9nr/J6eYWmD195EbHgPx73EaJ
         HxKg==
X-Gm-Message-State: APjAAAX2S0KSnDgBiWEK/fbihyLyYALDo8mX9pFrTdOuR5t8AFw0cWDe
        gfMsDeAYhOkz/AGdm7TP2dSmAPuajOU=
X-Google-Smtp-Source: APXvYqwxES5aBvLx0gBZPoQ4uf9OPrXMPXj76HdARJWVjDzl5iECGlwFNrhuI6ftbaxuc8XBOAWO+g==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr20889973pfo.213.1576563674196;
        Mon, 16 Dec 2019 22:21:14 -0800 (PST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id s18sm25538894pfs.20.2019.12.16.22.21.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 22:21:14 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id q10so105528pfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:21:13 -0800 (PST)
X-Received: by 2002:a6b:be84:: with SMTP id o126mr2416373iof.269.1576563289206;
 Mon, 16 Dec 2019 22:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid>
 <5df2b752.1c69fb81.77c46.0f9a@mx.google.com>
In-Reply-To: <5df2b752.1c69fb81.77c46.0f9a@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Dec 2019 22:14:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UGRqeAr8vVUfx3ADyxNLJRz3g=YhWNX1adgepx_kADrA@mail.gmail.com>
Message-ID: <CAD=FV=UGRqeAr8vVUfx3ADyxNLJRz3g=YhWNX1adgepx_kADrA@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sc7180: Use 'ranges' in
 arm,armv7-timer-mem node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 12, 2019 at 1:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2019-12-12 11:35:43)
> > Running `make dtbs_check` yells:
> >
> >   arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: timer@17c20000: #size-cells:0:0: 1 was expected
> >
> > It appears that someone was trying to assert the fact that sub-nodes
> > describing frames would never have a size that's more than 32-bits
> > big.  That's certainly true in the case of sc7180.
> >
> > I guess this is a hint that it's time to do the thing that nobody
> > seems to do but that "writing-bindings.txt" says we should all do.
> > Specifically it says: "DO use non-empty 'ranges' to limit the size of
> > child buses/devices".  That means we should probably limit the
>
> It got cut off here. I'm waiting to find out what it is!!

I was going to say that I should use ranges to limit the address cells
in addition to the size cells, but then I think I must have got
distracted and forgot to finish my


> > I believe that this patch is the way to do it and there should be no
> > bad side effects here.  I believe that since we're far enough down
> > (not trying to describe an actual device, just some sub-pieces) that
> > this won't cause us to run into the problems that caused us to
> > increase the soc-level #address-cells and #size-cells to 2 in sdm845
> > in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
> > and size cells for soc").
> >
> > I can at least confirm that "arch_mem_timer" seems to keep getting
> > interrupts in "/proc/interrupts" after this change.
> >
> > Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> This pattern exists in most of the qcom dts files. Can you fix all the
> arm,armv7-timer-mem nodes. Maybe the binding has the same problem too in
> the example.

Yeah.  I'm a little scared to go and do this for every qcom device
tree file since I have no good way to test them, but I suppose I can
give it a shot.  I was kinda thinking that, in general, it would make
sense for folks to tackle one SoC at a time and make that SoC clean
and test it.

In any case, your idea about updating the example seemed wise to me,
so I sent out:

https://lore.kernel.org/r/20191216220512.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid

I'll put this patch on hold until Rob gives his thoughts on that one
so we can really make sure we're supposed to be using ranges in this
way.

-Doug

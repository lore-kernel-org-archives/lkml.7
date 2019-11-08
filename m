Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0AC17442
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E229821D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573256781;
	bh=DVj4e+5dUvj9CfxICEqKu/slf5ah4O7Xbig8CEBOmbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lsqztd57UI7pwIEyHIZZg9zpQJ89Xxlwj6x/ACi6ArsaWsaxi1fGWkSbMwXjU9rsE
	 ThYlm+EBgM+cC+fl5Ezxta/pARlDLSn+n8ChUMyz6eL1hQz7sTK4R/qhYKIB8LggHd
	 nRiAfdebRytDETwNfo7zFqYDvojkno1u7lq9c/zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfKHXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfKHXqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:46:19 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CB52178F;
        Fri,  8 Nov 2019 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573256778;
        bh=DVj4e+5dUvj9CfxICEqKu/slf5ah4O7Xbig8CEBOmbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Q08bsrwaIq1CxO+JYAxaR0HUa1jeyfp5ofNTHcm+BRf6M0SaPGm9MLqCgX8L/zg7
         k6LruowSA87rOvg93jts7y6yRTyYov/GR2hmgCxVhvcGodHBjXjbxcd1poMHZnG5Ip
         zvpJxMCBbqxeaym7O2RcZ7uxqJ0l9Bp+/oIEp4Ys=
Received: by mail-qv1-f47.google.com with SMTP id cg2so2903043qvb.10;
        Fri, 08 Nov 2019 15:46:18 -0800 (PST)
X-Gm-Message-State: APjAAAXMrZQKQ2Jm+6+cMQuAI+93YTu/7a6xD+tlVD3wRqtVQs5LZhFX
        dbrFUEYSfhBHj1DMydR12ANqjrp/6nocAlZPgA==
X-Google-Smtp-Source: APXvYqxK4HOtNnah0NRINiwTwCR12VgWOScEENJQK+B+kNIZk+sXgNhwk2CFPqmGQZ4pNC4OirtSwuoSGI2+NgYHZ+Q=
X-Received: by 2002:ad4:43e9:: with SMTP id f9mr12596446qvu.66.1573256777935;
 Fri, 08 Nov 2019 15:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-9-rnayak@codeaurora.org>
 <20191106165632.GA15103@bogus> <3302bde7-2299-476e-e3cc-35c84a459d63@codeaurora.org>
In-Reply-To: <3302bde7-2299-476e-e3cc-35c84a459d63@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Nov 2019 17:46:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+iO8mFZDPCGBA+yhuwdSxKq6AJk2cHZK4QDB7VA3gWUw@mail.gmail.com>
Message-ID: <CAL_Jsq+iO8mFZDPCGBA+yhuwdSxKq6AJk2cHZK4QDB7VA3gWUw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] dt-bindings: qcom,pdc: Add compatible for sc7180
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 11:46 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
>
> On 11/6/2019 10:26 PM, Rob Herring wrote:
> > On Wed,  6 Nov 2019 12:20:11 +0530, Rajendra Nayak wrote:
> >> Add the compatible string for sc7180 SoC from Qualcomm.
> >>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Cc: Lina Iyer <ilina@codeaurora.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> ---
> >>   .../devicetree/bindings/interrupt-controller/qcom,pdc.txt      | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> Sorry I missed mentioning the delta and the reason for not including your Acked-by.
> The previous patch was proposing using just a SoC specific compatible, and this
> one adds a SoC independent one along with the SoC specific one as discussed here [1]

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>

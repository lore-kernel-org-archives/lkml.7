Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030BD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551364924;
	bh=0j7VLRsjdyL1RWs15bN8fpT8ougGXqtBh0dJZ46cKto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cFe28U17KLjbY6GVgyhGQSYDsQcjhjitYLpPc7drW0xtTccBh73n1/7DdVXW29xNF
	 3Ssx3Fb4Qym2hrdAGqJM/RXq5gnG0OaUOPs+u7kY+C22tFmwvIghWqOFqCAZ12Oeen
	 e8ecd6XNgzwcY02IKt8Vgy6quqIT9d7KAZ/40pnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfB1OmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfB1OmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:42:02 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAE8218D0;
        Thu, 28 Feb 2019 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551364921;
        bh=0j7VLRsjdyL1RWs15bN8fpT8ougGXqtBh0dJZ46cKto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qJT5JZeaZH4mKnSLNFCdDF4DhMqxFZ/VxFGrWHXd2TuOr0M0KAy4wfFLeu0Xp852g
         YDC60WDEkF9OgWTLfZlLQizPlqtrBodbBI/RR2nWvzhQEiF9YmdJbTSc9Rcy2xpEIa
         teILwjIULSXrZU5MB9HG8EO2BjU6K4auRMkkYGeU=
Received: by mail-qt1-f169.google.com with SMTP id w4so23770214qtc.1;
        Thu, 28 Feb 2019 06:42:01 -0800 (PST)
X-Gm-Message-State: APjAAAV6WhiONS8vjW+q81xZhpVXMHxpvaL5VIJcqQfQjT7qVuHyj/ew
        GcnkuLk1FKVouBA9rlqHJg5U8xN4uUE8jvQZhA==
X-Google-Smtp-Source: APXvYqw156MbwVHJjOmPiRVmtA6RR/wp6AYn6Kxa96TKSlH0SMU+Fv8wUmXJFpF4AhReJtl5oRIePkRFdDJ4uRA6eXI=
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr6620502qvg.246.1551364920462;
 Thu, 28 Feb 2019 06:42:00 -0800 (PST)
MIME-Version: 1.0
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-2-git-send-email-amelie.delaunay@st.com>
 <20190227235535.GA24395@bogus> <c54c4fd8-b97f-a70b-4805-fd3d217f5050@st.com>
In-Reply-To: <c54c4fd8-b97f-a70b-4805-fd3d217f5050@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Feb 2019 08:41:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+orZUitUvMtKJ8ww4hnn9eacy5Xak+oTO_MGrgSGJpw@mail.gmail.com>
Message-ID: <CAL_JsqJ+orZUitUvMtKJ8ww4hnn9eacy5Xak+oTO_MGrgSGJpw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:54 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>
> On 2/28/19 12:55 AM, Rob Herring wrote:
> > On Wed, 27 Feb 2019 10:34:46 +0100, Amelie Delaunay wrote:
> >> This patch adds documentation of device tree bindings for the
> >> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>   Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> >>
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
> >
>
> I'm sorry Rob, I forgot to add your Reviewed-by on this patch, which is
> identical to v3.
>
> I reposted the whole series, due to changes in MFD driver with side
> effect in pinctrl driver, but bindings (MFD and pinctrl) didn't change
> between the two versions. I stated the changes in cover letter.
>
> Should I have removed the bindings patches from the series ?

No, as the series should be applied together. You just need to add the
Reviewed-by so I can ignore it.

Rob

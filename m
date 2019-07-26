Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD357C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197C22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/Tfy/qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfGZMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:10:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46783 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGZMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:10:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so26757477ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrQTsqOEOykeYsYpjUAu93byMK1KwkPcKibV3U5vnJs=;
        b=n/Tfy/qYbxxPMGO0GtR4PSwWNzJiHr/teYhJWdmOLIQXeIGRhXlrNAOjHxIg44X/c8
         rTMphlu7MEMszPQPE7i0KXL/fg/5WjYEzxco2QaaRD1yrK2bg+KCzZWa39ZRgNTM2LtM
         lCI+/my1YocZGIgiqhq3JHhPYzlOqgYvp6ZdftyiDQSF1s5Nqn4vzv+ZzYEuh31enYTk
         jjQ04X5nn2NicQK3HyVuUjV+toViPvNj+wcJA44R4DusLvIx9mXjaDaZ27VLOEOxPKkn
         k32sNyCUvsUw8nN+h7F+9P8EGFwgzyFqenM4BP1xKx9k2fNKMAwbFIXSWbIArOH/RDFF
         Qdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrQTsqOEOykeYsYpjUAu93byMK1KwkPcKibV3U5vnJs=;
        b=p0iIbu5PacGrPPJyCmCBudiuOeod5u21A7Ginit4PN+blowLOH4Xex8I6IMAa02sZe
         oxJ6ClFzOR80s/sTFfFOcc/UEGAE7enSKZWQxeJ+TG8PT7nwjFU3gasZwyQ8PjIe2hhy
         qK4o30pL2tMfh2bI5admGJq+9GJ6PWU09Xr2x5CeEFg6nn3D+HKJp0F1GD6yhFgYgBiF
         GaR/FLYZvDwSUWPOY0mIje0Gn24W3BL9fymeuWjKw3r3N0rjFz3Wqcbxj7LAr0JZPc1/
         QQuTyDSwa5br0lBicaBkyj8djzwKnq4eWT86lasnK+vRCq9Rps1fVe+EpLWgtZAooZbG
         NIUg==
X-Gm-Message-State: APjAAAVJfpdFGDs6v3g2JIn0Sh9pBeKy4p1XWhc34zNML6tH7kLLOhUp
        u6y6zSZ9tj6El59AQX/tnqC23DU1hwCqEAGWRt5VMQ==
X-Google-Smtp-Source: APXvYqywRN7n6lzmjA5a4KHs4TPzxtEcwP96gaeiFcPkyYj2chffCIcDU5MoSxlTXx3/N/hta8tMsIUOdAnpviY8SDk=
X-Received: by 2002:a9d:529:: with SMTP id 38mr69587609otw.145.1564143014185;
 Fri, 26 Jul 2019 05:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564125131.git.baolin.wang@linaro.org> <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
 <20190726112901.GC4902@sirena.org.uk>
In-Reply-To: <20190726112901.GC4902@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 26 Jul 2019 20:10:02 +0800
Message-ID: <CAMz4ku+3FVOYr7Gvh-Yrdhvw2cfntbnEkhONYGbC71UmCgZA-A@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to
 be optional
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, weicx@spreadst.com,
        sherry.zong@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 26 Jul 2019 at 19:29, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 03:20:53PM +0800, Baolin Wang wrote:
> > No need to add hardware spinlock proctection due to add multiple
> > msater channel, so change it to be optional in documentation.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

The subject lines format 'dt-bindings: xxx' was recommended by Rob, so
I am not sure if I need to change the format as 'spi: sprd:'? Thanks.

-- 
Baolin Wang
Best Regards

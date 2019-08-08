Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5FC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3070D217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VMkDtAtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfHHDCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:02:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37621 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389632AbfHHDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:02:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so43210893pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/Z7L8SyshdubRcyIY95repgYfqLBFE4FKfh7eq8hsWQ=;
        b=VMkDtAtLTGvihLldZdjOKfErDSzMhon6bH5G3BdL+lkNsLL3dhRGrdijMSDj0i4/7d
         I4trJ2cPBcfQ9b3hUyrfivjLrr4sWMt8cYYyyVntaeqVNyAvZ5dxivLyOgVXVvDiPk6c
         jkqX9k20VGWNQKfp3L0eAGSlUB+86FaeW6LxVEayaRqcWTMWv0F3CGeFSxefboLbNnsR
         S1XHjj1FrqZi3qhOfdimenhnFDt052N8RMB9eb8BKX6yHcHBDlefcglRUp7sKokpTRMx
         sd9CmtD2VJcXM8d2+Wd2EqZ/6xbNLNJMIZshGNVOVfMuYEXBx85IGCNog25/90slfPuc
         dtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/Z7L8SyshdubRcyIY95repgYfqLBFE4FKfh7eq8hsWQ=;
        b=MrwJwpGnxWb3mqS9i9Fkwn6u7WXOsbbsO14eZbiFFTmVSTJzvkEI/LAW03PuxYV2Kq
         epf6FNceKesEY1WDfDqgBtK085mHX/R0DYG7y6s8IbyLIqf1btcf5lXyviO+2VhVhAiO
         FcwSGbqFTGNtRdJRYQI4AEhNRs7Yl9+FguUHrxy/KZF9P3HuOAhkHgK2TWGnrV3dXKj5
         /t/QMFtbQ83iEev2oTtaWrt9tW1pP0aDBuSfi7+rbhUpfzEmNobxa5pzTE69ky4JQxVK
         fLh1knjftKQ6dupqupOn4HLqRWUJOgeqQSPV89g7/eIHtdd6QGOkWBvhTDenK7XBWqlY
         CCJA==
X-Gm-Message-State: APjAAAUPtcLWv6SmY2eunnAULnODVcsDXfrgxnSGs17+9NPSVPQlJ1hq
        cPYIrhShPp4p3Sgih8bzs+nO8w==
X-Google-Smtp-Source: APXvYqylJQrZTaVlqLyT+6q2Nr1Mjd7x1ZREstnHaNOUKd1r3XvtkoAaiLRMfJ80fzLmRpUIRf0/6A==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr13114157pfd.207.1565233355043;
        Wed, 07 Aug 2019 20:02:35 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id q126sm52203296pfb.56.2019.08.07.20.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 20:02:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B based S922X SoC
In-Reply-To: <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-3-narmstrong@baylibre.com> <7hblx3gua3.fsf@baylibre.com> <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
Date:   Wed, 07 Aug 2019 20:02:33 -0700
Message-ID: <7h7e7ofjg6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Aug 5, 2019 at 3:46 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>> > Add a specific compatible for the Amlogic G12B family based S922X SoC
>> > to differentiate with the A311D SoC from the same family.
>> >
>> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> > ---
>> >  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> > index 325c6fd3566d..3c3bc806cd23 100644
>> > --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>> > +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> > @@ -139,6 +139,7 @@ properties:
>> >          items:
>> >            - enum:
>> >                - hardkernel,odroid-n2
>> > +          - const: amlogic,s922x
>> >            - const: amlogic,g12b
>>
>> nit: in previous binding docs, we were trying to keep these sorted
>> alphabetically.  I'll reorder the new "s922x" after "g12b" when
>> applying.
>
> No, this is not documentation ordering. It's the order compatible
> strings must be in.

Ah, thanks for clarifying,

Kevin

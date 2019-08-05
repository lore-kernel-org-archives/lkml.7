Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F2A2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565044021;
	bh=5QqKfUQlNAGGXBrLFCDl97vIo9RPGyUF2niHSSyTvcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YXLKbkXFDECgLC3tERD/v7ZAfVAxABaoc9VEiZMsib3RhSFAquxQAst4jv/OxDbiD
	 Wdn8Z8os0Kp9R9bDJtHFgd2/ZCIO37JEEtvqiTtSkEU4ZrZyrSzj7Et+ImngS1r09h
	 hbdRAEQkJN/zD8cLiqXWdJlFH8T/KivfujFJykdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfHEW1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHEW07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:26:59 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32412070D;
        Mon,  5 Aug 2019 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565044018;
        bh=5QqKfUQlNAGGXBrLFCDl97vIo9RPGyUF2niHSSyTvcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ApUwl0LsccWFP4qaiKNWLJDa0HqjDYY9+EFUhWoJqsiSiii0heKrwD51oEW5xvTNe
         ZJy5/TiR+RCfRoXdQm6SO4KsCkPMzPWFtGroHraP+pSJP5q8Badns+zZVC21LMnsCn
         5SdpQBYIsAYfvNZlhUP6iPadyR87NqGY6w7J6zrg=
Received: by mail-qt1-f170.google.com with SMTP id z4so82674550qtc.3;
        Mon, 05 Aug 2019 15:26:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUXUg44coMq6GgwkUWgYcvtSHQaE0fAIGKdQjEG/v8lWtpm/Wej
        Mnm/tT/WCq9F8d2kcLIFGkOIMziYvAL9O1kL0A==
X-Google-Smtp-Source: APXvYqzc4gt0XQb5ELtE8x9Bx00YbzwNJNxdKrfP9+wySRU4Hw1/j4rPECT9RH7hGOz2CxU9uMS3pmt4UjmSQvspWaw=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr389741qth.136.1565044017965;
 Mon, 05 Aug 2019 15:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com>
 <20190731124000.22072-3-narmstrong@baylibre.com> <7hblx3gua3.fsf@baylibre.com>
 <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL_L2qHe334sB57hR_coRhawKiqXYjKAQDJt_DHfBamBQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Aug 2019 16:26:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLavYVXi8MGEEs32-peYRTO2+V8ALKRxEKpLJwhyJByrQ@mail.gmail.com>
Message-ID: <CAL_JsqLavYVXi8MGEEs32-peYRTO2+V8ALKRxEKpLJwhyJByrQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B
 based S922X SoC
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 4:21 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 5, 2019 at 3:46 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Neil Armstrong <narmstrong@baylibre.com> writes:
> >
> > > Add a specific compatible for the Amlogic G12B family based S922X SoC
> > > to differentiate with the A311D SoC from the same family.
> > >
> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> > > index 325c6fd3566d..3c3bc806cd23 100644
> > > --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> > > @@ -139,6 +139,7 @@ properties:
> > >          items:
> > >            - enum:
> > >                - hardkernel,odroid-n2
> > > +          - const: amlogic,s922x
> > >            - const: amlogic,g12b
> >
> > nit: in previous binding docs, we were trying to keep these sorted
> > alphabetically.  I'll reorder the new "s922x" after "g12b" when
> > applying.
>
> No, this is not documentation ordering. It's the order compatible
> strings must be in.

BTW, you probably should run:

make DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/amlogic.yaml
dtbs_check

on your tree regularly. This will catch any errors like this and
undocumented boards (but not undocumented SoCs, still too many for me
to get that in place).

Rob

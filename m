Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1AF2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567770643;
	bh=6UFqIwtKvW1eriIbgBgmH3OSdsldJSwILczL2ULz+PM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x5tkCnUqZhcEpPpNcUcRu1zEnfuSHJVlsvwzP0rPimD/K93I1H2m64RprT0qUZn01
	 5fXbuReOXcl5S1CNZhziZkkX4K2zpSMvhuG5lDZRqnmSt6hnDQOxCD+3KQPI74IXWe
	 5Tvfyu6mmKMXRyQzbkxwbCDYY1rfihr7du+GqQ+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbfIFLum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfIFLul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:50:41 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6C9214DE;
        Fri,  6 Sep 2019 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567770639;
        bh=6UFqIwtKvW1eriIbgBgmH3OSdsldJSwILczL2ULz+PM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N0csuP4JYNSPIcZcs0RweApE9TD0NSFN9lth+8XvaWizi5oye5mSl1exsL720mVul
         8hs0HcoXfks1iXMpZQRUSutucTK2AHQM5cfFa4//G1fsXWd9hwFBbihKbHHv9wm8nc
         zYiitj3mdsobc6gRClSXtKkB6rbLd2JR/WaCCElc=
Received: by mail-lj1-f179.google.com with SMTP id j16so5737941ljg.6;
        Fri, 06 Sep 2019 04:50:39 -0700 (PDT)
X-Gm-Message-State: APjAAAVomMaKdraHykT5qZVoJbRMSOgFbJtBKYqY5/mknH4vy6mcW2Ju
        jrWr3+q9EZB5Cc4mrWcg6YW5Tk8ARIxfK/rh+5k=
X-Google-Smtp-Source: APXvYqxWkRdWTlhJIL7EvtAYDTFsy7AyeWu9slg4CHeVr9feUDarBlHinHRQL9wXQP33htWdRErIEeuuvAQCICFYSck=
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr5508092ljj.5.1567770637352;
 Fri, 06 Sep 2019 04:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190906101407eucas1p15eb0df53374b27497b4793eab24becf6@eucas1p1.samsung.com>
 <20190906101344.3535-1-l.luba@partner.samsung.com> <20190906101344.3535-4-l.luba@partner.samsung.com>
 <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com> <52963d0d-cf48-7085-5581-a94c6e15e0bd@partner.samsung.com>
In-Reply-To: <52963d0d-cf48-7085-5581-a94c6e15e0bd@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Sep 2019 13:50:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
Message-ID: <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 13:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 9/6/19 12:56 PM, Krzysztof Kozlowski wrote:
> > On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
> >> Minor fixes in the old documentation.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
> >>   1 file changed, 27 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> index 3b2485b84b3f..de0905239767 100644
> >> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> >> @@ -40,10 +40,34 @@ Child nodes:
> >>     a given speed-bin. Please see Documentation/devicetree/
> >>     bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
> >>
> >> +Samsung K3QF2F20DB LPDDR3 memory
> >> +------------------------------------------------------------
> >> +
> >> +This binding uses the LPDDR3 binding (described above)
> >> +
> >> +Required properties:
> >> +- compatible:  Should be:
> >> +               "samsung,K3QF2F20DB"
> >> +               followed by "jedec,lpddr3"
> >> +- density  : <u32> representing density in Mb (Mega bits)
> >> +- io-width : <u32> representing bus width. Possible value 32
> >> +- #address-cells: Must be set to 1
> >> +- #size-cells: Must be set to 0
> >
> > If you decided to repeat all properties again, then it deserves its
> > own bindings file. However I though about simpler solution - just
> > document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
> > There is not much benefit from copying all these properties.
> OK, I see. I will add only 'compatible' and skip the rest then.
> So the lpddr3.txt file will get this addition:
>
> +Samsung K3QF2F20DB LPDDR3 memory
> +------------------------------------------------------------
> +
> +This binding uses the LPDDR3 binding (described above)
> +
> +Required properties:
> +- compatible:  Should be:
> +               "samsung,K3QF2F20DB"
> +               followed by "jedec,lpddr3"
> +
> +Optional properties:
> +
> +The optional properties are the same as in the LPDDR3 generic bindings and
> +values should be taken from the data-sheet. Detailed bindings are described
> +above.
> +
> +Child nodes:
> +
> +Detailed bindings are described in LPDDR3 generic bindings described above.
> +
>
> Is it OK?

To me it is still a lot of text just for one compatible and I can
image more of such entries for other memories... However I do not mind
and anyway, YAML will simplify it. If you're in doubt, wait for Rob's
reply as this is his part.

Best regards,
Krzysztof

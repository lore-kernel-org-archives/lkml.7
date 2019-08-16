Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FDC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F375A21655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfDCPmmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfHPJum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:50:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39569 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfHPJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:50:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so3562398wmg.4;
        Fri, 16 Aug 2019 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/HQvzLuPAQzjKYNQcL4AudsvSLCJBYrtDqCfaQEVXs=;
        b=XfDCPmmDvgMEo9nSZCmOTkdIcYwbI4SSP722mwKE9xlgtpOudXrDNTFX6AnvRaQ5mc
         ULRJKcs+rhNt1YMZrquluQMOQdw4FfRxSuYz/L+LPRJd5jtYAqwMYKujzVCWg8XiYSIg
         sZqjv/HBTRVciGEmbL9sKRDTtS4ccaBPBmOJZeV3FqdPuKtBfZOSkWFYEZvBKFW1L5fA
         GyCFloxyiD1v7YjVrUQLEylEw65+cCp7vc1v1/ePjOhz0LigqqgpoIAX1yaBTGCxPmNd
         7hvHEDyTfcbaUm+tUwnjgsVZL5oHgJtEGIyiwMwfaov7HlrsWqQ+hqPMaoZFN5i4tJmU
         LYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/HQvzLuPAQzjKYNQcL4AudsvSLCJBYrtDqCfaQEVXs=;
        b=Sr3tUHFiKb0TgInq/Ytu9Gi6EMiIdJ2C2QHE7SGtffxiu/5uu+jGfcrn14fQ1qsOa9
         Un9Ew6RbTJXOflyOP+lullgtyaMEMf8pD2fKZMyzLHN62XBh9rC1Da9nSKHXDEGYZx+F
         13yXrtaMeQvCxd/HVWMDa2tVh0YHe3Cx01LoFOo9cqCUP3q4IKwCHZLDvZQZfCkCMAlX
         yDcHQ005g5ziLEjD+PA1bOnWNJo3vvWxxl8xU5mCkCV+GW8YCqnJ4AvZ3kX8Fx6VEwPA
         BEBfHj3Bb4+Q5wR+/p0qbWqeflZ63TK9kLzqZ+UFxFmgbTvty98wZkUVOqotqmVmszF3
         D7EA==
X-Gm-Message-State: APjAAAU57SBmUOI1Ea3llyX7YZGtDjGGiIrq2BHyg4pW0VjpDWg0pBkW
        NdU8ia1y4cVbjQBj2cUIOMw=
X-Google-Smtp-Source: APXvYqwout1PTGybrAk1uFRmU1LEyuvD8f9+M7j9OpOBrAG0FWKgRTuABVYoIjQHW3/bgSyt+ktSjw==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr6781103wml.64.1565949038988;
        Fri, 16 Aug 2019 02:50:38 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id h23sm4076063wml.43.2019.08.16.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 02:50:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, peron.clem@gmail.com
Cc:     clabbe.montjoie@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64 modelA evaluation board
Date:   Fri, 16 Aug 2019 11:50:35 +0200
Message-ID: <2361666.6tDiKGV9WF@jernej-laptop>
In-Reply-To: <CAJiuCcfASQriPLMuwuDCn9bU=_8q4jL+KkPo8NmMrrYpOqy2qA@mail.gmail.com>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com> <20190814132001.GC24324@Red> <CAJiuCcfASQriPLMuwuDCn9bU=_8q4jL+KkPo8NmMrrYpOqy2qA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 14. avgust 2019 ob 15:28:53 CEST je Cl=C3=A9ment P=C3=A9ron napi=
sal(a):
> Hi,
>=20
> On Wed, 14 Aug 2019 at 15:20, Corentin Labbe <clabbe.montjoie@gmail.com>=
=20
wrote:
> > On Mon, Aug 12, 2019 at 12:56:56PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne =C4=8Detrtek, 08. avgust 2019 ob 10:42:53 CEST je Corentin Labbe=
=20
napisal(a):
> > > > This patch adds the evaluation variant of the model A of the PineH6=
4.
> > > > The model A has the same size of the pine64 and has a PCIE slot.
> > > >=20
> > > > The only devicetree difference with current pineH64, is the PHY
> > > > regulator.
> > >=20
> > > I have Model A board which also needs ddc-en-gpios property for HDMI
> > > connector in order for HDMI to work correctly. Otherwise it will just
> > > use 1024x768 resolution. Can you confirm that?
>=20
> Schematics Rev A:
> http://files.pine64.org/doc/Pine%20H64/Pine%20H64%20Ver1.1-20180104.pdf
>=20
> Rev B:
> http://files.pine64.org/doc/Pine%20H64/PINE-H6-model-B-20181212-schematic=
=2Epd
> f
>=20
> There is a DDC_EN on REV A not on REV B
>=20
> Regards,
> Cl=C3=A9ment
>=20
> > > Best regards,
> > > Jernej
> >=20
> > Sorry I didnt use at all video stuff (like HDMI), so I cannot answer no=
w.
> >=20
> > Could you send me a patch against my future v2 and I could test
> > with/without.

I don't have access to my Model A board currently, but this should suffice:

&connector {
	ddc-en-gpios =3D <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
};

Best regards,
Jernej

> >=20
> > Regards
> >=20
> > --
> > You received this message because you are subscribed to the Google Grou=
ps
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe@googlegroups.com. To view this discussion on the
> > web, visit
> > https://groups.google.com/d/msgid/linux-sunxi/20190814132001.GC24324%40=
Re
> > d.





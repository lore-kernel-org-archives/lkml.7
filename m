Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2791C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD712190F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVOU545p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFDPfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:35:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfFDPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:35:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so16333908wrm.8;
        Tue, 04 Jun 2019 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwR2zaW5+UglMFbeROg8sY1NkjrkHOAAAE68DSA9sgI=;
        b=XVOU545p9DUX4ntGLfiwJD5GZtQp2V7xRV3u1yqFR3zYVl/iSce2i1kUBQ1FW67AlL
         /IdxhI4BzfUUCZV2n78CdvSGoHA12Bn/oyfYLPrxbeBj7vQum1caqrBUb6f0e5oGP3GN
         HE1et9zMgyEgqJUITuVuiHYJ48qOiGy348GvhgEZoXlY1CzLQfsJ5CX4g+AWHWVxzmLj
         5coFZEApyQb12YAC0PtiPViNeBYg1A2BAlhAHh7I889PWtb019dLcEroy/1s3zalXTui
         wAhtu1TftRYUKID5FViI4stpCR2RXSOZkcoFdqMD4prgJOUp+JuHCnzbs5vZy257lH89
         KtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwR2zaW5+UglMFbeROg8sY1NkjrkHOAAAE68DSA9sgI=;
        b=NDJWSaf4B+67OHDGNxspGLqs1hzqVVOob41YSATSuDrDmGqmgoM5dJPlRe7bLYwSJt
         p2b1nWHSIhpoJfBjnYAkVhB+eX/MYLK4x15sIFO5eDiYoJPyQnFkqye98SMMeHK0LNct
         vaZ+ctQoKkPhssJp7HLejTYLxWLPgwKDmNF8uxMn6aSKl/TEVxE/DItG+IrGAaONwZs1
         Rt5MAL7BiD8MN7vypJeiEsI0pX7qIA/fY4DY4g66N/12HB+QM/AYKWIKzoe3DicDmS/9
         JiW6zMPWsa+layXYMJU07Qn+IOMWiQu1tI9S0K6qRiiGgPUIXC432qHcqYlsvpptx9+R
         DjTw==
X-Gm-Message-State: APjAAAV20H93CmAgjxiPgYwhmDMGXf5MixgjGbJwk+bagjOD25D+akS5
        KJZiARvxqqrCStytTyudh4Q=
X-Google-Smtp-Source: APXvYqyOYfoGd5XgvbaAA6d5mS0ppVBzDRMmSA3DowcGitVc1FSSlVRiyN1q4m5N8GQPLfiy0MMfnA==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr7107192wrv.347.1559662550738;
        Tue, 04 Jun 2019 08:35:50 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net. [86.58.52.202])
        by smtp.gmail.com with ESMTPSA id f26sm10046745wmh.8.2019.06.04.08.35.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 08:35:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, megous@megous.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun50i-h6-r: Fix incorrect W1 clock gate register
Date:   Tue, 04 Jun 2019 17:35:48 +0200
Message-ID: <2504206.OUqqUFhxAD@jernej-laptop>
In-Reply-To: <20190604153120.zcxfn4kh2qjfktgo@core.my.home>
References: <20190604150054.17683-1-megous@megous.com> <20522585.shqbOC0eQD@jernej-laptop> <20190604153120.zcxfn4kh2qjfktgo@core.my.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 04. junij 2019 ob 17:31:20 CEST je 'Ond=C5=99ej Jirman' via linu=
x-sunxi=20
napisal(a):
> Hi Jernej,
>=20
> On Tue, Jun 04, 2019 at 05:03:55PM +0200, Jernej =C5=A0krabec wrote:
> > Dne torek, 04. junij 2019 ob 17:00:54 CEST je megous via linux-sunxi
> >=20
> > napisal(a):
> > > From: Ondrej Jirman <megous@megous.com>
> > >=20
> > > The current code defines W1 clock gate to be at 0x1cc, overlaying it
> > > with the IR gate.
> > >=20
> > > Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR recei=
ver
> > > causing interrupt floods on H6 (because interrupt flags can't be
> > > cleared,
> > > due to IR module's bus being disabled).
> > >=20
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> >=20
> > You should add Fixes tag and CC stable with this.
>=20
> Not necessary, since H6 IR is not yet supported on mainline.

Well, CCing stable is probably really not necessary, but you are fixing bug=
 in=20
existing driver (clk), fixes tag still apply.

Best regards,
Jernej

>=20
> regards,
> 	o.
>=20
> > Best regards,
> > Jernej
> >=20
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel





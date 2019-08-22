Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566484911;
	bh=azPLaSKtLeZQNwLXhQqsOwtjMaN4Nh/8/NOI0BdNGOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGfnsQW/8PMEr4BjsArFpM7Y84SnhkBG+cuVPbohgoy3xFsaSX5g8PTQSvFCL5FFh
	 fVJkkUog2CTgLmhk2Xvu+R/bpHxxHJxyRcaQLFFI/eedxye5YP/rI576KQNHk16XCo
	 7f+cGZh/K7+dlx7VhSDbS4agy+AlG97QInXbjpFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfHVOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:41:51 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:36211 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfHVOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:41:47 -0400
Received: by mail-wm1-f99.google.com with SMTP id g67so6059538wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ziW0AzJyU4+E0Nb6HXsnQe3N8iZ8j3cMw/59pcDvYxY=;
        b=h2I4MePCAOFtowTviIS+vguJjQFlHo3Joyo0Z09fOLgwHPCn481WbOo7S7+ZJQ61J9
         JS33nli0wgFvqO/mkT/vczdHC0hI6FpDz4rOZUvZXthEvDt5uUmbD5wzRlQEc20DMiE4
         6Wz9+dawNVL/OIrwo67cFftLk494mHBjW6e02XRyzCcPIYZV2Lzm9EGyF0mqFaHI6FJu
         CRiXeLpnWoXpXRapD1a64ztGxNgG4y1ZCjWhu8NzAvoiLmhj3jAlfqUgjkz428I50PSD
         SWN3hFGOrvWWSEsHFzTZP82NMbBZV4C0DGwjZ9LrxvEGM7xJJoZVakxK8PO5oq8rDM7q
         hC4A==
X-Gm-Message-State: APjAAAWT7+NSwRmBIuyc1l0D7Kjph+uEEj1u65AMJXUuTzoE1kRxJm5c
        0qtJkztyFwR937kawCgpws7+BdDbBNLDfdVPFhtwXcL5bC+eYoUOrNnQO+JQOePTNw==
X-Google-Smtp-Source: APXvYqxtAaD9ocs4SiQpudq2WvM1fXMIw5PU3AO0cjb220gBl9ci48itthulcnn9FGRZ5TtS/Ure0X+wgzHV
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr6542013wmd.34.1566484905438;
        Thu, 22 Aug 2019 07:41:45 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id f10sm38456wmb.6.2019.08.22.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:41:45 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0oHZ-0006Nv-21; Thu, 22 Aug 2019 14:41:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DAA952742A5E; Thu, 22 Aug 2019 15:41:43 +0100 (BST)
Date:   Thu, 22 Aug 2019 15:41:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in
 sun4i_i2s_init_regmap_fields()
Message-ID: <20190822144143.GB4630@sirena.co.uk>
References: <20190822065252.74028-1-yuehaibing@huawei.com>
 <20190822141826.is6nizjpdgvhd7ra@flea>
 <5b15becf-b79b-ae5d-91e2-6521ded50946@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <5b15becf-b79b-ae5d-91e2-6521ded50946@huawei.com>
X-Cookie: You dialed 5483.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 10:34:37PM +0800, Yuehaibing wrote:
> On 2019/8/22 22:18, Maxime Ripard wrote:
> > On Thu, Aug 22, 2019 at 06:52:52AM +0000, YueHaibing wrote:

> >> -	if (IS_ERR(i2s->field_fmt_sr))
> >> -		return PTR_ERR(i2s->field_fmt_sr);
> >> -
> >> -	return 0;
> >> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);

> > I'm not really convinced that this more readable or more maintainable
> > though. Is there a reason for this other than we can do it?

> No special reason, just suggested by scripts/coccinelle/api/ptr_ret.cocci

Which is a bit of a reason in itself since it'll save other people
looking at the same thing though with a return like this I have to agree
with Maxime a bit and question if the coccinelle script is really a good
idea.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1eqacACgkQJNaLcl1U
h9CAkwf/Uf2VAqlhiMOqQ0rV7FeewNL+az6bwpVvk0y9wd3MeFAYAwjfhm6ssxTm
0VFGFwQOrBZly3V5sM2+RPO7rvR+73k8ilAAKH4Te423k6tghyvem195C+W8XoE5
A8R0VBmnIIocvgj1PjbeF1R6Tq5uUWP88SUMCHbRDBGcLqXGY3JlVWao6UKXbas4
bHRmTBWA7qliaKrmrXnVXLpl/zYvz30YzW6IOBSzWVIDPL6ivAZjvRNz+x0iYs3E
xbv5KF1NPxQQILnHCxAQ5W+4PmqJ856qMgrFcnrc1D6VKE+1Nph67EOVrGy1lf65
l5xMPz2Dd7PtRcLXKdLVxuXxeJzUxw==
=BB78
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

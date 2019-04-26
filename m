Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616042084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he5FOjor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:25:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:25:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so4941273wrs.11;
        Fri, 26 Apr 2019 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHk6Q7YVWro0HUIwZ6DubgfOSDCLAqHqjxmCbViazvQ=;
        b=he5FOjorgS1idJxlhNzp+WG+1REcrUiXaSQ9CeLaTJ3wlwoxpVMxuMgeL3T1FP2gr7
         9zXZ7/0IQPgw0lhZ4nGPoE/thVE/yKQOEu+peeYWmSARgLPkXXSjE5ijcAKwf92i+7mq
         XGllPVkC7xru/Vrdxa/PAJkPeQ2fyVjI7+TcFikCFhuBdJKwl7xw8eTd2k/5E+F8IQGw
         E4bNcOH5zm25WHOP6uSPcbVgn/EIiK/8An0CjXPXPUmTxcmb5OhtxgRoxyfxalAdP3pv
         pm7CWsZrRM2sAqhCkH71YiTA719qLDHCGC/XD4PHuvRkEALV54CdhyA5vk2EwRLp2vSN
         zoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHk6Q7YVWro0HUIwZ6DubgfOSDCLAqHqjxmCbViazvQ=;
        b=dpKiOLYWxsGWWo9d5CF8kcsQdhqOhFb2arXMMxED2xQxS/6lldbdvTD0xv6IwgHJrg
         rCVVyYqf8x65MlulOJc6PC87mIZ6yCXDf/G/AvMgXzJzA3ImNGR/jO58Ptu4hm3djQh0
         NP2/LymPJMV0fxtD3yaoFavTy9CH03ObhwNNahRWlJO00kxbnlJ32jpK23CQc4qPxgLB
         ClrNSUR6z517QNlq6d0ZaO4RJsm7KaHfHrEpfcnPQVmGYX2lI9/bLYhYKLBL16J3pljL
         NYY54GRDBq2XAt0EO9+9/rr0ZDmBzch0fBjDuMvKJ3gU37fOrLOFIio74G8OlJ0RHLIg
         4hiQ==
X-Gm-Message-State: APjAAAWkFt0QupHZHUVTe+1eBdIEDFsTOwycCsoqXkHAzwO9U0qdOWuZ
        h5m+7UNk35uJ07/cCvu7FzA=
X-Google-Smtp-Source: APXvYqyp1DKWPlVfJP5wbH9fMkpIdFUeSNKQnoZvKHNQauSTPUCke5IKj6zopVxQPeAgg8DknDRFrA==
X-Received: by 2002:adf:e711:: with SMTP id c17mr15670199wrm.57.1556292300623;
        Fri, 26 Apr 2019 08:25:00 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id h9sm18683735wmb.5.2019.04.26.08.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:24:59 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:24:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] clk: Remove CLK_IS_BASIC clk flag
Message-ID: <20190426152458.GC19559@ulmo>
References: <20190425181447.60726-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20190425181447.60726-1-sboyd@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 11:14:47AM -0700, Stephen Boyd wrote:
> This flag was historically used to indicate that a clk is a "basic" type
> of clk like a mux, divider, gate, etc. This never turned out to be very
> useful though because it was hard to cleanly split "basic" clks from
> other clks in a system. This one flag was a way for type introspection
> and it just didn't scale. If anything, it was used by the TI clk driver
> to indicate that a clk_hw wasn't contained in the SoC specific clk
> structure. We can get rid of this define now that TI is finding those
> clks a different way.
>=20
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: <linux-mips@vger.kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: <linux-pwm@vger.kernel.org>
> Cc: <linux-amlogic@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/mips/alchemy/common/clock.c     | 2 +-
>  drivers/clk/clk-composite.c          | 2 +-
>  drivers/clk/clk-divider.c            | 2 +-
>  drivers/clk/clk-fixed-factor.c       | 2 +-
>  drivers/clk/clk-fixed-rate.c         | 2 +-
>  drivers/clk/clk-fractional-divider.c | 2 +-
>  drivers/clk/clk-gate.c               | 2 +-
>  drivers/clk/clk-gpio.c               | 2 +-
>  drivers/clk/clk-mux.c                | 2 +-
>  drivers/clk/clk-pwm.c                | 2 +-
>  drivers/clk/clk.c                    | 1 -
>  drivers/clk/mmp/clk-gate.c           | 2 +-
>  drivers/pwm/pwm-meson.c              | 2 +-
>  include/linux/clk-provider.h         | 2 +-
>  14 files changed, 13 insertions(+), 14 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDIsoACgkQ3SOs138+
s6EeYw/+ODtlfFBeX5N8+RMkQjbVCHXWEOdXzaRchdA6FG2OsXcE4sKemUaRndwq
39u//Gfd7+FzbRx1KozJynxMh4X4SZgkz8amg9E5KBMjxviapvni7zPs0iM4DCxU
QaD9lX+z7SHTjAmGO2Uc9WwOzGn7hKiawSaaWt3feFeycPQ19yz/oK9OT/gMtVh9
23fYY03Ct7m9jp7q9xfM6/03IO6QzA3ygvStbpHw06rQWVVO94z4RCziJKXEqwRE
zgqW+2tRCeBH6lx2wi6PHbPYpVvKCV/tGMFwjhDcfKgkWaCq/A3iGyJprnALkJV9
alCoVZ9RaxddQaxGo+nYI7Tf65j+jKsEZNDFO/rLL7uAsojJdI5SntyKJjZNJU/P
oELMbraTQV/YJD+CfuzDzCnX+hQ6HxD49TcP2G3hPPYFwfJPNXjTMxztThFghdcU
zUxEewHp36MCmxrCbB62AlySj013FdvXQPRWsbCK8WoPdAlS9RrDc7Fkq4rIcKvq
7qAdfSYKyRQDAAp62gjDQJLkGlolGAKGR6vxJTcm7PaH7hfSY87rQLTxbqaZvB4/
Be/PnMpG+OvwbGpMX6syEMcHVRoJwbJ3YP97GlPfFyQe8lj8gOumdN072Pe1LjsM
7wC7CgOqybPOzXwmDIXOTQkoVhJAYuxdmfxK3u31WbVhbQKBX34=
=IL2D
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--

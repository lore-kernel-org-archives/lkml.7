Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55452C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEFA2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM9bxojQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDZP0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:26:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37322 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:26:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id r6so5007672wrm.4;
        Fri, 26 Apr 2019 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V0SNaA0nEp4NEznqEA+NA6qfRftkgT/+RnqJg67XDDQ=;
        b=SM9bxojQPSBmqQQVSvsDOVle93PrvwJWmY4OxPN0mmUlOeSEjlstv5HsJ/Mhfbfzi9
         BAXwlfgNkGFEfxFA8eLa85qp7SSoLOBy5b7vLeQG0lVHEnkB8TtQGM93dGfhKvhmqV5x
         XK/+zxLnqPQ9731mtAzaeu7eNCshXQNLTbeRQju+1+H1/O57JeOW59Hbmzm2/JTM5l5R
         1kxLx/4s/4Y7xsXlKEJibGCgW/Z+QzJ36LlPSkpfU8hW8PjnTvH7bYzixBw1Hp95acdn
         vJ9CdmI+mftwh7QfSq17I97Z1lAQKP5zfyYa09nYW109dDp5SNbppj43GNVczH3X4yzD
         dhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0SNaA0nEp4NEznqEA+NA6qfRftkgT/+RnqJg67XDDQ=;
        b=UTWCLUzGhg3H/dtX/q5dTF7PUzYqcXghctFyaXCrM0twXgbLfz3Qp4YzV7d1z8fFkU
         AqCmGk89psyNPFS/IPyVyUKojX0hO1hvtcV0jNL3k6eR6fpEua+aEIhBdQ8jIE8mwaWK
         wk8/2twK6LwgPqesNcUQslcE83dlixal5ok2BMesrtJH1yEhnmnDflRPknaVG/RORqmG
         dWbRscz+EEvmJAd9dvF8lC3rYbCjUmv6HZ4p5fE6DXTvdcBYHHfV2zZPDIDRbuS5ZJzd
         bQKon9J7Geqt31zAr0+Vbwupjg1wefIofg9llASaZajhukh2Kk5ptuMjWeRo0RiaweBb
         /PAg==
X-Gm-Message-State: APjAAAWizxRxPYHGAHpZSDjTl8laYNRLJ5rHY785iAtZ2oa68ipcnEmk
        br/Zx7ryxWtSgwU0zb8s+5A=
X-Google-Smtp-Source: APXvYqw7/anK5JnbqxGLUMsdL+B4zuaiJmr3tkm7vHqYBTqwds5dMyl1TXGtrq2erWcBisYe2qwuSw==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr29861095wrj.0.1556292388228;
        Fri, 26 Apr 2019 08:26:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y197sm25921452wmd.34.2019.04.26.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:26:27 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:26:26 +0200
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
Message-ID: <20190426152626.GD19559@ulmo>
References: <20190425181447.60726-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <20190425181447.60726-1-sboyd@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 11:14:47AM -0700, Stephen Boyd wrote:
[...]
> base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> prerequisite-patch-id: 6196ca807a15f9f4a67d5e6b8668b4f13442ac15
> prerequisite-patch-id: 9532946d1be40c2b20af0591ac4636a4cf3b14dd
> prerequisite-patch-id: 4e4a9591f5a4ac0d5a72e694da8fdae8c8dda352
> prerequisite-patch-id: bcd75306e64ff866989a978127f6b16f7575d0d3

Just curious: what are these? I mean, I have a pretty good guess what
these are, but how do you use them?

Thierry

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDIyEACgkQ3SOs138+
s6E+3w//QY2u+1dP4U77H2Ps8hLK4fFnok0GiK/ZyE+yaditfEYdCZqS/hh1xG74
OEKrMRaCAl1A8DyAJJzro7Iqnxgs1N81PPGVzvl5je2hNiN2ODnhtk+mmFuuUBf3
QwBxhXzVDiCGtrlkBtpnMlRymurRvS+SIuDK6fyzArGjgbaVXREozJ06Q3aytemZ
gMfT3AZ5laijFVEfd6vtKrK8hJkMHTHDzpN/uDZ5hlZFEoWstRqluQR404vxZr3h
3rq0Oq5ECOt9go4+ZHnXfO0QwubsRVpuF1O+8U9L8WQsWUKKppmrB0veuvTNoq9W
m70l8deU/Tn4j7VXu5pyJbREZj7UC2flPgTgPrhonsUSTQo+s28pehxWk0I8jGVp
xc5Z2Ie+uoKt+SBIchug6Q2TX3jLDyynplLJGcHDsfI0HsB21mW507fGI1odzUTM
4Nglwx8c+LjynVJGKZI/NbXMOEkMQLUitsrM/tOyyQi0ew4144Hc7i3PVOpX60zE
dy7mmJEJ+80zaPXqjw5meMFq4v476Z8icKSZbHyUJaSrPdr/8f22s73ocQAhF4re
/kb+odtUNfV4+V4BN2RX3W4d8jqux9Hwnr2fGfcuRt8VnO7F8t6LUcswka9Umt0k
h91yTD/BQGste7Fa/Q4Y/4ZZMidnTVnzoLa+sqZaBnX4BUOIz6U=
=ghXI
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--

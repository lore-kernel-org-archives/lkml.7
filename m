Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B425BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9BB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMLnuCtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCLL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:26:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54278 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:26:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so2239958wmj.4;
        Tue, 12 Mar 2019 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7jLoohqNR0znndN00YfTA9lw+k1Sw/TsNLXQIgvNKEg=;
        b=QMLnuCtfbtvsVttxYDGex/YMLDUS5IPTI+P37D//t5ofS9NpQbNUnBBU5CqgPjLfe+
         unFnTPQj08ImsW7xbngiehsyxr13D3SH0IFU7oqICPr/g8izgYhwrWsuYp0E5VyhuX3p
         Od5pstCRSA8RXyiEIv8M8RIK+z8umJAU725FbOhtIFtS9dhsbDZx+V3x3VxBjcqisJgA
         1EPfmQHaIuArb4ip2RWGa2In26mYE+uZwwTWXeNNDGq7byo7LTbPkwCo4CfRzRC8lqjS
         7DzkMYt6JMWlqGv1xOZyMdEjmRAnzqlBKMIpnk72ccGiqx6bDYJQbCznCwor/m/M9wdL
         j07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7jLoohqNR0znndN00YfTA9lw+k1Sw/TsNLXQIgvNKEg=;
        b=C80Y0s8h/07avqRF1oJxgaPsl403hyWqbvfo/E2s0ErAL5B6bY/aB+JgfRpQPt7xg+
         Pk6/I2nJBUuNHsqT/+PWQpKzcAHUaAACISknLLlV9pRntdSNytsS+gytkv9J4xHOdPvR
         lu7EbnYPmao53EQD/4areQSSr28grA0ZHi59s0HTn5b+dJhSr10FxclBVip+KgBKGOHF
         63J5s1leoyhZ75JgXqjNOGzsTl7+sTTjYIdvIzeU1cHgVq/NfMEE72Qj8WNqph61g/y2
         TvNdbmlQnJsl6f1G9CMxJBajl8kWLYljSTD8J+8jSM+Y9lCU13TyuYqEx2QTGzRtOHI6
         3zKg==
X-Gm-Message-State: APjAAAWk8bzDHk3KoZCsiNMoifXdRgZP4vmfgjCVmrZ1wBxTl9A2Qypn
        s4AP1U+NPBmwncZxFYVzl2Y=
X-Google-Smtp-Source: APXvYqz7cX2WOS9pO8LfgWNdCj+lX/blwMKWvAB4FzVsaxTjLVaFD4av1HZL79F5kCGz1s3wQ0C/0Q==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr2016588wmc.59.1552389969774;
        Tue, 12 Mar 2019 04:26:09 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z12sm11534858wrt.10.2019.03.12.04.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:26:08 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:26:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
Message-ID: <20190312112607.GD31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
 <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
 <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:33:44AM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 12.03.19 10:17, Ben Dooks wrote:
> > On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
> >> don't need the temporary variable "dev", directly use &pdev->dev
> >>
> >> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >=20
> > This is quite usual to do, and I like it as it saves typing.
> > Personally I would say don't bother with this change.
>=20
> hmm, both approaches have their valid arguments.
>=20
> I'm not particularily biased to one or another ay, but I'd prefer
> having it consistent  everywhere.

You're not consistent within the series itself. In patch 3 you went the
other way and dropped usage of pdev->dev in favour of the local dev
variable.

Thierry

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHl08ACgkQ3SOs138+
s6HW+g/+MWn1kqxRifMoTc87mFQWgLTMOHS767jDOkb8bWe4+WlBYBNoK1OHJzrx
0xG4+NrwhFmlAZB3trYdB+xowUyASk0FrdaclsAls7ll01VqV8h9XhQ5cDfhhWTK
VfvNWn9B+4xWHFW9Gvuqy5/Hm5SrzwJtOuwnY6gzbS/ab3G26Pzl8Ux9DkO4kKf2
XafQp4WGZptgzrszw0ImctGd6GrCdT14y/tjG5Uz0qDj3qwacxC5oLJfv7A9TVf2
hvtoIHI1jHYim7UZT1ulwActXIAnpIUzDVUvwQJMlFT6LYAZp/9ZEFVfOhW+dZRS
sgYHPQ0GVrVwyRzgPYDSqX3SYwB0XRhlhJiwSW8J98q0dAOm6YpiOqtHJivAbcUK
QhN9aP/r0UGDOsricWT7PJw7JbEi3AHzu2o3ZUnGBapQIEAi2QJ//oxmie1njxPD
b2Xmmyd9728BO5bQQH65h5X4f145oBblh4usaXb8W52C1HG/yhpjZ5Dy5tqo8myA
GzePv5HQhjr9uvJLATFSQJBJbAw7RzdasZiyI95SeQEF74e4sIu1AuCtdvhlyH8k
OX2a/xfoVsaV8YbbRCKPwxjFp+TOsyxlQ9vqOZhU+TnGPZRyzOqGRc8IPQP+sgGh
UcwSoM0Jq+eOidJWA2w7aT1dBMBvqbHQ0A5OBhq3267ppp/VUik=
=zI8x
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

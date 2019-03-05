Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0261C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19B220842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3PrdXor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfCEMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:20:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfCEMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:20:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so9219720wrw.0;
        Tue, 05 Mar 2019 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HaHZCcb3wwTvheiEH4umrDk6a2rbIjelUaWqLNdpQmI=;
        b=c3PrdXortKR9DQtoyjEWSs+8LIUbb9/Nhmz3KWP8TeKHpsQSH11orF7AVv75o9DSwA
         K0fmJisxBXoOHekethjJf4phLvhImL+knwJS99GGYkqFrRS62AjGhA9tVLjxgx4ldFmx
         WBzp42JlHzqjI4xK1nrIWCjTTkCg9T5muQ719am3IZD5t6CSy5kklKBEeJz12i0mD1o2
         z2P4Gl3WnrlwfUzfnFOZlP3zSNENCfV4QUnKRpSoY8H373deNWaRR4bXFGGUuOkTYWvE
         Wi9Tx21c/yYEZY5uU10emIStceGttORCYXthrUH6NdAaSkp1ygFMX0QrnOn8vdUT8MQo
         Bt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HaHZCcb3wwTvheiEH4umrDk6a2rbIjelUaWqLNdpQmI=;
        b=Xb+MG2lfC+7d3VDcIHDaSUSohmOS5/JMaG7ya6RxIY9x8/bdQCSFttAZjPRhU1w7LA
         +EVHS9eR7bzmi+BnSvr08vMV5J9fGUB+9XKV6Qyq9RlmaHS0ufGZiDOaGofsYHvrx2Ek
         Tfc2NYJljwNm4VngvwVhkrKgA3Ni0GTjY53fLA7Tp3W4h6eC3xg2Zyli14no723RA3vI
         hmB0XaaoVxl04pYf/9EBnntCUzcJiDusLGmzZ3ULZErBGE/WEAvj8lbOp73faCMvZ1ha
         T8+zZMeMz1g76rFSICnKdDyrF0KocrOlFrVMHyzptEaYcqga7uXppwYgRYkH0rZe9GfY
         h44g==
X-Gm-Message-State: APjAAAVr/u4GR5AAT5exstZjaPMcQtKkwk8g3chhKuW3q1R98lVGOg14
        bgOJk49lJ4pkhmW3IdGlcAM=
X-Google-Smtp-Source: APXvYqyrcY4KRhypBQRXZxceZTBN5alSsH3p36T6CaBNO+/Wzi+qN6tR9cuy7BNaxq0Gv8CF0q/Scw==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr17390239wru.140.1551788432704;
        Tue, 05 Mar 2019 04:20:32 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id m26sm6903339wmg.13.2019.03.05.04.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:20:31 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:20:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra-hsp: mark suspend function as
 __maybe_unused
Message-ID: <20190305122030.GF26369@ulmo>
References: <20190304202610.1759671-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20190304202610.1759671-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:26:05PM +0100, Arnd Bergmann wrote:
> We get a warning about this being unused when CONFIG_PM is disabled:
>=20
> drivers/mailbox/tegra-hsp.c:782:12: error: 'tegra_hsp_resume' defined but=
 not used [-Werror=3Dunused-function]
>=20
> Fixes: 9a63f0f40599 ("mailbox: tegra-hsp: Add suspend/resume support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mailbox/tegra-hsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx+aYwACgkQ3SOs138+
s6F9oA/9G0y36pi3ft61OqkocxLmtr4Y24ehLLNbXGApAOul17LmulGPKmX4ZYeD
zdlfmyTfBVO297x0feDAXlpZehks/nUIAITMOpMvk2ns2RlFvSJJBCeuIQd4wHNn
4gtEwx1ZE0/SAPwHYfNXJ95q2fKaQ2ROb3HVueN5Vpl3Vlf+KWtAk1D2/Faw2mUe
VZNFrujKZ7m/7Qtfjb55f17nV0mpToB98ihQkQwmgwDK2DAk1RDmhDqH210p4fDf
IWPHg5azUKGjzH9ziVdcDFHu7HQzmF/Mp8hq1wZ5rbdnLFEDXRq86eaNbA6Av5H1
r7mxn6sxBZD5qzYhoH5wNqwjj8BX9C2uvviYhOQiWRxOB7GiOs2wChVsSdvCR2A0
8xzTF/7Xe8rR4a06H244J+yurv9xYamdnc8qjz2gjj6B/LDOtCfkwE2bEUac2oMd
evBP3KZyjbuYCTbaDc4o6BdkWhJC/5Qhb0ODLl4xwkQEgcjg4yeQCqEE8JOkjAGZ
l2JcEzcCS37HKK0dxW0F4HUBq0xgXRZkoqMfrNahxYUbg5r/q8cuyH4VT22fE2H0
bIqDxu7EdbrAFu7Nexq1wu4/nXyiMYhqKvjXwZIH/4PJ8fon0MP5GGdhj/RiM4pG
cfTLeAskpVUI86xLQzIz+01ZFgbw8+vmBKCH5IIFlF9z1v8CbAM=
=jnzY
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--

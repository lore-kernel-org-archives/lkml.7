Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D19C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B71C206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556215319;
	bh=LGzEwlUiSMEgTFyv0b5ZRM6Qgw/1TC9W6c6qhcF49us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yueIw0n/GsAfoFsoEEUDt0OYsqbYiHC7WqugvVGOEFVPGjSKGOnRjuthAEdwtdQfO
	 u9uMH+nhHxsrvgPXlsOH5T6tgssKT3Mp97Y8kBXzwz5gUJrxeUJmiVVzUWpU2jRHu1
	 YZXA5vkLUtX4v/iyCSarQ79KPYOl5xqIkqfQNaZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfDYSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:01:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDYSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LGzEwlUiSMEgTFyv0b5ZRM6Qgw/1TC9W6c6qhcF49us=; b=UnEIpkAeAB1nUK0JKvHZYoMF1
        vHlN0ab9v/Kvs3zjaLxancxcmj/FyOeogp1pL+E9I3cLpzcC+L9+Equ36DIwpCZtidce6CEgEYZbc
        e/ZgxVN8/jmSTsoQZHiu45Qdyabxcav1gjCbTicPuxUE75RPf/B8Cs/0NG5nCh1FJ7pCg=;
Received: from 94.197.120.235.threembb.co.uk ([94.197.120.235] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJigp-0003pT-0M; Thu, 25 Apr 2019 18:01:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BDD2F441D3B; Thu, 25 Apr 2019 19:01:35 +0100 (BST)
Date:   Thu, 25 Apr 2019 19:01:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
Message-ID: <20190425180135.GA23183@sirena.org.uk>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin>
 <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
 <20190423132116.GA3892@e107155-lin>
 <b36d8e3b-926c-11ce-747c-74124c09d13b@st.com>
 <20190423135550.GB3892@e107155-lin>
 <c8a23e26-79af-eb0f-80bc-5360f30b2a37@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <c8a23e26-79af-eb0f-80bc-5360f30b2a37@st.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:17:23PM +0000, Benjamin GAIGNARD wrote:
> On 4/23/19 3:55 PM, Sudeep Holla wrote:

> > The above statement makes me wonder if Cortex-M4 firmware is really
> > non-secure, if so why does it need such an isolation from other masters
> > like Cortex-A7. For me Cortex-M4 is secure and Cortex-A7 can execute
> > in non-secure hence Cortex-M4 needs to be isolated from Cortex-A7 as
> > mentioned in the above excerpts from the datasheet.

> Cortex-M4 firmware is non-secure, it could be a free RTOS.
> ETZPC doesn't isolate Cortex M4 or A7 but control which of them have=20
> access to hardware blocks.
> For example ETZPC controls if M4 or A7 can have access to I2C hardware=20
> blocks. The goal is to make sure
> firmware running on each side don't use the hardware blocks of the other=
=20
> side.

The goal AIUI is mainly for robustness rather than security - trying to
mitigate against any bugs that might happen, making them more apparent
during development and mititgating their impact if they slip through.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB9f4ACgkQJNaLcl1U
h9C3AQf+JEx5gIZpa4oKQafH3ehGuxAN8cQgk8nykr1vrakaKt3y31SoPmnC2og4
9g7b2Enf+wIvS1wVdoTrDsjXHcLEDyMoiS3aMhr0MNdz0rAHLDIOvTNZR+Pom5OO
5362rWiov/eh/Da+mchsORTZQFoYI58n2aH1hfNvt7zAJS8D/wJRfKdNVt7uX+8L
EFyKKjbj9HKnc5EypxOXk1XMTlpQed598NOKwC8wvT+gtOfLOXZopFkRoE/fOHe4
Plohm0974l1m1+Wc2UYIPlHt38sEDKmrVlj90sHX3xW+EkXo6u6vyJNHF4SaUHo0
7L8YqQgJ5OvPLcaKmVJZj9rpigwQXA==
=xjPB
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

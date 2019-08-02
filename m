Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3AAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C344620665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564744267;
	bh=XLLYYXdOnmK+uT0RSzNmwO4NnGixAx4hmIxZ89llDWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TQbqthQJ8A/HgCh6TnhBIwQfCAua9MaptpPQV7ZfMg6IjrDKEVjYLD9/iWSk7t2Js
	 inIUFVaGnJV3REWW8kla5ldpdW+QvMAyw6EULQ5FMiaLbWWjvctZAIVWgMtRoqknVJ
	 2FFmEUO9V2jIwSKB2/RGobrQ7n5gT569Y5jXIGbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbfHBLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:11:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42376 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfHBLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n3s4BVD5JdIzf1EzOc/HSXfpVMJH3F25dukM4N0R0rw=; b=o3itlc9UEZib7jTg8rBsfV2Ln
        5vlVoO5Nfaqv9ikfYOXKGOZS4hte58Euz9jU/4ttbMW7UVQx9ADRV322SE5owfVZKmgXUWGMI9+4J
        xAqNVRRzYNSf+nYVu/ELr1R/VQKE6+sOe7TAzp2vAVHXTu8GmC6Ex6EtD9yo8/ppO4arE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htVSH-0007QE-Uw; Fri, 02 Aug 2019 11:10:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E01F62742DA7; Fri,  2 Aug 2019 12:10:36 +0100 (BST)
Date:   Fri, 2 Aug 2019 12:10:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Message-ID: <20190802111036.GB5387@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
 <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
 <20190801234241.GG5488@sirena.org.uk>
 <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
X-Cookie: She blinded me with science!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2019 at 09:32:17AM +0100, Thomas Preston wrote:
> On 02/08/2019 00:42, Mark Brown wrote:

> > Yes, that's definitely doable - we've got some other drivers with
> > similar things like calibration triggers exposed that way.

> One problem with using a kcontrol as a trigger for the turn-on diagnostic
> is that the diagnostic routine has a "return value".

You can use a read only control for the readback, or just have it be
triggered by overwriting the readback value.  You can cache the result.

> Hm, maybe a better idea is to have the turn on diagnostic only run on
> device probe (as its name suggests!), and print something to dmesg:

> 	modprobe tda7802 turn_on_diagnostic=1

> 	tda7802-codec i2c-TDA7802:00: Turn on diagnostic 04 04 04 04

> Kirill Marinushkin mentioned this in the first review [0], it just didn't
> really sink in until now!

You could do that too, yeah.  Depends on what this is diagnosing and if
that'd be useful.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1EGiwACgkQJNaLcl1U
h9Bs6Qf9FgalB0i5dzB7naDLU8yYdeZfY+teIQZhSWv5GUBav5I3hs3vkMQRCu3b
B85CYaqrGqhe/TTBEPeZq6hlAzt91By0DWQ8oYiz9t3Vf9rqAxCe5M9OzKrN/GfS
veomBXXDd4B79HHPW9mGDHsNoflXkdJbyWsx9P6ZvCRs8mc6JtrRssDje474uNqs
fC3oWklOove1G7CStDQ/8QfK8XblO2FZlBzL0H0YbSuUy74Xz8Ioimd2WX1Yvm3L
DPdOR4I6s0MvP1lhgIpTYSXki4plZ3EdwSatWi4VmVmBMVGK1rDmiXhWzBkWheJf
915A2FSIMuUS5Z+2sIRaANFl7lHKVw==
=GrVc
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

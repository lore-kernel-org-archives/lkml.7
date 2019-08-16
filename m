Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FEAC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B46205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565957790;
	bh=H2YA5fOV1OZSgNy3CwfMFr+n4sVluyZSIMiBaoWhzq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHX/6xxfHAQLetmySJhDvaGq74reM8glRu5jPmIm21MbELTLHydBSog9kPX6nQ7Ul
	 Z3MFiBzZqQlJdHlnWQxU4QolikrsOwz5w4R7GOLuNbge26ckYgzg4BnybbyTo9qNPB
	 OHnDldEN9Pn25SbFh4u46r+cq6V5mx6YwVmQ3NXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfHPMQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:16:28 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:46273 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfHPMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:16:28 -0400
Received: by mail-wr1-f100.google.com with SMTP id z1so1330834wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 05:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dn2KIuS3Wg8ZAV1Rn4EmhRNXAghPOAWFXahs2NO+P7I=;
        b=twBiUJFwARS1vh3rXRDh+wz5JHZyFZpscq2TH4QvjamejRik8b+zrYsDUIKEIi7XXs
         4cvt3Hu+eFHs4Z+Ky5Z/klGUCYNOB7qwz5zOPC3viNZcAPpJHAkkR4GH22GJK2j7YceJ
         Wq21JLzgjnxnqTUloHKpgM2GDjTcvAmzyOWWWtf5ymfKHMpLoZvnPf0l3sC6DFrQt+zK
         ojElIgVdKQsgBTxt/MK7WoCakSotSmGGxtaZ7OcQtwDOLmDg+elMEd/92xJlpTsvzUhE
         z0mmT1nfxgOF38hZNoxyHw0kMG922l92TfkyoiymZFk7TXxGTEuzNtuk/vPnNDlZrn+S
         rrOQ==
X-Gm-Message-State: APjAAAUsbC0+7CzybhsqVLCihnYAAO5ufYo1CZgiMl0IyrDhPrawCOZR
        xWDKratXDUD13fa1cqN42k1P/bJlJyQrkVfPadk9EEJmQpWvGdEHrhbNUDF3AYrpxw==
X-Google-Smtp-Source: APXvYqxzvi1VoIOoRXJFajCnQ/dE3fzFo5N+5Qat7cLvuByHbL41fsf69MyjqXOpnK7z54RKl4/zDq8J3tpC
X-Received: by 2002:adf:f287:: with SMTP id k7mr10732366wro.183.1565957786460;
        Fri, 16 Aug 2019 05:16:26 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id k67sm34897wma.53.2019.08.16.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 05:16:26 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyb9d-0003MM-Ul; Fri, 16 Aug 2019 12:16:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2556927430D6; Fri, 16 Aug 2019 13:16:25 +0100 (BST)
Date:   Fri, 16 Aug 2019 13:16:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, alsa-devel@alsa-project.org,
        linux-imx@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: imx-audmux: Add driver suspend and resume to
 support MEGA Fast
Message-ID: <20190816121625.GC4039@sirena.co.uk>
References: <1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 01:03:14AM -0400, Shengjiu Wang wrote:

> +	for (i = 0; i < reg_max; i++)
> +		regcache[i] = readl(audmux_base + i * 4);

If only there were some framework which provided a register cache!  :P

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WnpgACgkQJNaLcl1U
h9AuxQf/SUokJSA9quJeah9hsT6jJhQKPr9uQwbuhnIcx6+bhKouXbtrmPWZsHF8
zLUHwY1cvcQm2qitQxsYCZm1a65PWSIAX9P4s+GUfNVz9p2dL0q3TYDH8mDJBjWv
CK1KDEfko6PsY4AHrSa13aNy7IImcOn2J5+/CUOonmPlKPS7CezGbfACaQMG5Zdf
Ln4T/JnCQ6IZzFeJMwzD/RzXiwXOLc7SZ5mIADxbP+4rL9ByOG1BJy/rXIV9YbJe
IQqO5Zu7uen0NjPDOQP/Uy8RF4HItglOTrO8Cjr/95gQ4QJKxLzQyq5NzEGJu1h8
BgQWgH1vDAKWp04BZb2jzQtLMtmwiA==
=hQwi
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

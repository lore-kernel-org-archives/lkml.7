Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E25FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A0D20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP5B99ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCDL13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:27:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41881 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:27:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so5117216wrw.8;
        Mon, 04 Mar 2019 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hfkvHciGTCF/pgtOcV4srOUnmhn4Bpy49tSPJIowWr0=;
        b=EP5B99ge8gAJGhnAwzhDSCNJfFFillYWGwc8ksAqLsizAnYG769rzeGMGiB/l6huSi
         xCOjpohuFFP+S/j3lSY2BJjmH9GOyrkqOicR0x6BkFNAvKFsPfsZp8EgVecctULmKl+P
         ziuuEMqCclgpH8ExMg+38CohTAHLkwUDGLXZJVh0O62WjH9jQ2GA0OEk9D2ZHydzlIi8
         0IgmWpxYjlbr732tonA/7aS1C/90OmMeJkJDoCFEEPza/GXGvFloiWe2BOmqFAox60RN
         PSn6mcoXWL/rp69OhdTyO4U6bPBuTocRu1em3V/DIq09dIhnfL4ekJG+C9EZO/1YgGxK
         p4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hfkvHciGTCF/pgtOcV4srOUnmhn4Bpy49tSPJIowWr0=;
        b=nPbKpEFG8QF59MnLr+xXKviLps4rsmGHUYKUPJgU3ruIKHYE8cHFBTrssNsONW1uW3
         NDoKscU2fmH3EcoFLMn7aC1ZDbMct+Wg2jwTIijorzPW/fcIIntpyMrsgtWqKGO0MgHq
         UcGk5kTe6FRjUoSODwrgITDKK0kmm4aat2ysmdKeEctv8WmX6DapVjkvgh5M9NqRRKC/
         ae9s/zeDPCaQIkPt0wtqndt9F+/9Efrx3AZbrfm0T0Bda3m56D9RyYIwxQoHx0UGvKOK
         qWqjkn9wNUq0z6xEUdbUn4ur6Kr4jKiHkPMIX5jqdzs4PA7sr7kE90bWkAbBR5M1dFGs
         WVbA==
X-Gm-Message-State: APjAAAWABLdRnjvwxJDomgRxM164ACUYrzt2CxplhPL69PrFLNwsVkgd
        6/En9m7raas2IfJ75hGBBxo=
X-Google-Smtp-Source: APXvYqz1A33rg86/BfH+Efxi7Lq18z96y1e3MGE9BqHu/FiCphjkD1pIu85smoe6GFC85mmtE4e0Rw==
X-Received: by 2002:adf:8251:: with SMTP id 75mr13227356wrb.112.1551698847479;
        Mon, 04 Mar 2019 03:27:27 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a82sm17966023wmf.11.2019.03.04.03.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 03:27:26 -0800 (PST)
Date:   Mon, 4 Mar 2019 12:27:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pwm: pwm-bcm-kona: update macros to remove
 braces around numbers
Message-ID: <20190304112725.GB7617@ulmo>
References: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 01:11:22AM +0530, Sheetal Tigadoli wrote:
> update macros to remove braces around numbers
>=20
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

I dropped the "drivers: " prefix and shortened pwm-bcm-kona to bcm-kona
because PWM is already implied by the "pwm: " prefix. I've also replaced
the commit message with a real rationale rather than repeating the
subject.

Please keep this in mind for future patches.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9C50ACgkQ3SOs138+
s6EL9hAAhKtTMkUPAPy7awGRhP1g8u0EYPLDrMEyywa89xRkDOZDaxZjMnlOGFwU
oBNBaK1Ibq+dT3C8beWcXXcviRemaMdJiX9zgbwOPpiWMDtl0TfMyDYC5Q3wGYHi
/RVfQhGl26Z2D96irtXH3dmNzbHib+P1yE2kkEihd1YLwqOdNXvx3+eRMH0bHOpJ
VcGHlO0JH2OOBjOf6rvsn6W94mHd6wqQl4agnCHIHVq8IPnki0/QgO/rCrvOwDtl
n3BXqu5bUZs7Vn5jFsLyjO1zbDBw/Ms2SXrtySCJfOUiFiaVbsKElwgN7l5dVj9M
2m9lJiaJHvOqLATD2IjY9pCHZcvJLMtB7R7zPX6eYlmwpEUCNndR2Dtz5WTGyvQJ
O0PRWjNldCLJBcLNdGNvDOHXnWQeIvGKXhzr6rcNEB+1X2NLJWv5S7lBqRdaqAnK
E6QQRByImLIvjYefom3H/aH4dkeEkg0GeeNXoeRn424rEGaNVIL9dlUl56ht6IWX
n369nH8z+ysmAwEhcaOFx+R2DTfHeKvDb4TrJqHwypZCCyUaIadkTJw8QixkCWIM
djLSmkTuDsYNz1hh75lImUbcIFAWUlEQthxrAenaZa/PCC1+vnH9hEhgsfnQQBnx
kNJGuN/EuOUtlRkCuzUo7w7GXLA9ujB/2wwS4qgVCAJ2UI+Ipsk=
=P3qZ
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

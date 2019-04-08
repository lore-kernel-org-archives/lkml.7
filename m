Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A6CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE6220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUzJ57SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHKX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:23:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34539 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:23:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so15717550wrq.1;
        Mon, 08 Apr 2019 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vzksQyBepYMSs3nlx47tQwDZKIKVksDkT49FKUSIqc=;
        b=ZUzJ57SF4ljMUorTANr1qjRm1E1q2XZqa1TZatg6/qLsQtCb/G+j1xhqW4mESwjHJh
         Uwo+ox0SjnrHbj/vRqZ0bkop90AVe7YrJk/8wjnIFk//9ykNuPviob9/Hct6QNVXMumA
         9IDk9VVIGkWKuvji2USJ2uei6bcgJwfIDWisTJ66QRE02KGQmQZbFs9cHUglzylPtwvQ
         VCSs3bsia4TJNJNpO4HcKP10TRvkspVeCngUyiq9CHKLuKA6TVRVNvt9nX/fa2afJ2xY
         0RCyTwtpWPAticAmMwAZTcUpMVZ47H6FRZ/vrVUZdlu2p+HXKbKi43iBZdTcq6M3tCDh
         Rbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vzksQyBepYMSs3nlx47tQwDZKIKVksDkT49FKUSIqc=;
        b=rz06K11nt00acCUVZYWOEC44WbvFDMly+4w5wOIcgClOrwyijqkcvBPsDlR5qYnZyE
         6G5z+cijmawvmnoozLDcdHPnQ19Npoam/KpqpCqou1zTfKo7puIns0zNbB7GKphSI5x8
         13eM/SX+oyNMCzJKsTZrH3vdJ2PeRL6YY8VI3hfTJzjqeZNEDHLnFgPPCMKBUa09crYE
         4WpWc0RtCHjJwFMDp+uEMXEQfCs4SK4VSv75kcJW3ENasrQMtf4be4PxG+vEj8D7Npdc
         7MaRCLLPN8JtK/3RZ6FLbh/10v1TSI167/1tcrzc7c+fCywuLDg2OjgCl3mLJWm+ULtr
         NixQ==
X-Gm-Message-State: APjAAAVGIZXcYn4Kl7j7nUllQf4lFFc+vN9FUxc9unCsA40pkpK0j7Kc
        VyYyJsJ6bIUrwvv3JCSeTLgA5xaG
X-Google-Smtp-Source: APXvYqznyqTrj9/sR14awb72z3p5+/KbgnqnMqpdEp5SjxU03Ljcav5I/eIajB1RT1bRD1u9caoeSw==
X-Received: by 2002:adf:afe1:: with SMTP id y33mr18824022wrd.288.1554719007232;
        Mon, 08 Apr 2019 03:23:27 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id g8sm46892539wro.77.2019.04.08.03.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:23:26 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:23:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: tegra: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Message-ID: <20190408102325.GD6644@ulmo>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
 <20190407211646.14962-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20190407211646.14962-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 07, 2019 at 11:16:45PM +0200, Alexandre Belloni wrote:
> Call the 64bit versions of rtc_tm time conversion now that the range is
> enforced by the core.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrIR0ACgkQ3SOs138+
s6HX3Q//U3oKlv0L6mqhoSZEz1d0ICm/bMKHSblgOjNi43KROQnm5EdxX6nE7msb
SOPkPBtXpTxvxaPP+oXBV4CGscMVdOFjaKTRBrEfN88n4PM8FGr15RiXA4/Wrm3H
S+rs92nH9PxH+JPrgc8OJ3o+Z6jUm+0oRFoMl1d46THEZq7kZIuPvbvYdjvcRw0l
RLMGXOCQXHBm73KH/MYAOKNQBTJ55T6N+fGtxrfkRwNv6gFTsCUTSVaIivqa7b4Z
nwQr+sQXpJ2m/TrBELWvE/lkqHq9VOsWUxYaTsEP5cKME1OTV4NvRv5grGggHg5Y
Dt4uJiT5TSdfaNW4tYiHtn8rK1DCPEEC+u6tu72nQ7tx2vEcKJ9tFRu8iNB4K3Tq
lQUz8sQ5jFDVfjpXtC797xPYDU4kr+0C0dDR7y5AQTHNExePF3QSfMVMLBhtQmOq
Kgd6qNWsU/mJYd4mYR6R5WJw0/ABpPhK0UbLjv6d06yg18RZlwf2Wh+3P7VL4AY3
Jm7aMcEp0hLET/3ejpNcqrdICE0XwqVwL2MMOh0rRCFPQsqQzF1gq7f/qS56LGZv
wquKgw3W4MtbkmPa2rtJVYb5xZgOh/fz6Vue8Sgkh3JG0wnQEz+AnkNGoeLjFIaD
6GiC/P7fz1SipDX0c4UWNl0Ot6fcj0rDxa/0fgnRlvZ584iFfDs=
=ozrY
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

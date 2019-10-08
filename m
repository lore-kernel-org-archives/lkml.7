Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED36C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ED4206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEeiaX7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfJHL3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:29:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:29:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so18902167wrm.12;
        Tue, 08 Oct 2019 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYmSEb4UkFBwKb8YV3FOeq6yilH8AXXad/DLPAhG4DI=;
        b=tEeiaX7Me1T5znQaAg+ubwUI0vyc8Zhm1RjV5QaasUhzCH7mpsLT9TdXrRLlndmrBy
         9RHa82qNm8Z4BChHyMO4a1xGthdxMHsOyhGGzZ7pTvwqU+7Ym1YoivrurbPIQa6OgqII
         KGwRa/dbvofp/UQ7IwH9WC+wq4VhIaGzl8ez39hfi1WDhYyms/dh8HbWcuccGmzK/cFx
         fy7IcIVsurt7yk0XrmiR9v1WtfNAL7w58nKFHfsWUCPjmRPrgd0RD98wjUYEbwc+EBxf
         GBGTyeaI2ExDYMGQ0tzbCGYyyLFe5sKirM45R6aBwUpFWLVALeunS9JMqEIaSaoAlwc8
         tD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYmSEb4UkFBwKb8YV3FOeq6yilH8AXXad/DLPAhG4DI=;
        b=qoZ4sEne627nlcUxRg67VoqcM/8Mcz6gc1CSLwRGzh02lp8cTa1OSTiIE9pvN5WHDR
         i5XaKt9fgt084I+Artw2FhKJjSgOX4qDp06JHOIKl/OivEjyk/7O6MHj+BfGi8NdyxJ8
         xcmuRoOFPH1XUek4ZrXTJoLQUQ4OBkW4NAgqECMICR1WurWdP8aKHHmW7ZenrCfquiF+
         yVQLpDYw42xO7d5g7aFWGto1FHYaG/rngOiLm7Ym+MGzHoBfPzI5jMauwaUx1On21bWQ
         gcF+UY4yds8HbV50c+3kAp7SADZWev6idptVLq3OPYpeRCZNNxFEJVM9galCQAvJbghb
         2glg==
X-Gm-Message-State: APjAAAWw5Sao+5VGbgpOWleiw5kz6+OYYvN7T2p6NyKWz/+cJBnsJI0l
        /f47kE1uibKMkDcbOdAKvmQ=
X-Google-Smtp-Source: APXvYqwDi0ge0lsN7GXz3MGF8+juCAMiP5g/2tiWKI2mruB19jSzvAi1nOuWd7Kf7c7AMppkHec4Kw==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr26060310wrj.321.1570534149735;
        Tue, 08 Oct 2019 04:29:09 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y186sm6213868wmd.26.2019.10.08.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 04:29:08 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:29:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     JC Kuo <jckuo@nvidia.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH v3 0/7] add Tegra194 XUSB host and pad controller support
Message-ID: <20191008112907.GC228118@ulmo>
References: <20191004162906.4818-1-jckuo@nvidia.com>
 <20191007110311.GA614644@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20191007110311.GA614644@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 01:03:11PM +0200, Greg KH wrote:
> On Sat, Oct 05, 2019 at 12:28:59AM +0800, JC Kuo wrote:
> > Hi,
> >=20
> > This series introduces support for Tegra194 XUSB host and pad
> > controller. Tegra194 XUSB host and pad controller are highly
> > similar to the controllers found on Tegra186. Therefore, it's
> > possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.
>=20
> I've taken patches 1 and 2 through my USB tree.  If you want/need me to
> take the others, please get acks from those maintainers on them so I can
> do so.

I can pick up patches 6 and 7 into the Tegra tree. There are a few
patches in there already that conflict with the DT changes in this
series and those will be easier to resolve in the Tegra tree.

JC, I noticed that you didn't Cc Kishon as the PHY subsystem maintainer.
Please resend the series with Kishon added in the To: line to make sure
he sees them and can apply or ack them.

Given that Greg's already applied patches 1 and 2, maybe leave them out
of the series.

Thierry

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2ccwIACgkQ3SOs138+
s6EHqhAAtp/qnbVEMpUPdQ4QZrf6zUalRDl5LzyC8TQdSl+FMfbcFe9thXOQNkKN
w69TNE00wHz9llCeHLB7cXYKnXZkRjxjJg+0JRt5ULV6ijZH+vRG1ICs/FG5KPxZ
RFODotu9nCMcbFmszhYTHP5TtvVObWylAhjQ8lBBWFRutILCsaYwY2qA5cd+JAAW
itNCCKSIAhqksYpL0hmfFr28bUoMZ4fh51Lnie/RP0lHV6HHa1LPYXJQ10lx9x2u
E+BanUgNYaNTpgnoZgQUsc0kjnrU8+watMHZGNAT2qOOtm71Xs1iOxkLR28z35Jm
L8oTrS9DZAoob0ewxpWPH8dJMwrF8yxp+8Pp+C8NG0KpHpdiOM7woEq6VXEHaY+d
6sfngywiY6YvY/dH18hH6Ds0tPWCaEwzDBdEenZAm2+H35cz4mFKBR/mxy2EkZJq
cgRBJVLrKgG84Bnujfq8hNXkrGp3I3KCk+ENeq4tC+EpgDc3i1He7mS1G9ppSdxD
lEMfnZqBD9Rj4zAQPoAVtkMdXGi93LL2YPIMZhEGbyl07ZejfsC+jomAXhmWpk+8
r+3zZj10fXH7xGsdRAHIzra36DYVe8hsYJrMtyIr4yiDgebpDr5Ofvc0jdWq/eRU
kxbyY8RANaFfs+vH7hIoB1ta6y0X+0SXeixsk+PuzqYfvDq6fV8=
=mEdr
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

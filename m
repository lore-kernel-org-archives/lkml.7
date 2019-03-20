Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EDBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0422175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T11oQwML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfCTLdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:33:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:33:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so2321604wrr.9;
        Wed, 20 Mar 2019 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aA8przRa/9zUzuvycUYPyA5Dd85i19rn4cyzIK3lqEg=;
        b=T11oQwMLzue/B99To/RQ1n1KeOUJfjPXqGZQVhKSMyGk5f/k0fApwVjA+OktdcZxAJ
         EPttqJNC3i9KdkEWYXkUep4GCdW9O0z1hL2aG8YjykmtkSwI7PeI6zBa+jwWrCdXtJrg
         jClTuq15+/CGRx0H/R5VqCbhBFpNjqagekMk7TTzFHFoQ/jixzkOnrmz7+M0lqI0LcXr
         Dq70BYQqk5jCom6geR30a03EthU0sXs1ArppXN7dJLhzOy3Bn2AdyLe5Uui05l063yNR
         uwgpZ87N1rkJzGUCKZJlRkTxtZaAhL/exMFn3L42hFS/4T5KAJKzyXIdEaPyDwOSJKA8
         G+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aA8przRa/9zUzuvycUYPyA5Dd85i19rn4cyzIK3lqEg=;
        b=atLwrPNAu0orRMUeZ+UOLxEYpWqxjUt5895qTq1BfN56dKryVSSSNJanGXgzzDYHRR
         gD5LxRNqY50l26G34gIi7HnK4b58VbSi/tgXXpr5FS332oCw4T7uibfoZDVQEMTV+TNl
         ftpeg8vgPhpFu8SXjN6LWTsdzw+7vMydp76QIhCMavbUmQyzJTmHyx9UCbVm9a42xGjm
         SqNLIA6L2/+Pk7yVbVxfe/T3BtCjTFydjRCNCU+uhJEQTmBnUvpj/aHHxW5syE0CuwUA
         DdgMW2LPAYpvQ4WmtdwA+NGCu5RMXPds21rfzDHeXx88pGEC39mgMXfWD5tUprg74q4m
         xefg==
X-Gm-Message-State: APjAAAXmiOM0C6vBMuTvBcc97oGvEQX4tgUqvCAKr85BD9+toKNp+Oig
        fYQMTmhOQDajgFPcbO4fuMg=
X-Google-Smtp-Source: APXvYqyhJFwmg1PQY8IS21HT7iWrSoiF08iP6V/xDrUVGwfr/B70pqjJ65ACUJKUMMpngWPK/bO++Q==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr23084490wrq.149.1553081612789;
        Wed, 20 Mar 2019 04:33:32 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id f4sm51965wmj.34.2019.03.20.04.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:33:31 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:33:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] pwm: tiehrpwm: Enable EHRPWM for AM654 SoCs
Message-ID: <20190320113330.GD23838@ulmo>
References: <20190312091629.31701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20190312091629.31701-1-vigneshr@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 02:46:27PM +0530, Vignesh Raghavendra wrote:
> This series adds support for EHRPWM IP on TI AM654 SoC
>=20
> Vignesh Raghavendra (2):
>   dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
>   pwm: Kconfig: Enable ehrpwm driver to be compiled for ARCH_K3
>=20
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 1 +
>  drivers/pwm/Kconfig                                    | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJQoACgkQ3SOs138+
s6EXAw//cWZX1D6eDRV5bMkyKhYVvcHLOEPwvz27xHnAHwzaq7xMEWmRT4me3Aoa
MVyuxneuigA4JJO2c8JFlv/8UpgxU+tLtW1BtjB5iEu7yrIlzu7c/fGOaIawkroY
oPkJefoZrLFHHhIjRtpofKHrQ+5zYPV687IhMzU0fapIdId0Di08yCiFl4BIQxmD
VrYxYACjqUXMRwW7H/aUunySqSjU2g39TGhD5Ei33kG/HlUZQl9jqKXkWU/Xsvyd
lEaNfhIgl109oDygVb55T/q7VO3Kt2+B9OLzqPGxAf2z6I+Almylicx+SH+L0nJl
LqRznCMUyIM/JdJYJHsi/WH3ZNe9olF9yHwIqSX33Tu/HVkdS9coqLfRsFX9AxAG
oXIE/twkjD+zmet+KQrAWJBgZv704iOQAS5agk2bd637qSrWf900+rDWXtI0GiFR
rO3x7CZ8obd/Rwr9raKVqZQvJhtUwBiUi+vdyzsDu81NW5+j6tCoGIKL65u8WjiL
cC3tUfnJFWV+dwyGUI94rA1v3KM4ttLgBJ1WyUCAYVrgzs4TejCZ1c0MAEiD2ufO
E7RE7dLUTSKAddQsUCY1MXvTG0wGn7VD2X8uGB1Xfr6E5AcKyL0px8XiGdUYYgmx
QvlOHtFF2JEPhOibrkMKwoxeBHa0aYzr3XZxJR7UP/ulQVtZSGg=
=D2ki
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

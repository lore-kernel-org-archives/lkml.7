Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461CC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF1021920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPKITSG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJBM0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:26:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44808 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:26:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so6301011wrl.11;
        Wed, 02 Oct 2019 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsapF76Q1TOEmh1rttebz7zK2OwlZHHTPamgXkWw2iI=;
        b=QPKITSG0ejX6kL/FKLVFzzcjl/OaEH4/nNl6nT45pNUXIy8uCQekgc/W6ycjA9FmxT
         459PBRykWQmEEW4XnkDGxjImbHlSt6zrDPY6volB/pi03fJJdiOpl2Aj3znNsZ5U3W9t
         gqezCM26cWXLYSXtYL9Esof7ZluA96QgSeO2YG5zGnu45f0d4k+TTOi+sxLIQSnA7/i8
         y57n/thQP1T+wDAHPdxqA65mquBU9HH/nwmtiAU71SlAQJhhu8xSsE5ZlgYorQpJP5oc
         qGfhv1PLVkNU42rmx6GUmjbXc84XsvXIuDJt65FarnjT0WZ6D/MzJIBAJjfUsQjb1n2e
         4quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsapF76Q1TOEmh1rttebz7zK2OwlZHHTPamgXkWw2iI=;
        b=AZWG5QyJzQnBH4ic/ubbk0EZD6vVclyhbiZ+1xBXjapjVck6hNqxfqgXKiNgfb7WC2
         VM+DKEuMxy+S0XM7L6XVXWyXeWJq89/zuVpdT+qLDlU+YdNHCWv46ORtbo5sQWHVrPTo
         6cs8hLEUgZM/7OSubRJegUwyc9gZsmy2JJ3f6gnshCCtkpiVmrZIZs1zJzLhGvRZ/SEY
         /MPyiY+r8s/PomT66qRzQFfJngmudzwbbMOSbukbBa7rmiNr34J+kL1DWTWTEUTXEd66
         G+XReXa/rnDhDJ3xiRiUiC7OclNMmhCJ+YFHsIN0IryxgEzXaHPgRx8AISI5wmPvhkVK
         uHnA==
X-Gm-Message-State: APjAAAVZ+RPhUV/O2iUZGZwarO3Ig9AF+VM9fz4oJ0DzU616MjEJzXoT
        UfcK6whI/UAy3cXogkTDRAM=
X-Google-Smtp-Source: APXvYqwNCk9dTLf6PRTkYsS5B9lezj1GIKYCU3LxHDQIG+agVQDk5svygrX8B+BbbrB5sBIE/3Ta+g==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr2683779wrw.281.1570019210652;
        Wed, 02 Oct 2019 05:26:50 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id t203sm8458080wmf.42.2019.10.02.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:26:49 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:26:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/3] usb: host: xhci-tegra: use
 regulator_bulk_set_supply_names()
Message-ID: <20191002122648.GC3908655@ulmo>
References: <20191001132333.20146-1-brgl@bgdev.pl>
 <20191001132333.20146-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20191001132333.20146-4-brgl@bgdev.pl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 03:23:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Use the new regulator helper instead of a for loop.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ul4gACgkQ3SOs138+
s6HhUA/5Ab4y4CUvbNGI3qBuN5kszxhX3js9RnOzfvLMECkxSStw0S9bI4cluZBJ
Y9T9McYbSoWyoAqGuvVAK5BnqcgytzaqBMvLqmsYb0q5hYxQGCSHeQkpYir0Aq9q
0GiFHGkbqg0+y5UQkM0SlfWHwIYT7arDhd0XHncmNQtaAWWEKopZTSR2mys4XAE+
bXskoedemp3oIvjxXIvYQZzMYnJyMXTzLjtjEZFetaOWq1QVXY0Dqf5YasutN5/K
Urs9TGZtW31qxC9z6T6xWxLuPtS0kXOIhYQ+dlS66+sra4MNQaRse5h+1BWFKeee
Vmn81FVXniTLbpCMQ0M/gxFSGIoAADiK2EI0sDju3KzoOcq1Ol9gxQGeTnkXklSj
gXxt/1PwZPQLJxlerrYUvlv2gQLjdv74pRKCgAN5/JOKw25kXzANWjmNfWn3E3p0
/CUmrVCrCgIFG6yTt9bGGWCMsgMieEQP+scabwBYEi1Vflt+I4lwvxNFMD/3Qk4A
N7TRvhVMB8o4pa1jls6/NM6edqFnj7KZqBk4RhkCWsYbAECVgDB01rOsCH9sRIj9
mZMG6HUatyG3auomJxl4PZl4COre1ECfu92u182uqyt6+cIh1xyuZo0fNd9FJCei
TKkVS8C8ryl0zFEjPnObWBdD0HLb8aQJedzelvubwCU1U1bek28=
=qTAb
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

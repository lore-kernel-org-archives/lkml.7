Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6DAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5520815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgD1WPZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfJANiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:38:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfJANiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:38:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so2442322wrl.11;
        Tue, 01 Oct 2019 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96r3CtWiSvcK9gJDc0tqchiSXL0mJ/YvvBtbDmkfaE0=;
        b=SgD1WPZopI9T61+uSgIvK+P8Moz6ilypDWR5uZTEcSuXxgh1OVfRxm8IC4KUHqMmSX
         hBpGb1wgoBnVtZU64ZhZhr+uvsnzRW/oNhSmvQvPcJiVn4Y+sszZSZ8iK4h2QVTZ/vD/
         Din5OSrcToGMog98cihi9+QPhYXtbZdwZeVtyftm5g8+p0FRTR7IyBmjvhwKnugSiA9P
         qSj65oMPYlvd5CfFm/4+9WBwPAqze/wV4n7HpSB5Kf92Y7gNEEPi1977PQ0qwg1bstoG
         e/NcisDmyad+4UgxYGb9cCU4WroV+kg9wmeo7HYz9pCGEqNW64R7AEoAusLmSMVlDEAh
         uImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96r3CtWiSvcK9gJDc0tqchiSXL0mJ/YvvBtbDmkfaE0=;
        b=ig5y2A2iLA3S5LalM5yU4n1qZlbBUyBOyTrvGH8EyuLxwzOmQpzar/IhQi8wxY+Yjd
         tysZ5gr6Nw1bPqEp/MgSkZJ51kX7mbOg415rNRrecXTiEhujaQNzaM1B+aCBoGIzk70k
         XsAEgshAC0XFwX5/RnYfgTlXUjTC5BVQVyyMNmnVYJqJiYtZSGbthhjKbOYHGnwm1HmC
         tB+jR6JKNcT38R9Kt3TA4NlaDTYqwV2V7coSgCINPLQIuGlnllMTHYSo3HbRY5hx+J/F
         iqBT3WsjuTfz3PINuOuwN0FMlNeeeGhweuKZtdiGIjLVd5dRHQmEwnT8eYoLg/eWJP2e
         qDHQ==
X-Gm-Message-State: APjAAAW6ZjJFX5UJsKCkuourO5nC1tD970PJfwJaftsLi0oY3uOG5jIJ
        SIaE0QH3mesLN+A1Y8UlGOdGhFuS
X-Google-Smtp-Source: APXvYqx2MapoAoWxH36kAG/86QPnpHg5qum++6m/VlNMhipx4NA3i/ZbQOKuletj5kJHHrNYMRtLMg==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr6086222wrv.160.1569937090036;
        Tue, 01 Oct 2019 06:38:10 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id f20sm2844042wmb.6.2019.10.01.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:38:08 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:38:07 +0200
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
Subject: Re: [PATCH 0/3] tegra: use regulator_bulk_set_supply_names()
Message-ID: <20191001133807.GB3563296@ulmo>
References: <20191001132333.20146-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20191001132333.20146-1-brgl@bgdev.pl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 03:23:30PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> The regulator_bulk_set_supply_names() helper was merged upstream. Use it
> in a couple tegra drivers.
>=20
> Bartosz Golaszewski (3):
>   ahci: tegra: use regulator_bulk_set_supply_names()
>   phy: tegra: use regulator_bulk_set_supply_names()
>   usb: host: xhci-tegra: use regulator_bulk_set_supply_names()
>=20
>  drivers/ata/ahci_tegra.c      | 6 +++---
>  drivers/phy/tegra/xusb.c      | 6 +++---
>  drivers/usb/host/xhci-tegra.c | 5 +++--
>  3 files changed, 9 insertions(+), 8 deletions(-)

I really don't see the point here. You've got a positive diffstat here,
which means all that churn is without benefit.

Is there some subsequent work based on this that will actually improve
things?

Thierry

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2TVr8ACgkQ3SOs138+
s6Gmxw//XyHpBaZ6nH9r5G6qR4tc5ltdQB1dqjsetQiQ3GP40BUwO9mtMUUgcfI/
rdgUFAuLtiTH5m5XHYyCmBIWHi38bwTStJ4x0f7zg7IAfabhlRrTDPsaUSJuN+tt
JL5RYKy9LjGIt8B3FusJWBgMMhAhmLf4vTTBqMRaK1vAd7XFqz0LAz+weUs11aZ8
gauUBP2qZ6n+lL5ahAStY/0GC9gos1iNzgsvG6tZD3JyWQe6xwKvrroSq+s/iQUL
V00s28QIe+zsQMl9f47mkJoAY5d55heIehG7oaYWPYsJS83yeHlW7YRi+CseyZwa
o8ZSi3FqILEuO+yjH+h2nD8bpKltfhBwi4VUzn0sFAzz4btFkt1J0JYClKpF+Fwx
msvSehNfgZt0JDJaQ6ACCBEVkcfCXe0pXX8BwLYW83V9gKWnklf97DKvFKmg4HMd
/2JeVHouwG20VkQcjnYBTOpBv+08DKG0D19ZgviHnibUeTTu6mlpbCD2T6DzkLUE
mGInzNLfgLfflCSeOusBazYQGy9DrGNhqGpnREXDY8NwZEUyA1EkHSl6BCOc6RaI
VexLVXa11R0fNZRNJk2H2/MU9H/MWUUC+jRJQ+4X/ScGYtWjkJSe8LJ0KmgA2/5/
gmqCqriJyFLot6c/z1kmNoSo2q2iedr7i4XKaUKrnf28LTQlRxk=
=aSWM
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

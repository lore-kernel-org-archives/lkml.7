Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5DBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5521530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfFULE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:04:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52099 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:04:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AEB14804F9; Fri, 21 Jun 2019 13:04:14 +0200 (CEST)
Date:   Fri, 21 Jun 2019 13:04:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Schneider <lukas.s.schneider@fau.de>
Cc:     kim.jamie.bradley@gmail.com, pakki001@umn.edu,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jannik Moritz <jannik.moritz@fau.de>,
        linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 4/4] rts5208: Fix usleep range is preferred over udelay
Message-ID: <20190621110405.GG24145@amd>
References: <20190619154648.13840-1-lukas.s.schneider@fau.de>
 <20190619154648.13840-4-lukas.s.schneider@fau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <20190619154648.13840-4-lukas.s.schneider@fau.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-06-19 17:46:48, Lukas Schneider wrote:
> This patch fixes the issue reported by checkpatch:
>=20
> CHECK: usleep_range is preferred over udelay;
> see Doucmentation/timers/timers-howto.txt
>=20
> It's save to sleep here instead of using busy waiting,
> because we are not in an atomic context.

Is it good idea? How can the system really sleep for 50 usec?

      	   	     	     	    	   	     Pavel

> @@ -865,7 +865,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8=
 sample_point, u8 tune_dir)
>  						     PHASE_CHANGE);
>  			if (retval)
>  				return retval;
> -			udelay(50);
> +			usleep_range(50, 60);
>  			retval =3D rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>  						     PHASE_CHANGE |
>  						     PHASE_NOT_RESET |
> @@ -877,14 +877,14 @@ static int sd_change_phase(struct rtsx_chip *chip, =
u8 sample_point, u8 tune_dir)
>  						     CHANGE_CLK, CHANGE_CLK);
>  			if (retval)
>  				return retval;
> -			udelay(50);
> +			usleep_range(50, 60);
>  			retval =3D rtsx_write_register(chip, SD_VP_CTL, 0xFF,
>  						     PHASE_NOT_RESET |
>  						     sample_point);
>  			if (retval)
>  				return retval;
>  		}
> -		udelay(100);
> +		usleep_range(100, 110);
> =20
>  		rtsx_init_cmd(chip);
>  		rtsx_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
> @@ -918,7 +918,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8=
 sample_point, u8 tune_dir)
>  				return retval;
>  		}
> =20
> -		udelay(50);
> +		usleep_range(50, 60);
>  	}
> =20
>  	retval =3D rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
> @@ -1416,7 +1416,7 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
>  			retval =3D STATUS_SUCCESS;
>  			break;
>  		}
> -		udelay(100);
> +		usleep_range(100, 110);
>  	}
>  	dev_dbg(rtsx_dev(chip), "SD_DATA_STATE: 0x%02x\n", val);
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuaUACgkQMOfwapXb+vJdwQCbBhRj4pZVZbSxjFw5Ou1WPS5+
SJIAnRX/bJiI/3/Npo1cUiL+ZXtQx3UK
=+6QU
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--

Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20842087F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfCXWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:09:16 -0400
Received: from sauhun.de ([88.99.104.3]:41010 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXWJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:09:16 -0400
Received: from localhost (p54B33218.dip0.t-ipconnect.de [84.179.50.24])
        by pokefinder.org (Postfix) with ESMTPSA id 51B2C2C0114;
        Sun, 24 Mar 2019 23:09:14 +0100 (CET)
Date:   Sun, 24 Mar 2019 23:09:13 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: enable buses to save their clock frequency
 in adapter
Message-ID: <20190324220913.GB6934@kunai>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
 <20181210084111.6938-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20181210084111.6938-2-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tudor,

thanks for your patience! Now that the at91 refactoring for the I2C
slave support is merged, we can keep going forward with your patches. As
I told you personally, I am positive in general about this change.

> +	u32 bus_freq_hz;

Why not unsigned int?

I also think we should have accessor functions for this new member. They
will be very simple currently because we don't really support changing
the bus frequency at runtime. However, I can see that it could be added
somewhen on top of this change, and then we need to extend the accessor
functions with some locking.

For now, I think this can be solved with simple policy: The value has to
be set before calling i2c_add_adapter(). Also, we should define that '0'
means 'value not set'.

So far about my thoughts. Any more comments from the list are welcome!

Thanks,

   Wolfram


--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyYAAkACgkQFA3kzBSg
KbYFdQ/8D0r9Q2iDBaKL+JQ7rhQYIU5+/eyYfJq3PbUdnUhA4IyPZonMtzUvUnib
HfkKZdmB/DCE0mUlS5dB2T5NGMObGqfaMEGydzVI9h+h0pCrrQ7LQVj8DOA2lKEV
g5WVuo/mT/P8bwYMei5Oo/bUe3pLUcl4/rOhySVl5Ns8+QKsPjNWMi+asmP5AdHY
w2FsfuWzxnb7Pp59BVUk8Fv4nIHSu6s+xTxMm832MEPhO0l/gybXl/RbGnm5fyLo
4jr0FtDm5vpH90CcW0TzV5zBgMWxSMHn1VQx8t7lEGDe9noUZvOr8ttGZ1XaSf/4
BzcGRKQsaN+EfjQOQ8hFfTxVYaIgdCv64OlEyAxi4Wk5P/KywMEUtihAPznjfaWz
IAGw2GorsaH/izQq+WLHqmJBkUmiKduevUTo4SkCcz/RFH+EHqZDkRXAW7DxOF2W
z7y1+YEPLr1D1R5B95mI2xeZ545u2lpW1PImjTJcSwiKNq4maTTNOMOk1hB/nMfJ
Mu2WOrRmQosouuryU3Ma/1sNh5kJMAdd3nvKj2szVRAQM8kokXXswbih7q/LvWnv
/u9nwFiHUDibsB9mJeew42iHGqRRqV+sP/cQEOtWLqW2gM5k/0kiqbLobYmyX/2N
6o6DWMitZM5FYZjKYor+86fDEzRhrJ0VBBKNWORVeq1omSNS6go=
=MkdM
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

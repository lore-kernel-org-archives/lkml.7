Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4702C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A381206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbfDQTpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:45:32 -0400
Received: from sauhun.de ([88.99.104.3]:33968 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfDQTpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:45:31 -0400
Received: from localhost (p5486CD54.dip0.t-ipconnect.de [84.134.205.84])
        by pokefinder.org (Postfix) with ESMTPSA id DD8A72C088A;
        Wed, 17 Apr 2019 21:45:28 +0200 (CEST)
Date:   Wed, 17 Apr 2019 21:45:28 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190417194528.xwivkyubhxyfrx4m@ninjato>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai>
 <20190416223813.GA744@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i3b6ii7ljdtzo5c2"
Content-Disposition: inline
In-Reply-To: <20190416223813.GA744@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i3b6ii7ljdtzo5c2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Yes, that works as well. Note that it will actually print something like
> "watchdog: <device>: ..." due to the pr_fmt() at the top of watchdog_core=
=2Ec.
> I guess that should be ok.

I have the following diff applied on top of patch 2. Works with and
without a parent device. I am not super happy casting 'identity' but
since its u8-type is exported to userspace, I think we can't avoid it.
Guenter, is this cast safe? Here is the diff:

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_c=
ore.c
index cd3ca6b366ef..62be9e52a4de 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -115,6 +115,8 @@ static void watchdog_check_min_max_timeout(struct watch=
dog_device *wdd)
 int watchdog_init_timeout(struct watchdog_device *wdd,
 				unsigned int timeout_parm, struct device *dev)
 {
+	const char *dev_str =3D wdd->parent ? dev_name(wdd->parent) :
+			      (const char *)wdd->info->identity;
 	unsigned int t =3D 0;
 	int ret =3D 0;
=20
@@ -126,8 +128,8 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout =3D timeout_parm;
 			return 0;
 		}
-		dev_err(dev, "driver supplied timeout (%u) out of range\n",
-			timeout_parm);
+		pr_err("%s: driver supplied timeout (%u) out of range\n",
+			dev_str, timeout_parm);
 		ret =3D -EINVAL;
 	}
=20
@@ -138,12 +140,13 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout =3D t;
 			return 0;
 		}
-		dev_err(dev, "DT supplied timeout (%u) out of range\n", t);
+		pr_err("%s: DT supplied timeout (%u) out of range\n", dev_str, t);
 		ret =3D -EINVAL;
 	}
=20
 	if (ret < 0 && wdd->timeout)
-		dev_warn(dev, "falling back to default timeout (%u)\n", wdd->timeout);
+		pr_warn("%s: falling back to default timeout (%u)\n", dev_str,
+			wdd->timeout);
=20
 	return ret;
 }


--i3b6ii7ljdtzo5c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly3glgACgkQFA3kzBSg
KbZk3A/+LZ2YvExZPaqhdORkp74iw/y522BH5v3O6XmWaBH2TLEYGEYsc41+LEuS
4FzI1U5yp3k/sbqhUtpHN0lE/7q9WtB4gRCs+wMEMM+mgLf997UFHFVTfVynoGJs
hkEfI7l7MDvPQS+lekjmLM/1eh1N3qEXVyvW4lZPD3S0TUgELFnfOzpzaypxi3X4
kkg6MyeDQUiE9PxD6pHv8eBgWGF27R3cN2e9ZeSARjsRW8mdnH7LNipHlFwYJIok
xzBRXycrJYfZMXh3C1bI1z7tvkV7Pwi0uNYATEQWJMc9/Jsf2PdguedybZj30ru3
L5sUSyNaj50XwmkYWxJ+wRZZqgMhUh8jjd6+YoRh8z32PfA+ewD5hHiuWK/AUvET
FNNuevV4cZ4bwleO6zixSjHviJMANhKDb8GGNjZk/a+lq4AGTE2cdD4AohaF0lCi
ZEUUHzQiuKIVcNbvK5dEND/c56RHdwBsKkkQ9WV+Pfs6E7EoMLSeISEI17cJVkK3
6q3jt9sDhoLGzt6x8yHgtq94rr8nCcF+mXOPLtDIlTSlJrzmiUlAjzOtuWZxljIo
m2T1gCQUdAOC3CIEVxKoKNrxtvWg6CTcWGLjvNzYEQdNKQIsYHclubTl7Iz1AwOp
57oli+kezXE+RtKBZDdv0i5SMs1RyiJyVJ13mPQUhtxA/E6z05s=
=nISJ
-----END PGP SIGNATURE-----

--i3b6ii7ljdtzo5c2--

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA183C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DE720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfCYQoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:44:03 -0400
Received: from anholt.net ([50.246.234.109]:35938 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfCYQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:44:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5E5E910A2EF4;
        Mon, 25 Mar 2019 09:44:02 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HsXuhGinJWRG; Mon, 25 Mar 2019 09:44:01 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 21D3410A2A70;
        Mon, 25 Mar 2019 09:44:01 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id B5FA42FE4653; Mon, 25 Mar 2019 09:44:00 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drm: Add a helper function for printing a debugfs_regset32.
In-Reply-To: <20190221093757.GL2665@phenom.ffwll.local>
References: <20190220210343.28157-1-eric@anholt.net> <20190221093757.GL2665@phenom.ffwll.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 25 Mar 2019 09:43:58 -0700
Message-ID: <87zhpi29bl.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Vetter <daniel@ffwll.ch> writes:

> On Wed, Feb 20, 2019 at 01:03:37PM -0800, Eric Anholt wrote:
>> The debugfs_regset32 is nice to use for reducing boilerplate in
>> dumping a bunch of regs in debugfs, but we also want to be able to
>> print to dmesg them at runtime for driver debugging.  drm_printer lets
>> us format debugfs and the printk the same way.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/gpu/drm/drm_print.c | 16 ++++++++++++++++
>>  include/drm/drm_print.h     |  2 ++
>>  2 files changed, 18 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
>> index 0e7fc3e7dfb4..5ecc0f04cd0c 100644
>> --- a/drivers/gpu/drm/drm_print.c
>> +++ b/drivers/gpu/drm/drm_print.c
>> @@ -253,3 +253,19 @@ void drm_err(const char *format, ...)
>>  	va_end(args);
>>  }
>>  EXPORT_SYMBOL(drm_err);
>> +
>
> A bit of kerneldoc would be nice. With that:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

+/**
+ * drm_print_regset32 - print the contents of registers to a
+ * &drm_printer stream.
+ *
+ * @p: the &drm printer
+ * @regset: the list of registers to print.
+ *
+ * Often in driver debug, it's useful to be able to either capture the
+ * contents of registers in the steady state using debugfs or at
+ * specific points during operation.  This lets the driver have a
+ * single list of registers for both.
+ */

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyZBU4ACgkQtdYpNtH8
nui+JhAAj/z8uWtwRTJDBxpJ34iGxOGP4H36JH/bYfVsQwDjjv0su8SZEvPPEWPa
eszpaZzYDhSAL+ObjZ2+tS0ZpPp6yjF2YTdgauZ4BiGU1foxPMuMfZxnA6PJXtNb
zBm+At4XaBcxaRR1jz6qzj+Dop5gJJhJhUPW/nf+d7OG5dXadwZG5b4bFStX1cc4
eZOsVDZO4qPa+z+j11OATkuaOIGdTbuk3FsAK2CTso1dRvu4K4BGkuCMkx5uRD6/
HZeO1/1BTwYpOahxAQzdSTYUgRgJLURHoutsyodYdRwQPA7dW6UVRNtwuMptJQ2C
leuNTAzTMDP5lqLCnXqR1kbJowf1S+2fW2amk1hLBi9EgKQKzQsbmV+k1am+2o09
JFyunF6Pbt2RvH6gy0uajGHXA92wStb14MJRWHZerylf7OzILHF7blezLMJpZT0V
0hktMnjiIThnEG5Sb2RyWXiFxT9PMHN7p5S8hYNnQMjr/0sHKlpvbWBpil1+4Vq9
8TSAXEXD9sNYlWmdTyONqjHBo5Q8pYZECJLi0mRPiH9FZc3CHUlp7KptcvBRh1Wh
ApYoy4HM+ajyoslS6ccaZWX+J/3iz70qXcYWmvQ4fcfP64pu59YM5A66XQQzNe24
+28nVhk9PERlE7bK4uIYVlki/2vAFnTQH5XJ9fr8dmxN7uLkx3U=
=X4XQ
-----END PGP SIGNATURE-----
--=-=-=--

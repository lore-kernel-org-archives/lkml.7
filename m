Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C872206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jfTmAkXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfHADiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:38:46 -0400
Received: from ozlabs.org ([203.11.71.1]:59349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfHADip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:38:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zbcK5Z9mz9sNf;
        Thu,  1 Aug 2019 13:38:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564630722;
        bh=isPmiUGwY2MF0zG5T4q1ehy6NMVRyd1KzUvIWv/GRUo=;
        h=Date:From:To:Cc:Subject:From;
        b=jfTmAkXSJfer3viLdhLLGhK7RIAqhzF6lK3Ek71POl9TmeCIFfoBn2fn3W8FPBzSs
         t/vmko3i/FwzJue9XHFazPz7lZeMO2DTLe+HF2+/a3Ea+5/MLJBR8Z4upo3dBzpKVe
         MY1ThJ1pbhLymzCSk5AZaCMfY9JZlcdZojxvc7iwqKmYFPAHHeJ1XJ51l58CCzFoxs
         6O/56bjvhwJA4D8RfBtmAKBbmUByXEkY+lrPIX7T65gbah1SlWGne3YBBT3GQMY2/b
         RA++38rD/6EkiucuHeH33cGpeNPhEWLJ1GqlmIOZcBdEaTyRguGiZdfccBC4UrP3kq
         XdsyIPVQl+kdw==
Date:   Thu, 1 Aug 2019 13:38:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20190801133841.64e69541@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C8m=IPxq7KGrUarT+ZbNn=6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C8m=IPxq7KGrUarT+ZbNn=6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/staging/android/vsoc.c: In function 'handle_vsoc_cond_wait':
drivers/staging/android/vsoc.c:440:33: error: passing argument 1 of 'hrtime=
r_init_sleeper_on_stack' from incompatible pointer type [-Werror=3Dincompat=
ible-pointer-types]
   hrtimer_init_sleeper_on_stack(&to, CLOCK_MONOTONIC,
                                 ^~~
In file included from include/linux/pm.h:16,
                 from include/linux/device.h:23,
                 from include/linux/dma-mapping.h:7,
                 from drivers/staging/android/vsoc.c:19:
include/linux/hrtimer.h:381:67: note: expected 'struct hrtimer_sleeper *' b=
ut argument is of type 'struct hrtimer_sleeper **'
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
                                           ~~~~~~~~~~~~~~~~~~~~~~~~^~

Caused by commit

  82e18bace3dd ("hrtimer: Consolidate hrtimer_init() + hrtimer_init_sleeper=
() calls")

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 1 Aug 2019 13:33:44 +1000
Subject: [PATCH] hrtimer: fix typo in hrtimer_init_sleeper_on_stack() conve=
rsion

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/staging/android/vsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 4f7e6c1dce42..1240bb0317d9 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -437,7 +437,7 @@ static int handle_vsoc_cond_wait(struct file *filp, str=
uct vsoc_cond_wait *arg)
 			return -EINVAL;
 		wake_time =3D ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
=20
-		hrtimer_init_sleeper_on_stack(&to, CLOCK_MONOTONIC,
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
 					      HRTIMER_MODE_ABS);
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/C8m=IPxq7KGrUarT+ZbNn=6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CXsEACgkQAVBC80lX
0Gzv1Af/Svs9pQ2C9NRXoLQBC6VPuNa+1hZUNJRHFHXCj5BChFx73OESfc55SMce
o4RIDmxoGdWdGe96sllUnmBcW+lcDQm07H3agp+d/4GAVBKP3cxSw58OMk2B+ExU
OaVmQx4uUj9l23CDES+WF47nin+Doj4MvXCPaQRE4VRm+x7WfGE7C+WjMs924jLd
fApgrsXK6dWTz5jvZKReRJY4MyVVCgP/CJR4leji6UzgggHIxdh7l6Oq4e1WZLnu
Gw9IBDJMgdaTePup81+TPzwzg/k5Pd5EkqRuLE1R9ujY7lGQUM3VLHnvAHRw4ekN
mJiEjKM8hUOI0AXNqSHGmyTHhx/KVw==
=SOjt
-----END PGP SIGNATURE-----

--Sig_/C8m=IPxq7KGrUarT+ZbNn=6--

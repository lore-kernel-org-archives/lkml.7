Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC928C32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A962133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eVHlTn+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfJDA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 20:28:55 -0400
Received: from ozlabs.org ([203.11.71.1]:46157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfJDA2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 20:28:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46krMm2t9cz9sPv;
        Fri,  4 Oct 2019 10:28:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570148932;
        bh=PTlOap/H0pjO4Y6CRG4ys9DEy35nD7nu8ddSTSivxQA=;
        h=Date:From:To:Cc:Subject:From;
        b=eVHlTn+p1SGKrjInm9HkbApB1J0o7dnPos+cSWSOPwE2EmrPKB7RaYrYi2NIQkZAm
         fVOZkNw8LWpo7hOWGwbdUPk41ODHUYxAr/Tnp7PHmKaMVgSihbCy/sgMSYh2GyRHfy
         Ab5XzZZf58ecNTORUY0fTqL8SngbGcqlMnrAuXeT8jgzS1Zfk7lZu/cm+zl4B6HalU
         7vnDYnYPxnxf9QoWKCXjzWLkOrd4ehi5U9el6qmmvi/9xNHNOU7OnaonSOjBOzSby7
         V3EaiFJEGyrICrkgmZzrxqggDA29hR6Owio9hqD8be512SjvZzCqdrdXwlEF6i9mXV
         jVOpZCMDlJw5Q==
Date:   Fri, 4 Oct 2019 10:28:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: linux-next: build failure after merge of the hid tree
Message-ID: <20191004102844.4864a9af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wcPrFtbs1AkLEGvhWtew5yU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wcPrFtbs1AkLEGvhWtew5yU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: drivers/hid/hid-lg-g15.o: in function `.lg_g15_probe':
hid-lg-g15.c:(.text+0x1a1c): undefined reference to `.devm_led_classdev_reg=
ister_ext'
ld: hid-lg-g15.c:(.text+0x1c68): undefined reference to `.devm_led_classdev=
_register_ext'

Caused by commit

  3a0275384c27 ("HID: Add driver for Logitech gaming keyboards (G15, G15 v2=
)")

For this build, CONFIG_HID_LOGITECH=3Dy and CONFIG_LEDS_CLASS=3Dm.

I have used the hid tree from next-20191003 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/wcPrFtbs1AkLEGvhWtew5yU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2WkjwACgkQAVBC80lX
0GzXFAf+PwmlgZL/q9TuzxBYTv0BxHzTMOV2ZFwZhwgUTectVL9pIs2ihHqe7jAG
znKeMw/i35mKYszF0ud3TV2oGfqmNppB/YThJzraj7MHT6YlNqsWoZNYTXlpv/bP
52jzeTZbxYB5Q924cpYC39Z9HE8rKTiMm0ktOKDI24WQyH2Y+Dwheek5YNPABTRT
rl6+FomqmVJC2kZg0qDH7LWkQqFO70qat0v7Ygg6WZSBBBV2JUuSYPUOqjTl5IU2
aiobRk2mnuw74zS16P8UCFpaGRYcV4wvbKWfTUFPk12cssu7V0elZjWArHrXIV3N
SznvJejGYXTULztGilOvYezAEXZpEA==
=ZC4k
-----END PGP SIGNATURE-----

--Sig_/wcPrFtbs1AkLEGvhWtew5yU--

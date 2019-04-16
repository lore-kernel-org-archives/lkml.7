Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D5C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440DE20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfDPUzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:55:36 -0400
Received: from sauhun.de ([88.99.104.3]:52662 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfDPUzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:55:35 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id C12652C3637;
        Tue, 16 Apr 2019 22:55:33 +0200 (CEST)
Date:   Tue, 16 Apr 2019 22:55:33 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190416205533.GB8268@kunai>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20190416204814.GA26442@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> That is indeed a problem: the pointer will be NULL if there is no parent
> device (such as in softdog.c). Otherwise it should never be NULL.

Okay, this spoils my err_dev solution. So, we probably go this route
then:

	pr_<errlvl>("watchdog%d: <err_msg>\n", wdd->id);

?


--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly2QUUACgkQFA3kzBSg
KbYumg/+M6eJR8P4Ytfq/Td9QpEV9hdIc8422y/SRy2fU0eiyJ4zktPc0ZMLLl6D
TeXnSwfwn86ABsrRRjDokMRMS/J8PibPn1CNNNe5OG7YZmr2k8fl1K+RBed5Hdcx
H4l33imF+wx8PlMmFT5I5WyafSGYJnS5zsA7Yr85g0hGLrg/nDNqubZqnYJnIj5X
tHxNc4Nb+wL78bHMX8Lb7ua+1hIZqhT845FALmB7adaWKQlJ+vBnPRf3ZsYH5rC5
gm7+Bkm4W4O0KRROc7z96HtvepArzAQ+OeyL6xUE/i1J13NyUXeRva6zVpGaF7NN
HwzQUPXWdwAfS1uGd7+W3FgVSuPhwZ6OBQd1mhoQnG88a1xmHfq6Dmbd7TQp2+kK
YSr8F/rHTCb4zoemhpF2jmEc8sJEkA30rpzfOX4QNtW5sg7yvQg8xq00UzxJhYQJ
Cn7tgbqhr8Fc8e9HoFG+BNVOv/nPOYuaEokjI0sbAzY7ZihMQQUfAOlrTL3We8X4
oGjksD6+rZmiZ/W3k8c/OhvW157cZziJotyFS5FrEmNf94IkH92QXWgnBpJYVgeM
VoRphI/XfcF+Gk96ZVfJ+rL1OsKDQcA8X0UtukD6QZKx9Z+U/6BWtKYETYWRKC+Y
LaOR6UNpYdPIOSmDgzZeD0v0efQSPKEQ7PZFWqDjQJQu152RfSQ=
=SUL0
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

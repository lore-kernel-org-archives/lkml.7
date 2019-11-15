Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0852073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKOKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:02:13 -0500
Received: from pietrobattiston.it ([92.243.7.39]:48196 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbfKOKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:02:13 -0500
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 05:02:10 EST
Received: from amalgama (unknown [IPv6:2a02:578:85b0:500:6544:6148:b2c5:4b58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 267B1E1E7B;
        Fri, 15 Nov 2019 10:51:49 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by amalgama (Postfix) with ESMTP id 6A7A83C01EF;
        Fri, 15 Nov 2019 10:51:48 +0100 (CET)
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net> <20191114215154.hze2avicv7pwiksp@pali>
From:   Giovanni Mascellani <gio@debian.org>
Autocrypt: addr=gio@debian.org; prefer-encrypt=mutual; keydata=
 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
 uq3/WmRPv8r10mXRkWvDuXvi
Organization: Debian
Message-ID: <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
Date:   Fri, 15 Nov 2019 10:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114215154.hze2avicv7pwiksp@pali>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VRlruaYk5NhSb22zKHuexSmqkCKNkJcx2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VRlruaYk5NhSb22zKHuexSmqkCKNkJcx2
Content-Type: multipart/mixed; boundary="noQrS7Pec5SqEHiMVloew3aXNKUtDdFOP";
 protected-headers="v1"
From: Giovanni Mascellani <gio@debian.org>
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net> <20191114215154.hze2avicv7pwiksp@pali>
In-Reply-To: <20191114215154.hze2avicv7pwiksp@pali>

--noQrS7Pec5SqEHiMVloew3aXNKUtDdFOP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Il 14/11/19 22:51, Pali Roh=C3=A1r ha scritto:
> This is model or BIOS specific. For example on E6440 are used 0x34a3 /
> 0x35a3 SMM calls. Because of these platform specific problems we have
> never incorporated this patch into mainline kernel.

Would it be sensible to use a dmi_system_id table to discriminate
between the known models and choose the right commands? Of course we
wouldn't know the complete table at the beginning, but it can be filled
as unknown models are reported.

As a matter of facts, testing your patch I discovered that 0x34a3 /
0x35a3 work on my system as well (Dell Precision 5530). Do you know
systems on which other codes only are known to work?

> Also note that userspace can issue those SMM commands on its own (via
> sys_iopl or sys_ioperm), fully bypassing such "protection" proposed in
> this new patch.

Yes, I know, but this is incompatible with Secure Boot, so I believe
that this feature should go in the kernel module, and userspace should
eventually stop doing direct requests and rely on the module. Isn't
userspace sidestepping the kernel in this way already assumed to take
their own responsibilities, much like userspace writing random things to
/dev/mem?

Thanks, Giovanni.
--=20
Giovanni Mascellani <g.mascellani@gmail.com>
Postdoc researcher - Universit=C3=A9 Libre de Bruxelles


--noQrS7Pec5SqEHiMVloew3aXNKUtDdFOP--

--VRlruaYk5NhSb22zKHuexSmqkCKNkJcx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSiBF6hBvCQNcghJEaNr8EMz954SQUCXc51NAAKCRCNr8EMz954
SYC1APwOZ5A2KufzPUrGbpHZH4wfIE/d3F2oWm2itXUuzAuWRgEAi+yPiuRNvxHr
mmHAQ5sZ9TluvzrnsHkqJ8HvbpPLaQU=
=6Yc3
-----END PGP SIGNATURE-----

--VRlruaYk5NhSb22zKHuexSmqkCKNkJcx2--

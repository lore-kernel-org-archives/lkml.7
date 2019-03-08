Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46100C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2DC205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfCHRrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:47:53 -0500
Received: from anholt.net ([50.246.234.109]:53338 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHRrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:47:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0731F10A2E2B;
        Fri,  8 Mar 2019 09:47:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4JNpYoaSh7E8; Fri,  8 Mar 2019 09:47:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B76D010A2BEE;
        Fri,  8 Mar 2019 09:47:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 5AF232FE4653; Fri,  8 Mar 2019 09:47:51 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Dave Emett <david.emett@broadcom.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Subject: Re: [PATCH v3 1/3] drm/v3d: Add support for V3D v4.2.
In-Reply-To: <87o96l71im.fsf@anholt.net>
References: <20190220233658.986-1-eric@anholt.net> <CAApk1dVubN7ME6GNuedGmF4V1qnH_JYnSEvFffAzwsMFaZNmgg@mail.gmail.com> <87o96l71im.fsf@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 08 Mar 2019 09:47:51 -0800
Message-ID: <877ed99s1k.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> [ Unknown signature status ]
> Dave Emett <david.emett@broadcom.com> writes:
>
>> Sorry, a few things I thought of after sending the Reviewed-by email...
>>
>>> +       v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
>>> +       if (IS_ERR(v3d->reset)) {
>>> +               ret = PTR_ERR(v3d->reset);
>>> +
>>> +               if (ret == -EPROBE_DEFER)
>>> +                       goto dev_free;
>> Might be preferable to make this explicitly check against the
>> not-found error code (whatever that is)? As in if (not found)
>> <fallback to bridge> else <return error code>. Similarly...
>
> You won't have both a bridge and an external reset controller in the DT,
> so I'm not clear on what functional change you're looking for.  You're
> just concerned about what the return code from this function is?
> -EPROBE_DEFER is the only one that matters from a probe, really.
>
>>> +       if (platform_get_irq(v3d->pdev, 1) < 0) {
>> This should probably explicitly check for not-found rather than any
>> error. As-is, we might silently go down the single-interrupt-line path
>> on a platform with 2 interrupt lines if platform_get_irq(v3d->pdev, 1)
>> hits some other error.
>
> If I do the -EPROBE_DEFER check here, will that be good enough for you?
>
>>> +               ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
>>> +                                      v3d_hub_irq, IRQF_SHARED,
>>> +                                      "v3d_hub", v3d);
>>> +               ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
>>> +                                      v3d_irq, IRQF_SHARED,
>>> +                                      "v3d_core0", v3d);
>> Not introduced by this change, but return value from first
>> devm_request_irq ignored here?
>
> True, but let's handle separate bugs separately.

Resubmitted with the fix anyway.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyCqscACgkQtdYpNtH8
nuhnhRAAm/sjWAX3LK2MFCqzZ4HXLd8aWaTyZZyjEn1XH2F1ItVEmdRoRO+Kpoof
TNILjfGehowGU3JqJ69oFAEXayTlx9ayZpT5P/OcSkU0V1io1Q9SoEQlhloEQEDJ
lMdwCaJ290dp4KYdmCFQW94QOOYfTqTGEVj79I01lNBh2dI7Xa7PrqFn4bFN40wX
IKqUknUig6DM/nTIFP9P1j5oGx1L3EjuGj/tVyYfRITyd9w8iojQYk0dYCDJng+M
4Cflv0Xrmpp3rdpxGqT3uQwO9PSvpgXJ0oHFEUyG73jE4qMyb6HxIJGFOmXxuII9
4E09nm4uGJpjBYTKMlKuAxexlwrmy0vNp8EzxGxTma3oTVWUK8pvmjSCOGGL2yTs
jiWZYy3w098ij795pdm7wu5u2qVtlGDMvfqSwFG4mbhqPPu5SaElmYPn5b/xWIqQ
cgUCXMootlIX6DyK+/U/nuVJg1ibKMPxb3W2Mbkh1DcbFHZKuYYTofs/uwjPnIat
eMGLOMTfsMlLXkCiZm+3rl5RXpNMT7CRJC5IWIJkFDEJO5yUsaSCKhfMtDCRgmFh
jNSjR7+92fFulJ4003rlndy47sOgaKfNDqO6C9mpf6M5wxJkfw7acpeO6BgHQBQX
NUjOKwGxI7mZ/L/DtfzIpMYlLhst5BOT4PtDyGgOqZMChZAomuY=
=QShD
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C77C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346ED2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="P604rRO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfDXPEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:04:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfDXPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:04:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so13921934wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UtKvFaMYKcOEFxAf7S6t3sOGUhT+jJuJvvvI5U7lMWk=;
        b=P604rRO6UgFEwaMCCp38v++I5yw4DuIZY61lsCe1e9tcZKp62qd7P95Oci6JDweIA1
         2ToHqqQjYxngeWqz1a98q66EL0e+QVbUYdAlii7xyKVtvPcQsDlMTCdBcMlrFvmILFc8
         plhZG+qc+UCRlvUa+6FrkYfQQTH/y6aXbzFGStRbohpsTIrwiPEzOrTdqgChWP8i64k0
         C77RNHvAFzp0FkOkp2UoVJf+Ssk+88VTOSqWXAJ56OYNhbX4qvG5GdGN+INkm6xkXOMa
         //HtEplVVkYJ+oIw+tLYgWZmMNeJ2j9QpsWNUjE8MC3n7T+hRReRYAcZxCz/1tmffU6F
         fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UtKvFaMYKcOEFxAf7S6t3sOGUhT+jJuJvvvI5U7lMWk=;
        b=cOlE7qQa5bmBBNqeL60nBdEbFUo1s3KAIODQCLN8GNwflZbTTHT0/KXGZrcG6il7ot
         Jn9KK9zA22qIVs/PN0Gw/qYbZmrAyy42B5TR//TGUVhorUPHfXLE4/r+SMaKl+A/Iw3X
         rJdX3jiH9hKZuFT/XTUPJGFP59+ZEfFGroxqCCdIuX1/dxix1L8ECwckE9JTpn7gqXet
         cQ3587KiACeQH8KsJaaTXyTJY6YbSyZJm5uHbh0558o8VL4YVGo42QBynlHdpkkzpnFd
         8N8KiVJ5KGNzmaM7rFnU0lhWZ44eUaUFriQRFsU8DnT8KSwEq675LUgePad63mffcgHE
         AlbQ==
X-Gm-Message-State: APjAAAUHMQPc7hzNcqLgrBD1l3j9Bv86xGhSIBILPUrAn1jB1wN55p41
        0s/eJrCP+AfDs7AVal+T5/mMjw==
X-Google-Smtp-Source: APXvYqyi+vrR1IKag6Wxoc0Fi+IV0KIQfXvxgV1K/GU8iFL/qfFVprFHN04RlAHsrPt8/l1Xgi3+mQ==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr22749535wrp.129.1556118268831;
        Wed, 24 Apr 2019 08:04:28 -0700 (PDT)
Received: from brauner.io (p4FC0A32E.dip0.t-ipconnect.de. [79.192.163.46])
        by smtp.gmail.com with ESMTPSA id 13sm16562468wmj.33.2019.04.24.08.04.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:04:28 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:04:26 +0200
From:   Christian Brauner <christian@brauner.io>
To:     tycho@tycho.ws, keescook@chromium.org, luto@amacapital.net,
        jannh@google.com, linux-kernel@vger.kernel.org, stgraber@ubuntu.com
Subject: SECCOMP_RET_USER_NOTIF: listener improvements
Message-ID: <20190424150423.k3embc2vkho2kixp@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vudzdu2fh7h6ai6o"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vudzdu2fh7h6ai6o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey everyone,

So I was working on making use of the seccomp listener stuff and I
stumbled upon a problem. Imagine a scenario where:

1. Task T1 installs Filter F1 and gets and listener fd for that filter FD1
2. T1 sends FD1 via SCM_RIGHTS to task T2
   T2 now holds a reference to the same underlying struct file as FD1 via FD2
3. T2 registers FD2 in an event loop and starts listening for events
4. T1 exits and wipes FD1

Now, T2 still holds a reference to the filter via FD2 which references
the same underlying file as FD1 which has the seccomp filter stashed in
private_data.
So T2 will never get notified that the filter is essentially unused and
doesn't know when to exit, i.e. it has no way of telling when T1 and all
of its children using the same filter are gone.

I think we should have a way to do this *or* alternatively have a way to
attach a process to an existing filter.

The scenario described above arises pretty naturally on container
attach. The standard way of doing this is usually
fork() +  attach_namespaces() + clone(CLONE_PARENT) where you don't
share the filter of container's init. So the seccomp context has to be
recreated. [1]

Opinions?

Christian

[1]: Note, that systemd-nspawn is creating the process by talking
     to the container's systemd and requesting it runs the programs via
     transient units but this only works if systemd is run inside the
     container and if you trust the workload.

--vudzdu2fh7h6ai6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAlzAevcACgkQjrBW1T7s
sS0UYBAArnbfK8vRmVJ0N3CcFRpKmFItoqKDHIEK4zqGgVXC4bP9M4q9OrwnZs1J
utnllI0Xk19FbJ6FWjuINvkO22bQqw+CkqKbYU4+zpApIRe4U5ckt6WjuUxqj6e6
qZ46xl3JC/JNyF7LK7C5uu0KJ447j7FXU/0nw+NQp1kXRfopdMohxcIHYpm8nkJL
1J6qea/erFuhvLd+r7GI2CxAYjoUVtdnvGJQyX+X/UGxQAHOk1Y5TbjFf9ch2PrW
fLqbGIl2ZQ713qb/jZM+msCrR1OnU9dH2peCkCMFkQmPy27dmjtdC+C12zt22b6p
W20VwJasn601miizWduWM/9k+PbGXTsL82sOv0z/nBr2PbWUk88HFy18oPxb1t7d
2nngTFLAhKcr8SfbUkcT2wjCTHRPgvGL3iy1TSpQIwtBEubpGCDiueqJOY2C1fG8
hmpJZnT24ZrFCatbyQXRMT8tDqmMUhy3pz+BZdQxuQyOrLGc8KAjbEHpd37eFVU0
879y7wm9vPnyJWAqE1ycj3HtfLLZvMkL/ZTCzp87UKseTsxBnbPqFgcfC1IiGsfI
JVk7LMHlV2i7oY71ZuQiyv7vzx/BVLsVwq3beJc8icEYYThczMnRWuVFDCuTyelM
lAmdAF7EY6fvlycsCcVVqToBd1IGPOIT5T2picokUtfzyxxMeA8=
=sKxP
-----END PGP SIGNATURE-----

--vudzdu2fh7h6ai6o--

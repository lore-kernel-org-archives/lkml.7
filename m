Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76319FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E834215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfKHVyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:54:00 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45404 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726640AbfKHVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:54:00 -0500
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA8LrvJO003606
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 16:53:58 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA8LrqF3011430
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 16:53:57 -0500
Received: by mail-qt1-f199.google.com with SMTP id m20so8847934qtq.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=6u/kteb+1VP+Ls8+c1O+w3Tz6wSk5cSCfhQVSFvadys=;
        b=Q4wtksU23Ig8MeynQwLRNdVpVkecBjJeV3uPoA13YJDljjDbSPU2iAaQXgRhBCWvcN
         SetxxvfRbzFEyz7hIQy7tvH4SfU4766Nlr+VkVA/siTGPYE/050MA1Nr/OmyWJOhYYCg
         77YJt4WQ27uPZeAv/xj4Y7PQVAKNjLJRlElkHNMw1CJgiBj0vl3IeK+GSXVmlIb2nkuu
         1TqvYaXeEW4/S+AlDZwUHaTPdhVtg7V/hFwaO3zjtUEWxNbsZSt04qeqlqVaUJNN0u+u
         uF3H9Uu9WZgL2kNaNSC2d1dG7Sh2uOgwugZdksNgh9OEFWPgGwMJlnAMu9mmUx6FMKMY
         s5Vw==
X-Gm-Message-State: APjAAAXCpBYC9ZQNNXRdGVx/PpXRovu5m7nkhqd3eZvySXGE5lVwiPk+
        H1yqFyxUUJ1ShZ58hQ8lcO9DeZUP/1WSwgdBHv1DCiw8+KEd7SN9xjj0Y3Gzjz7UHq4fCp+QiUV
        5VvYdee5RK4urqTjCZj1HQKDAmMaUKo2ytjw=
X-Received: by 2002:aed:255c:: with SMTP id w28mr13431199qtc.185.1573250032488;
        Fri, 08 Nov 2019 13:53:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrEqcce9cE0K4quRbgg++z7Fi7Lxmqopm81sZn+9yvMdC5nBTIZrteO39T9WWkp7wR4Y06fw==
X-Received: by 2002:aed:255c:: with SMTP id w28mr13431169qtc.185.1573250032181;
        Fri, 08 Nov 2019 13:53:52 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id e17sm4345469qtk.65.2019.11.08.13.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:53:50 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 01/16] staging: exfat: use prandom_u32() for i_generation
In-Reply-To: <20191108213257.3097633-2-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
 <20191108213257.3097633-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1573250029_29941P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Nov 2019 16:53:49 -0500
Message-ID: <33441.1573250029@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1573250029_29941P
Content-Type: text/plain; charset=us-ascii

On Fri, 08 Nov 2019 22:32:39 +0100, Arnd Bergmann said:
> Similar to commit 46c9a946d766 ("shmem: use monotonic time for i_generation")
> we should not use the deprecated get_seconds() interface for i_generation.
>
> prandom_u32() is the replacement used in other file systems.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

exfat does some weird stuff with i_generation. but (a) it doesn't require
monotonic increasing values and (b) this change is orthogonal to the weirdness
and won't break anything.

For the exfat part:

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>


--==_Exmh_1573250029_29941P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcXj7QdmEQWDXROgAQI1OQ//ezStXbB8JG2TWINA68IgPvBsh6EuosfW
k4X4s8YJbQS7QXAZb679Jc0EV1X9yXMdpvKBA9+gEXoimzUYSDinq7D3Nki08Ehc
Ggchu+Ht0EKLsGJh4lS36sKBMhoSb3CMFznGPWavdcS/pXM9NrGc5oF6NJDSftJg
RZzoNK19ZZNU8DTPWy40DTolRNTIqCUc0D5po5czSe8yvPB6bSYfRehKxebS/eRC
okfxJPkJDt2iZ3CcLOlCvPxU+j0qxWvwV7yHf4yAJVW4dstdt5+N6IcYXl2ss7wI
4OHDOfFT7S07zaFb1Okna33PONu/lzpUTBU5AOhxqBqIe5bc2ki7MtBuyGSW/Y1P
lde5zW2i+OMDe/091UGZKgfEZLBhYu+bmsNfx7va1Iqds/x5Pov1E642hQVc4/m9
q5aTBXPQdctAm6noigx8QOoWLMJyFLsVg26+6erYpSf8qA6acX7TuAPu/G3dWq3z
gdOyJPwSvd2XH+BK1DWKyVlMP639V9xrCZs9XgUDt8cQX7CIhNlAMZ20N34fj+ax
6iP1E4t4tZAcFBn5ajtKkS0Uq6XdfcB4e9vvLYK9aNrMk5b7AVhPJWwTncx/tcHv
5cQl1M/h4W7WiXfl8b1ZgdN8Qb3Sl5Qr3pVq0ekrD3HCPHCKiWRVlcwCx2ihwup/
OD7uQb99evo=
=bMTp
-----END PGP SIGNATURE-----

--==_Exmh_1573250029_29941P--

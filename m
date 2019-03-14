Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90711C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643E32085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="TzGY9GUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCNOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:16:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40103 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfCNOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:16:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id h28so3385897qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MjuRscEAQa7uwFVR6a/4goUiLyW9U+N9/Zr4EMvkSUk=;
        b=TzGY9GUpDJlyOipgu0GlApSeHoZ2NjC71ClIrVvUgAl7Ra4oA1wXnF5YhungNkCBZ/
         v8sJCRawQ3/Gf2QgiIJKWukoFSxKZbD5kH3X52J0IpwGgOXreA39gVyk4Rh0h6UFPFDw
         fBcQduJB/gWYLCCTfXPTv2Fo5wUTy2ncJjj3udv0DkHOhwA+wR6w5VvlVk4mCR1odbdW
         h0ZTCfp50s92N7ajGxcLQYM5WiVZ22PrKEvayTw9wwnUfu/QrpKXoiSpoHMITZunE61/
         BvGrnh6O0gGzg74GxL+odQL1GC6KFLfvnzDCf3ztFn1SSRqubv4URoRuYJ3IaHw2x3d+
         y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MjuRscEAQa7uwFVR6a/4goUiLyW9U+N9/Zr4EMvkSUk=;
        b=qprYF/s9zXbYvR4tJdw1/xvnP3baxMFHXBavYQMnHuyAQnVm0mbDqwcELfpOkRBIC1
         NKczTF/8SA8O9BfLxczDwSXpWNVxRiTjcS2GSAsq5pZe8U/AfupglQUUMLMZFhjby4Dn
         B2rjDD9LcnY6isgh4EjZ699GPnhPl9hHv/TGyiP985OZgmc9XqVi+u1JADMzaUhtsO/Z
         xg/HTIHj4czwAQ0M4F/SwR2Krvb13vfF9C/b1j5KRF4IOBGCaA889r8RWMHV/Z7EMK92
         cDiR05rXZwdCgC83LXSuz5EKxj92RF3a+Gc/hUDQ6AbNqjcLdtCuSllW3kY4Y3X0Z60C
         rzLg==
X-Gm-Message-State: APjAAAXTSDGXN/P/k8yBMOQVFlV/T0ca6Oes3iTGvVbq+fe2zNqIlOmb
        6wqwqchPzWwnMasbucVHKlKNCA==
X-Google-Smtp-Source: APXvYqyXMbE7hIPu7gGzBELNcJU5d33w7JUY3hg9O/6/OZSBXUT5paEEZCaM9P+hDTk4OfyZIjpVXA==
X-Received: by 2002:a37:8345:: with SMTP id f66mr10831132qkd.154.1552572975340;
        Thu, 14 Mar 2019 07:16:15 -0700 (PDT)
Received: from [172.16.152.72] ([50.238.205.70])
        by smtp.gmail.com with ESMTPSA id b5sm5333451qkf.69.2019.03.14.07.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:16:14 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FE25456B-A63E-4601-960D-96F519250B8C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B9CC8382-AEDB-478E-8C52-3DA0748DFD4D";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read
 due to multipage bvecs
Date:   Thu, 14 Mar 2019 07:16:12 -0700
In-Reply-To: <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
Cc:     Hans Holmberg <hans@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314111637.20236-1-hans@owltronix.com>
 <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_B9CC8382-AEDB-478E-8C52-3DA0748DFD4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 06.49, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> While reading this patch, idea came to my mind - maybe it would be =
simply better to get rid of partial read handling from pblk in current =
form at all and use bio_split() & bio_chain() combination instead?
>=20
> This would definitely reduce a number of this 'kind of complicated' =
code inside pblk and let block layer help us with that. Even that the =
performance of such a requests could be a little worse (few smaller IOs =
instead of single vector IO), I believe that partial read is more a =
corner case, then a typical use case, so maybe this would be a path to =
go.
>=20
> Let me know what you think about such an approach - I can make a patch =
with that if you want.

I agree with Igor.

As I mentioned offline, we should fix this in a way that survives
further changes in struct bio; either making pblk handling visible to
the outside or rethinking the whole thing.

Igor: If you can send a patch you mention, it would be great. I have
been trying the helper approach for some time, but it is too specific,
as fixing holes in the bvec breaks the bio advance-only semantics. Your
approach seems much better.

Thanks,
Javier

--Apple-Mail=_B9CC8382-AEDB-478E-8C52-3DA0748DFD4D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyKYiwACgkQPEYBfS0l
eOAJsQ/+P6PVANXWaGOaAJxzxM0mI8di+DjBN5QmM+PNKhN5fQlB7D7MCvlxO+zP
/30aASUuoFVE9uqCc3rxMfwghknAWeaXsTh4lO9NB21QqE3EDIwjONx57OwFJ4RB
XCJcPJfXGYZVLEnE1vTroXsIrvY+4W+w2zh400kuphP4J8s6JrPVb89Xfptu67lm
6fmwUxrtlqqw+sTUsU16UBP7OVsJUV7t8Ykj4BqmUGJSIo5nJ0GqOVuiUzikPbDj
9gp9QRqjyWDUFnuIOq6C8LnLiLekUvK0UHj1+Xt9uo71ITCTMKUu/9/AgvL+l+oa
RIv3DpmQLHGh7in6gMibrvHqaWOyDG830HiBbghBdEI/XCyEGJRjM+mA6U8ZCzDE
Hxpb9eICb+v5WxrGNBzhf+Te/pRvfmBbXhF9kZEFLUbR6M3kh/0Reb/ZAs45kHY2
xbMCc2ZYNpmLG3yAqfhQ4Gr5+vvtAdWW+OtaKjgNCmj30UHvOtOU833Yng5BlpNV
48sGfFllWso2Y99Bk1pSOf+2u9aicuowGVYhGUdkNN+xZ25VqZKLCTqr0FERoH+W
N+cz58eln7Q2kw8XRxzWfIt6VJ8eiSgtuSQ31JyPHWSRwcD+CCRShmGUqBhDD874
QtuTTh26q7Y2hFq7u1hpvSoizGKO3+xa+V9d+odca4OfkGJjUdA=
=6XRK
-----END PGP SIGNATURE-----

--Apple-Mail=_B9CC8382-AEDB-478E-8C52-3DA0748DFD4D--

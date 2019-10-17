Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD12FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvvXCKtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439110AbfJQI0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:26:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438938AbfJQI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:26:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so1142643pfn.11;
        Thu, 17 Oct 2019 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xb7qs12MemfKVWtSykgYZkO32TotNiSe8AbElBYtURY=;
        b=tvvXCKtpyNKDe2hsKEadS4wQBy88bOUVWID/PEDJjxydVxbn8lc/gw/1VmSwPvjLnD
         JNsyamF20conyCO9V0PkRfGdBoQ1nLt7i7YEvfr7xQAJLn2zCtsBtY5bttjNOGZFJ5d/
         1P40XadGaxb5zq1tnadLiAgCZ1E32B2Z+YlzbV8GTCP3Zn4vbsGLEtKXyMt+hVQObOCp
         SExNW6VXfIv5haZgQWh5xK1Tih2TjcM85u4iMHDIs/sqGx4fDIaZXfUKvQdcwnJvma+t
         SEASIkinGS51D7jyaYydZgxpt8RSlNtSbdC/xXnPlgVC6uqiSMb4ydlokr8pNK8udN+C
         dW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xb7qs12MemfKVWtSykgYZkO32TotNiSe8AbElBYtURY=;
        b=FHHmvI81CZ6+ihnel21LAKmJQptQDtNO4AgZKC8JQnRjmMYSzjAojBe0Wxa81vb4s8
         jMfnpNvwFZ+f2mGFMhvRiUkCSzjTptD9vPjT+hquESRGXmN1uH0RoPxlxPVJBG0hddTy
         anVktmakZU4sMajPtxxoH3+jhAa3P+Q0quEOGJIy0q8+EMOUF3jtcZDtqcD4vIlxR6I1
         xUM0af27qrekqu7BjqjPsRQgEa6C+KZFbXkudhrSo0WoaBUBVsdz4TBTJGpRmaBGOD8V
         ugLnikkhSxdKk1o/QiXG1f5OLYWKOeKPIVAuJy3gca8IpEKNvKFcMEYO+1BDqFPR7gvF
         /Rbw==
X-Gm-Message-State: APjAAAXY55EDdnv9zznFNsAtDeJFcIGxYR79fcwNRn8StP6n00eZJ9NR
        oTUKSz44BTsBw0BZ1mtJDts=
X-Google-Smtp-Source: APXvYqwfzKNIaADxeZzbyjxc4Rv0Xni12tW0pUklkueISnMwSTc29z/rvrIzvUc0FJHPIv+OhzlgZg==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr2891634pgt.25.1571300794153;
        Thu, 17 Oct 2019 01:26:34 -0700 (PDT)
Received: from Gentoo ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id f21sm991386pgh.85.2019.10.17.01.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 01:26:33 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:56:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: [RFC] scripts : mkmakefile : change name to create_makefile
Message-ID: <20191017082619.GA22508@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

It would be good, if we can change the name of the script to more
explicit name ,which also tell us the purpose of the script by just
looking at it.=20

The present name "mkmakefile" is perfectly alright for the people ,who
are technically inclined not so with other, who wants to understand.

This my understanding.

Present Script Name :  mkmakefile

Change Script name  : create_makefile

Please shed some light.

Thanks,
Bhaskar

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2oJagACgkQsjqdtxFL
KRVvaAgAhf9g5o+HCmnaDBDG2b0Z5drT1VO2BHh1DyVl9KwI2PpbMG9ToezruMF8
rHKhg249Xz9xTiCvXr337T5BsU39YJ8Wss33aZ0Ptk3BjbDK/kTabQjf1Giv3Akw
TorrQUMLQ/lLvLx43T4ASIAQaPJ/Bi9ZZQ27fWqVqIS+7OTODHWMko5YKMuRwRt1
tSiy59ontancJwdnEcy9+KK+W1yaSqZrgTPJLwjmM++ZJ55iWb6i/JHQVDCBaAEj
rVRhiRj2gicK/z3dm1eG034B4MS36a2dyVjb5bnZZcBYYM82fMN5/1n0LMYHV2Cf
F76YHImeUWu5RnA1GJ15rSv0fJNgxg==
=NzPR
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A877C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C32214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHAGI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:08:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39566 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725790AbfHAGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:08:55 -0400
Received: from mr4.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7168snb006231
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 02:08:54 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7168ns6027508
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 02:08:54 -0400
Received: by mail-qt1-f197.google.com with SMTP id y19so63773962qtm.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 23:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=6XW54QGy7hHRbK3i8IBYCrpdCQ6OjXGnD1ZDLzSjmR8=;
        b=sm9oInBlXmfxLCwgUWXekJhDr1T550cXd6TjsePf6s3o/FuQJd13d74prOZEJNr0lq
         5gR59URGx9cTXYTY4tqOfT36yXUN98eQzdiZsYj7seEDb+MrOso1uFGAXMZNvJfd96dA
         yJhiAaUa+iXHrOVWjEejkMiEt6myEh9ESi7fCdgs/vlu1hqJmfWKov6JC0UsTvQ1e5+e
         1xluMU9MlFT/qXjgypxyiAppzc/7NEHv+e5XKXUoTgviOxgiJ14FSLyYmAvC2tNfU/jn
         0LjeaEsz7HdrXvCjKpCRqgh7gB0e/XW63PbiV0Rvv8L/X6boxj23XpfwoQ5GwGcLNUYO
         Cujg==
X-Gm-Message-State: APjAAAXfy1ROXCAkusL6I4U4stTHfM8rHwbMzbnwAnJqet74a6W/YQNm
        ggUlSP2yUhHmxguoGTfauIeVS8Bib87WppgoUYoTDHYSH1jLaTk4Qqq5Kok++Hb9MUS45Zxp12e
        6R7etnD9hN0rJQaE2O1Hx8j/Aj3iR/keekHY=
X-Received: by 2002:ac8:6702:: with SMTP id e2mr69131726qtp.317.1564639729401;
        Wed, 31 Jul 2019 23:08:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy674LHytXkZ7tAgkcnbVM3SObNLoijWBzBMhluJZCsf92j6uvXGYGfGoUJUazPqASR/uaFGg==
X-Received: by 2002:ac8:6702:: with SMTP id e2mr69131716qtp.317.1564639729137;
        Wed, 31 Jul 2019 23:08:49 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id y3sm33499963qtj.46.2019.07.31.23.08.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 23:08:48 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-next 20190731 - aegis128-core.c fails to build
In-Reply-To: <CAKv+Gu_zEO75s6o8bv4TXPxibSH-dCe-V46AYjL-dOEAvpQaqw@mail.gmail.com>
References: <13353.1564635114@turing-police> <CAKv+Gu8EF3R05hLWHh7mgbgkUyzBwELctdVvSFMq+6Crw6Tf4A@mail.gmail.com> <32521.1564638419@turing-police>
 <CAKv+Gu_zEO75s6o8bv4TXPxibSH-dCe-V46AYjL-dOEAvpQaqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1564639726_11794P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Aug 2019 02:08:46 -0400
Message-ID: <1166.1564639726@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1564639726_11794P
Content-Type: text/plain; charset=us-ascii

On Thu, 01 Aug 2019 09:04:11 +0300, Ard Biesheuvel said:

> The fact that crypto_aegis128_have_simd() does get optimized away, but
> crypto_aegis128_update_simd() doesn't (which is only called directly
> and not via a function pointer like the other two routines) makes me
> suspicious that this is some pathology in the compiler. Is this a
> distro build of gcc? Also, which architecture are you compiling for?

It's the Fedora Rawhide build on x86_64.

 [/usr/src/linux-next] gcc --version
gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2)
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.



--==_Exmh_1564639726_11794P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUKB7QdmEQWDXROgAQL/ZA//X++jPWkUpqtEgh/dzI2CPmiFsFnU9Dun
E8xmWFASKSXkidLYOdy78ZDhGvGHrvvXx7n4k3JFYMrH1hAGNIWarHs84lgYy5rr
TCUzN1wizKBhsSKZqUAQWSohgaY3HXmSq+u9nWMJMwkE6JgpJH1Ci4mMETdO/19u
IP26wzsg2CUXBToq9nFPrOtz5jfRkFET5+OKU/h670koYRYqY6OT3O8GhE9ZA2In
6cFqPx0XZ823XmHULYel9YLZYXJXVm/N3Kuyq0C9C6CLhR29BL8cG6X3Y3L+3pXh
hfZKXwXt6jquXAiT4yMz++6RmjS1CDWb1sQceD/fALgZQLbTHbxJNAGs3AatdEfI
X5lUcSDeSIFj3wHxsWLj9MA/XBgZErq4b5gihdbA4mH55ChHDol6hdbhfr2EeebZ
bl4X5TtcKSZxz/AdhLard/QoENY5wWYuDQpAdSDHTRlWEKnQEImN9532eSmAgJoe
pYuClanuUZ832xJa7XnaqbIQD8JM2xJSyfQf4XjURjWwUj62DrbxXu8tHG1SpA6u
xObyh6B6JeHl8QHk+A3ftiunDYNfT73Btcq3RaONCV9Wb6231Bk+Y7HpTgqtqTxV
Miz1yZIN68PstLQw9a3YcT3V5IHfHjTmrOVM8Kj5RHF5aXYLjV0CeJRBwHOrqSUA
ajBfu1UxhHg=
=OPAo
-----END PGP SIGNATURE-----

--==_Exmh_1564639726_11794P--

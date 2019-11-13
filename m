Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6588C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A95206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfKMSsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:48:30 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56580 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727241AbfKMSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:48:30 -0500
Received: from mr5.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xADImSbB022433
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:48:28 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xADImNI1001934
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:48:28 -0500
Received: by mail-qt1-f197.google.com with SMTP id e2so2074478qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Fo4fEZjebs1UemMYCiGaOExD0sFqQ4EojFlLMcKIhuc=;
        b=kpUPiPjYmvCzWlEEGlELokjBhW6l66KJLyR/xS7NMwpRNBkXbuYai0zT3h4WhEVSkn
         ebT72TDHOe502KkZWPualnU/eZ2LSrm+RlVURUIVVHIr/Dx7hcVY5p+hFa95qeyUmB8S
         FEc2eUEPKMv9EgS767HhFAVGUFqwGYgfV01+HTFqu3g+5YCbbb97GaRP2bejvpMyPFv+
         MBcCeHZAa4onwMe9jOotVqjGpiL9K5EXsQvenqYxshfUmXyf2050LtnFcTzuHeTVOtPz
         VoeyDzQ1MzZNAmw7RqkalEec5d++rENBvYUiau6t1n1Cvq9B/UyFcKrfBuTzrZ+FlvHV
         0ssA==
X-Gm-Message-State: APjAAAXQZzxfKMb16/7Y+T8aZLkTdhBa2SWP7npRdN3K4/Sc0hyZ/KdY
        Z9nepOimeTmn/DoONG/xGKXWa5IEFQcecIfY8TAE+PpfRb7g0PwZUyDuT8/ej0WQ7J1rEcHHUsH
        shzJ/Howj3MBmu94d7RY2qsbgDAfQDPxHS+I=
X-Received: by 2002:a37:c40a:: with SMTP id d10mr3876429qki.126.1573670903314;
        Wed, 13 Nov 2019 10:48:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZyh3b02hf6ZQ5jDLWJPKaioEx6Et1AVdxUCjjrElpChyEZAr5poVO19WsI1sCXDYpXO7E8w==
X-Received: by 2002:a37:c40a:: with SMTP id d10mr3876412qki.126.1573670902961;
        Wed, 13 Nov 2019 10:48:22 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x39sm1788053qth.92.2019.11.13.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:48:21 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        linkinjeon@gmail.com
Subject: Re: [PATCH 00/13] add the latest exfat driver
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com>
 <20191113081800.7672-1-namjae.jeon@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1573670900_10801P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 13:48:20 -0500
Message-ID: <286809.1573670900@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1573670900_10801P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Nov 2019 03:17:47 -0500, Namjae Jeon said:
> This adds the latest Samsung exfat driver to fs/exfat. This is an
> implementation of the Microsoft exFAT specification. Previous versions
> of this shipped with millions of Android phones, an a random previous
> snaphot has been merged in drivers/staging/.
>
> Compared to the sdfat driver shipped on the phones the following changes
> have been made:
>
>  - the support for vfat has been removed as that is already supported
>    by fs/fat
>  - driver has been renamed to exfat
>  - the code has been refactored and clean up to fully integrate into
>    the upstream Linux version and follow the Linux coding style
>  - metadata operations like create, lookup and readdir have been further
>    optimized
>  - various major and minor bugs have been fixed
>
> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.

For the record, I'm totally OK with this and glad to see more up-to-date code
than the codebase I was working from.

--==_Exmh_1573670900_10801P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcxP8wdmEQWDXROgAQIzfRAArTNRIzzMJEFimFdo3I3pwBAyCZYffO3D
1gyYXolrSmLn/8QhOzrtDQKIM/ZMTIps1PGNQlH3WeLDxvlojnq0QXb0mu1QHdbW
WQDF0hnAZKOzRNVdkafXlflXrFZN8gB+/YKRYn20xOjOVh4TQdVutKT6PvKvQPnf
Uskad/slaxp70rpnqswpi+qr6ukKtU6TEfE5mW+OKhZ/PsH76DK9ihUfC3AsGK3V
T1v2JYkxElw4WX75j7wNocz9opuDGJn273MkmrtWhI2egn3/kMASgAwZmUOLmueG
WkHKYYNHmyY78f+IcYj1IffC4Db/8nmmue/4OSUaEGq9qXL1AVbZ4T39rqv9qtaD
3c3BF6XLMctNTzMXNe6QIa+0UyMhEGv2fksmI5H0JL98YMcyKuzc7TcRadNzwCQu
7o/5NwwGyf6d30VxrzPPx9b1bOlFOh+28m28r56nFxvgV+mQyLf7PG7Enpmbz85l
tkH/KbzrjbQ4JAmItrY0bCkDKaiFgcDBnW/Ao7QEgSPtrVTCpXuCzyXwQqtO2VVY
Uw1FZn7j0FWrpdTynKCTm5DQX9g/PyS1uMAawoSK7chVNsk3+H/e4s4hiIT9vFb7
Oapyot3eKZcYXhRH5tcj5DzAx3iA0vmNpjHhBmzcHpMqBxcWN5hJ/MpaOwvaFq8e
FB2ihtmGWwY=
=1doZ
-----END PGP SIGNATURE-----

--==_Exmh_1573670900_10801P--

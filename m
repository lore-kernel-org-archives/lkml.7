Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBBC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEDC20815
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myp3LkR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfI1PNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 11:13:14 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45878 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfI1PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 11:13:14 -0400
Received: by mail-pg1-f182.google.com with SMTP id q7so4963395pgi.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GJdOVhyq6aPaO1EK9mtpMY/G3UU14+UyR8ujiMBQ3Ok=;
        b=Myp3LkR8l9Ri68CMSakTatVeWVaIpE30x0lilnFRyPD4eTiVXC1ap6tcJ3ErvoKHxn
         h1x0UcAc06Z4OUt8LCbZUeqCsDqIkAcPfdx7DjEkbZskEcaNiUm1BjNqLLlQ4dLBN7ow
         uOvAINHjEMWBcecivdPg00xtL+AgVUb4JoPE1augupmFj10BJoQCRONZi/pO02GLwA4d
         l/FjtXOCep3fVBn2yNKc5rTGGTXym/bV8Wm6zXS8vdqoc0dfMl9EfdldfgjIhhUhjRMP
         1r+E6rQ0AXaGYl18vFi/PjuyxGLeR/kmpm5PtxF+AwHMjJHk6/iDWjCSnpXheCE0T02r
         5ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GJdOVhyq6aPaO1EK9mtpMY/G3UU14+UyR8ujiMBQ3Ok=;
        b=YYFjoHEohKENYBDdq983pNCtk1oIfAzK2az+kGPm9swi73KGKIq/MKE+AihAQv3n3s
         CFBE5hnUDNW8bmc4BWknQu21NFsXsVtrg0jqq0/iKyIF3l1c1r4DVsD29nsKcxgwtpu0
         1nX61J3DyXB4tvXpxz6EtIkgprCeFN5smH5St62/1SR7is8QSigFhRnZ2V2fgmZEof+g
         g/MyIEx8ju1wDbsXn2kzlaWN5Q1ZoJRVfqrmkoFKKu6zeFTM6fKIxMgIf/fzR4O8GV0S
         uKiczm48Sw3OGxq7w81+yAX6plJRygdKz8gFRp6YfEWsGO6irLJ9v18032TbPp6+S8de
         adaA==
X-Gm-Message-State: APjAAAUZiBH1YFeYgLRjqmfwP7T1ZbN6QfPFtIHWVJOrXvaIm7mkvble
        eNHL8Sj++Yp0Hr2VKLxgYKpo5d3o
X-Google-Smtp-Source: APXvYqwivoHZJ6MLG5yv1aQOiAwMrnccnd/481Dd3Gjt8jQnq108aWZVMuRxaRpPleQczJf9jd03Qg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr15147350pgr.367.1569683593197;
        Sat, 28 Sep 2019 08:13:13 -0700 (PDT)
Received: from debian ([103.231.91.34])
        by smtp.gmail.com with ESMTPSA id y28sm7456684pfq.48.2019.09.28.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 08:13:12 -0700 (PDT)
Date:   Sat, 28 Sep 2019 20:43:03 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] remove dead mutt url and add active mutt url
Message-ID: <20190928151300.GA18122@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 4e4327891fe2a2a4db342985bff4d4c48703c707:

  replace dead mutt url with active one. (2019-09-28 20:11:00 +0530)

  are available in the Git repository at:

    https://github.com/unixbhaskar/linux.git=20
    gpg: Signature made Sat 28 Sep 2019 08:11:25 PM IST
    gpg:                using RSA key
    9F017E9D66B07216543CEBB0B23A9DB7114B2915
    gpg: Good signature from "Bhaskar Chowdhury
    (Musing_with_GNU/Linux!!) <unixbhaskar@gmail.com>" [ultimate]
    gpg:                 aka "[jpeg image of size 2135]" [ultimate]

    for you to fetch changes up to
    4e4327891fe2a2a4db342985bff4d4c48703c707:

      replace dead mutt url with active one. (2019-09-28 20:11:00 +0530)


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2PeHcACgkQsjqdtxFL
KRXypAgAw8a4wvWxo3mUe9oQ47VZhY39flqwpGbdNj3Mt9vwMGI/epynLs86XJXG
pTPnXCJ9coNqknz8DKxf7etpjS8QbX+bRei33eyeInqD4vfroxlsm+5ys4Px+D9Q
vUI2hD5vip6EuvS9Q2iUxcTmSLSIii2Y0jABee/LmIICBDuXhWX1ycrDqwfzEIHm
R1l+CCUe9hf+ol4PhcbOzQZKmc4Hg08Nv/mEF8jHnXu5UyCxfohW+cNv+SrHsWMj
5MrNug44UkNEUh5Hyy2j3Tj1ZUPNDxQKbKpILuyecgoIIeu7Kq1G7X+4d4kfWD0F
BX72//UrOk9NquBYOlRvEHjCowFG1A==
=6Td2
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

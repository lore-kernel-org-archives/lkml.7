Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuEQjlCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfCFCSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:18:35 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36418 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCFCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:18:34 -0500
Received: by mail-qk1-f177.google.com with SMTP id c2so5966962qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 18:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DDNSngyH4+FRgQiTypvGozbdXR5oCG6bzGozgsdqm4M=;
        b=SuEQjlCeXLsH9l7McnzUNZsaYCc0b1Chv2DIaVxIl6Jl/1ZrwfA/7KX2TwyvcR+QuW
         XdHAZum/pDhFcjCJ+GpoeC1FuCxo9Tx695bMRsDPG2J8Y/aYZVLnKX/iv5H4GBHxVLxK
         8cy7uxvcQkQDtyARrvM/JU+yq0vXcNZZa5R7gVDQypLNUlV0OCQEmgyi9DMxmOorzTnR
         VetzHfBdU3Rj3pAqatlg1XWGz8wRgaFUyP6EhqHnf1i1V83VL7Hw7ESJ2XCUlujsGnbY
         MWM5IfXw3qaKsRVvVmZLawkatxyKaljhs5pgxLuujdWg7bJghGedYpn01YSvGPkFSVYN
         j3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=DDNSngyH4+FRgQiTypvGozbdXR5oCG6bzGozgsdqm4M=;
        b=MUQlqc1y9grCFF0Oirsdog0mH2CPbCkPATaG1dVXLQwPfk/Dt8UASGH1q3wjJ8wMMK
         k9n23EEkMflp3UHaF87DTfDLWu4thbFLzEkOUV6csvTFGqLzkvj75BLowW7ZMz+2CpQQ
         tTTtsHjPIjs19QVxIxRRCJVO2RAzQEpFmbg3c8U404XyRjRRnAVO7P6RKM3l0wFoWVin
         VHVMpxcOabD5KAk6vKeU0n+NKsQR6D9Y/JxtdWGOfgpDwRGdEGuTsKimhKgHOs1dallc
         24LGFt+UQubEuSnHudRpd+6MF34/mhodWN3ae0K9AwPXY35YKY4bmIZaCqccZfOi3yOw
         jO+A==
X-Gm-Message-State: APjAAAU4PSPL3tX1AOqSMBwqy/b/U2ygotVolnIhU7YT3zDLpKMP3ZZX
        bnYq0vvQv4bWifwjFgbCMew=
X-Google-Smtp-Source: APXvYqydQpVkqcL8RZIleaWnBqVl0rizFXVPx/y6Y4DMEmTm749q5SrNukwBSGXZADENWI7MIYlgtg==
X-Received: by 2002:a05:620a:1665:: with SMTP id d5mr3959484qko.94.1551838713139;
        Tue, 05 Mar 2019 18:18:33 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id m88sm160817qte.68.2019.03.05.18.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 18:18:32 -0800 (PST)
Date:   Tue, 5 Mar 2019 21:18:30 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (ibft) stable/for-linus-5.1
Message-ID: <20190306021830.GB25368@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please git pull

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.1

which has two tiny fixes - a missing break, and upgrading the subsystem to use modern
macros.

Thank you!

 drivers/firmware/iscsi_ibft.c      | 1 +
 drivers/firmware/iscsi_ibft_find.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Christoph Hellwig (1):
      iscsi_ibft: use virt_to_phys instead of isa_virt_to_bus

Gustavo A. R. Silva (1):
      iscsi_ibft: Fix missing break in switch statement


--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfy32AAoJEFKlDoTx2wm/+IYP/3E5ssx/s6SKAAe7wDxsqcgD
Ta92MA8ddczzYVkCcxQbvCf2YhbRfrGlMt05sI/8yDrH4ZG7FjBz/HXkD4UqbB4O
5pugeEC43Q9hfUOVvHiINeWUhGsuABJjPqJd9MpxT9KFCTV2UNTgihPvGMNGhiI2
v0NPUhW0B9t1GaRBnUhYHy+Bg6psZThmHsab4RPkYx3/TXTZcjjUawP7CQoW73x0
icDZb1D4UFtfJQEHdDhsvVR4p3727ZSEqGrAgJ1xMaciCxi2m8670+tezukxgC2V
eITpFzUfplRu6yWDqoIIaleosSBMSEojxuNhEztBRypJkah4/ggx4mMg8f2BAi4y
SAlrbgb4R079ffNfcNB4zfgLBbDVO20bTDkutDZ/9qkiBRYig1mfKAGVp3t/0k0I
Z35qhFUqbTHEu3+SOU4yA+fyKzj4zqOk41ZUco2DIuZLLHutyse5vedwj1ovOyPp
jVhNJ3a8QwS9H0NctBUzBJR9cie5XrisxE1d563CsV3GRgU+VFwRC0yK325Y63gT
NSdS/RyeBF4xyYay9rfjL603GsYu5rwtVg/ADTthe5nIUb2ow9AEt552QLtL5Ous
Aga6RR3LPY9uHJbIQSdGskrf9HjGfpJKbAt7qm6yY84FRP1ebteagGefiNfWQS1l
MSYKrTpOyCfwM+Vq2+9a
=x0tD
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEFCC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65360208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwyt0Gi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFQWrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:47:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfFQWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:47:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so6570293pgl.2;
        Mon, 17 Jun 2019 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x92Aza9jCNmVRM2Nosfan3LRA81lLexSKzqeyp5AkVQ=;
        b=Jwyt0Gi7i6IZYUPNpCDeG5Y8Vz/iiqg+OrOKJgn84ED80FJv4jiYiC6PNdaneUZAp1
         O8HIJkRgqeMHF1JAH8XUA+kI2zXS431TlJ1aDYyUZg6s5URU2ESuIwX3nbKuzZtCpzID
         VK+2CBYKZJjmIPoefjiBtzuv+QP4mA8lwE/5g+Hnd+vWIo2FPrcGFG2N49NDdqIAxa1W
         pPo59yNC1g7de5H2h6kryK1eEAnKWmIOCXZga3NVjUt81fyzX8Np8Aw/yAqA1v0k+6gT
         i/RM7PljXeJjr65PIMsnsjr2CW8INXgAluttGU9KEI8x9JY+K/SHjhnovwVL8eHqZBG0
         0cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x92Aza9jCNmVRM2Nosfan3LRA81lLexSKzqeyp5AkVQ=;
        b=dMbLzkrzNH7O0zbrkd7Kuep7/Kkb4/SLOVBV5zjUJi8DF+U3r0kQVkSqVqYThN2sDn
         9MfAVIaFlzIpDYarkMAE4dv3cyr7xb3L/fkZC/USULze9zaM54/cs5Ti2/gh0wZH3e0d
         5WUP99EmpsDN8k0hQgn25QbzQ/zuqfDqvi/gecXks4wCTLk+boJmGFhYI9uNADLrbnPe
         FQ5HOpzzvEisIFBnXleetTy4UlhV5QUR2tsabCrpUvS4p8in6oSYJEvyYDY9saI8rzYw
         IxKSyahf3X1FCuxDBDjBdEj4l6Rm+r0bYEVOPck/6PdHZplLrGyDuE4w1V5pcCgc+qES
         Q7+w==
X-Gm-Message-State: APjAAAUyIPKQ+lIV7PT51TjJIM/mgZXGNiPHIpZMp60KfEgV6QfOWf66
        /Bwqzaq8p8S//GmRI2/rkPI=
X-Google-Smtp-Source: APXvYqxHtAfylvCP56eWkQvDkttRjJFDRaouEYspgpRiV0+q0SkHxXkcTDaTC2c4DT+tnngNj2/OEQ==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr91086764pfb.210.1560811640999;
        Mon, 17 Jun 2019 15:47:20 -0700 (PDT)
Received: from ArchLinux ([103.231.91.66])
        by smtp.gmail.com with ESMTPSA id p2sm17663408pfb.118.2019.06.17.15.47.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:47:19 -0700 (PDT)
Date:   Tue, 18 Jun 2019 04:17:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.1.11
Message-ID: <20190617224707.GA30899@ArchLinux>
References: <20190617180944.GA16975@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20190617180944.GA16975@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline



Thanks, a bunch Greg!

On 20:09 Mon 17 Jun , Greg KH wrote:
>I'm announcing the release of the 5.1.11 kernel.
>
>All users of the 5.1 kernel series must upgrade.
>
>The updated 5.1.y git tree can be found at:
>	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.1.y
>and can be browsed at the normal kernel.org git web browser:
>	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>
>thanks,
>
>greg k-h
>
>------------
>
> Documentation/networking/ip-sysctl.txt |    8 ++++++++
> Makefile                               |    2 +-
> include/linux/tcp.h                    |    4 ++++
> include/net/netns/ipv4.h               |    1 +
> include/net/tcp.h                      |    2 ++
> include/uapi/linux/snmp.h              |    1 +
> net/ipv4/proc.c                        |    1 +
> net/ipv4/sysctl_net_ipv4.c             |   11 +++++++++++
> net/ipv4/tcp.c                         |    1 +
> net/ipv4/tcp_input.c                   |   26 ++++++++++++++++++++------
> net/ipv4/tcp_ipv4.c                    |    1 +
> net/ipv4/tcp_output.c                  |   10 +++++++---
> net/ipv4/tcp_timer.c                   |    1 +
> 13 files changed, 59 insertions(+), 10 deletions(-)
>
>Eric Dumazet (4):
>      tcp: limit payload size of sacked skbs
>      tcp: tcp_fragment() should apply sane memory limits
>      tcp: add tcp_min_snd_mss sysctl
>      tcp: enforce tcp_min_snd_mss in tcp_mtu_probing()
>
>Greg Kroah-Hartman (1):
>      Linux 5.1.11
>



--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl0IGGYACgkQsjqdtxFL
KRWjVwf9FxyxD1R5TDrakjqnps5/1HB7ZZDWENzK5f69icEXHbPejEpipJXw/85k
CYeVXZxhc9T5WdxmSheFNsJ85LLSR7n3/FxF6Ga70Rh4ShDONoe9eJIX5Dnrdfka
2PsUAuIjqCPflUnm9bEskHSmXDezl1a+ojgjTimD0dq4Z8zv2RH3VkZcg/JgMKNy
0+ji/r9gQ/wVRhLNmwW/mYEMopC8K8bhaGbirVd4t5fMw8EgogsUzCfsYAzNEOlZ
CYmx8isnxNVhH3LIxaqLtDuNmuJ/AbiphbhFe4DeIACklM1s0VlNxsQXf/xFjJ4Q
I5xhRwDh9vPd4G5Ped1seX9CBCCj9Q==
=ynAQ
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

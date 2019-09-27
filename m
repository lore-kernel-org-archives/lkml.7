Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C50C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3320872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEZ1bC2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfI0DdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:33:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44189 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfI0DdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:33:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so696819pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sEqAKwH6i8dRuUDjuZdQGDMRFaWtJ7z76eqdeUKMFR4=;
        b=vEZ1bC2gUnz6NoBfMDyxU9mxqyIb/A9GLsNodsnP6M2YVFdpkn/RgyXY/wut1e5Z+/
         XvN0N7yXbIpFp8O478hZYTRFeOiuc/x+vk5ziQ7S8i4IKZa7uFJ4weGgJxfggn47bX7t
         Cf+fkI9awLbvzBVGm1dNhlblm2J1Ffv8z/IvH6/hhWCFBZwk0VPGex6nYKnAcxK6TC8J
         Lj1k7VxqydDx9ZpFCCOX4LJjuG4WQ3WxzinI3Cz+VnWTojik/Cx9uD1faOZK1QiDw6hc
         7K5LdttHfaWvXbmoDi0MqFoQz4mZOoG7LsS6bUbvIiIct2exSC4W4neFLz+X+8nSEZdD
         6Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sEqAKwH6i8dRuUDjuZdQGDMRFaWtJ7z76eqdeUKMFR4=;
        b=i3+x+wiCrOb3aKAJYPWfajThOwgWuICuRGr5W11va4h6hyzIlR1kLgDAdrff+RYmE4
         nDIQAKM0q8cK7U83DUNUFALnfC2TScCFSsimq+qIXf9H3c+xNrF3eIsCDHy+iCRVS3l3
         3lHeefEpheijbFlgADFAEx+aJ40/xRjxQUwJN57/CPLOQemAO7Hxi1IV5ZD8FnkLJygy
         Bcq82OkDtYHgIpKeAewJlon2quqYZbJPdZCILdbUnUkfmm3wx1fkBlZdWrMYESq2XsE1
         ZbRQvcj/ygbNlNryHuySxj6whxVeJ8lh+x/N/mMhZ1PAehp89MuJRckBRi2HEuy6yzV+
         6cpQ==
X-Gm-Message-State: APjAAAVXXmrDEkqlN3u8y+egzTwSJP7tdfalyiJ+ach5TEX8PghsQnXt
        P7WqoeMp+s63DdGn483iGP6fsRr5jOc=
X-Google-Smtp-Source: APXvYqy0Qv0EyDA0NnBHthk4VEz7/BQ/G3vIfATAo52ucWn6ZvMJj8NWR56RcXl52UdCm2gSHOs7EQ==
X-Received: by 2002:a17:90a:e008:: with SMTP id u8mr7532910pjy.46.1569555203984;
        Thu, 26 Sep 2019 20:33:23 -0700 (PDT)
Received: from Gentoo ([103.231.91.66])
        by smtp.gmail.com with ESMTPSA id z12sm732004pfj.41.2019.09.26.20.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 20:33:23 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:03:10 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Please reap out these dead link from the kernel doc
Message-ID: <20190927033307.GA4536@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 I am not sure who is handling this ...stumble over it ...please do the
 needful

 Here is url for your reference :

https://www.kernel.org/doc/html/latest/process/email-clients.html

 There are two external urls for mutt config , which are dead ...those are
 :


     http://dev.mutt.org/trac/wiki/UseCases/Gmail

         http://dev.mutt.org/doc/manual.html

Is this because Mutt move from trac to gitlab ...here :
https://gitlab.com/muttmua/mutt

Wildly guessing.=20

Probably Jon or Kai ...I don't know ..sorry about taking names.

Thanks,
Bhaskar

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2Ngu8ACgkQsjqdtxFL
KRU2EwgAo8AVbcXsOkFZAM8KXToMIbbpjLp8355xnQd+tSFCjwayeJ1tu16dVR+L
qZLTEJQvHNHZfkuRE6W/k0gi/fagvRSRllfI3XJzNk1xgWaLbZXU7OEM/oxZhM86
/noSgD8OQM3xb/I1I1/jMtYlWTJs5e8kCeUADimb10QOS3zSZDxqrFpHrrgyEJuQ
xlnj4CuKpBks4IO2t/y+c2Z63dJzoj4h/otn1RnIZDaT9lF28dgRLDVycpZhgN+U
DEn6H6X1KAkFeNYY2vDjbKJoXq15YYmkQHajCx4zjjVvDwkJxvGZ2rFnESSa3j/R
wN7vx47VyMc3X+aHNrnlBM3etpJaLw==
=IG75
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

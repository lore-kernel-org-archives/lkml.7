Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A98C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E96B20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvK0hWZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfI0Fk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:40:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46737 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0Fk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:40:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so2797085pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 22:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p8cR8eEF3Y4QlAt8jsJH2qGMUaR9/l1QUIf3Un6cMS8=;
        b=XvK0hWZC4OfrMNAdsjjrTLRXQ25QaPuVppAb3XpOfnT2GEZ2xZ/dt96Zn0kVyORFys
         dcof7HVxVQgcPP0a/JiOHc8hAWR5TJJxPgwBBd67/7VaalaQ/Jz0KNJU8jE9F9LXjOyu
         dHJvTEXTj+Ug15TBHWKcBcjCyN/pmaG4P00at4WWmoPR4D4AXWYQWO4w+cnrLBNXW8rU
         F9nYjjlhsigiJpKCGT2HEvLS5RSf1INh20xUC91nMFgfmBVK2vCiB7LmoFjyIZiON91x
         Hs+S6jjuz6JY6zQz/WdThSvk8OjfpCmjNU0821XHD/J5o+65qwmMBhP6kHFtIs0o5btx
         l3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p8cR8eEF3Y4QlAt8jsJH2qGMUaR9/l1QUIf3Un6cMS8=;
        b=hdboo/vtFsOAua6n1rygtcfhjA7c+irR/Y7W64XzYydOvuLAS6vqpHyZFBQEO1bsJG
         L38wCELE/VzJs6h+ce2pcqYjCW64hfpqquDueSrZnwVDAKk5BrtZelWdESJ8r/LAjIQB
         bNUOyTPh7A2SMGLOiHfFPyWXkuv0UcypWf5ptYdOghA7gV66kqQkPsBljyQAw17G1xyS
         SqG69bGN5k2Mcpg9PEYN1tJPyhzLqFEOVQ+2fIVeLz88VPMsDEdWWFWiaYGazAyTvfCs
         WDcoS0ap+NP1CqJQmezaWoNpdcWfieRKLgo4BcFw2y08BgCT4Ycr+gc4fJ4o0jHzOHe/
         aZQw==
X-Gm-Message-State: APjAAAXfQJo7BcFe/Jt5qZWpHp4hcwCYeWOyXSGw9xGMXbI6QtmMDmdM
        H+7nJaq6MxPtIyCucbAZpEYwZ/ytqBg=
X-Google-Smtp-Source: APXvYqwtX5fZWTc2tj6L4CdpHyIYewDQhRI9xUR5raz5N06YslytNk5u2dnsM5d4egwF540ipzv3vQ==
X-Received: by 2002:a17:90a:30e8:: with SMTP id h95mr7943032pjb.44.1569562826774;
        Thu, 26 Sep 2019 22:40:26 -0700 (PDT)
Received: from Gentoo ([103.231.91.66])
        by smtp.gmail.com with ESMTPSA id g7sm729866pfm.176.2019.09.26.22.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 22:40:25 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:10:13 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] reap out the dead mutt config links
Message-ID: <20190927054004.GA17257@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/email-clients.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/proces=
s/email-clients.rst
index 5273d06c8ff6..1f920d445a8b 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
=20
-The Mutt docs have lots more information:
-
-    http://dev.mutt.org/trac/wiki/UseCases/Gmail
-
-    http://dev.mutt.org/doc/manual.html
=20
--=20


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2NoLEACgkQsjqdtxFL
KRXKuwgAq200mPQjpITuJok/3paqATMd01UtmOmcvHSQgkkdXMKQXUzigSoNtAgH
1kCBv9kDZzpqH5DYYRp9/PGsOp90+tzxQB47LgAdS6YcvOzPH8AYbwSOFjByI+8o
kQvCFPRkMa44vAVgkOzUSa0l9kbkRSi4Vvvk4vvW2G8v+1vYt8Vw5NPAfYKb0NX2
IpQzrOeftWGNFXa+2os+F0/cf14m0EANinPN/iH++DNJXJTczQfKdrjtP/nwRfmW
+aSkfIzlUUsxMDsXobB+OQH5Tlgdqe1HfWTMMvX7rXHASw6mxc7r1SNBes0wCSty
7jJodWH8vYw/6j+0g3QrDlreAdlPTQ==
=S8Ww
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

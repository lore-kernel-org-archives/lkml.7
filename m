Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E23C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2624217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5pKS48J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfI0Oo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:44:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46144 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfI0OoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:44:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so1178387plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TUjdrIXMNe8uNjDuFL/hI5mDTUlQM39+j47CXaMJo8w=;
        b=f5pKS48J2COaawff7kRnyg+7s7TWdUiALYYKjnnUNhdMtiygqrHeRVw0SKktYJWbTo
         CE1mzz+Va3wzQI6+ON0nIC5qcY7B8Ll61o8e3rnBJ3/xE0GQQ7LHegK+piEXslKsqKtL
         fT6c/HsgbYlbH9dxzjkkXTX3e3WPBI8lU8D+5fekbAdqDWG3QxiNPdp+RlMi7hPNDRdj
         RlgtMoH+5RH2F070EL8D9DrB2ljhOpYJbk5AN5buEpj5NznpQZvEw384ew+rfqFlhr6p
         Dx/mmz7Zo0sHweitgdjDn6RUklKlgFmhXw7pOZGcs92m4Mv+RYoFDBWpDmLjtYERRN2T
         WAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TUjdrIXMNe8uNjDuFL/hI5mDTUlQM39+j47CXaMJo8w=;
        b=HzF0B5w88Kl/pfha4O4FQ/2u1w53DsqWWpOQL6YUFEXjPPz+fWSQmI6kwBZSSvOerU
         9TgX/9THsvsUV83xTwZOcjytjgEtBi7DYX0leuAtBMdsP3NsYW1VTTK9bsBb67YfZGfL
         Yy9zjAtFNk6zuwuQkc5kWqusP3YQiPbFw2xi5Wz2Agz5aj3Ct3djeVqhNZSGgXvI4xOv
         sJ0haWUlqs4G0kH9qUTS0h0uKz2Bdwb0eFUUSnt9n69YQmHsM73PTf1lpNEoQayxvSoZ
         hiQ4KpfJRyMWBEyFqPptGwpdqnCrjqUikSOXr+yFNdCGn9LQ1xJB37vV3mm1RVlswo4i
         ttJA==
X-Gm-Message-State: APjAAAWHQvlksYNtUR5mhcg+o0qULaSSRIcBvnVZu4GtsvE6Kd4hMtAi
        va6UWB+jidrKXWLkVFLYeAdLyWVH
X-Google-Smtp-Source: APXvYqyX6XKug6In1kYuzUUS+vN+QxNpF0CH8jaibQbiI318FYbxhJCnjD9OExrS/yZjdvohCE430A==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr5102056plo.109.1569595464901;
        Fri, 27 Sep 2019 07:44:24 -0700 (PDT)
Received: from ArchLinux ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id d20sm3806250pfq.88.2019.09.27.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:44:23 -0700 (PDT)
Date:   Fri, 27 Sep 2019 20:14:11 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2] Remove dead url and added active url .
Message-ID: <20190927144411.GA167835@ArchLinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The below links/urls leads to "server not found" error, that means ,
those sites are not maintained anymore.


We should induct these below urls to look for the config.

Dead Url for Gmail Settings : http://dev.mutt.org/trac/wiki/UseCases/Gmail
                          (we need to remove it)

Active Url for Gmail Settings : https://gitlab.com/muttmua/mutt/wikis/UseCa=
ses/Gmail
                             (We need to induct it)

Dead URL for Manual : http://dev.mutt.org/doc/manual.html
                 (We need to remove it)

Active URL for Manual : https://gitlab.com/muttmua/mutt/wikis/MuttGuide
                             (We need to induct it)


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/email-clients.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/email-clients.rst b/Documentation/proces=
s/email-clients.rst
index 1f920d445a8b..15781bf10b8d 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
=20
+The Mutt docs have lots more information:
+
+ https://gitlab.com/muttmua/mutt/wikis/UseCases/Gmail
+
+  https://gitlab.com/muttmua/mutt/wikis/MuttGuide
+
=20


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2OIDEACgkQsjqdtxFL
KRVB0AgA1xoyjymkYpFrvCsxEB5ABxzcZUA+ED1vc4ATtGSnaAXuL5uXPs3pjl0B
md2PhUsi8jecCAjI/a8sXJ+oLYuH2tD2x0r6j+aheKDCEnMcj6oBSbGioeRu3mby
eBNf2H6y4UoMl1tQxafAQOudeKv8byei2apMZayteuatSRB2L49GbXvvHOSLiXpV
HH74Th29RKDwRv5dzMQfaFFuDGDlrG0vc7Y8PeLglsIJvJhGqcjBb1RjKKQsgqtd
2Y1QKiMysiQuTrlqstl1lVsAxC4JrMRczwct46+cA+XuSJz/x3rpfq4yHB+djnUY
5CG//DRBAxfmDTlCKRcLOPmq8M1Xog==
=7cbu
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

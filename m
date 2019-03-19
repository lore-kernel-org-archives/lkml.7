Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3974E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAnNAB0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSS0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:26:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43796 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfCSS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:26:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so14404544pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+pv7N5dZB8BBHmN6DIo8H2HB8nh1hDFmwGzl8xyZh88=;
        b=wAnNAB0jxvCWLMuPL6T+7mtoUraQaRTNFkSQlDfOUJ2P5wCilh1wB/YZ2quuqjzBYV
         QIKmTgwxkuCGRWK3mmdMY1nowNAteCaW2nX/oBizJUQf6toU5MxmuTrexSoEzyLSwusV
         mfejIW/vmDPcPj86YyLdZOnWEjhzyYX/chL5y7Lg3FR7fZgY81os2siIjnw7OeLKT49Q
         O8xHgVT9vcKx7FGRzJ+H7miJTexUgEgwF7Bx3dFiIsM3u9dd4bxJZM3gk2bC0ARME2OD
         UCsytMJzV1z2IxBM0ZLbUD3nteulberR7awbuzl44tBF1HTH+484YPMGMatq1S3wUfYa
         C+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+pv7N5dZB8BBHmN6DIo8H2HB8nh1hDFmwGzl8xyZh88=;
        b=IBmQ+Yr13X9ITKkOkeXg1aQE3bJKIcBBLJBK1ncguUHRJT9d1izFK4ozJso1zxraK/
         Y0qZC4AZIjhpLcitXJgJ+uChWw34VrFUTRcOPdtcIiNpKnrw+xolSTMpNVX9OJEX+3m4
         J1qlyqBu1aCQAcnmXIPY66asCd5wcMECe0kCWk12U0PbsFsdPNui+OE/6ZZZt/dcUK6y
         ttHeXW5ptSijx+nIcP5T19ku4mb/cY02q4tRW+t0uOkk5e3P3b9aqiqWaIP0/U3iSIJJ
         5MWritqixOO209eZsC2TugUxF9P6RwrPLqISk6ShmYfq9u9fVDTm+yfKoyk1e8Y7m1rU
         qLOA==
X-Gm-Message-State: APjAAAVIysyxCJyGO5D4cVtlSySV2VzQ8Cd4dmePjyasXcTmLDgmMU6Y
        ovcRLFVxBjb+JxMRCUCZ7Fzbog==
X-Google-Smtp-Source: APXvYqzhN3XbPCUq5saV3Nx3OzeJ6RM7MUdn5/K8Wv+EwncUOB8dsbswjJiotbQiEu7XgVadCsQKog==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr3439630pls.91.1553019962712;
        Tue, 19 Mar 2019 11:26:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id z14sm6371164pgi.11.2019.03.19.11.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 11:26:01 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:25:55 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@chromium.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, bleung@google.com,
        linux@roeck-us.net, ncrews@chromium.org
Subject: [GIT PULL] chrome platform fixes for v5.1-rc2
Message-ID: <20190319182555.GA197525@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 2794449576a6024e203eca5cc2c1a3ae33102b8e:

  platform/chrome: fix wilco-ec dependencies (2019-03-05 11:35:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.1-rc2

for you to fetch changes up to 57aeef7f7a6848024b92c32bf23e8c85a8ac896d:

  platform/chrome: cros_ec_debugfs: cancel/schedule logging work only if su=
pported (2019-03-19 11:00:30 -0700)

----------------------------------------------------------------
Chrome Platform fixes for v5.1-rc2

Two fixes:
1. platform/chrome: Fix locking pattern in wilco_ec_mailbox()
	- Closes a potential race condition in the new wilco_ec driver.
2. platform/chrome: cros_ec_debugfs: cancel/schedule logging work only if s=
upported
	- Fixes a warning in cros_ec_debugfs on systems that do not support
	  console logging, such as the Asus C201.

----------------------------------------------------------------
Guenter Roeck (1):
      platform/chrome: cros_ec_debugfs: cancel/schedule logging work only i=
f supported

Nick Crews (1):
      platform/chrome: Fix locking pattern in wilco_ec_mailbox()

 drivers/platform/chrome/cros_ec_debugfs.c  | 10 +++++++---
 drivers/platform/chrome/wilco_ec/mailbox.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyRNDMACgkQHwn1ewov
5lht1BAAqIxuYABqK7gv3lBFRjd98PRDSefn5mdHPqNeW7YRMw2N/wp93j8X4VPY
uHmw9qw4kduIhnKeSCrzHAops1zlYnMXXlI29jB1s5IYI5xjswVsv9XbDJlkCPzp
TfCAnPo+AVE+YuyUngnrjy2J87Q1TbX3z/fcS+7ka49ncSzVq/SJEwPCISZLgbCT
5i+yXzDKzC0bHbj/4MfS3e9+WGbXQNrqYmMffiX62XHC46eH4dFyFmp5x4nKJ6OR
RK6E8HQf6fWyZuJ/DN8ER0qSLzdVTcQo2LEVs2z1VgdLLuFLlH6wEk7NGA4eXHUE
Cbr8bi/R+D6E4M8EW+V5nc2zUJJoX3TcktDQJ8zWeD/Ptu1D28ifz1oKWRWIMsnq
yInyCSTKwcM+N8QLIYt8FZfmN05qH8PZwzr5mhmwmmNhG0kc4GcjI+x199XsbHUI
eUqLHYrZMDj5zLKVcUmI/SXAgP5KfdUriCcAcMRXX+EreSdld8tyXq0P9W12a9/y
ghlZso7wWrZekRmBedd8Yfo/A9ub6cWi+zs7/xKAtJCY81gPhLUP61X3Cuz3YrkO
JoXiUrGsz16xPKgeOYfy+a+rY5EJJlVvSsPU/PSN1ZLm4rFXzw2O8M6KlmbgQ8Jp
ElFKkQsHnaRmixjnw8mbtfY5UVNwaIVkiNq2d4mRl/at88c2cEc=
=XkEf
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

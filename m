Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B62C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEBC21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msUOr8AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfCLRwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:52:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45257 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfCLRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:52:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id 125so2363607pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1jOxuWmKKOnrgPAvMsP18qgvozWvfRVdus7LvFkixxs=;
        b=msUOr8AXo/PG90hLtsn0scOsBtQjDCJxY646uVnOSGnim9o0BMWFB789yxJsOZsim7
         J+NkvNjb4HPimEWmZoN7MVLal3AP3VA5CP0EZOFfLXGiQeCsjGFP5cQuLSVhAttGQPSe
         LWh1EjZq4kzEcYLpINmFrqBFq2dB4etL9DFI3H7j7fYxU8LggD+hqaewAF0HV6zCOwcq
         wvDjxe4intrLZNE+5I7RlhwGglse7wynRqCCcTlOx/0EJroiMu4zJIMqwkokeoBa1jxK
         WkPL+wWGmbE66ASUyoW7a4KrO+yuaR9Li7Lh+Zoot1fT3EdmfAZH1E8xt1pUDdbQPS83
         0jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1jOxuWmKKOnrgPAvMsP18qgvozWvfRVdus7LvFkixxs=;
        b=TIK7ISNFnkWhxVSv/BLDqTIqPF4pFIf4wCCUbwU9DIgxlg3LGNU8V598HTSPMHfJZ2
         U9tW3cAM5j2y+0wpjEXUmejQnHINP3x8gyEDVZIyoxaBsYspkCvmLim+yIAvRD44KxmJ
         yCDeSFYpL9Xq3F6I5P7ZxrORpoq2WVxTlbGCEosv+sEMz/ikP/UOFKBqFkHOG+/R17+v
         AoqrbCZ6zwQt31hWyw3HhsKcwAp/MZQ8WezslbUATGX43zw2eS8h24OSo1WKuPLjp7tr
         qblBklcq93TSfzkmveTaZqdVbwwgwvgf5tpMVRByHKdSL1lrNY8lE12lCh/zDaIslrTF
         jLqw==
X-Gm-Message-State: APjAAAXuRm56hVuoOp9X1f/aHnLQcjg9AftqoHOQqXoQEEV7hgVvq+YF
        OY7HgbnwqYN8RBWDYwZ4bDVgur3ctqM=
X-Google-Smtp-Source: APXvYqwlPSmNxQRclG2Drvebfk04lSQ60y17k+PKQJ+IPV0/pEKYehQNKbC8aB8uc2njVXeelLJfUA==
X-Received: by 2002:aa7:8c8c:: with SMTP id p12mr40928881pfd.0.1552413130416;
        Tue, 12 Mar 2019 10:52:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id l12sm21394767pgn.83.2019.03.12.10.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 10:52:09 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:52:04 -0700
From:   Benson Leung <bleung@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        enric.balletbo@collabora.com, bleung@chromium.org
Subject: Re: [GIT PULL] chrome-platform updates for v5.1
Message-ID: <20190312175204.GA218101@google.com>
References: <20190312043908.GA261883@google.com>
 <CAHk-=wg50Hn+vBmTSLVc2dG0+3Sjn0ZeL22RH2YxgpgvKw5NpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg50Hn+vBmTSLVc2dG0+3Sjn0ZeL22RH2YxgpgvKw5NpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Mar 12, 2019 at 09:56:18AM -0700, Linus Torvalds wrote:
> On Mon, Mar 11, 2019 at 9:39 PM Benson Leung <bleung@google.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.g=
it tags/tag-chrome-platform-for-v5.1
>=20
> No diffstat in the pull request? And the shortlog looks truncated too,
> with Nick Crews being reported as having four commits, but only two
> visible.
>=20
> (And yes, there are four commits in the pull itself).
>=20
> Finally, you say:
>=20
> > 2. Cleanup series between mfd and chrome/platform, moving
> >    cros-ec attributes from mfd/cros_ec_dev to sub-drivers in platform/c=
hrome.
>=20
> which I don't see at all in that pull. But that turns out to be
> because it already came through the mfd tree.
>=20
> Things look otherwise sane and I did the pull, but please fix your
> script and/or workflow. The "it already came through the mfd tree"
> issue is fine, but diffstat and truncated shortlog is bad.
>=20

Sorry about that. There was definitely a workflow issue this time around.
I'll nail down what happened. Here is the full pull-request sans-truncation
for posterity.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.1

for you to fetch changes up to 2794449576a6024e203eca5cc2c1a3ae33102b8e:

  platform/chrome: fix wilco-ec dependencies (2019-03-05 11:35:46 +0100)

----------------------------------------------------------------
chrome platform changes for v5.1

1. SPDX identifier cleanup for platform/chrome
2. Cleanup series between mfd and chrome/platform, moving
   cros-ec attributes from mfd/cros_ec_dev to sub-drivers in platform/chrom=
e.
3. Wilco EC driver
4. Maintainership change to new group repository.

----------------------------------------------------------------
Arnd Bergmann (1):
      platform/chrome: fix wilco-ec dependencies

Enric Balletbo i Serra (20):
      mfd / platform: cros_ec: Use devm_mfd_add_devices
      mfd / platform: cros_ec: Move lightbar attributes to its own driver
      mfd / platform: cros_ec: Move vbc attributes to its own driver
      mfd / platform: cros_ec: Move debugfs attributes to its own driver
      mfd / platform: cros_ec: Move device sysfs attributes to its own driv=
er
      mfd / platform: cros_ec_vbc: Instantiate only if the EC has a VBC NVR=
AM
      platform/chrome: cros_ec_lightbar: Instantiate only if the EC has a l=
ightbar
      platform/chrome: cromeos_pstore: switch to SPDX identifier
      platform/chrome: cros_ec_debugfs: switch to SPDX identifier
      platform/chrome: cros_ec_lightbar: switch to SPDX identifier
      platform/chrome: cros_ec_sysfs: switch to SPDX identifier
      platform/chrome: cros_ec_vbc: switch to SPDX identifier
      platform/chrome: cros_ec_i2c: switch to SPDX identifier
      platform/chrome: cros_ec_lpc: switch to SPDX identifier
      platform/chrome: cros_ec_proto: switch to SPDX identifier
      platform/chrome: cros_ec_spi: switch to SPDX identifier
      platform/chrome: cros_kbd_led_backlight: switch to SPDX identifier
      platform/chrome: cros_ec_lightbar: remove pr_fmt() define
      platform/chrome: cros_ec_sysfs: remove pr_fmt() define
      MAINTAINERS: chrome-platform: change the git tree to a chrome-platfor=
m group git tree

Nick Crews (4):
      platform/chrome: cros_ec: Remove cros_ec dependency in lpc_mec
      platform/chrome: Add new driver for Wilco EC
      platform/chrome: wilco_ec: Add support for raw commands in debugfs
      platform/chrome: wilco_ec: Add RTC driver

 Documentation/ABI/testing/debugfs-wilco-ec         |  23 ++
 Documentation/ABI/testing/sysfs-class-chromeos     |  32 +++
 .../sysfs-class-chromeos-driver-cros-ec-lightbar   |  74 +++++++
 .../sysfs-class-chromeos-driver-cros-ec-vbc        |   6 +
 MAINTAINERS                                        |   2 +-
 drivers/mfd/Kconfig                                |   1 -
 drivers/mfd/cros_ec.c                              |  14 +-
 drivers/mfd/cros_ec_dev.c                          |  89 +++-----
 drivers/mfd/cros_ec_dev.h                          |   6 -
 drivers/platform/chrome/Kconfig                    |  49 ++++-
 drivers/platform/chrome/Makefile                   |   9 +-
 drivers/platform/chrome/chromeos_pstore.c          |  17 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |  84 ++++----
 drivers/platform/chrome/cros_ec_i2c.c              |  32 +--
 drivers/platform/chrome/cros_ec_lightbar.c         | 150 +++++++------
 drivers/platform/chrome/cros_ec_lpc.c              |  38 ++--
 drivers/platform/chrome/cros_ec_lpc_mec.c          |  78 ++++---
 drivers/platform/chrome/cros_ec_lpc_mec.h          |  63 +++---
 drivers/platform/chrome/cros_ec_lpc_reg.c          |  73 ++-----
 drivers/platform/chrome/cros_ec_lpc_reg.h          |  20 +-
 drivers/platform/chrome/cros_ec_proto.c            |  19 +-
 drivers/platform/chrome/cros_ec_spi.c              |  31 +--
 drivers/platform/chrome/cros_ec_sysfs.c            |  62 ++++--
 drivers/platform/chrome/cros_ec_vbc.c              |  83 +++----
 drivers/platform/chrome/cros_kbd_led_backlight.c   |  19 +-
 drivers/platform/chrome/wilco_ec/Kconfig           |  20 ++
 drivers/platform/chrome/wilco_ec/Makefile          |   6 +
 drivers/platform/chrome/wilco_ec/core.c            | 136 ++++++++++++
 drivers/platform/chrome/wilco_ec/debugfs.c         | 238 +++++++++++++++++=
++++
 drivers/platform/chrome/wilco_ec/mailbox.c         | 237 +++++++++++++++++=
+++
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-wilco-ec.c                         | 177 +++++++++++++++
 include/linux/mfd/cros_ec.h                        |  21 --
 include/linux/platform_data/wilco-ec.h             | 144 +++++++++++++
 35 files changed, 1542 insertions(+), 523 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-c=
ros-ec-lightbar
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-c=
ros-ec-vbc
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 drivers/rtc/rtc-wilco-ec.c
 create mode 100644 include/linux/platform_data/wilco-ec.h


Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyH8cQACgkQHwn1ewov
5lijcw/+IDI5LpP2FTOKlHKZmzvlaVIwnvkImmg2gDF675tzFIs8hNT27sex3zz0
ScKrPNxx+bw0Aygd4uLiGjS1eDDxFnZLHUvjfHxC9bZajTo5eXz/zjd4h0DJ9cHu
81X3A9+MXwQu29GnCxnHQBEs+6DdrA2f/slTBCwyJ+eclMye/9m4Bilo/IvcnEHR
K3ZHA8yOu7QdnOELbzpp8JQ17yW/ZgfTWuRHKBwTczBy2qyjfI6rj/RSPZO3Rzsb
i4jpjkxKeLZ/XTYFA3az2j/lysnyiu21rzWiJXbk0dJwNpt7I1+Rvcjh1j+ltLPb
NJ96gz035Uzu/gB/XHpeVO++IGTgFn0UetldMM77x75qyt3GgDDjlDpmdpGL28b5
hXqAbAiuN6pvr2YuSkkboZkkAYN9ZqhgQrCFwHdZcqTJdR2Gy7wEoAha16lOhG4k
sw5lZ2RFH6dzvXpyQWxZcFsiu23ioMyp2fotka6tlcVP3dJD93cK0Pg+iOn/dVkG
Qn+IG6ANOp+DRAI8Cv9HHlAHNAH8sAaPoX5hBqUGV2WkTJtpt8k9LLmOPZzRkdau
TBfUTvPSsSiQjsv201sgiB5wAR/Qhn3+w8rF2XtIfzMP/EUdeY0KAz6ksoLZNFyx
1UvbkwzNh77hkz7MYoVxdx9jsWEbPdHoaenM+vmr8W2irkjjBFw=
=lPxP
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

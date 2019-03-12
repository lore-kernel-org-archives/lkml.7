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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3655C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B800D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ev0fnqSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCLEjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:39:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfCLEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:39:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id b2so832853pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3TitDM4xhzNwj5D+o7ycj+hOBD4Cq648vCERN4zGarM=;
        b=Ev0fnqSyCTfPQbclKyvWftCULeJZKVM8NNiAqOZ07d++VVOV4qPHtj71bEieAbEUNJ
         O3phMyrxmj/aMEQFj8bvEt7Dj8oXbLtCA+I/z2KSVhiDuGONZ9qmIMHLfSsl8VCD07rE
         b3cgcjrKAVSbqUpFEGjT+v0o1lFFbU/WI01CoviWUwwl1PIyI1z9QnSZx7N5Apl4rZj1
         O4FDvVfy/dOK6UMWzxaREz0fB+h3viNGvWlBKuHauB01ktmKhEeDbqLNNfWCoO8A9LYB
         gfQq+nw71LWlRV0DDJ9aMPNoZ75Gv9etrnJOAC5n06Cs4B5nNQwG+PmgIB7Ls0GDHqKN
         YG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3TitDM4xhzNwj5D+o7ycj+hOBD4Cq648vCERN4zGarM=;
        b=e3yyRtn26OEigoCRelsxBmSkvmKPoI+Dl1QtFBFlrm0w1Dvb9hvooqehyPQQ6bOw+Q
         7ogNt6f5lozagDlMZcmjjMZ0b+dO1DndThjVi/GObNSK2NOiGG/mgLTqgEXI5WwE4uzH
         TbRZJIBspdnt7K9yl+6W/ok6TOOAYl/otQgrv/Wc4hdjcpkrCCQLgdWv3T4jefvOdIct
         jrmOaa8OP1rHQW18FLnIdBI1ZrgvVn1iARpWG7UKDsksL4bOWc8A/zpuTqMzKIwK+oje
         QyZhewYhIsRVtE49ulYVN7/PJLW21thcrTU67ZBCX5CYXXnUEV9+OtfTHPhibXtFMmeJ
         pPng==
X-Gm-Message-State: APjAAAUrMYoWKmLwcdQsiuYGgHu4+MbgxO3YhsM16/xJA/LXluUFzs9z
        eFVB5EfKKjqQZSAJnhX30TbJkJjiniY=
X-Google-Smtp-Source: APXvYqx58YnUT+JrPauJST7V92E0Depp6nx0NihEt8nETFVfSNT7XF6MrijgKlvBhxTaS7reNmH+zg==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr36884339ple.142.1552365554165;
        Mon, 11 Mar 2019 21:39:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id h9sm4669484pgk.22.2019.03.11.21.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 21:39:12 -0700 (PDT)
Date:   Mon, 11 Mar 2019 21:39:08 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        bleung@google.com
Subject: [GIT PULL] chrome-platform updates for v5.1
Message-ID: <20190312043908.GA261883@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

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

Thank you,
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyHN+kACgkQHwn1ewov
5lhNAQ/+J4HhtTPcF0Qo5ZUiYNjyU0lTTt5eI1zLvhxHr47FIFQcggnMkbOmEmFM
qkz63ffdYQWPvelxb9/dW58aq65uuEmGnmOuwVIGKWskpTIz4HTbWdnKsxeXsgt4
bHXZi2ZvHoUl9LP05fxfJZrpRKrA9I0S7hQWYFwJt/6WXZdKi6tITt7WZWsIflyF
c9xkDgpI+odAaINLD42V0j5ZlmE/RV96taUxBUwWcwvtBaEIP7DkiGRLzZEWDq/e
Kzx5yBJ3sAPGoAbGpTj2buFv5SPOMM81fxBkNSde6C0oksSXMAXOK554F4TvzoVX
uO+ISoR2S7Va7TCMNs1B3VZl2kQiiqp4Lbjnw8g9zMZlvy+2HkLLoYiOl+DzJ7lR
Q/VOV3JuUR90F1EqNIroU3iVaCcq6vTi6FUoVM0olwPc52aks/Q/DRiE/Gcq458u
Ch8tUuycvukzWmekHo85N/EprjEVjzK78QdM+JVCPBJSXDWWqyA6ML6N5l53ZHc8
djV92xHuUyyO+uGJgJznp39+MtNjjswoarxeHQs7FkUkqkXD2nGekibvRW6QBF+5
IGQTw3PryYNNuUaVCY3QWS+Z0ax1omXywlAfrkVKcDHXk3l3dIX3B6zwtlB+zvAe
FkBW4xY8DtvQ7fn1QNfYwHV/nRORsWAea1MVYivwAA3UfXs2U6A=
=5JE8
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

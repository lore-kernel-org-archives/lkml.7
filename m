Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE1C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F32133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/9EBV1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfELENg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 00:13:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfELENf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 00:13:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so4722543plm.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9LLc35BJ6DwW+U1HaVZ9wbuN8uS10gKvoLzpskUmci4=;
        b=Q/9EBV1GPAMQCqpEM4s3MaT8kcotnpe6MrF2aLNVMBgHXdZXc0uKDTpW5bqT6ED7N8
         HNl3wq2cMoUPtK+Akui1XDdYnpWYxWVrGGWXbvPNVOarwI1jTRoGzfUhXOjGmgz4cfgi
         5cQwO4H2VdIbrRawI4bU+2oYSu/vcfPTg1/1pftoeCxszW5tkRQ4Uta8Uq7gmXpiQ/o6
         xEQLrXz+fKkz6hkHlDDUr7fVilI/4mXvv+hdHX3uk8mldKhu+c4rIUDvI/AEyk1cRfkO
         cP6kIPsLJMcaKnVCCMXVVX5lQVQub32GeraMiHaW6duPyz19WPt97qHuNtJhKdFv+TtA
         yAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9LLc35BJ6DwW+U1HaVZ9wbuN8uS10gKvoLzpskUmci4=;
        b=doziOHR2sEgGnO5LF6s+AW93KnsEC4+KJj98YryzB7cWRow1q+6e1vqUR76z1wl+Mt
         uFJfITdF5Dx7TxV0sHKlR5aYDTzHU+uE3xemR3xbsuK2qZH22SeHv62fNdY972XhAwwn
         ZJg05x86P8LDEcbcAgMo/PE/tLbWGkwJlB3INc9Fk9sYs9asD+ioE6WooFGUiic7306P
         nF9wgD0xK5mFmNzYVwHWcwlF51foLdUpcb7iR4lY/iLGbgsIbEPHBxL1VU972VCIi5RP
         /Z8CZKVUTI+nUDBvJBaRK2MqhFRuIblTBRG9C/qfeclGzWGv+vDTQM8pOp7wiA/Ts74R
         P5sw==
X-Gm-Message-State: APjAAAXwmCVhVqPppEpl7Vp0a6HGwLcgCu2UDPiUASVbssruIt0Mwwum
        RhnpzhF7FD6GICM/dXFinHhVLEnixs4=
X-Google-Smtp-Source: APXvYqyVNf5fYKSZmm8c70xkA8Ob4/VUaL/koLfBkIJNWA04iQqJQMvCp9m2R7YSIZXGm2R0nK0dTQ==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr23919294plp.180.1557634412526;
        Sat, 11 May 2019 21:13:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id w12sm21049794pfj.41.2019.05.11.21.13.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 11 May 2019 21:13:30 -0700 (PDT)
Date:   Sat, 11 May 2019 21:13:24 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.2
Message-ID: <20190512041324.GA7523@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.2

for you to fetch changes up to 58a2109f6eb46b2952e2ce3fe776ce02c0c540dd:

  platform/chrome: cros_ec_proto: Add trace event to trace EC commands (201=
9-04-17 10:29:34 +0200)

----------------------------------------------------------------
chrome platform changes for v5.2

CrOS EC:

- Add EC host command support using rpmsg
- Add new CrOS USB PD logging driver
- Transfer spi messages at high priority
- Add support to trace CrOS EC commands
- Minor fixes and cleanups in protocol and debugfs

Wilco EC:

- Standardize Wilco EC mailbox interface
- Add h1_gpio status to debugfs

----------------------------------------------------------------
Douglas Anderson (1):
      platform/chrome: cros_ec_spi: Transfer messages at high priority

Enric Balletbo i Serra (3):
      platform/chrome: cros_ec_debugfs: Remove dev_warn when console log is=
 not supported
      platform/chrome: cros_ec_debugfs: no need to check return value of de=
bugfs_create functions
      platform/chrome: cros_ec_debugfs: Use cros_ec_cmd_xfer_status helper

Enrico Granata (1):
      platform/chrome: cros_ec_proto: check for NULL transfer function

Guenter Roeck (1):
      platform/chrome: Add CrOS USB PD logging driver

Nick Crews (2):
      platform/chrome: wilco_ec: Standardize mailbox interface
      platform/chrome: wilco_ec: Add h1_gpio status to debugfs

Pi-Hsun Shih (1):
      platform/chrome: cros_ec: Add EC host command support using rpmsg

Raul E Rangel (1):
      platform/chrome: cros_ec_proto: Add trace event to trace EC commands

 Documentation/ABI/testing/debugfs-wilco-ec  |  45 +++--
 drivers/platform/chrome/Kconfig             |  24 +++
 drivers/platform/chrome/Makefile            |   7 +-
 drivers/platform/chrome/cros_ec_debugfs.c   |  74 ++------
 drivers/platform/chrome/cros_ec_proto.c     |  15 ++
 drivers/platform/chrome/cros_ec_rpmsg.c     | 258 ++++++++++++++++++++++++=
+++
 drivers/platform/chrome/cros_ec_spi.c       |  80 ++++++++-
 drivers/platform/chrome/cros_ec_trace.c     | 124 +++++++++++++
 drivers/platform/chrome/cros_ec_trace.h     |  51 ++++++
 drivers/platform/chrome/cros_usbpd_logger.c | 262 ++++++++++++++++++++++++=
++++
 drivers/platform/chrome/wilco_ec/debugfs.c  |  89 ++++++----
 drivers/platform/chrome/wilco_ec/mailbox.c  |  53 +++---
 drivers/rtc/rtc-wilco-ec.c                  |  63 ++++---
 include/linux/platform_data/wilco-ec.h      |  22 +--
 14 files changed, 984 insertions(+), 183 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/platform/chrome/cros_ec_trace.c
 create mode 100644 drivers/platform/chrome/cros_ec_trace.h
 create mode 100644 drivers/platform/chrome/cros_usbpd_logger.c

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzXnWQACgkQHwn1ewov
5lh3EA/+I2VZvKUZ0Rc/WPPc+/b2bDRaBw4ETlhLPjairL1ZO1yY3iJfHBdZBXAy
DsKoILYJ5glcSEH/zBv/fdkAPslk9KqUnmp0kvqXHo6x6r/UIcb1VECBjnVyXREp
MYDfEqNZu1dFiVNCaDxcJaKqLwq2UOqm6xOa0DPoOKSgb2227hfmmua000zr15kf
MtMOknFdF7vQIJJncacDWqaU3sZAJFPHLBWEnuErOLt7zXdK9+7PP/v2nwKzSM3h
nz/OCadddOBL8QIC/IZy0DXJIcayoOUf7tet391DPzimOQPNSZnLGQuPvnR1LvyY
SXEwOCTeXlO9KKWmqMzjyz/jrdsR/RL25UxR76m9K5QBSyQXwD5QHSMOwsjfkpmM
oy7wiYxL17ytcNbi1SmsTCak/TJmFFMh3KAhgJNAvKrB9H4WOejJOyQjY/SFIGbu
DGz61mKzUGodg8QQhKqB0Y0AfcU3GtATaJB65IdmxrJY0mT9pfZlUOR9iF4JP2eS
9jj7rJHMz5ccv/fX1UsPeBnLTL/Z/zWE/JpIBgjkLR0chrWTlZjbCEAcEbWz/dIZ
JbRZqVPrKewM0WXaSywyMGzkhKGqU9xNB1HAnCVnitde6QAFYs0LDCGgxwm+6389
9ttwSqs08JOs4R+L8ZDuogQ/Au318N4GdYNFixnNLUsTb72ybUM=
=y3CO
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

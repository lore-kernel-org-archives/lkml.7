Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4958AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217332068D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDrapg7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKMRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:51:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42995 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:51:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so2132862pfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5TBPzQm6E+yQZNW2LXk44v+dRh+XrfHmEhh51Saucs=;
        b=IDrapg7FdCDVd9dzi04J1KnAIyqx1NytPnIHaxozY4LaXBVS3sZY9bzcf73nl6zxFE
         YtwM0VSBBhKOcrLwAEx/f0cpmYGr60ewFbDIvBMs1lvjgYNNvnEvCREbUgSXbFSz0X8D
         Kgtvm62ebxk/LWRvPlSB05O7I8u7tn+bQ4kg4vtZ2t7ThF6oOKtNF0exkit0u/DRF4Mo
         plJndSzs7QIjyclNj2dT+rTg8vNKkEnGnlxo2rYlrkUKcdorE2O9KjFDbJE2dTEcb1QG
         g6j9PeKVyAtZpvquQ1hdKda/r6DgU7D8fM0VYZoJHnjaW1XOUpAhHMH02y8We2f15xE/
         MgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5TBPzQm6E+yQZNW2LXk44v+dRh+XrfHmEhh51Saucs=;
        b=jE0TKfeNCRQMVTuqG2DcCYc3U6WruDewVl3+YtpcMq1dUilFrHfBFP8xI70x9u/fov
         UdjUL/6J0Y1z7uU52iNGCSwECCIPRfl2MQzOP3joE45KKrz+ZtH/sbVLSDYwi2virZ7o
         b2Hu7ycx3Pu5oVIDBTkZAsTa6We49yk8B17+dBTIq8BkS7ZGqz6Va9/PRBj7h1Zihu6O
         Lhz0ymhOtKZbWSt3b2DUDIsT6Ww2H7mbU7xJJ2ILZrRz9Ii4M/sE1GBDLmMjgTJ2xe+a
         1nsj/60gg1CLEkCxG8DOMWJvSMCUfll/Iyw5kTuG5Uo4CJlV6Y9MKvCemK5OuvBQdU4x
         5SNw==
X-Gm-Message-State: APjAAAV7F7nM/WlJ4fppcGQ3nQJnduZU+OGHRwpe1/TVtEL4H2tpJtQ2
        5VXc76cCSscPDg05ajk5L5/ssCmhBac=
X-Google-Smtp-Source: APXvYqzVWhARqpI3JMJtAkCX3fSjDBKXL2HNrKnDRuWkXmcp7K3F8TPkVcwnEpWXJ0PO7K18/EBeaA==
X-Received: by 2002:a65:4342:: with SMTP id k2mr5243439pgq.63.1573667493791;
        Wed, 13 Nov 2019 09:51:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id q34sm3242669pjb.15.2019.11.13.09.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:51:32 -0800 (PST)
Date:   Wed, 13 Nov 2019 09:51:27 -0800
From:   Benson Leung <bleung@google.com>
To:     Jon Flatley <jflat@chromium.org>, heikki.krogerus@linux.intel.com,
        heikki.krogerus@intel.com, enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org, sre@kernel.org, pmalani@chromium.org
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
Message-ID: <20191113175127.GA171004@google.com>
References: <20191113031044.136232-1-jflat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20191113031044.136232-1-jflat@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Thanks for posting this.

Adding Heikki, the typec connector class maintainer, and Enric, co-maintain=
er
of platform/chrome.

Benson

On Tue, Nov 12, 2019 at 07:10:41PM -0800, Jon Flatley wrote:
> This patch set adds a basic implementation of the USB-C connector class f=
or
> devices using the ChromeOS EC. On ACPI devices an additional ACPI driver =
is
> necessary to receive USB-C PD host events from the PD EC device "GOOG0003=
".
> Incidentally, this ACPI driver adds notifications for events that
> cros-usbpd-charger has been missing, so fix that while we're at it.
>=20
> Jon Flatley (3):
>   platform: chrome: Add cros-ec-usbpd-notify driver
>   power: supply: cros-ec-usbpd-charger: Fix host events
>   platform: chrome: Added cros-ec-typec driver
>=20
>  drivers/mfd/cros_ec_dev.c                     |   7 +-
>  drivers/platform/chrome/Kconfig               |  20 +
>  drivers/platform/chrome/Makefile              |   2 +
>  drivers/platform/chrome/cros_ec_typec.c       | 457 ++++++++++++++++++
>  .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++
>  drivers/power/supply/Kconfig                  |   2 +-
>  drivers/power/supply/cros_usbpd-charger.c     |  45 +-
>  .../platform_data/cros_ec_usbpd_notify.h      |  40 ++
>  8 files changed, 696 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
>  create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
>  create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h
>=20
> --=20
> 2.24.0.432.g9d3f5f5b63-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXcxCnwAKCRBzbaomhzOw
wqYUAQC31vWYQJwUDrJUj3CcMKizgNjf/eVXFBaDpsLH2CSy8AEAsggG/0VkhYOf
pvarcArEPRWU+EHJgc0UQd56/YThsQA=
=h+5z
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

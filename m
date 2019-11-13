Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10929C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D12206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfKMSZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:10910 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfKMSZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:25:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 10:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="214367174"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 13 Nov 2019 10:25:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Nov 2019 20:25:37 +0200
Date:   Wed, 13 Nov 2019 20:25:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Jon Flatley <jflat@chromium.org>, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org, sre@kernel.org, pmalani@chromium.org
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
Message-ID: <20191113182537.GC4013@kuha.fi.intel.com>
References: <20191113031044.136232-1-jflat@chromium.org>
 <20191113175127.GA171004@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113175127.GA171004@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Wed, Nov 13, 2019 at 09:51:27AM -0800, Benson Leung wrote:
> Hi Jon,
> 
> Thanks for posting this.
> 
> Adding Heikki, the typec connector class maintainer, and Enric, co-maintainer
> of platform/chrome.

Thanks Benson.

> On Tue, Nov 12, 2019 at 07:10:41PM -0800, Jon Flatley wrote:
> > This patch set adds a basic implementation of the USB-C connector class for
> > devices using the ChromeOS EC. On ACPI devices an additional ACPI driver is
> > necessary to receive USB-C PD host events from the PD EC device "GOOG0003".
> > Incidentally, this ACPI driver adds notifications for events that
> > cros-usbpd-charger has been missing, so fix that while we're at it.
> 
> > Jon Flatley (3):
> >   platform: chrome: Add cros-ec-usbpd-notify driver
> >   power: supply: cros-ec-usbpd-charger: Fix host events
> >   platform: chrome: Added cros-ec-typec driver
> > 
> >  drivers/mfd/cros_ec_dev.c                     |   7 +-
> >  drivers/platform/chrome/Kconfig               |  20 +
> >  drivers/platform/chrome/Makefile              |   2 +
> >  drivers/platform/chrome/cros_ec_typec.c       | 457 ++++++++++++++++++
> >  .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++
> >  drivers/power/supply/Kconfig                  |   2 +-
> >  drivers/power/supply/cros_usbpd-charger.c     |  45 +-
> >  .../platform_data/cros_ec_usbpd_notify.h      |  40 ++
> >  8 files changed, 696 insertions(+), 33 deletions(-)
> >  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
> >  create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
> >  create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h

I'll go over these tomorrow, but I have one question already. Can you
guys influence what goes to the ACPI tables?

Ideally every Type-C connector is always described in its own ACPI
node (or DT node if DT is used). Otherwise getting the correct
capabilities and especially connections to other devices (like the
muxes) for every port may get difficult.

Br,

-- 
heikki

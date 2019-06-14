Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E9C2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfFNSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:24:22 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:47009 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbfFNSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:24:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9B398100E86C0;
        Fri, 14 Jun 2019 18:24:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: show39_6001ba81f8710
X-Filterd-Recvd-Size: 6452
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Jun 2019 18:24:19 +0000 (UTC)
Message-ID: <3aa6d42db4b64c625b8461ee7d442f3f1830e8c3.camel@perches.com>
Subject: Re: [PATCH v2 00/28] drivers: Consolidate device lookup helpers
From:   Joe Perches <joe@perches.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jun 2019 11:24:18 -0700
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(dropping the very long cc list just cc'ing LKML and devicetree)

On Fri, 2019-06-14 at 18:53 +0100, Suzuki K Poulose wrote:
> We have device iterators to find a particular device matching a criteria
> for a given bus/class/driver. i.e, {bus,class,driver}_find_device() APIs.
> The matching criteria is a function pointer for the APIs. Often the lookup
> is based on a generic property of a device (e.g, name, fwnode, of node pointer
> or device type) rather than a driver specific information. However, each driver
> writes up its own "match" function, spilling the similar match functions all
> over the driver subsystems.
> 
> Additionally the prototype for the "match" functions accepted by the above APIs
> have a minute difference which prevents us otherwise sharing the match functions.
> i.e,
> 	int (*match)(struct device *dev, void *data) for {bus/driver}_find_device()
> 	  vs
> 	int (*match)(struct device *dev, const void *) for class_find_device()
> 

As you are doing treewide conversions, perhaps using

	bool (*match)(...)

is a more sensible api.

> Changes since v1:
>  - Drop start parameter for *_find_device_by_devt().
>  - Fix build warnings for s390
>  - Add *_find_device_by_acpi_dev() wrappers.
>  - Group wrappers and the consumers into single patch, reducing
>    the total patches to 28 from 57. (Rafael).
>  - Better description for acpi cleanup patch.
>  - Added tags from v1.

Below this is a _very_ long list of cc:'s.

If the list is generated using scripts/get_maintainer.pl
perhaps it is more sensible to add --nogit --nogit-fallback
to its arguments to cc actual maintainers and avoid people
that have submitted cleanup style patches to various files.

> Cc: Alan Tull <atull@kernel.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: David Kershner <david.kershner@unisys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Elie Morisse <syniurge@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grant Likely <grant.likely@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: "Heiko Stübner" <heiko@sntech.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Len Brown <lenb@kernel.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sebastian Ott <sebott@linux.ibm.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-wpan@vger.kernel.org




Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380EDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B94121D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfJCReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:34:17 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52859 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732907AbfJCReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:34:11 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id ADB16FF80E;
        Thu,  3 Oct 2019 17:34:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/7] Introduce max12xx ADC support
Date:   Thu,  3 Oct 2019 19:33:54 +0200
Message-Id: <20191003173401.16343-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, here is a patchset updating the existing max1027.c driver (for
10-bit max1027/29/31 ADCs) with a few corrections/improvements and
then introducing their 12-bit cousins named max1227/29/31.

As on my hardware setup the "start conversion" and "end of conversion"
pin are not wired (which is absolutely fine for this chip), I also
updated the driver and the bindings to support optional interrupts. In
this case, triggered buffers are not available and the user must poll
the value from sysfs.

Thanks,
Miquèl


Changes in v2:
==============
* Removed the addition of three compatibles from patch 4 (the
  preparation patch) to add these lines back in patch 5 (the actual
  introduction).


Miquel Raynal (7):
  iio: adc: max1027: Add debugfs register read support
  iio: adc: max1027: Make it optional to use interrupts
  iio: adc: max1027: Reset the device at probe time
  iio: adc: max1027: Prepare the introduction of different resolutions
  iio: adc: max1027: Introduce 12-bit devices support
  dt-bindings: iio: adc: max1027: Mark interrupts as optional
  dt-bindings: iio: adc: max1027: Document max12xx series compatibles

 .../bindings/iio/adc/max1027-adc.txt          |  12 +-
 drivers/iio/adc/Kconfig                       |   4 +-
 drivers/iio/adc/max1027.c                     | 190 +++++++++++-------
 3 files changed, 133 insertions(+), 73 deletions(-)

-- 
2.20.1


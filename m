Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51001C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A4E2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394847AbfHWMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:42:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393272AbfHWMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:42:08 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6DA8528C1A1;
        Fri, 23 Aug 2019 13:42:05 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] counter: cros_ec: Add sync sensor driver
Date:   Fri, 23 Aug 2019 14:41:26 +0200
Message-Id: <cover.1566563833.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chromebook EC provides a counter to get all vsync coming from the back
camera.
This series introduces a patch coming from chromebook kernel 4.4 designed as an
IIO counter. As IIO counter will be deprecated in favor of counter, I rebase the
original patch and support the new counter API.

The serie need to be merged after https://lkml.org/lkml/2019/7/9/305

Changes since v1:
- Drop code related to IIO_COUNT
- Add external attribute to the counter driver
- Add cros_ec_sensors_sync.c to MAINTAINERS file

Gwendal Grignou (1):
  counter: cros_ec: Add synchronization sensor

 Documentation/driver-api/generic-counter.rst  |   3 +
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/counter.c                     |   2 +
 drivers/counter/cros_ec_sensors_sync.c        | 208 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
 drivers/mfd/cros_ec_dev.c                     |   3 +
 include/linux/counter.h                       |   1 +
 9 files changed, 235 insertions(+)
 create mode 100644 drivers/counter/cros_ec_sensors_sync.c

-- 
2.20.1


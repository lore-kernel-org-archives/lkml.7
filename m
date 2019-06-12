Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9901BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfFLIpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:45:40 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:43570 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfFLIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:45:38 -0400
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id AB75E4D037;
        Wed, 12 Jun 2019 10:36:36 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 0/3] PWM framework: add support referencing PWMs from ACPI
Date:   Wed, 12 Jun 2019 10:36:05 +0200
Message-Id: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in Documentation/firmware-guide/acpi/gpio-properties.rst a
GPIO can be referenced from ACPI ASL _DSD with the "gpios"-property of the
form:

  Package () { "gpios", Package () { ref, index, pin, active_low }}

The second patch of this series adds support for specifing a PWM
reference in ASL of the form

  Package () { "pwms", Package () { ref, index, pwm-period [, pwm flags]}}

The first patch of this series is necessary to resolve the "ref" in ASL
if the table has been loaded by efivar_ssdt_load() or configfs.

The third patch of this series makes leds-pwm use the ACPI-enabled
PWM framework.

v2:
- fixes by Pavel Machek and Dan Murphy

Nikolaus Voss (3):
  ACPI: Resolve objects on host-directed table loads
  PWM framework: add support referencing PWMs from ACPI
  leds-pwm.c: support ACPI via firmware-node framework

 drivers/acpi/acpi_configfs.c   |   6 +-
 drivers/acpi/acpica/tbxfload.c |  11 ++++
 drivers/leds/leds-pwm.c        |  45 +++++++------
 drivers/pwm/core.c             | 113 +++++++++++++++++++++++++++++++++
 include/linux/pwm.h            |   9 +++
 5 files changed, 161 insertions(+), 23 deletions(-)

-- 
2.17.1


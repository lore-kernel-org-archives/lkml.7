Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8472184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDKNbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:31:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:31:15 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.113]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbAUg-1gdKDq2H1M-00beRR; Thu, 11 Apr 2019 15:30:34 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 0/3] hwmon: pwm-fan: Add RPM support
Date:   Thu, 11 Apr 2019 15:30:08 +0200
Message-Id: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:9sa6naMRFGBke9TflH3E6QFNMPua8wF9Iwhb4gxhwp0MvohkXtP
 Pgai4a4bwgecwRf4DMwnn8t7L6h1ZSsLFUHZRWy/xgKJC6IFslixSlSx6xo7q9PDP/PYGjz
 4A9Fhz7Iv8u/ccXBD4wuXz+vLA7PtizbWUHs0dPm0GJyhTqY4T0OO+wvUzNVxYUTiwb+mjO
 MNXCWGopex3dRDvF9pwsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzQBIJPTL9o=:u5e3k5o7ygVy6HLc7JtP4G
 Csj7x4PhrbJqBOQG0ekj2RzqoQn8E676K8ZGcM2G88ylWZxR6haksztPRtvop7+VarCRgmDFg
 OWvz3d6R8qEdRLFDsKJ6oZVWEFJ4BRd9E24MbN1qVNvwM3ZrP+gYIxtyIhg7O/19VQJNqps/B
 iaTXwjgWQGrUCgGGqWh8s+jDuiunh4PNICIVsTnB5Y6oUmHIgOFP05p1bxQ2Ef5URvJig2Lk0
 INtP92qkk22XOwhvpf3tG7PX8luAjtXM6Ivh8Ezsc73oBrxjYHDFPi4KuMgZcugdbbTgoj4Zz
 R7qDprPddWeiwGlWpFykQoKALkjJpNYcDCoHsHHbSunvx85w0AbqkBJXCD04bkvnASNnNbdR4
 4UppFHVpzhcxHqLvZvRMLGRNtyTovvSj/e3uiqcs/OSiO3t/LBYusfCg9I0gIH/RzbjgEEDHf
 LtRfBZ9YD1l5al1j72ii73uLVdfBVEbLuwZ+Cpt8ONvt6FR7B4kqIIaUh4okaqDI2gHMYQG0E
 g1jvWtbgkvG0DcvsKRfUAf1mLzWf1cxVFhV6YAO8qilHoUeuXDYW6uHGig6y/tyHOngzkXusx
 F3rVLXwGE6d5kap87f9VH0nVZ7Ek91HYMF9/xUVOC0DvodPuwh7gcpZKor6toeA0KWga3XJc5
 4LDljz0TUtjbdfkYC5q1hvBSDdNfFzp1eTG0UXOYSw6s840JTK3QDztaw90kJDTchGyKD58/W
 K0XJz8H5RBtDh+xU8eOg9e2gPipYQriv7IMkFrcqp6my+5YZOMc9zlMk6MA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
with pwmconfig/fancontrol because of the missing hwmon sysfs entry
for actual revolutions per minute. This series adds this feature.

Changes in V5:
- address Guenter's and Robin's comments:
  - use of_property_read_u32 to get pulses-per-revolution
  - call platform_get_irq ealier to avoid glitches on the regulator
  - simplify pwm_fan_attrs_visible

Changes in V4:
- remove copy & paste artifact in dt-binding example
- switch to u64 for rpm calculation
- drop overflow handling and init atomic
- handle 0 not as valid irq
- reduce range of pulses_per_revolution
- handle probe defer of platform_get_irq
- delete timer properly in bail-out path

Changes in V3:
- rename property interrupt-ratio to pulses-per-revolution
  to avoid confusion with interrupt binding
- handle error case pulses-per-revolution = 0
- bail out properly in case we are unable to request the irq

Changes in V2:
- address Guenter's comments:
  - improve description of interrupts
  - use atomic_t to avoid races of the pulse counter
  - measure sample time to make rpm more reliable under load
  - make sysfs entry fan1_input conditional
- add dt-property to define interrupts per fan revolution
- example for fan with RPM support

Stefan Wahren (3):
  dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
  Documentation: pwm-fan: Add description for RPM support
  hwmon: pwm-fan: Add RPM support via external interrupt

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  21 +++-
 Documentation/hwmon/pwm-fan                        |   3 +
 drivers/hwmon/pwm-fan.c                            | 107 ++++++++++++++++++++-
 3 files changed, 126 insertions(+), 5 deletions(-)

-- 
2.7.4


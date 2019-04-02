Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69142084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfDBOWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:22:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:22:47 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.84]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHWvH-1h6bLP0mtV-00DZCU; Tue, 02 Apr 2019 16:22:10 +0200
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
Subject: [PATCH V4 0/3] hwmon: pwm-fan: Add RPM support
Date:   Tue,  2 Apr 2019 16:21:47 +0200
Message-Id: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:u9hpHqCTnUjnd+rhDJ9UACW2puSKMuZuktrfAA77OQYwq3oPND1
 rlPOCpWirycQjRUcb5a0LvuL00eUR+vzUbp3Ix9O6CkilKmJS+fL5XknKuzdO+4btrXueSg
 3uF4A+W72+rOOqBPYM2mR+Mme55GF5El9iSt1xsfeI7u0L/VoL7iz/n4eNedemjUzc4YWmu
 A8bFu0PECp+ngOgntFQRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FKkrdHraerM=:D01GnnNVwY4eOS5y6OLXv6
 jGEXoJXpWYD/cbQor2Zyt39Y+3HvU1v7QPWEW4usdjFcSPozpxWy1soQR4c7aXrPiQI0zGuBP
 9DsPfJHbObTnmZXYbmIjPM5o/ezApxRKTNpPhAHP2UJvb7QoPxWGevXxAMBXMNNcc1ygLjmG6
 AFEEBhJ+boAIkE91gkbj3XNkPqtxnvi7953emmkhPFOosaVXaMohaJwAYYc+gHwfX2EF9yr2b
 TBnYMw6YznJtT0ag66IKXSvxR37RfqJ/dlJPofcZ48Y8HiMozZ8Q3QsMpcgD+NYBmELZKiU3A
 XpiwhT8QmPcW38KHtzw2ERkCRg/jmGHQmQ0isOqeB4mlSVFfNrcOlD7m1EHH1zEfEbkAOU6zO
 5ifhgAfMxwMmlHgtOa+ZY38GY2ND48c7KUMvmhF8XuHbxEkWTnUm5uct1MGoY/v5vEriit4xF
 JGB8ZRUZ+gLEb8gAt9PEf3yPwVGEs0KbyoA9Anq6Zslayi6Mw92xTa1NB9ZZt0pkq2PzHrxsK
 8FZsYcBsDHzmzHNMjzJzdhoWAXbKJqiG+bhezTsL8By2LxXfkT+u4/3MWz9ZTFIVnnaRNV4Zc
 sAiB7zEVxoWUPD8NPD5oVozrMI4fJr9ExXn1UBrv/9qppT3jUJLLSJy28luSXEqLzFQDSHaWu
 HnLQjG7PaZXsTmZUMksMdG1JESSHH46VVIVWSR5WLIXSkDnlj1YY2Sw23sHGIdSXYu8F01ZSR
 9mt2IfAdx75nhOC+uQVdjr+X8NGGfox03yuKAHAAxJmv6/flkFbuHE3h0rQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
with pwmconfig/fancontrol because of the missing hwmon sysfs entry
for actual revolutions per minute. This series adds this feature.

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
 drivers/hwmon/pwm-fan.c                            | 111 ++++++++++++++++++++-
 3 files changed, 130 insertions(+), 5 deletions(-)

-- 
2.7.4


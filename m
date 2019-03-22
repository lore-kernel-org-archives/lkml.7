Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E52C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D3121873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfCVIZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:25:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:25:30 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.35.112]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M91Tq-1h2Hew2DKQ-0069k0; Fri, 22 Mar 2019 09:24:24 +0100
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
Subject: [PATCH V3 0/3] hwmon: pwm-fan: Add RPM support
Date:   Fri, 22 Mar 2019 09:24:00 +0100
Message-Id: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:wHI4PaDmNNvLUCA0YRlKcLYLznYLu1th0lZPCFhA1N1F7ev/uIh
 RSxAHtuFFUvNeYewA/zg1TYq8PmpfeF2CBpvl/glxpkwaFvnLNoEGWV0YiV7dxQe+HHmB24
 SuXc+FuIqUrMqbbDOGJeZ15FvsQFk/Ey5stzh7LFxvHX6akus1lKYszg7WXAYVy/iwGfa1F
 TebBih+CfFjCUOuuwD6Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zj/weAfWClI=:LB244jBP6rzCySyt+0JT+M
 r+iTT1KpSwkHvENIonbRXRNpk67/r01eiH/hutAxJipJWQuw4QiS0aDlv3FQy6u37EZmxOzjY
 gIV5QR7eQhDQwsWzfHubL4grtGi04GLEuuEsiMGXF6/cMhZa+U/+gNb2+RVl2O036nnaQNMCQ
 dGLnxiSIej6GReIKU9ln/3YV2Y+jbXY7/zHCUbAEugxY2xL8OLUhP+3snsF3ViAz/3cUlRYoO
 hoyRzXW4NjAo86rZ4Yz77UtvHMZmv3n6/P/cRoPypvizNbAqBvozsQ5u19OWynaIQQ++iUsWq
 xTIvuBbgK+jF0989MDac1rAeRzn3lAY3NNN64eVr7akF5uL2i4qUPdrPAVXosHKlJrZFf1ENN
 lHNH3lNk6b9NbLwQYT20wa4pmWxdzJVCW4gGc2R1QbhbaC47t/3QiVkK3bJK550tQQdpx5vL6
 S2UwX2uP+4Hhg4fdp+P/NVw/FI4QpPRiIAuIpED4cUgcPLvXLzI+HZUKy+94Tx/vlaUIHKgVL
 vm19aEWoXEvb7Hbf3andgMBkQkhor9zU4Fq6S3sGq8Y6tYfL69fCSNo4opEHZPOhTrfIGyJrd
 RQlgoat9pVPv12FxOsaXmUPjXNs/iqsZSsxcBd36gOfNRqDSQZ9qvKO4D8sYVaQ2+iZCCuBRf
 QHoapvazCS/QDL9DD83oJfH/8n4ldrEDb6aRzkpVqlyQIUGqAZXr9PZK9mq4iDC319LDjw//X
 j6rqovzFginAJPF3sN+bF9kenF2tRi0POuLqTLkCPkBlU/QkRsx9E/H2NsI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
with pwmconfig/fancontrol because of the missing hwmon sysfs entry
for actual revolutions per minute. This series adds this feature.

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

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  22 ++++-
 Documentation/hwmon/pwm-fan                        |   3 +
 drivers/hwmon/pwm-fan.c                            | 100 ++++++++++++++++++++-
 3 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.7.4


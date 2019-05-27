Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F81C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD612075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="1I9NjLgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfE0CpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:45:01 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.109]:20023 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfE0CpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:45:01 -0400
X-Greylist: delayed 1315 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 22:45:00 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id DE6C9400C97FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:23:04 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V5I0hvNue2PzOV5I0hIMfB; Sun, 26 May 2019 21:23:04 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+9yYQvPdqu/4ckQremg+mZtepkUtNgj5O30UnNMkG3w=; b=1I9NjLgfXph4PCH5IRGFnTTpvK
        es0ioV8NiTwRSy91IX4ZqnXxkBBlukmuuES/ui3CNCZgUHkdco+sFkF1vShQNPLGPkWMvVRa/kocC
        JvYMZpd5bUIX829puwT6FbfeZtVshu2u6Ly2SHL4q4IPLUN9RP15ceaXS63O6GFz9VrskIAWuKDce
        IfbQZKlB97ETjyuBOKJbfLO26aFK8kIuzfLUCGEFRN3ZJ+IcwQ639bBCqvnyAzDJEbeys6mGEHLA7
        VV6lB/vI9VbmXsJuMOa1cIGcaMXm/RQQS2Pc0xfd9+//BQBPnlSZvbb4L4Sqn5cdU/kdiGHnBa9Tr
        XzCoEoxQ==;
Received: from [177.34.20.96] (port=57660 helo=castello.castello.in)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV5Hz-003JNX-W4; Sun, 26 May 2019 23:23:04 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Sun, 26 May 2019 23:22:53 -0300
Message-Id: <20190527022258.32748-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV5Hz-003JNX-W4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello.in) [177.34.20.96]:57660
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 13
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree
binding attribute to configure the alert level threshold and check for
changes in SOC and power supply status for send uevents.

Max17040 have a pin for alert host about low level state of charge and
this alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Toradex Colibri iMX7D, with a SparkFun Lipo Fuel Gauge module
based on MAXIM MAX17043.

Thanks Krzysztof and Rob for yours time reviewing it. Let me know what
you think about the fixes.

Krzysztof I added a new patch to the series to check the battery charge up
and clear ALRT bit when the SOC is above alert threshold, so not generating
duplicate interrupts.

Changes since v1:
(Suggested by Krzysztof Kozlowski)
- Put common code from max17040_work and max17040_thread_handler in a function
- Code style fixes
- Define mask and low level threshold alert default
- Check return value from max17040_set_soc_threshold
- Set low level state of charge threshold before IRQ
- CC maintainers from drivers/mfd/max14577
- Use flags from FDT client->flags instead hard coded it
- Mention interrupts on DT Documentation
- Fix "maxim,max77836-battery" missed from DT Documentation
- Fix commit description

Changes since v2:
(Suggested by Krzysztof Kozlowski)
- Fix ebusy exception
- Remove device_init_wakeup from probe, let wakeup-source from DT decide that
- Fix the use of "charger" to fuel-gauge on device tree description
- Clear ALRT bit while setting the SOC threshold
- Check SOC and clear ALRT bit when the SOC are above alert threshold
- Fix unnecessary uevent when SOC is an ERRNO
- Notify user space when power supply status change

(Suggested by Rob Herring)
- Fix the use of "charger" to fuel-gauge on device tree description
- Add the (%) units on the description of property
- Drop interrupt-parent
- Fix name of property to let clear that is a low level SOC alert

Matheus Castello (5):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add low level SOC alert
    threshold
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Clear ALRT bit when the SOC are above
    threshold
  power: supply: max17040: Send uevent in SOC and status change

 .../power/supply/max17040_battery.txt         |  28 ++++
 drivers/power/supply/max17040_battery.c       | 134 +++++++++++++++++-
 2 files changed, 158 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.20.1


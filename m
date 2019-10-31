Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5143CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5F72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 19:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="owWBC3YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfJaTF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:05:29 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.31]:42902 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729542AbfJaTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:05:28 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 15:05:27 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1F45A1026D30
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:41:44 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id QFOBiQ22cPUvSQFOCirqa3; Thu, 31 Oct 2019 13:41:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hqa03vOsorRFXxU8y2ofxcTa3+6apVLKNhZ0+d6Hk5s=; b=owWBC3YOBH6Ib58Jh1NCbdN19r
        Tb5MJR0fTAbeE5E9aMpDf6A1PQDZk0GAdZpJqUfK2VfbnZ7+fTZfu0HqmsnP//GZ7lBlWIzZEqgUu
        AJ8/GVjNe2x3NlwaLYM7PI/G3iI+uRaNRXzrX5Fvgs1FXtIBbDNjAktMhgPEjbebV0iRiSns4gw7p
        IPdg3V2Ft/XOj+sHB986lF2MaOZdHYlg8P/N6R8SuDRZ702b/lLgf1dQ9n6mvKzUlfsQj4y2hoO5U
        +rZ3FCS8edE4/PmsGwqeo4Qr9soFrCYYcJVBo2fjS6HsfRTk8uqSUCNv92Vz2xqOrWkPgN4ZRbWBL
        4oO9OITw==;
Received: from [191.31.195.127] (port=35710 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iQFO9-0035gz-Mi; Thu, 31 Oct 2019 15:41:42 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v4 0/4] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Thu, 31 Oct 2019 15:41:30 -0300
Message-Id: <20191031184134.30621-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.127
X-Source-L: No
X-Exim-ID: 1iQFO9-0035gz-Mi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.195.127]:35710
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree
binding attribute to configure the alert level threshold and check for
changes in SOC and power supply status for send uevents.

Max17043/17044 have a pin for alert host about low level state of charge and
this alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Toradex Colibri iMX7D, with a SparkFun Lipo Fuel Gauge module
based on MAXIM MAX17043.

Thanks Krzysztof for your time reviewing it. Let me know what you think about
the fixes.

Changes since v3:
(Suggested by Krzysztof Kozlowski)
- Validate values of the maxim,alert-low-soc-level early as possible
- Clear the alert bit while handling IRQ
- Remove the "chip->alert_bit"
- Check the SOC and status at the same time on max17040_work
- Add note about the compatible of devices with ALERT feature
- Only set alert register and IRQ when compatible is max77836

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

Matheus Castello (4):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add low level SOC alert
    threshold
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Send uevent in SOC and status change

 .../power/supply/max17040_battery.txt         |  33 +++++
 drivers/power/supply/max17040_battery.c       | 134 +++++++++++++++++-
 2 files changed, 162 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.24.0.rc2


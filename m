Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1325C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687B206D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="fi0H0IiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfKQOiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:38:17 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.187]:26852 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfKQOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:38:17 -0500
X-Greylist: delayed 1344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 09:38:16 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EC2689C4B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 08:13:59 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLJPiP103qNtvWLJPiCr2k; Sun, 17 Nov 2019 08:13:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pf1d0psg4OicB0p6AYwuL4Z2uixARtDFKC8KIILlS4I=; b=fi0H0IiTPcB6x+Ne4JDhttwPb+
        CbcTViSswk2Qof7oMLFgyKaBCl1rjoTaHcI6fxAg5r/VJXvej6uFl/AnmMszv3/kLUtBbBU1NoyN3
        8I3rRbXo8l2ybpItbAv7wZxbm963oevrXw1603HY1UhpZExWg+yrmnvx0QZ0YJ1ISPzF9OZ/K21mO
        EYtbW1Z4VHlAQmZPN5nu8OktSYudBFASfCEkiWfnTuy0KhXB+f/Nbbpfwq1cHnHNV3Qm8pwsNIWOm
        dF0B4s6Qpwm3TNay+1p6GQWLA0G2TBI3zVMUjc+dPnVAUrE9TnE5lwz2tl++4OD/c0CMvwAEaydd4
        20wddm1g==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLJP-001Ad4-0o; Sun, 17 Nov 2019 11:13:59 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Sun, 17 Nov 2019 11:13:30 -0300
Message-Id: <20191117141335.23404-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLJP-001Ad4-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
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

Thanks Krzysztof Kozlowski, Lee Jones and Rob Herring for your time reviewing
it.

Changes since v6:
(Suggested by Lee Jones)
- Use relative paths in documentation

Changes since v5:
(Suggested by Krzysztof Kozlowski)
- Rearrange code and add max17040_enable_alert_irq on patch 1/5
- Remove useless dev_info

Matheus Castello (5):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add DT bindings for max17040
    fuel gauge
  devicetree: mfd: max14577: Add reference to max14040_battery.txt
    descriptions
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Send uevent in SOC and status change

 .../devicetree/bindings/mfd/max14577.txt      |   2 +
 .../power/supply/max17040_battery.txt         |  33 ++++
 drivers/power/supply/max17040_battery.c       | 141 +++++++++++++++++-
 3 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.24.0.rc2


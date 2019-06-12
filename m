Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A61EC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3339A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNy5kaOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfFLQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:28:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36392 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfFLQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:28:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so4081324pfl.3;
        Wed, 12 Jun 2019 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/637Q6mpGunbWTAeL4j92iIRZqh/BthAxQ35Wp87uVo=;
        b=kNy5kaOzUSULBLa2qpUzpPcKl9RFuSXoIoKo4YGwkexxHVmH7oVF+JRzf/aXzjmedx
         wgLvedExBw5Y/CiYz5LCXINEWiyH52vC7JBcpT2VTz5o79G12beH25AjyR6zLj5rdA0N
         PmI9m8JbXr9lVOMew+i8MVa39wlPpxGIXT8skMLPsvBWbNCx0cWvbdR3RI+EZcx3tOlR
         j+w0hgzFtY+qTJVKaZ24eYjvCoI1m9YCNAbPm6CuRK+UW4w/zWy3Vj1BRq7hLNyrsLlT
         sfR1Jxa3Bu6HR5XBTGziok1krxisyYpPyaUNt2EaGN/J9CdYVmgKKvS7obCU2x3jR+pk
         iW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/637Q6mpGunbWTAeL4j92iIRZqh/BthAxQ35Wp87uVo=;
        b=QYzl2YnIXCrazxGJN/pgmx969KmA0+Jzqr0M0F8zgitXwp4OmOTWbGHIjwhkbn6fsR
         nglpjyMa/eOwslFbjEhwu2dAdzFKAA3koF60EEOZr06pwqgXEeDdGUkBcLQWcPKcLgeY
         ZKShH0Ib3FIgORfPcryuZYyTfJ56f/cUrR6tsANjHKI5jh/VyMkB3bQTxCX1HYAV8FgC
         KQffC1kr8CetOwhGMyj30Y47617P44wr14OpOS3p6MDKnpdh9X1tw1yLCQ/6vrtbp/Vb
         ySCYhLeZlM0om8tVoo3W8v34yX7NgS9twPzQleQ2JlJ7HmVwYk0pTyxj+4TclalndC+Z
         dS0A==
X-Gm-Message-State: APjAAAV55F/sgR2OVZ4EQ9rZ5Fg5isi44RJbfXnb5p499E+LWUQiBMQ/
        7zisbzc5KQE7lqtR5tFX3kE=
X-Google-Smtp-Source: APXvYqzmt51QG675QIk4A/SHIYXjiiU69ZTW95jyerlieuhn1HcqSs1SkgZqH1PrPgv+PJHvJ+J6tQ==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr80503pjh.58.1560356906597;
        Wed, 12 Jun 2019 09:28:26 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 201sm70084pfz.24.2019.06.12.09.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:28:25 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND, PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Wed, 12 Jun 2019 12:28:14 -0400
Message-Id: <20190612162816.31713-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sun50i nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points

 .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  12 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
 6 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c

---
v4:
-Remove sunxi_cpufreq_soc_data structure for now.
-Convert to less generic name.
-Update soc_bin xlate.
v3:
-update changelog and title
-convert compatibles to allwinner,cpu-operating-points-v2
-document the valid names for opp-microvolt-<name>
v2:
-update changelog
-convert to dev_pm_opp_set_prop_name instead of
 dev_pm_opp_set_supported_hw
-some change in OPP Node  
--- 
2.17.0


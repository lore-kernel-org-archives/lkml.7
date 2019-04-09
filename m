Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33ECC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C7B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR+W9FF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDIR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:26:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45557 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDIR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:26:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so10092688pfi.12;
        Tue, 09 Apr 2019 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2OPzDwOe7I+UnNSxlX5RL4h6AHbqcWSwv2DhZC078Jw=;
        b=uR+W9FF4/Rg4RzQuHf+07C5aW4QXNJi4CuEpLlGsB3GRMSkG4vHqsRMfZ0t/rB3ulw
         iLrXRHMXCpdEPsrWvSHKyN4SWpvGNy3EKPn8oFkDuN/WHwrqCvCZBjfSYzk1A5iblOGK
         76zYYsKy3dUV9v40WAJLOawqFa0IJN90Ly0/8QHVDse/1kU9uraDf/Va1S2No51sAj3H
         43DNzY7kRuvIckHH6bG1UN11tsTbPhcI5Tj2Tmtzvv/eSSvxO1yyP7cAWVyvOKCq4nc2
         89/s1vYQ3YZQCgyPuFe1hCW4z8u2QzCQjM0opgohwogbXKGFwA2/H3M0XDrpFXHYsT4o
         Vvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2OPzDwOe7I+UnNSxlX5RL4h6AHbqcWSwv2DhZC078Jw=;
        b=NGJ24rwsyHn2LG9KlDAq5AESmwG97Fna0kuRzso/DNZxtV/nhXc++K8gWtOUlovB/p
         BkDtbK4F71HIsCg6miu9Bd3Yu3qVISz8miyVCIaBhGvSPfLIrzwEcg4R7jRTgCu4tsNB
         86x1iYqv2NltGzkPZexwaAUJpGYa3gpUaR7ysiGPorFShhbtpbf7vQvkSi14FRaWmOIr
         oEfl9/Hk/ENGd7Ia8N/ffnI0+gNqTkDWyXUhHPb+X9LEEEjHmSVMBwPalH6mWhOOAKQy
         CI52c6ro9IOuoBvTE07yuVsBh50RJED27H6ZH1ubLygxU8P0vavaAzECxMjzqZl1F6O9
         /TuA==
X-Gm-Message-State: APjAAAWPBwwZJGWvMDursuFWPKWfQoowxxdIE3+ZLmcB602umjrZT7l/
        q7qc4+z8vqsvfflnF3nDfnsGtryFBrE=
X-Google-Smtp-Source: APXvYqxtg3Eugmatg8OYWhdBA2qBSJZvTrXbtIXDQQUzLNVk3FhZRvnz6SKW7593A5zaeSeSmbJYvQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr36565491pgh.263.1554830763853;
        Tue, 09 Apr 2019 10:26:03 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l10sm23922205pfc.46.2019.04.09.10.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 10:26:02 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Tue,  9 Apr 2019 13:25:56 -0400
Message-Id: <20190409172558.18778-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sunxi nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu

 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 +++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  10 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sunxi-cpufreq-nvmem.c         | 234 ++++++++++++++++++
 6 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c

---
v2:
-update changelog
-convert to dev_pm_opp_set_prop_name use instead of dev_pm_opp_set_supported_hw
-some change in OPP Node 
---
2.17.0


Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA3AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E8520833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXcFDWVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfDURt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:49:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43602 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDURtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:49:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so4643086pfd.10;
        Sun, 21 Apr 2019 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a4OYel+MPHwPZSgfhXLKRg7cQA7lfi9yrXmzwAEuXU=;
        b=gXcFDWVKIanymZygp++olJ9Ke5RljhPaJi3gl8qEkfX9QaTN+Af9EMrIlCS6MZm9GC
         z1IMPH4aivgerIcpNyYLubAoYknKnkBM9pqAVQFt9pKHbB+98rEVi+hlHPz4hpxiyu2w
         DvybEXqOiwmBisbPeXnwLi/eP93ObKeD/0huZ9HYAS6w9VthE8xI1zgZUAxPeTWJ36Td
         tSjvfhwuk7SjG55xeDWUHSqnNtQlTYaAcoDkEkDx03qHFchcVGOCpDaFW/cKJnTal2Ef
         5fE1YAFZs/hYfc8ivVZFIqpqvZrxMHzCpG+lprn7/OMFI4BV7ApQ0lsHW+AxqITXGRx4
         ih8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a4OYel+MPHwPZSgfhXLKRg7cQA7lfi9yrXmzwAEuXU=;
        b=PN1Kc1q/WoC87tT4mtIa6t1hY2VWvKVrSCX9FlLFAG48PunIMtp4I49zY7okPmGPYs
         9Rr0j88poeIa8R6KMjYwYqKIOoCB4tAzVvffUHqhbFsMsAb8GS+C75A6rVuhsDlF4195
         Txvu91QUl1jHQdgeygrpXpIrfIGBUKxKj6aZR6cK8qG6inNlWT5U30wj7RNidB7ojZCF
         7vMPSs+3zkU2xvZVd7c+mpUgBg2tue36ZOBz5GXu7hSJysgt9p2/taq1D57W5LX0QDdr
         zehcsPDmga0c+dg9HjPp0qGuT0V8wFpn8oUBRDcvylgiO88rUajQ7VdSxUQad4WnmpuR
         uKTw==
X-Gm-Message-State: APjAAAVYsOQ81ZnP2EkTrIJs7mZkezzH3oY8nhUBt2yaOXqUIh58lH8l
        9UG7+vYk8a2w8YwFOUEdYgk=
X-Google-Smtp-Source: APXvYqwMGHxwe1zLjyklHd/KmXG3QogK/++Vgu5uS4Wy9+6ZjyZFQIApTBDRqwfRBzolAxcxrZTPQA==
X-Received: by 2002:a65:4247:: with SMTP id d7mr14830824pgq.114.1555868959009;
        Sun, 21 Apr 2019 10:49:19 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g63sm16279233pfc.127.2019.04.21.10.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 10:49:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Add support for Maxim 77663 MFD
Date:   Sun, 21 Apr 2019 20:48:29 +0300
Message-Id: <20190421174834.9366-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the Maxim 77663 chip that provides PMIC, RTC,
GPIO and watchdog timer functionality. The hardware is very similar to the
Maxim 77620/20024 hardware units that are already supported by the kernel,
hence we will reuse the existing drivers for 77663. The GPIO, regulator,
RTC and watchdog timer functionality was tested on a Nexus 7 tablet that
has the Max77663 chip, everything is working perfectly fine. I'm looking
at upstreaming support for that tablet device and Max77663 is one of the
core components that are currently missing in the upstream kernel.

Dmitry Osipenko (5):
  mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
  mfd: max77620: Support Maxim 77663
  regulator: max77620: Support Maxim 77663
  dt-bindings: mfd: max77620: Add compatible for Maxim 77663
  mfd: max77620: Support device-tree properly

 .../devicetree/bindings/mfd/max77620.txt      |  4 +-
 drivers/mfd/max77620.c                        | 99 +++++++++++++++++--
 drivers/regulator/max77620-regulator.c        | 26 ++++-
 include/linux/mfd/max77620.h                  |  5 +-
 4 files changed, 123 insertions(+), 11 deletions(-)

-- 
2.21.0


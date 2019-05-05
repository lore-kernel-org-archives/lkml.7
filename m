Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7AC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4637C208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5ljalxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfEEPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:48:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45586 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id w12so8990985ljh.12;
        Sun, 05 May 2019 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlEG9NIkB+2QxScurVzvzhb4UAYd8wqCw9tKjxEGmJQ=;
        b=Z5ljalxiS8q/cLjSGutusocESg6ENqIF3poRf0yJOfDEkDl0ZBxIYovnL4Wb9CwcUp
         o7LMaEE14rnCOzLnDCIjefX6rQWpgp76lRN9yFZ9072J/5AdRhvRx2O4Z9+M2sXccDjC
         7SNgfPR0iXoQVd392+b17D02toIX3hnYof0/m6HZD037jav3zl6/VtyJA1zC2GkDSnUX
         bnpxSnBlg5LMveEg+GBdwhtfmfAApRxc8JhGFPUvr47YlP9/UQCE9H8n93yb2C8m6Y1V
         mmMbNRF134Zjoms6dU/4NzZ/kqZhMwnveZRKrqrdJhjD4PotyPRGHJ0kYkJwxD6KFRPW
         +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlEG9NIkB+2QxScurVzvzhb4UAYd8wqCw9tKjxEGmJQ=;
        b=nYpnJyjDAuYTif36J7PNQn8TM9LEjdRDtShfizeatSTPLKCIMZbNTzaCqnwDexzv+C
         OjhXxaiD1TBYY1QZttoJmt4mdu7bWdy5bRLXnjqdYnLntP3BnQU+fZolXYtIyJKLwsPn
         J8IeEoig3j8e3OobVRSHyX4sVYxImV1g+F2sqILHu75JGeq8EYom2oEJZ2EVP5CNXERD
         AQK7tlXr1VQIV5AAoAHcwpmGaFEDyMUaoBvx3rJY4VsoJFz0NM2jpcKLLDgqQ4CvG/H4
         sDt9iZpwfDQGnz4y24LNx7iE6rzLpl9Ab0JyrBbQMmc950cfpaaSHM6NF2vfcJ+HsJOh
         TjZA==
X-Gm-Message-State: APjAAAVRuKiPirSHiaNh7NU4wzKKUWOysGQ21htrNA8WR4lkiGTyVhVF
        QqBxz21fLYqccWZNEW+aWSk=
X-Google-Smtp-Source: APXvYqxgEFFvRre94LLBuNrR+odXfimmP7OXvMOrD2Vr34gtNHuQQ0eq3glKVrQd9gHS4vmGxltDgg==
X-Received: by 2002:a2e:9002:: with SMTP id h2mr3205865ljg.164.1557071311388;
        Sun, 05 May 2019 08:48:31 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:30 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Add support for Maxim 77663 MFD
Date:   Sun,  5 May 2019 18:43:19 +0300
Message-Id: <20190505154325.30026-1-digetx@gmail.com>
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

Changelog:

v4: Addressed review comments from Rob Herring to v3 by making use of
    generic "system-power-controller" property and making couple other
    minor cosmetic changes. Added Mark's Brown a-b to the regulator-patch.

v3: Dropped "Support device-tree properly" patch since turned out that
    I2C core takes care of the device-tree matching and I wasn't aware of
    it.

v2: Added PINCTRL sub-device to Max77663 MFD as it looks compatible with
    77620.

    Added new "maxim,system-power-controller" OF property.

    Patch "Support device-tree properly" now doesn't remove driver's
    "id_table" since potentially it could have some use in the downstream
    kernel forks and it doesn't hurt to keep it around.

Dmitry Osipenko (6):
  dt-bindings: mfd: max77620: Add compatible for Maxim 77663
  dt-bindings: mfd: max77620: Add system-power-controller property
  mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
  mfd: max77620: Support Maxim 77663
  mfd: max77620: Provide system power-off functionality
  regulator: max77620: Support Maxim 77663

 .../devicetree/bindings/mfd/max77620.txt      |  9 +-
 drivers/mfd/max77620.c                        | 87 ++++++++++++++++++-
 drivers/regulator/max77620-regulator.c        | 26 +++++-
 include/linux/mfd/max77620.h                  |  5 +-
 4 files changed, 122 insertions(+), 5 deletions(-)

-- 
2.21.0


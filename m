Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23948C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC85520650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHF7mD5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbfJOOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:51:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfJOOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:51:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so14797046wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoLI6uxqNutCvB1E5NYLK0N5G2eYt5SdmA96QNH7WAk=;
        b=EHF7mD5NCAVyiwZ06oKRXxO8ZP2vDGlLT3SaNy3jgx2+xHAWyLBc91gSjOUs1HfW/+
         uuDkFQengYvCKjUSPOXfufZBidobXJTUHzg9cOKZ8uWAr0mFjylHg1vJaLLvuN/rFpa6
         YYx2aLELiG4kFhhtEvZa7g1euP2mzJJoacgmLNBiIWpAXv5Os9sT8GN0hwNf3JSmMm+P
         Pup6WfzbJWH/uEqYIJvlqjmqjFitArYQcwDw1TZKiWCkPvHxzsgG4NfLrG+CcQUQ2mNf
         Nmx+A4BMzLe+3yLVkLErpmmso0TgyrQL62nqLcOHVtaPVlkXiNerqICyvsCdFNxCkggx
         3ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoLI6uxqNutCvB1E5NYLK0N5G2eYt5SdmA96QNH7WAk=;
        b=XKRu55dPu49JPvEjv44Cr3MouvDG6czPKfExP1Ij1omtYleWU8BFJ1irKeQwzTovMe
         DZxmLvdZNSPIUW2YLOxrzFXS+r6aPd137w/JH+rcP5wrDsM7p7IMazuLHEJBMYP3SVxd
         JI7F5W5Q6D4F9RYdmBT3xW5SGcaqGwbMEm6RTHD90IbxC3wDaRY0GOwb/67y35sdgzOI
         VFsPH49pPHxONi4lOYg8oKTd3rrufda5x6hvRI58D50Q4GG+JmFxX0OBtzaKIhUsxHS3
         n7BoA0JOwVjK7pF5dMP22IAG7+yNBB4scEGtDdDJk177vIA51+LVON6KnnaCVS6cEIOw
         VjLA==
X-Gm-Message-State: APjAAAX1lZIO9A0ucEzovsENwnSHt6ppB0fdFq+CfpZ6MmceWe+OdCpC
        gJdUAND0nWlo4LDeTxrJaiM=
X-Google-Smtp-Source: APXvYqw0NwqbXq2J1uiXVlbRjhIaOLcqGzUMa9l6dQT7jR59OUq6/cFTa/H6xdWVej7rCvwaX+Sy4A==
X-Received: by 2002:a5d:5451:: with SMTP id w17mr31546117wrv.183.1571151110542;
        Tue, 15 Oct 2019 07:51:50 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id o19sm27425286wmh.27.2019.10.15.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:51:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ARM/arm64: arm_pm_restart removal
Date:   Tue, 15 Oct 2019 16:51:41 +0200
Message-Id: <20191015145147.1106247-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi Russell, ARM SoC maintainers,

here's the full set of patches that remove arm_pm_restart as discussed
earlier. There's some background on the series in this thread:

	https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/

I also have a set of patches that build on top of this and try to add
something slightly more formal by adding a power/reset framework that
driver can register with. If we can get this series merged, I'll find
some time to refresh those patches and send out for review again.

Thierry

Guenter Roeck (6):
  ARM: prima2: Register with kernel restart handler
  ARM: xen: Register with kernel restart handler
  drivers: firmware: psci: Register with kernel restart handler
  ARM: Register with kernel restart handler
  ARM64: Remove arm_pm_restart()
  ARM: Remove arm_pm_restart()

 arch/arm/include/asm/system_misc.h   |  1 -
 arch/arm/kernel/reboot.c             |  6 +-----
 arch/arm/kernel/setup.c              | 20 ++++++++++++++++++--
 arch/arm/mach-prima2/rstc.c          | 11 +++++++++--
 arch/arm/xen/enlighten.c             | 12 ++++++++++--
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/kernel/process.c          |  7 +------
 drivers/firmware/psci/psci.c         | 12 ++++++++++--
 8 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.23.0


Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FD6214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383142;
	bh=U96cZagmbCkN7R1eK0pRJ3y3+87rAh1edE3u8Bb4/Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKRhCJ8qUWhpATV17eZjPB8M5QNIvpz+WgoQOu7lz8HqRCWA6A53YFr5gcggAuWQC
	 YxH9J52xuaVT/CZKc9tR967AOg1iulAMP3r/iIaE55sKIA6NEjkH4/xx+RlFcqgiyS
	 FPwq9Pz1PnOXjLws+b7yXFOmvaR7wVtz+qOaqpc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfJFRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfJFRcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:32:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9B92080F;
        Sun,  6 Oct 2019 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383138;
        bh=U96cZagmbCkN7R1eK0pRJ3y3+87rAh1edE3u8Bb4/Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiLzthYdInfxvY/Y+dy0vDCF3NI3yzsT0CgKn4QVrss1USiSuCkVOv6PEbsZwo4Ne
         jWVqpH9Cxqt2wcpxDvrEDBdcaIGuwX7pCyormlfQ0cOT5/X0PR5kmjojuLgMNzw0BS
         p9QVhbxKXQsWQ4of7SNwGm0U5TKVuZot7g8D3+Jc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/106] soundwire: fix regmap dependencies and align with other serial links
Date:   Sun,  6 Oct 2019 19:21:47 +0200
Message-Id: <20191006171203.501329692@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 8676b3ca4673517650fd509d7fa586aff87b3c28 ]

The existing code has a mixed select/depend usage which makes no sense.

config SOUNDWIRE_BUS
       tristate
       select REGMAP_SOUNDWIRE

config REGMAP_SOUNDWIRE
        tristate
        depends on SOUNDWIRE_BUS

Let's remove one layer of Kconfig definitions and align with the
solutions used by all other serial links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190718230215.18675-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/Kconfig | 2 +-
 drivers/soundwire/Kconfig   | 7 +------
 drivers/soundwire/Makefile  | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61ee..8cd2ac650b505 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,7 @@ config REGMAP_IRQ
 
 config REGMAP_SOUNDWIRE
 	tristate
-	depends on SOUNDWIRE_BUS
+	depends on SOUNDWIRE
 
 config REGMAP_SCCB
 	tristate
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 84876a74874fb..1ba1556f19878 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig SOUNDWIRE
-	bool "SoundWire support"
+	tristate "SoundWire support"
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
@@ -16,17 +16,12 @@ if SOUNDWIRE
 
 comment "SoundWire Devices"
 
-config SOUNDWIRE_BUS
-	tristate
-	select REGMAP_SOUNDWIRE
-
 config SOUNDWIRE_CADENCE
 	tristate
 
 config SOUNDWIRE_INTEL
 	tristate "Intel SoundWire Master driver"
 	select SOUNDWIRE_CADENCE
-	select SOUNDWIRE_BUS
 	depends on X86 && ACPI && SND_SOC
 	---help---
 	  SoundWire Intel Master driver.
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 5817beaca0e1f..1e2c00163142e 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,7 +4,7 @@
 
 #Bus Objs
 soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
-obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
+obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
-- 
2.20.1




Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C8CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEAE20833
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="cBGFQ57s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfK2IzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:55:19 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25857 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2IzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:55:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575017651; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aHQGL27AFyIrx+4oOxuaIqQQQ05SYfgXcvBgDPo74I4GtjesLSMcmmSf98E4hz0E8fSu2z7kqUVejs8NL3zHAW0a7gU3S7shqull0lJlOaFeg4QiWfxs32e1UkqeGrt+LdQbQ/V2I+V9B0dlztkZBEwBt2rZK8fdvE1Zk5LRiXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575017651; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=1hGPrm+p5zUCh8vVbV4PGe97UQ4RnYIUCs3Zs7VaTEA=; 
        b=eyAQlfXg11rewE0YRYgPP0SRA+Znw3khgFYEWhREQsg5kW4qcEF/162fNN0dDCCPZCkjAOkvrZEtSdcg3AsqsPwLIuF+6vCzs9hisj4To48ancE5xeOzyM6UWX11FjkoYLSCRONdT2tIqRqebKuTv7gEZuY1fYYcMYWQ1TDZGLo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=JOkHCOHculHLpgRfs0cQ+GrhUZ6ZNVMhPKMrEMY9S1OFzi8T3JaB/la396AWgcR0vSPX1hg2A4/t
    vkKWJUOv9ljPKin4glgH++3MSNLieW1c0/8zvcGfgfnDd/nQgO0O  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1575017651;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=1hGPrm+p5zUCh8vVbV4PGe97UQ4RnYIUCs3Zs7VaTEA=;
        b=cBGFQ57soBFWmCZPK1RiYIEn9CJ3aKspL4ueR2PYYkql0kl14d65Wx3TO0UVdLxZ
        m1L3qLC4VZ0QSJSDB0mfZjMiebvEz7UQTiQwkNscUfGtPJfR/U7lHSrujMT2Vv7ah31
        1kwSKTulP8+JC1zARaOS+kcRvNY11cSbbg4ExmGw=
Received: from zhouyanjie-virtual-machine.localdomain (139.207.146.46 [139.207.146.46]) by mx.zohomail.com
        with SMTPS id 1575017648817736.2370865952828; Fri, 29 Nov 2019 00:54:08 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, syq@debian.org, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: [PATCH v6 10/12] MIPS: CU1000: Update defconfig for rtc.
Date:   Fri, 29 Nov 2019 16:48:51 +0800
Message-Id: <1575017333-29020-11-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
References: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selected rtc support by default.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---

Notes:
    v5:
    New patch.
    
    v5->v6:
    No change.

 arch/mips/configs/cu1000-neo_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index eef0c5a..b2c090a 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -63,6 +63,8 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_JZ4740=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_JZ4740=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_JZ4780=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.7.4



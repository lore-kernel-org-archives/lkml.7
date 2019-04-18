Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECDA21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611029;
	bh=B5wjE0fDvV7Yv2yh3z7E95r+xY00wV1XeD52730xahs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eF8zrHL6XxOCayeQVY9wzBbksYu8m6S86o1eD5Cm5kO78odxbwl+40ajsn4He5i34
	 7o2XRqlS9HazTCQJDdouwrVG6dVFZrJjfSfTffJ+btdI5yOSjSrOBnQtcTsHg8BrL6
	 lyOw/o58Ge13M/nFNaPF6Yfy3dyzSjr8wo97jwjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbfDRSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404119AbfDRSKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E66A20675;
        Thu, 18 Apr 2019 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611023;
        bh=B5wjE0fDvV7Yv2yh3z7E95r+xY00wV1XeD52730xahs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1+1tWcPpiuIoIYvLihnuGo03iXd8ovJZA/oei21XMHQyC3lw66bBdp8QgGoCWA2J
         VbLfpeu++skkKY/2XNXX2Mz9k3ofAU+I3j/iMo/owPEY2cmP6rC0MZxP5BJH/jKf9V
         Pz3rP+Fyh52yFOn3phbVMMcp/7Z3MhowufOQ1J/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Eric Bohlman <ericbohlman@gmail.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paul.burton@mips.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 06/93] mips: bcm47xx: Enable USB power on Netgear WNDR3400v2
Date:   Thu, 18 Apr 2019 19:56:44 +0200
Message-Id: <20190418160437.684867203@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cdb8faa00e3fcdd0ad10add743516d616dc7d38e ]

Eric has reported on OpenWrt's bug tracking system[1], that he's not
able to use USB devices on his WNDR3400v2 device after the boot, until
he turns on GPIO #21 manually through sysfs.

1. https://bugs.openwrt.org/index.php?do=details&task_id=2170

Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Eric Bohlman <ericbohlman@gmail.com>
Tested-by: Eric Bohlman <ericbohlman@gmail.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/bcm47xx/workarounds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 46eddbec8d9f..0ab95dd431b3 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -24,6 +24,7 @@ void __init bcm47xx_workarounds(void)
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
 		bcm47xx_workarounds_enable_usb_power(12);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400V2:
 	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
 		bcm47xx_workarounds_enable_usb_power(21);
 		break;
-- 
2.19.1




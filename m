Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055DF21D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642167;
	bh=6w5Mp700T+oUr+mAfo2QJAurvqTx7c9BUWomuOfLvjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rcB1Gr0nCrhkMrmG/9BcakOv1fz2EqRXNLCqIo+Mdgnolmj/phcReCFcfJJDBJl6q
	 Yclts9AkZBbyBkLConEhFOLz2TT5GhilA2fILsyO6lWNh59B6Bl27O1XgCnea4k+ak
	 QWo2NEev6aPV/RFE2knz/b1dUPB4XJYAjyzpn/3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfL2R4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733013AbfL2Rz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D3B206DB;
        Sun, 29 Dec 2019 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642156;
        bh=6w5Mp700T+oUr+mAfo2QJAurvqTx7c9BUWomuOfLvjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCciJXhxUNzneDOWxEExJRhye+7fD5MrEHctdnYwmQtqeQ8nKtvO6YVcak9RBNNE5
         lAQTPixfhKbLv4DvN3LtqPiFNYeD/8ZburVNENz4O8npIfGURSXvuH00BQ9SP4GiZm
         Lvw9p3qSs5W7EdYxl8WIh7SpyrZRWyo3RGFG8IAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 328/434] firmware_loader: Fix labels with comma for builtin firmware
Date:   Sun, 29 Dec 2019 18:26:21 +0100
Message-Id: <20191229172723.757283624@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 553671b7685972ca671da5f71cf6414b54376e13 ]

Some firmware images contain a comma, such as:
EXTRA_FIRMWARE "brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt"
as Broadcom firmware simply tags the device tree compatible
string at the end of the firmware parameter file. And the
compatible string contains a comma.

This doesn't play well with gas:

drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S: Assembler messages:
drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:4: Error: bad instruction `_fw_brcm_brcmfmac4334_sdio_samsung,gt_s7710_txt_bin:'
drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:9: Error: bad instruction `_fw_brcm_brcmfmac4334_sdio_samsung,gt_s7710_txt_name:'
drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.S:15: Error: can't resolve `.rodata' {.rodata section} - `_fw_brcm_brcmfmac4334_sdio_samsung' {*UND* section}
make[6]: *** [../scripts/Makefile.build:357: drivers/base/firmware_loader/builtin/brcm/brcmfmac4334-sdio.samsung,gt-s7710.txt.gen.o] Error 1

We need to get rid of the comma from the labels used by the
assembly stub generator.

Replacing a comma using GNU Make subst requires a helper
variable.

Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191115225911.3260-1-linus.walleij@linaro.org
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/firmware_loader/builtin/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 37e5ae387400..4a66888e7253 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -8,7 +8,8 @@ fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 obj-y  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
-FWSTR     = $(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME))))
+comma     := ,
+FWSTR     = $(subst $(comma),_,$(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME)))))
 ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
 ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
 PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
-- 
2.20.1




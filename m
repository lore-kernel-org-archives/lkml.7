Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C192077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012606;
	bh=1zQHsGBrev9QP8tnF9w/5wOy0Q/cMgTS6Va4wZVBeDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSEQsH8BWhkqYpzVo18v6gCI5IDu+cQINPO1r8j1ALjEoXv0ax0R+n3s//JXttAvx
	 hBwkRjqWi5Y40h9wiQWmHnt9iPTdW+aDb3fx1FgehXCFTccuflSJmPoMn4gRmUipfk
	 3ZiZWCiIvhtKqSWg8VaCeMynR+FhM6S3oyfRv4Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfLJVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfLJVNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5ED2077B;
        Tue, 10 Dec 2019 21:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012388;
        bh=1zQHsGBrev9QP8tnF9w/5wOy0Q/cMgTS6Va4wZVBeDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/40luGqJdYJtThwxsod3E0wWaenqxp0oKTc5/wi1seKKMG9Cmg7RRUU+wmJ29HWP
         V6FfRAZzWD3MSG7oDXvM7XJw96Toiq8Q1h03A0M1bPzv3/qJYX0srZnNE66t3vA2Gb
         J82jqkms42c08iOZjYz5BYWARvTcvhLXsqYOVag8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 310/350] firmware_loader: Fix labels with comma for builtin firmware
Date:   Tue, 10 Dec 2019 16:06:55 -0500
Message-Id: <20191210210735.9077-271-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 37e5ae387400a..4a66888e7253d 100644
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


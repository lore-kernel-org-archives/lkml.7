Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EADFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2B920733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNpKcK36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOW7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:59:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44850 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKOW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:59:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so12324480ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBmbrDGGUNK2PSi8Bx8VXe1x5gi+GmXOPHBLYTXbcxE=;
        b=yNpKcK36NBDESa30v3iWE90W/v1jImyLysC2A7Xfx9DtVdQo/TzCz5a1mFif/k7wIT
         kjEKnlT2rlzSdHIt1YK28dvnrraEHDulZhRB6aWCkd6a3g7lQMd4YJ5boj4DB+PdDGWK
         srCkSJ5pX6Jl87Iqt6Dt7Rk4m3mG9zVZwN9fkmBR6cZqOdMm32Ys3R+RwqL2VgfDyvhx
         XUYyklWda26Br2wAav+sKNFI259M3aJpBzug/PdbpF/qeSuOK7ogGGiHrd1nyFUpq9bV
         qf/spFXoflrD1nvqij4dxDahCgPhWKTGCm/oxe4WgrV9LvHmCaxsDyOV0f6YQfgqp0b8
         baxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBmbrDGGUNK2PSi8Bx8VXe1x5gi+GmXOPHBLYTXbcxE=;
        b=Yzlc/LOqmHEwMyJh24+yRgaoRpiPpLwR0TArRPoluEzJeLNnLHOIJKfiBO5TJ73Jo+
         9pV36L/NojZRjxZV3gQjrw9/+SirkTxmcxIWZ+gFXhtmedctG0NHf1T0Lg1ORxywbS6T
         g9zG3mnAa0JfCamZu7ChWDX0G39/VQxWhJXOXR11rCPOsE09/qqq0K3kR7Tod1BTu/BD
         2SA1Sey5rMDXJIUUGTNWlkKq47BO+0uz0jEeBttlB21Dy3NQq2tCCQvE77sySTTCYLoS
         YC7m5tjwkLaZWKidQHQIJBgPwhoyQxsP2NBvH4XFWR+eEsSRgOECNsQ0sTu8l4w0ww15
         XPKg==
X-Gm-Message-State: APjAAAWbgSiHaf3/3Sv0tSnYIeGuFfoM2wQMR/7KBnhDscjG4k7hopo+
        J6/SPFAt2QIEzzj/zV+0mThFpQ==
X-Google-Smtp-Source: APXvYqy8PxRdvDMTC4TAwcYm5z/n+GQ/j09ttLML2rkOcXkEOQMIvvgsO7cSKCzHA+rjMw6JCJBMvw==
X-Received: by 2002:a05:651c:1196:: with SMTP id w22mr13064971ljo.217.1573858778674;
        Fri, 15 Nov 2019 14:59:38 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id p193sm6519119lfa.18.2019.11.15.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:59:37 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] firmware_loader: Fix labels with comma for builtin firmware
Date:   Fri, 15 Nov 2019 23:59:11 +0100
Message-Id: <20191115225911.3260-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.21.0


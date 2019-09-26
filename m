Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0120C352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86979222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6e5ZgDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfIZTbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:31:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:31:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so126630ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8nKiwxqvEVkSC8bjnHhL2rSKeHZeY+99QwUiS0BzNY=;
        b=x6e5ZgDDdZyxGUBJfhfmqswAYXEyDmuPKFoVH2fpMRnIDRkVbvE/k+nQyZyoyOtZ1y
         iq2BS34ltXtkhNncT5YWLrq2rdDBGE99wix6R0bQxgbpvSYJtqjrJPpKvHlPvC1K3AK8
         M+9J0nzpvH2fOuP8fSyFsuaSTtRiPhZ/36EmbWzIQLUJp6XIj+CZ0meDo6VBumXdGxay
         aTg3YNYBTZHF2MLJBqKgAYilmPDLGYtRMliMrhUJLPuUuKBENWlM6MMQLapW8k3c6cZL
         Ls+vEIhE61K4r90KjOP3iLXvDNKA1otUNHa1I5avo4FHvKfhjp5jWgl57dxTrtaWBSIL
         MDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8nKiwxqvEVkSC8bjnHhL2rSKeHZeY+99QwUiS0BzNY=;
        b=qYq5Du64W3rj3rbgEL9u3QxaJcmJNQxfzaLrPvGzX0yQKlQY9hA1KDY92lMdsyp71E
         2k4YcBdnxULFl3YE7h8yAVYOO66o249uZzsf6QTJSocbnOsxRlR6wRIIhU7zU8bgqv+L
         bPYfb7bHwRsflXLvXgKTsiuWfZsqqYZT5ZiFXlRKZk2X/YLNZn/7iNg4ksxShV7oF/G4
         Ul7TdU9uI6ZW1Ccoypvtk+176n0oxQHEtfPdpu894YBlLGaLOi1HhuRTnYCx8lmsv4oo
         B5uYVfI4dAoi0xSLLda+//ziAn/8Kwu3PfxfZRZYErSwQCFsc2g9rlACwLtCgGbGqsbk
         MAxA==
X-Gm-Message-State: APjAAAUFKNEjbGsoIKv/QnKlcRm/SU//202BTIis7ePl6YLio/Ojj9Tg
        EgxspJGnKaZancZHkpsvQgJsDg==
X-Google-Smtp-Source: APXvYqyPCLciNb7qX4Zjm7aNczaVgDK+J+9vmAw3bKwlSiQhmh0siXn6ZKwOs2oTn76/1DnH4277HA==
X-Received: by 2002:a2e:7d0d:: with SMTP id y13mr213314ljc.170.1569526262671;
        Thu, 26 Sep 2019 12:31:02 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id c16sm31923lfj.8.2019.09.26.12.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:31:01 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] arm64: configs: unset CMDLINE_FORCE
Date:   Thu, 26 Sep 2019 21:30:29 +0200
Message-Id: <20190926193030.5843-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926193030.5843-1-anders.roxell@linaro.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
CONFIG_CMDLINE_FORCE gets enabled. Which forces the user to pass the
full cmdline to CONFIG_CMDLINE="...".

Rework so that we disable CONFIG_CMDLINE_FORCE in the defconfig file so
we don't have to pass in the CONFIG_CMDLINE="..." when building an
allmodconfig kernel. Since CONFIG_CMDLINE_FORCE is unset default, so
when doing 'make savedefconfig' CONFIG_CMDLINE_FORCE will be dropped.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 52a32b53b2ed..878f379d8d84 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -854,3 +854,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_MEMTEST=y
+# CONFIG_CMDLINE_FORCE is not set
-- 
2.20.1


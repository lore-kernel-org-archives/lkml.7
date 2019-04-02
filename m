Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33807C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0814206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCU4LuYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfDBGbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:31:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41133 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:31:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so4034148plj.8;
        Mon, 01 Apr 2019 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5lI6Cm8DXQohzRLyyRrBDvhGKUFb9mSBAgeXH8Sbbw=;
        b=PCU4LuYE1RQ8Nd35Pecg9oBVn2EQCZLJD6UIdwPRo/EiPdfnjGbRGhHB2yblcUMytF
         zJOAvZ4ubqtfTb9MoJX8WsWCUaKOAhmPdD6ZLduhK0O8N7GYSdQ48BtcnaZb2SVBGpbZ
         dPijpKmdL1+9Tx7KnC9AhQ+AzBOc8QyKT6K18UWEHIgK19NVCuAXvYGzPWWI4b+i/uwr
         IKdR1Z4nQR2PtsZJ022W9aV0SyVd5zXA2NKApxPTI5KCsLdaI4PkNgTe0SJcdhidcf5o
         Jetzj30fCnrF9ryGuzul3CUqHZxr4K0S63Ki8FvL9AdGyiFzpjqu3qjz7iUS8zzYQLjQ
         6jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5lI6Cm8DXQohzRLyyRrBDvhGKUFb9mSBAgeXH8Sbbw=;
        b=GHDMgEScFCoklh0MYzcwWwBAPeiQEEpe7iePAgQ4uG2a8MA+z3GMhMvHGB3janpSwk
         YElApYjddZjCgCflf9n5a04im5491M2SJ3BpUlejAOEXBe4/Aj/DbFDRwLAS4ukMPbKn
         DXdzTBU+1GtWdqn3OyoGfbFJRrmec9ZCYcK78HgGEt1a/wi3/Ra1qZzDfHC/OMvsmkNi
         O/i357QNahLC/DMjJBnGY5fjvK8+ctyhaxWQzQi8JaQRF1Zv+hVoiYA9LvSxO7NadXk1
         NTKwmOfbsDNGhX0PMOn00TePFEx7jcMCxED9BjIn2Y/eowZ4rYsna5bZW269b39WhjSk
         IsIw==
X-Gm-Message-State: APjAAAWGrBuTjnxX7oIHUwvL0S/+CEmS64DLFJ/zUvi6BRFIF2641Rgk
        SYhCL8xy4qBXsQQTy+ElABk=
X-Google-Smtp-Source: APXvYqwYR6LdnL4uy6cbUMrLOBM+U76iG5CPQ/aGeUxQ5Zjp147mg64//+odVU3qjvqueQET6xOLow==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr32862396pls.250.1554186712458;
        Mon, 01 Apr 2019 23:31:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:31:51 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com, Rob Herring <robh@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 10/18] dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
Date:   Tue,  2 Apr 2019 15:30:45 +0900
Message-Id: <2aaee83992bcc1d29080ef6921ae6ad56856389f.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

The STM32 LP Timer counter driver now resides under the Counter
subsystem. This patch adjusts dt-bindings to account for the STM32
lptimer driver move.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
-- 
2.21.0


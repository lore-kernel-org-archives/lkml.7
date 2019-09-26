Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53564C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B00217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmbyEtSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfIZTa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:30:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37355 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:30:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so105225lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRPre9NyfI29GwZlshBH9gC7wzK/z0KwBuEoRmdliGw=;
        b=ZmbyEtSbBWuMMpVwSZrHjYIdpkcnkwrF0qUUMy+MafE3PBuxLYpS5NxZCb/ts7t0m2
         URvbK3ghblOhCpJfGC2ls/2wVb3UrwxpCiNw1SDuYlzwu25KYpk8SBOaFXK/7HlFBuO/
         /4W3oShWHyJTVBG40zewUhr6Ps6wZBQvd0ndRPMXdoJwKC66qXN8qcxNBY6eENCOupCG
         jn49OXgfkpqEGPjZk1kpo8kmoRX9L/aeOKuygquMwxeXXHZD8gzlUvIQfZSWiwZDJP0l
         Fm6jKF66NsW27/LVLzMjWsXplegnahgkoBtnCXXimpiCmdrWdxuoidKJtbCJw2lT2iYp
         OgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRPre9NyfI29GwZlshBH9gC7wzK/z0KwBuEoRmdliGw=;
        b=o+C0W6NFwcZv/u2B9+PHf21TS+rRjpVUbgXmggPbQkmJ0cyn0G+uV0n+H3lCyvTixe
         6i1STYZEogbjOgx5GiSTt7AN1avTt6+CM0mZeG/rKBFujurm4WiuGKmFJjOptbkK0k/r
         iQJ4c1RUmAQK8uJ5MDwxJ0rUll6TVAJl3ENjGA3cIerkhlQ87GBio25ICdVGqXq3TNWn
         tTlr07Cj3oxnHAkLYjAkmwHnVM1nY4dysY0lVYEZ+GEIcMetrWqo2+I4I+KPa9qvY5GH
         6jbGNoBMlRMqk2jMbTrqZVVvRuh8CsRFkeA89PrIdjuyhyAjIC0a76YhUQFQp4Xu8dlx
         jRfg==
X-Gm-Message-State: APjAAAVz1OXNdyxuVYpejrJlp8KND5OWiho74zcFDDNYlJldk+cfpD6g
        rvlyUpbcXZjPySSWBMiQZBLfoA==
X-Google-Smtp-Source: APXvYqxMxxn16V9qPfWdtkfkq1r7wYv/YWf0OUsdrDgk6aN00MwBwYaHHJAG9v1Vh1fj5ZR7oy+s5w==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr208631ljg.146.1569526254516;
        Thu, 26 Sep 2019 12:30:54 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id l16sm19009lja.34.2019.09.26.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:30:53 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/3] arm64: configs: defconfig: enable DEBUG_PREEMPT and FTRACE
Date:   Thu, 26 Sep 2019 21:30:27 +0200
Message-Id: <20190926193030.5843-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926193030.5843-1-anders.roxell@linaro.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building an allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
kernel, CONFIG_DEBUG_PREEMPT and CONFIG_FTRACE will be turn off.
There is no benefit in disabling these fragments. By enabling these
nothing will happen without interaction from the user to enable it from
the cmd or boot line.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 56dc7488ff36..52a32b53b2ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -853,6 +853,4 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
-- 
2.20.1


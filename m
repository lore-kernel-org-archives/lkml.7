Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBEC352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1F8222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGPdS2W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfIZTbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:31:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39957 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:31:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id d17so66207lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsypJ4JyedaYNx6RWWvSX6imROFVDBxRCyA4sdErGA8=;
        b=GGPdS2W3eZpVUxY0pzLQKQL4b6bUB+zr3B0dSzIZ52sgkbgf54Z+wh4mK88Q+QyecM
         +fcma3S18yM9+zLeODW3nTvueYR67NpfHssNxOn+R6w7wd6p5EhTxeQ6EvwOztt8jAzp
         4Iqulu98JyL0Q1C5RNfHt9rtdGuVyvN0zUpElsAQu2S1lxk8YOR0hopbfSzlOEhDVtJo
         F+s8VqdaV+ja9h/8xEcZhtGaNW9DNsp+cns47N/aKEQR5CaOa+z39IbLuGZYUNV1qklF
         tKdlsBow8VsCfDd5jGa2CQQuV3Zf/JVt/jFmFN/XU1TjFJ0/bBI1xtEsL8jOfVH+2KiM
         z0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsypJ4JyedaYNx6RWWvSX6imROFVDBxRCyA4sdErGA8=;
        b=lcSZIRFwOs2GZ7OoscauifcD9CLISp6VOw/BLcTBpIGfsCetxm8FeGn+pg3HBDvbA6
         ZCPy1Fb3e0KaLr1pP9YRaCLKQYlTAtSEMalrutHdfPqAV7EK+5mesTHKVBtjoITPznJk
         0b7kL9Y9wVY7HjSzard1tDhO1/Wh+7j8ABRd+1zERXQFe4olSkLTOqEADcAXFIGFuFIw
         Tkyu+we6gDKrNL18sF8OsN4/9KVVKT7jwmbN+1pXxujIRq/ElnuDiYCDpcETlndaTS0r
         /G2PSy1t2z4ZsjHLxkxawzsOOlEhFlzyhFMcjotpJ7f4Vt1sKf7vZ3zprKVteMP4inJ+
         n6JQ==
X-Gm-Message-State: APjAAAUS9lbMKpx2paFa6+7E8cWLm9tfAmyYa5OlFcJ6D9pBPOxGN4dy
        zaMBbVj4nzTHjnxd/7vOiBuwedXkeCfEhGjF
X-Google-Smtp-Source: APXvYqwKed/w/gxyhfXpvPb+gb1Vek3IYxj+Vzi00MuyUbDuhzDUjYBRMvHbgH1ysbuGBj0rnrhdlg==
X-Received: by 2002:ac2:5451:: with SMTP id d17mr114619lfn.77.1569526266912;
        Thu, 26 Sep 2019 12:31:06 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id r6sm17998ljr.77.2019.09.26.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:31:06 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
Date:   Thu, 26 Sep 2019 21:30:30 +0200
Message-Id: <20190926193030.5843-5-anders.roxell@linaro.org>
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
CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
people wants.

Rework so that we disable CONFIG_CPU_BIG_ENDIAN in the defcinfig file so
it doesn't get enabled when building allmodconfig kernels. When doing a
'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 878f379d8d84..c9aa6b9ee996 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -855,3 +855,4 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_MEMTEST=y
 # CONFIG_CMDLINE_FORCE is not set
+# CONFIG_CPU_BIG_ENDIAN is not set
-- 
2.20.1


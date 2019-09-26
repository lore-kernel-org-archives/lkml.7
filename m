Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0BFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0B8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+mMnejq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfIZTas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:30:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39675 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:30:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so69610lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVMRim0CvrP2OAMSRSPszsNYlyw6bDIFE8ceCAvsXOM=;
        b=g+mMnejqlJOWehTkajvt8uHYKxP0LWJmITU82kmzO/kahLSqR/DOv3G9njRlD9GEpP
         Z62a+jaK2cyM0RtceSx56eTGo6qgBkgeZyuK4gyLgHtwrKOYSKnIVkMpKZB84xKlfhYK
         G6MYJcME093luWLhV64Px5KNQZvrsS1u9LLESrUVz9+QcEkcxgeqbmTTkOxXrqTVnbeh
         K6XHhQDuhyE+kRNO4UueNFRXBUhYnN3WckFiZ514VLIgeL+bmKGrFD4c4rGxllsXXDvO
         2GCNAg1PGKjJd0DyVP6KmGiA9zkGkGLUNRwT/sH6MMUIqAJSkSh/zDN4GhCzA8FhrYHO
         ztMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVMRim0CvrP2OAMSRSPszsNYlyw6bDIFE8ceCAvsXOM=;
        b=A7P0A/WrFVUAe72WjB05SjmjG2cPT4ziq/DW0qdqNZszFFkYZiisHAEdxOtTmK3Moh
         fKRMySCXN4ff1Hc7cXDpsHrNdC/URkLueLdWJnjNIsXzqlcxzkWe2Fm5XVVd3lTEFXqa
         tgVWptmLN1jmYSYO7oIwONADSklGQtHXD7byzzcJJmozp2KpRtRB9dlutfWFAXG+kDsx
         7oYeqPkAHPeWKlT0nIwyJw8wBc1iTem7r/dWJuPt17g0CqyjUpLHX9+u1S7NOaQpw3OO
         2bW/HStvPJZV5yWS0uu1wvZWxp5RBuWnmXOLptkbn3/hiQd+JuJqcz9hE7YfuBT8D3rO
         Fk8g==
X-Gm-Message-State: APjAAAXm7oebIZYp8GcZAuxDMIm6Vmq3rQPKO3klSU2i5NNytzZTDI6z
        zRZRwpb4L5ollYWzRZ2//g/Jsw==
X-Google-Smtp-Source: APXvYqzTvB6xs1qyLeiw4unz6QoktLWw49txRFhr3JHzYrAOZpWqpjn9a3HmiAAYQbwY7g/UItgfnQ==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr128940lfo.35.1569526246405;
        Thu, 26 Sep 2019 12:30:46 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id s1sm31389lfd.14.2019.09.26.12.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:30:45 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 0/3] arm64: defconfig: set/unset for allmodconfig
Date:   Thu, 26 Sep 2019 21:30:26 +0200
Message-Id: <20190926193030.5843-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get an allmodconfig kernel to boot. The way I configure
the kernel is:
'make allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig'
allmodconfig will use the KCONFIG_ALLCONFIG file as the base and then
turn the rest into modules.

The idea behind using the defconfig as base and then configure the rest
as modules is to get a bootbable kernel that have as many features
turned on as possible. That will make it possible to run as wide a
range of testsuites as possible on a single kernel.

These patches makes it possible to boot a LE kernel.

Cheers,
Anders

Anders Roxell (3):
  arm64: configs: defconfig: enable DEBUG_PREEMPT and FTRACE
  arm64: configs: unset CMDLINE_FORCE
  arm64: configs: unset CPU_BIG_ENDIAN

 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78912087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHGlhWOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfJaVsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:48:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45694 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfJaVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:48:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so7856959wrs.12;
        Thu, 31 Oct 2019 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sEuZEsN3CO17Mk96Q9i8WbzrGmqYVcLxl0EB6NndMBA=;
        b=NHGlhWOH/lPzkiisqXGbCuqEH3Cld5YZg5wB3dQ5EjwTa2udUJNWsdHlxUGKg23GAT
         5X6weI8hStYzrXSUv3yWPZWKvm+ql7YOJTqq9CQrjDzjlDxaHOO5QDMmkdvFrxKyImVg
         l7cFw15yuXDcDQAQ9Jj19zsXBpy85G6mfCyF7ZKRWloLgf6pd5Er82Y9hBhOgc31d6k3
         kzvjGCSMK83TiVP0PsUdBW5Aqsq6S+KrournTX1g5JHIoUV2U1zYYittS5pyaxgjuaYt
         IRG21NXAysTNvlN3e9MckdKqEP5zoetsDm+TN3CnidRGBibcEZGLlPydXAnzmwxNfVvy
         CwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sEuZEsN3CO17Mk96Q9i8WbzrGmqYVcLxl0EB6NndMBA=;
        b=Pu9NibAAWYvpiUEO/SbubTyvxiFDqWiykl0cR0n7Lq9AteueLMarG2Df7Bn1YW+GIv
         ZNekfjiFJCz5ijGEjWBbsnkIAvsFpi3LnU3SJamt9M/wL8MYdE23ebovzzM6ZWAZVAM6
         97GI2ptKj7NuZoxtaSOb0LMo7EcaeD6W7RRxzUBmDgs75kUKpO7+qp7VOvsVYc2EmkFg
         HzefgxAqJEpjY93lG7ZH8OzS5nZGIFMqKWWnPVaZxTcn/zndmvkyW1QZ+0QqqBARPPiM
         qu7l34RgDBxOZx/WZikqlcbegbyQs8ih/JBSIyjMAq99voPcFhnSUj9MD1C7rzx66vM5
         zAMg==
X-Gm-Message-State: APjAAAVxN8yu0bksIeqvyaBEjfol5xBh4VrxocFeQDACD1+tV1A1kSex
        /NSV4p6mwYQtOlkU6thTL4s=
X-Google-Smtp-Source: APXvYqwONELlt6nYOaizT5kkHAo20vYTlb0GLvd1u+tok17wOcwrfhYhLQBU7nsf0a6o7FC9F5iitA==
X-Received: by 2002:adf:8088:: with SMTP id 8mr7492245wrl.230.1572558496697;
        Thu, 31 Oct 2019 14:48:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g184sm5813674wma.8.2019.10.31.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 14:48:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Doug Berger <opendmb@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>, Qian Cai <cai@lca.pw>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/3] arm64: Brahma-B53 erratum updates
Date:   Thu, 31 Oct 2019 14:47:22 -0700
Message-Id: <20191031214725.1491-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

This patch series enable the Brahma-B53 CPU to be matched for the
ARM64_ERRATUM_845719 and ARM64_ERRATUM_843419 and while we are it, also
whitelists it for SSB and spectre v2.

The silicon-errata.rst document is updated accordingly, we unfortunately
do not have internal numbers tracking those errata.

Doug Berger (1):
  arm64: apply ARM64_ERRATUM_845719 workaround for Brahma-B53 core

Florian Fainelli (2):
  arm64: Brahma-B53 is SSB and spectre v2 safe
  arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core

 Documentation/arm64/silicon-errata.rst |  5 ++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 38 ++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.17.1


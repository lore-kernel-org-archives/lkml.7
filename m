Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C76C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C431220640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQMQfbbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405913AbfIYUCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:02:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387787AbfIYUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:02:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14so560237pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNhpGEC3xKEUzgeifEP+x7IybNdlV9Dtf/y1slQituc=;
        b=CQMQfbbhrVok3TQFG72mIe+jYOOE+rU3M4M2qRpg13+nMIm+qvgQKOuHfWtwoVlepb
         EIFUic7kp41e7CV0luGlbcFCcB4shxf6JyN4eHqo+bMywTwPOioxbIctP3uvZRp7ddKl
         aLHQnVcccOR30bs3QOuDXSDlaUJEJbT2NOVX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNhpGEC3xKEUzgeifEP+x7IybNdlV9Dtf/y1slQituc=;
        b=riQuVLo/mtZUBfAbkuL5RDYSMD1gWrKYjpnJyX4hwPb5CfyACDbzLa/2ZAOqUnuG0V
         KpqtzR5ulpTk6lPzvEbC0QJmeXIQZIJ/LAh7yFILjg3lWCHFzOhGDjtd4EEZRcanSFcE
         2h2sanvJpptuqTK7BDs5cG0l/icXe2sIULLRsO+Vk1tmzW/ZOagrkUy5QBo0EJ7GMxuy
         Q+rTtH3vpnYfTchGGHxNSESIS2/tbQAFP+Ju2TMaisUHU1gB4MwRZEkKCPYVJxtLM6g2
         UJBSInmbxOKRkM2szKcHnMzjneqOMFvFoeOHiLePkxRXqm/SIqs/JxWLUr7Ub3Cu5Vwj
         I2RA==
X-Gm-Message-State: APjAAAWoEn6VmsyQNyQ8Tvi960PiMHtG4eQBjMhZWhu5hUuQ8vGpGoFN
        JWpPBTWxtGFXBqRM5cVNKju+Tw==
X-Google-Smtp-Source: APXvYqzhC0Ga95TJdizkW4HlNLgb6ji6lavDbKM7n54/+dTbnR/WUEVhDadt2Le0ynCTkxMhsY56Vg==
X-Received: by 2002:a17:90a:2744:: with SMTP id o62mr8222552pje.139.1569441768922;
        Wed, 25 Sep 2019 13:02:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d76sm458113pga.80.2019.09.25.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:02:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] kdb: Fixes for btc
Date:   Wed, 25 Sep 2019 13:02:16 -0700
Message-Id: <20190925200220.157670-1-dianders@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series has a few kdb fixes for back tracing on CPUs.  The
previous version[1] had only one patch, but while making v3 I found a
few cleanups that made sense to break into other pieces.

As with all things kdb / kgdb, this patch set tries to inch us towards
a better state of the world but doesn't attempt to solve all known
problems.

Please enjoy.

[1] https://lore.kernel.org/r/20190731183732.178134-1-dianders@chromium.org

Changes in v3:
- Patch ("Remove unused DCPU_SSTEP definition") new for v3.
- Patch ("kdb: Remove unused "argcount" param from...") new for v3.
- Patch ("kdb: Fix "btc <cpu>" crash if the CPU...") new for v3.
- Use exception state instead of new dbg_slave_dumpstack_cpu var.
- Move horror to debug core, cleaning up control flow.
- Avoid need for timeout by only waiting for CPUs marked as slaves.

Changes in v2:
- Totally new approach; now arch agnostic.

Douglas Anderson (4):
  kgdb: Remove unused DCPU_SSTEP definition
  kdb: Remove unused "argcount" param from kdb_bt1(); make btaprompt
    bool
  kdb: Fix "btc <cpu>" crash if the CPU didn't round up
  kdb: Fix stack crawling on 'running' CPUs that aren't the master

 kernel/debug/debug_core.c | 34 ++++++++++++++
 kernel/debug/debug_core.h |  3 +-
 kernel/debug/kdb/kdb_bt.c | 94 +++++++++++++++++++--------------------
 3 files changed, 83 insertions(+), 48 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog


Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD734CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C8205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ns1ZYl/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503501AbfJXQii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55657 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503426AbfJXQih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so3569593wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dYt5aHbdAcoo6iOaj0orMUSAvQMPaS0z8lFzdR/A7V4=;
        b=Ns1ZYl/2Z7R9SELtWm3ZXQehrrSdTOXVC8OUXM2hM0HYtFG2jHyYkGzlMM2tGrTBJ1
         PadyzrB/+/j1eT5StN3toKeTz/PAXMrdKQyTCN9tYT3/SrXTiz9OS8EQg9ceVBDcPJ7L
         YSa27E3euj3OEjinq0HDg27dX+MgxGueXHGRrPQH4u9yXzWJnkWkbzvnb4fsmU0ZWYub
         kcuwX4TIz5K5q8WW7B/Ef+2cKaUd9IS+JwxARfmgBNUVClV4wHRRliuFbGBmnc0YKw4X
         8mAK159WfLfu+f4lRLQkqNbihdts9A4/BXWsd0Ngz+C0SmzIAb52ebd0PPe3zgJzwog4
         ToKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dYt5aHbdAcoo6iOaj0orMUSAvQMPaS0z8lFzdR/A7V4=;
        b=nF7F4UF2FX1rLB6m6mNznEGqFZ+VFr8hUHFEQAMps4EiSAfQIpAA8q2EQ9MqGhjDW3
         O9XL+v8bQjw5EwImRxutwJYtP1JZCL0SqqJns78jT9PdREkX3StICQcSLydwj5znI7+T
         EFDQprzUSAXesn+LygEhI7tb+jsqQiJd//5uUYy8NiCP0XCC6IhRWFtEWirlvGURiJyx
         l5s2pgBQ5uc0w2sabR7fkFc3zGgV/xN/SAWPa2qIGXNG9F2s0DjZgDfvDHiZrdkNbDGG
         dIOtGCE0FTb4YGLZEqIt36NmDuL6W1wKOFBRz3WWRs+yClk/jAkWc+0GwhoRNiReYqUQ
         omaQ==
X-Gm-Message-State: APjAAAWYArogiynG8kBVnD0VFDVgj9n8Z0nyQEjnubXYnaiXc1fQDrE5
        RkzDwK4IAbbl6YLVEgZw3j8gnw==
X-Google-Smtp-Source: APXvYqxajiI3u0bx2uwGq4iPJh90TzC5CDZXmjeWLns9qC3nWHb0jFRD4YDKVNeGdlHzDhTCWW5zoA==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr5566577wmc.68.1571935116224;
        Thu, 24 Oct 2019 09:38:36 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 00/10] Simplify MFD Core
Date:   Thu, 24 Oct 2019 17:38:22 +0100
Message-Id: <20191024163832.31326-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD currently has one over-complicated user.  CS5535 uses a mixture of
cell cloning, reference counting and subsystem-level call-backs to
achieve its goal of requesting an IO memory region only once across 3
consumers.  The same can be achieved by handling the region centrally
during the parent device's .probe() sequence.  Releasing can be handed
in a similar way during .remove().
 
While we're here, take the opportunity to provide some clean-ups and
error checking to issues noticed along the way.
 
This also paves the way for clean cell disabling via Device Tree being
discussed at [0]
 
[0] https://lkml.org/lkml/2019/10/18/612.

Lee Jones (10):
  mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
  mfd: cs5535-mfd: Remove mfd_cell->id hack
  mfd: cs5535-mfd: Request shared IO regions centrally
  mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
    entries
  mfd: mfd-core: Remove mfd_clone_cell()
  x86: olpc-xo1-pm: Remove invocation of MFD's .enable()/.disable()
    call-backs
  x86: olpc-xo1-sci: Remove invocation of MFD's .enable()/.disable()
    call-backs
  mfd: mfd-core: Protect against NULL call-back function pointer
  mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
  mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()

 arch/x86/platform/olpc/olpc-xo1-pm.c  |   8 --
 arch/x86/platform/olpc/olpc-xo1-sci.c |   6 --
 drivers/mfd/cs5535-mfd.c              | 105 +++++++++++-------------
 drivers/mfd/mfd-core.c                | 113 +++++---------------------
 include/linux/mfd/core.h              |  20 -----
 5 files changed, 65 insertions(+), 187 deletions(-)

-- 
2.17.1


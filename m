Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FE32080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PS6PHmQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfKDSMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:12:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:12:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so12853578pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IOrnVjzKQTHajn3CFMHgF0C3ygPTxYZvls8u9qhJFmc=;
        b=PS6PHmQNfAUlHw8UA707P0dlj6K2TOGPCwtXYXxWtzCOKkaoOK4zw98M2wLImdMUwR
         ckMGK8OKLC14u5DIX1TAeZeIiKjyvGCyrhnyYgaLR0KTC8z5pfkRp3YB8tKu2QduS5lf
         fi5d86sMpsv6+PgrOSJD+Mm3CYd02h3x8g1JNDkvr9VV7+pTXLL1j3IaFBb9S2aptR40
         DiWL+iW9wbUDbwKk+NcTUT/FIxpA9f3djtP2lCZGGpGiI5huY+Ow51AeIl3zKOFuAWVA
         HEO2Lok9edb3v0Q2KOFHqw6kRTRzmFiD7zaYlw9OFJg0VgTQ3HF+FRElsGinDEnF3/zq
         JySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IOrnVjzKQTHajn3CFMHgF0C3ygPTxYZvls8u9qhJFmc=;
        b=b5hRoPSSeJ7PvAcgskUiFbFG8IM3RvL2lnL0DhEaHe1U94ZSQEDtKVJ5TX9chyh30V
         nIPRvhUh+VJ+xQPEuNOja25tL6JgnyxjJD2abheoK3asjl52O8IUfon0rnYDpYlxA445
         l7MjuWD50fhbHxw7+na6HIIldOuVLT5FbPYycyEAOhaZ2qWoMIbXwuu4jeR3vXjPjsL6
         cjRIt3BfcZHsn4O+l/uG26WJNuyDs8emTKcjodubrp9Ze+IcCb4LZ/xWI7G5ocefyJIV
         L7YSgCCYCtaEQIPnfOPon661aVy/pbkQSF15m88pfjkl1ToZc/SAK7wpYuM4D5Lle91+
         Yf6A==
X-Gm-Message-State: APjAAAW9tCtGV6CpacKH4jsAgCC+z6zoWzFsV/w8y2GnT4zR9JTfSWUn
        yZnS7QeEYo+zOU/id02P+k2C2g==
X-Google-Smtp-Source: APXvYqxehQz2p3EAwjX8rJ5mLXOpKAM3g/M8xfqjrwh66Mqgil1TPv+RtKTQE2XfgLYqtKEQoPpVIg==
X-Received: by 2002:a17:90a:fc90:: with SMTP id ci16mr555884pjb.140.1572891173307;
        Mon, 04 Nov 2019 10:12:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:12:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] coresight: next v5.4-rc6 
Date:   Mon,  4 Nov 2019 11:12:37 -0700
Message-Id: <20191104181251.26732-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I collected the following for inclusion in the v5.5 kernel cycle.  Please have a
have a look when time permits.

Applies correctly on the char-misc-next (da80d2e516eb) branch.

Regards,
Mathieu

Andrew Murray (2):
  coresight: etm4x: Save/restore state across CPU low power states
  dt-bindings: arm: coresight: Add support for
    coresight-loses-context-with-cpu

Mark Brown (1):
  coresight: Add explicit architecture dependency

Mike Leach (8):
  coresight: etm4x: Fixes for ETM v4.4 architecture updates.
  coresight: etm4x: Fix input validation for sysfs.
  coresight: etm4x: Add missing API to set EL match on address filters
  coresight: etm4x: Fix issues with start-stop logic.
  coresight: etm4x: Improve usability of sysfs - include/exclude addr.
  coresight: etm4x: Improve usability of sysfs - CID and VMID masks.
  coresight: etm4x: Add view comparator settings API to sysfs.
  coresight: etm4x: Add missing single-shot control API to sysfs

Rikard Falkeborn (1):
  coresight: etm4x: Fix BMVAL misuse

Tanmay Vilas Kumar Jagdale (1):
  coresight: etm4x: Add support for ThunderX2

Yabin Cui (1):
  coresight: Serialize enabling/disabling a link device.

 .../devicetree/bindings/arm/coresight.txt     |   9 +
 drivers/hwtracing/coresight/Kconfig           |   1 +
 .../coresight/coresight-etm4x-sysfs.c         | 312 ++++++++++++++--
 drivers/hwtracing/coresight/coresight-etm4x.c | 351 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  81 +++-
 .../hwtracing/coresight/coresight-funnel.c    |  36 +-
 .../coresight/coresight-replicator.c          |  35 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  26 +-
 drivers/hwtracing/coresight/coresight.c       |  51 +--
 include/linux/coresight.h                     |   6 +
 10 files changed, 825 insertions(+), 83 deletions(-)

-- 
2.17.1


Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F77C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BAF21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YJDh2YLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436561AbfIJQJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:09:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39481 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394139AbfIJQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:09:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so2952596pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUvxJ7wlmXdEjdS8Ji+2ki9BT3REdqo3NpskuD2RAZE=;
        b=YJDh2YLeoTKo99EIHf/GbAcGlRVVjeHebFXD80CmOEXk6TDGBbj/Uh5lPLn3Z2Y21x
         gTixE7rHSZVLLXSJ6GbQCyzq9QYepRhuOnus3wPSwsY1vxwywof4CRlDE9o5bB6kFdRh
         L0aDQx9uJi6dcUYgOueyyIdi7vxhQ8v6gGLkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUvxJ7wlmXdEjdS8Ji+2ki9BT3REdqo3NpskuD2RAZE=;
        b=rK4tRGaZH12dvPbIUf0hozuzcC0R8ir5F20yamNYfy8ENgZFukKQ6ELazr2s/0j+Vo
         669uyC4egCgQVQgdg40foA3e2ZCmx+3RSMLrkCOfWHMxDhDJz9MlWGo/Bx+mQLYUIjiO
         eue3uU8Cu7p9rZfUuCJV8Giym1Jcfv7QOCq3rgrH0t36eyMUil3SySDK1ZSesEi39Pvq
         TrDQlt2RgrVA4VJW5WtLVP7XioJ+KKdaPYnfk1nTZ4ztwv74cyC0QWp21iZzjeqSWTVh
         ZuaA6xZ/cJAdLCLHJRiR15I1/kBxO9DKdcROOUBYcCKnVmRcZHngDwBJZrm+htLYSJ58
         TJDw==
X-Gm-Message-State: APjAAAV2my9LMqXZA2WWEjYZskO9e9cv0REi8JHiVCCLDqzzjQbsqigs
        B0omA/bUnuu/MX6G2zszztNdrQ==
X-Google-Smtp-Source: APXvYqwv8qruQZ4KH/LAzFeFB5Fw6fLmcphoP8mGiPT4myBOZsUnw+zQpjwu6W6Ar30JnBYs9mBOxQ==
X-Received: by 2002:a62:64c9:: with SMTP id y192mr37931196pfb.6.1568131744630;
        Tue, 10 Sep 2019 09:09:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id em21sm106088pjb.31.2019.09.10.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:09:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 0/5] Read-only memremap()
Date:   Tue, 10 Sep 2019 09:08:58 -0700
Message-Id: <20190910160903.65694-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements a read-only version of memremap() via
a new MEMREMAP_RO flag. If this is passed in the mapping call, we'll
try to map the memory region as read-only if it doesn't intersect
with an existing mapping. Otherwise, we'll try to fallback to other
flags to try to map the memory that way.

The main use case I have is to map the command-db memory region on
Qualcomm devices with a read-only mapping. It's already a const marked
pointer and the API returns const pointers as well, so this series makes
sure that even stray writes can't modify the memory. To get there we
introduce a devm version of memremap() for a reserved memory region, add
a memremap() flag, and implement support for that flag on arm64.

Changes from v2 (https://lkml.kernel.org/r/20190614203717.75479-1-swboyd@chromium.org):
 * Added a comment to kerneldoc for the new MEMREMAP_RO flag
 * Rebased to v5.3-rc1

Changes from v1:
 * Picked up tags and rebased to v5.2-rc3

Stephen Boyd (5):
  reserved_mem: Add a devm_memremap_reserved_mem() API
  soc: qcom: cmd-db: Migrate to devm_memremap_reserved_mem()
  memremap: Add support for read-only memory mappings
  arm64: Add support for arch_memremap_ro()
  soc: qcom: cmd-db: Map with read-only mappings

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>

 arch/arm64/include/asm/io.h     |  1 +
 drivers/of/of_reserved_mem.c    | 45 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c       | 14 +++-------
 include/linux/io.h              |  1 +
 include/linux/of_reserved_mem.h |  6 +++++
 kernel/iomem.c                  | 20 ++++++++++++---
 6 files changed, 74 insertions(+), 13 deletions(-)


base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes


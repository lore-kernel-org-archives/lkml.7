Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F84C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B22166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="apNC443I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfEQQrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:47:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35037 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfEQQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so3957460pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEOBQ+tiRCBCDhxOnqUK3ak9dZiYIaMI5j8XdfHoJPo=;
        b=apNC443IjOu26zOUT73921FGrnZ1n43OPBcwr8RIvJ+ZwA785Xj8ae/wdc1rrNkXDy
         23fQnlF+WLg7ie94sC7Saky9o7IuCQHw5EtDYIwfJ3Hhg5BFCSLEIgSAq/ijzHWjvVtg
         gNLSxE2QaGgEAbJZHjlXf9OVihYSzy2yxrfjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEOBQ+tiRCBCDhxOnqUK3ak9dZiYIaMI5j8XdfHoJPo=;
        b=d5EAM1dez9gOGDYHpJaihJFvdB+Z1k5FO12emNPQC636raSoRhMy0IgkgpfNAfKNiq
         UtwVIQryXwY/RRvv3dgnnuZCx9Brm0LW/D7N7vLpkOST8IK9geeivnvdbyCB2OkrYefi
         DaMYMz51uSYrmKKsStwrLz+ovY0wCv+K+1ujABw4M5bllGMPU17ZE3WErdpFAWf+P34F
         p6jWvIIyaorNbA278s4iUx7yPtZYUcKcb62+tfq10C+VelJwWe0jZ4XBZluG9zFBkT8K
         Zk0BDBeofx1zLni+TTCL81/Q4sXpUOCd4cxOLriifGbIDhDeaZBbp9nHH/CbKL1NvH/t
         VxRg==
X-Gm-Message-State: APjAAAXDBa3uXsPIxRdsg2xGPGJ6aC3FidBBHzNWTVafQz390D1CCtdW
        h9xTpN+vBX3ODaIdHTD8uExRzd0fn0jqNg==
X-Google-Smtp-Source: APXvYqxzWh7+qSyhy1qYyWLoyY4I2do1NdTj92SZJu+yMhoeS1eAS3iHOrpPbfYELyOXmcFNaUiphA==
X-Received: by 2002:a63:170a:: with SMTP id x10mr56459139pgl.355.1558111671057;
        Fri, 17 May 2019 09:47:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l141sm12229810pfd.24.2019.05.17.09.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:47:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC/PATCH 0/5] Read-only memremap() proposal
Date:   Fri, 17 May 2019 09:47:41 -0700
Message-Id: <20190517164746.110786-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
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

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Stephen Boyd (5):
  reserved_mem: Add a devm_memremap_reserved_mem() API
  soc: qcom: cmd-db: Migrate to devm_memremap_reserved_mem()
  memremap: Add support for read-only memory mappings
  arm64: Add support for arch_memremap_ro()
  soc: qcom: cmd-db: Map with read-only mappings

 arch/arm64/include/asm/io.h     |  1 +
 drivers/of/of_reserved_mem.c    | 45 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c       | 14 +++-------
 include/linux/io.h              |  1 +
 include/linux/of_reserved_mem.h |  6 +++++
 kernel/iomem.c                  | 15 +++++++++--
 6 files changed, 70 insertions(+), 12 deletions(-)


base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
prerequisite-patch-id: 62119e27c0c0686e02f0cb55c296b878fb7f5e47
prerequisite-patch-id: bda32cfc1733c245ae3f141d7c27b18e4adcc628
prerequisite-patch-id: b8f8097161bd15e87d54dcfbfa67b9ca1abc7204
-- 
Sent by a computer through tubes


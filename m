Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A869C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D9E21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wx04VyZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfFNUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:38:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36880 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfFNUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:37:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so2165313pgr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vrmhhZaEzM19h9Zlx4Mo9l21Q8Z/1tpB8JbdgO/6Q0=;
        b=Wx04VyZXSi7uEkn+qcquHj3EoBnN4m9FX9vJIgJ6cgeChrc10QLuaKpp7+rGSiDvGN
         Sk53gojxneIiAZ8hn+pPpC6+ljGcvOasLCV6lMxQw1+3d6Tp7bsi0XiXzlyoQRZ2r0b1
         rCNafT3ZKZUrDMLDEKZq4H1mERd0VafFAJUpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vrmhhZaEzM19h9Zlx4Mo9l21Q8Z/1tpB8JbdgO/6Q0=;
        b=ibwRuIbb9kBCKoW1DFr4/gWkQaj37drPlzeg+iTVfqKIEta0xbmvw1oNFCHy/z00DT
         qmlpaNPYzwAh4S3glQ7g24h4kCGmbrNkZL8YHlFbqcUVRMc+MygMhoVaNJl+v/ZjrZ1i
         Rdtk3EPovA/xE7Bk8VKBGJbRpGpDUVwtaDDkjW3CTl1VrpKoOonl9elhq+mAbBppVhS8
         evQbpYaVTdVCMOh7N+X+BricKmyU4ziy1L2zvD2Q+sb5XTNQDLf1DsycLRIwuUsNUr9m
         0PrTARyDFeLB4y3ScSKXg/DqtrbNehVqZ5tKdDQMyVKLXCwoH1IFvNs292ChTBQ+FEcm
         0EpA==
X-Gm-Message-State: APjAAAUDVqUtUaFjL5GQ+jLicPm47UvOsxE7XOQcsukbyoKviu4lb9qp
        ZYpMITdLwhTIKLpuY/vtZQTAgw==
X-Google-Smtp-Source: APXvYqzfpvXhgutGtT3dFx0GfX5kTtc8h04BE0rk7Qac+K8Ljsdx6ZzVsIxdzlj/CBTPmUiseBZrxw==
X-Received: by 2002:a63:6005:: with SMTP id u5mr28274041pgb.123.1560544639097;
        Fri, 14 Jun 2019 13:37:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x5sm3673187pjp.21.2019.06.14.13.37.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:37:18 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Read-only memremap()
Date:   Fri, 14 Jun 2019 13:37:12 -0700
Message-Id: <20190614203717.75479-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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

Changes from v1:
 * Picked up tags and rebased to v5.2-rc3

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


base-commit: f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a
-- 
Sent by a computer through tubes


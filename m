Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F72C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88420880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ht/2KH1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfDASFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:05:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37324 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfDASFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:05:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so795088pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1pceyZy4S8Boeyfv9ZRh0saRtJ+K4ZmmRbKgcmFfvE=;
        b=Ht/2KH1iRn+740k1OnBvmCEkgsubKw9xN7Ry4xCCSurceoGLr7uNpi5CxpHJaw2B1Q
         dvY/CFiCn0suMdu1q9rx3HzPBCuYizIn4BwJU3vSskzn+DKjNehws5dWL/C65GrsnHBx
         Ei5slv0iBhqESl7rwuJo8ssh8hK4HSyaGe3rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K1pceyZy4S8Boeyfv9ZRh0saRtJ+K4ZmmRbKgcmFfvE=;
        b=b0p1Uz41X6gt5LJkAeorETlNYZijDhuDVGsPnxzhqbF79+6w7Ua6hENtQAio5woQGq
         f81hQXJvL/gxk1uijgU2pZ35LUDJZbVBqDbSIbZH9TzWubK1KebINQMVx9TUuMR5LrNn
         HY5s7Jbn6Tni34NHrE19AxAGdEzG64VVE2ttnXkwkS++EJU3LKBPN+cux5ftRRWe8YZi
         F++ftYng/8JnJMHpNm9/bUgX0WMgk+itMc1SVlEK4T/k+3A1DcPcXSRb+YWnnyg38CIe
         j7t1TTpEExtTMnxacSwAnYzSZ75TNIPuHz39AAV/AbI7lneUWQlAWcG5rJTz3jrs1lMv
         QMFw==
X-Gm-Message-State: APjAAAWVAhvwZikvvgmTWirX/9zV3eAZH7Z9jgLyQsKA3CAiUiIGoGs8
        oNXIkkWP0NZbQDjVkbbMWCyLBA==
X-Google-Smtp-Source: APXvYqxfLlbh6A76feTaDSOJkx6wCknRx5xGVQWe4SpHZRon+f/yTAgWDObH7KFFTaiEB0VIh9yEeg==
X-Received: by 2002:a62:1d0d:: with SMTP id d13mr29209711pfd.96.1554141911892;
        Mon, 01 Apr 2019 11:05:11 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id n82sm18086257pfi.63.2019.04.01.11.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 11:05:10 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH] platform/x86: intel_pmc_core: Report slp_s0 residency range
Date:   Mon,  1 Apr 2019 11:05:04 -0700
Message-Id: <20190401180505.6621-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMC driver performs a 32-bit read on the sleep s0 residency counter,
followed by a hard-coded multiplication to convert into microseconds.
The maximum value this counter could have would be 0xffffffff*0x64
microseconds, which by my calculations is about 4.9 days. This is well
within a reasonable time period to observe an overflow.

Usermode consumers watching slp_s0_residency_usec need to be aware of
overflows, but have no idea what the maximum value of this counter is,
given the hardcoded multiply of a 32-bit value by
SPT_PMC_SLP_S0_RES_COUNTER_STEP.

Expose a slp_s0_residency_usec_range to usermode as well, which returns
the maximum value this counter could have. Consumers can use this to
manage rollovers.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Note: I also looked at a similar bit of functionality in
intel_pmc_s0ix_counter_read(), but noticed it's doing a 64-bit register
access. Is the counter being read here in pmc_core_dev_state_get()
(weird name btw) actually 64-bits long? If so, we can abandon this change
and just create a fix to return the full extended value.

---
 drivers/platform/x86/intel_pmc_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f2c621b55f49..bec54be9be93 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -396,6 +396,14 @@ static int pmc_core_dev_state_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_dev_state, pmc_core_dev_state_get, NULL, "%llu\n");
 
+static int pmc_core_slp_s0_range_get(void *data, u64 *val)
+{
+	*val = pmc_core_adjust_slp_s0_step(0xffffffff);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_slp_s0_range, pmc_core_slp_s0_range_get, NULL, "%llu\n");
+
 static int pmc_core_check_read_lock_bit(void)
 {
 	struct pmc_dev *pmcdev = &pmc;
@@ -764,6 +772,9 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	debugfs_create_file("slp_s0_residency_usec", 0444, dir, pmcdev,
 			    &pmc_core_dev_state);
 
+	debugfs_create_file("slp_s0_residency_usec_range", 0444, dir, pmcdev,
+			    &pmc_core_slp_s0_range);
+
 	debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
 			    &pmc_core_ppfear_fops);
 
-- 
2.20.1


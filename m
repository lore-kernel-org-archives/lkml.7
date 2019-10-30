Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F081CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD962087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk6g1uSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJ3PO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:14:57 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:55409 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3PO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:14:56 -0400
Received: by mail-vs1-f73.google.com with SMTP id m15so339299vsj.22
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I6jD1WRmo86OM3bsIakAOe6JbGStvpAqVOoE2BT6rcU=;
        b=Wk6g1uSOgxeYU9rbcErk6qD765qn6dLXwOR9Sy+xNuM+iSx5iBdg5gG2x3a++IBKQb
         84T0d4ucZUMKle4HVIWjA7+kM7liZ+jdSvu5S72G9nLnxC8+IfznBaDiBXd5jfrDbi+V
         GXsmqRHSNni4QTUgb/R1L7M9JJmll/eHRXNOw74/u040fGpS1lY951aQgcwc0xnMV2g9
         KEWuO4+yEdntOCRBrpfM+FlwKXSpi0NsEn1eWPeDnvlTNVkyzpco0VbnwYsrFdOioqp5
         HW5OIhZEVuWMjaDh8dXwKyp/VxgS4svDjrtiFCWiyBDbce+eDtOgoBsIWbRTjaJMsqJo
         fD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I6jD1WRmo86OM3bsIakAOe6JbGStvpAqVOoE2BT6rcU=;
        b=uWGYEvhbCCRx+cgl/3o6lo3xZdvd0C8cdVDnf6+LEOGn0EFwrWF0pjCVxbpsAM/YKe
         IseGGPP7Snu3S3jhbs5OJnSAZdaCV9XNV/ufAZ1/RBdx6U2RtS/Vd1QXnInmhUOGqUa0
         tS5Oh6rFmi//fF+HO2dP8QxIcAOnE/m9ra1NWe6AUbkbKkgMEBLt/RbIg0HwX8Y7NJ38
         NDyTPSf4FCJrYPH8PI0ZMKNdN+gZuqswj1jaV1UzepfccCwPG76KB8GjVywzPrRPheV4
         pmoK9RBj8eU3y/Z9MUWvfj60mrjdqkkRvF1N7+lsiG78M51o+m8hu+oGEu/nXRulKNNd
         W08g==
X-Gm-Message-State: APjAAAUB1e2o9HSBep8B1hpVl5oR3PYOMd88mPZAvFzmiKlaLQH1pmFs
        r2EHzRK5IGR4h5SZcnUlfmxYfO4+VBJr
X-Google-Smtp-Source: APXvYqzVXv3phZKJ6kK18tzuCBHmUvTKTyupg+8nDEpD/+f+55XCt8xAN1D0dRe2E3jxVYD4dOA87TGf/mZD
X-Received: by 2002:a67:fe86:: with SMTP id b6mr5198734vsr.162.1572448494253;
 Wed, 30 Oct 2019 08:14:54 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:47 +0000
Message-Id: <20191030151451.7961-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 0/4] Make IPA use PM_EM
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the IPA-specific energy model code in favor of PM_EM which
does the same thing in a generic way. For more details, please read the
cover letter of the v7:

https://lore.kernel.org/lkml/20190812084235.21440-1-quentin.perret@arm.com/

Changes in v9:
 - Rebased on 5.4-rc5 and fixed conflicts with pm_qos changes

Changes in v8:
 - Fixed checkpatch errors (Rui)

Changes in v7
 - Added patch 02/04 to fix the build error reported by the kbuild bot

Changes in v6
 - Added Daniel's and Viresh's Acked-by to all patches

Changes in v5:
 - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
   appropriate ifdefery (Daniel)
 - Rebased on 5.2-rc2

Changes in v4:
 - Added Viresh's Acked-by to all 3 patches
 - Improved commit message of patch 3/3 to explain how it has no
   functional impact on existing users (Eduardo)

Changes in v3:
 - Changed warning message for unordered tables to something more
   explicit (Viresh)
 - Changed WARN() into a pr_err() for consistency

Changes in v2:
 - Fixed patch 01/03 to actually enable CONFIG_ENERGY_MODEL
 - Added "depends on ENERGY_MODEL" to IPA (Daniel)
 - Added check to bail out if the freq table is unsorted (Viresh)

Quentin Perret (4):
  arm64: defconfig: Enable CONFIG_ENERGY_MODEL
  PM / EM: Declare EM data types unconditionally
  thermal: cpu_cooling: Make the power-related code depend on IPA
  thermal: cpu_cooling: Migrate to using the EM framework

 arch/arm64/configs/defconfig  |   1 +
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 404 ++++++++++++++--------------------
 include/linux/energy_model.h  |   3 +-
 4 files changed, 167 insertions(+), 242 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog


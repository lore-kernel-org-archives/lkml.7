Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDABC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D5C206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkobSOBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLDJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:54:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37585 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfLDJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:54:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so2964869plb.4;
        Wed, 04 Dec 2019 01:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sy0TPVo2jYoLirOgnD0I5TlsFYusUGHr86X3IrbRM40=;
        b=jkobSOBwsTsp2VlFUJmtvhD8RQntjjl4FzcEViOOz1/cDyieTGtkwGd/ljvQH9vaRQ
         4mpmbSOlS7RVfutVY5OB/EJFLV/Ca0P6LDC0J6nStZf0JMn0BD7FhBWxiiCH9he1NWvp
         rdc8S0j8+qTa8+HCfQZOI3BoWy5lQB4lt/72qAiaJO14mt6HIdS2Ji2Bn0gD4iOwJbF1
         UN3poic2F4bR+qxO7CLO3CjC+GEeMm4/osXgDX0gkVinxe/NvB6Cf30IH8C6FwlpamXv
         mDDzjMAPHK92PMd1uvekFEad8qhtBbxvkqQy4xJ9ll6hUJTzRy3xN9j3Nu23kUFckVJj
         OueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sy0TPVo2jYoLirOgnD0I5TlsFYusUGHr86X3IrbRM40=;
        b=p7hii9u0BFFhCRrtQmypyA0kuSm8IlFjJneiEoG1xzMxl5xo0tqg2UDU9DOjR8d3Kp
         ziYWUXWo6Z0KhvnsaZLsSJuTnVdG+9OVU7KO3CXzV0BaeMXsatd+7OfSKQg7e7ooLgVh
         OSRfJj9Gu413NVdP+t/KIMNtmpeSU/jI4livQhxIJph6oAgS9MygxBwyKv2eV6ByiWof
         Vs2EPIB5/kz0bfvn1+oaUdTOW4HMDTRBW2aCB+Vf4J0v5/xIl25BJCerdbtIsVG99JvR
         dRDxPCMRNypQFr1p83rKNI6EcNKEreO7bYm2ONqSfuKlbzd6yA4yu7qo3PJl66DntBg5
         4adQ==
X-Gm-Message-State: APjAAAXtTa9cS1MLZJI543VL4CW3I9JH265g6u6l+KDRfJ5N6MfE55PI
        k47T+kbp+BflaigK3WMbkNA=
X-Google-Smtp-Source: APXvYqxo3ED3pddFuvzNz/kwQfbUAJnhiSak+AuYf3/mHFipcLJYTWEitA6+QsXxaIQk3P8mDxqRXw==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr2561717plr.195.1575453256706;
        Wed, 04 Dec 2019 01:54:16 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k101sm5941687pjb.5.2019.12.04.01.54.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 01:54:16 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some improvements for SIRF hwspinlock
Date:   Wed,  4 Dec 2019 17:53:30 +0800
Message-Id: <cover.1575452516.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set did some improvements for the SIRF hwspinlock driver,
including changing to use devm_xxx APIs and removing some redundant
pm runtime functions.

Baolin Wang (3):
  hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
  hwspinlock: sirf: Remove redundant PM runtime functions
  hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock
    controller

 drivers/hwspinlock/sirf_hwspinlock.c |   46 ++++++----------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

-- 
1.7.9.5


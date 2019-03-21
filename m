Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBBDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045A20828
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RM4oJsPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCUPvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:51:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41012 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfCUPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:50:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id 10so4947692lfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3wXLHVzDXPFkBZMI0BuFAmdtmlad1VCrH/M8cy5MXk=;
        b=RM4oJsPfY8JVYAUVzfBFIKEMPBxV6lpmzzNaKvt6DTdcQDw5ea8nkXaaaN9wN8ttUD
         OzZzvSvARN1SFt97evqiR2zOTkaqVTIWj0D6vcVv6S5fnNg4ThiW4O2tas01BKPxn9fD
         BTE2God/3t0g/t08to34bf0pP1CeeRMaJUunaPq3f6Iy89Opy2HsSqznEojo3jBuI3Pr
         RNIVrUKNcgPLfWHdoYKr0kDHQBYCbGvvgHLBxDMwQv41YwzOHgOFDMFpdK8xYaZPi7w3
         UvyHLGiNgQymnJaRfX885meObdMFyOid3EeEWnrtG9n8ocSiWM81dZoD5jKHE1/d071r
         kSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3wXLHVzDXPFkBZMI0BuFAmdtmlad1VCrH/M8cy5MXk=;
        b=Y6eg/7Lr5ZSapuvXT9fxXGz4tnjFXJ5CybKpT77wN1MzS4kFNt474Jfxom2wWPE85y
         CkGCfbpWsqf90UaXDRmryFTD2mippnDT0k0cnF/wAS9GJkuBB7sqc2T6vzKy8zIyyJXe
         8cbtjiuDCGmObQYS9IgemnCjaAwj+HAgVlVKH5K+jke/luRwmTdRDVJKXLIK1BOrEDEd
         SoSoZUxz5uiajpYxBvCj7L6CIN5+jLq1EfH6b3OvkSRjSZKhO6qrQ9f6c7c9bI/cLtE9
         B/1C4iJBCxK/rjRDDSopAe7WrID8w4FhCIB0/Dj2M2rk64C++SAOT0l7dG66z0UUvc7V
         Rlmg==
X-Gm-Message-State: APjAAAW/fgmOJ/tyFH08uljOulm/aJuTR86vHnfLfV8AU8MeKJW3HHXA
        q7Ky38SNi55MJVK2FIjfuGbWKQ==
X-Google-Smtp-Source: APXvYqyYbEbt9+AtrcSCrfv94hDg8xArgkLMl6VsifQ+pulf+zGZfwiYII5P4MBbP+MkUwl8wGzgRA==
X-Received: by 2002:a19:7114:: with SMTP id m20mr2427066lfc.63.1553183457474;
        Thu, 21 Mar 2019 08:50:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t81sm1016925lff.21.2019.03.21.08.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 08:50:56 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] MAINTAINERS: Add mailing list for the interconnect API
Date:   Thu, 21 Mar 2019 17:50:50 +0200
Message-Id: <20190321155050.25847-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mailing list for patch reviews and discussions related to tuning
the on-chip interconnects. For now i am not expecting a lot of traffic,
so let's use the linux-pm@ list.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Hi Rafael,
Please ack the patch if you don't mind this.
Thanks!

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..186439e7f846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8046,6 +8046,7 @@ F:	drivers/gpio/gpio-intel-mid.c
 
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
+L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/interconnect/
 F:	Documentation/devicetree/bindings/interconnect/

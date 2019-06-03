Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE4E24195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="S8UE6Niz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFCW32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44256 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFCW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so14827815lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lotckpB9JDGufjXUBLNpzfaUpLyROHUdRLX7HI7aSjo=;
        b=S8UE6Nizd9DR8uXXnMt5q1r4wE6I1t7G4f7buUX62EJo0eih0hAsVtTRk0mKmFzfQ3
         HfjRZbzI2Ynb0aBuOXbc4Rt03bBQWwdiB+kdES2Q3KQIjZv968Dh7ao9wcqb1VaOmRE4
         ZxOTbnoLY+ck3z/4Un2wRdJ4NQLOQFPuwZAIjDRA8GD61qCDuc5ko789/nt3LwJ28X3x
         a9frEiz+0ISc4yoFKg6JUiIATQtoiVASMrxPbThkGyL3IXq+XWx+ZmR0UUeQrLHi/jCr
         Ca6WgrCiQoE9OpDQVWYaPQwPqh50EY3Myk1ZlX30fVScJzJP1PXMy2s5CY3OlyYNRJnq
         fa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lotckpB9JDGufjXUBLNpzfaUpLyROHUdRLX7HI7aSjo=;
        b=NEu6RkxLNYTDrYiUZtLsGt4/N+T7sk2jYu0MJxBNkcPy67x0vOpMmDLgs3rN07SvST
         dklGQQa/WgAsrBLUXpdPrmBOtsfL8MSO/nu9NxefLfSGc2i6THSVkE0TYy3iEQ4T4FNT
         7eD1uBvz0ApJhmO3H0ldz26DiTbnPbdtUdVkhrF4NoTC2epJz7a/k+32BNPtXABhB0Qq
         E9k8YV/JCs1xdgEOoVi2QHGKfqHwXpQCJtda1jx0anfwUvzdb3jqSFvIDezjYB72Dti9
         b3+l11vbsNm/QsPXgxg/FIxbI0pWgIYxYQdkRAtyGo/LSitELBT5SNHSMDLlfCCvwqwx
         CIUw==
X-Gm-Message-State: APjAAAWpv36ViUGCTVvynzGM+Aps1PIAkQYh4owMXn5JRpQCdVyGUwOX
        ypvzBW/MeCqS9heel8k3Em7BkA==
X-Google-Smtp-Source: APXvYqx9D4P502pEavHEC5T/D/rR+M+a8fR1JlW21qowintKJw4j7HJM4AshcFS+rtThQEwqGAYS8A==
X-Received: by 2002:ac2:4209:: with SMTP id y9mr14221333lfh.83.1559600964953;
        Mon, 03 Jun 2019 15:29:24 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:24 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: kpc2000: remove unnecessary include in core.c
Date:   Tue,  4 Jun 2019 00:29:14 +0200
Message-Id: <20190603222916.20698-6-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Use #include <linux/io.h> instead of
<asm/io.h>".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 6d4fc1f37c9f..3f17566a9d03 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -12,7 +12,6 @@
 #include <linux/cdev.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
-#include <asm/io.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>
 #include <linux/platform_device.h>
-- 
2.20.1


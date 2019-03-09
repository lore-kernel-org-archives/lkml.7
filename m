Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDD72081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CxSzSgs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCIEY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:24:59 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47330 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCIEY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:24:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 6D4F4D88
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H6hMJ5scf6tN for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:24:57 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3F54AD7B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:24:57 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id g3so16925352ioh.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ehEIpCPacJfov5ndAxPWAlvAbToRoZroygpBuzor558=;
        b=CxSzSgs9jJfGJLfvwVeGWiIJfj35n0az4WvIO8EavcRaGuEDMPGfkp1DRBKnb1hdt4
         IxJyRHcc8o9EOlN7eEpkQRFTKHSjHJ2pfCzq+iEnn4LdLG2JA4DDQPMnxRY4YgR5wDWj
         mvopNWLD5GmNcMtmN6tc8g0T+x0z1D61hFWU9uMm7QBXFXfQYXbRn37pmlgNeWQiQuZN
         2u+isAILk2hnoKFGH4I5YRNRfeRGFK5BQGQKlRbXTHJZO9LiKY71Q323oXEir+bP85JT
         S2LNROhwD+n1uqhTa68yCYLrwPnz4DUcDPYej31fCMubcFnXJQzsrRnf5lv0/3YIhVuW
         bXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehEIpCPacJfov5ndAxPWAlvAbToRoZroygpBuzor558=;
        b=m9l4spIOAwfzitblz8u9Nmf7hM/XCW6QABWzkyLJMu3115oMkkJpSkIeGjekxtETDy
         VjVaQjHQxEMcCp/b394Rt3YcbnA+NHQ8EKpST4L1ytIuzSKhbOSbl+7GIxYqCGkXBwJr
         myX5j0uRX+vtlIPaDhlbhNlmGtekodiDgOsu7cPaRUviSQ7Tst/tp/EwdwCY43l3SttM
         6hrQ0XesHzlfaSSVE6XgYuf2xIDxHQFCZokUrs2SL4ZP4iR9PjxOqGbjRoT2eO9FBNYD
         DCjMCXGDcgf1fJPNaKbWbrEjGFG6yEanZc7ukM7UEy/gsqauiOBfCciJqmipvIihx9Tb
         RmeA==
X-Gm-Message-State: APjAAAX8kRDGN3nXJvDaOYCa6uX+RI5YsEUYj753Dz/KzM/md1Wn5Mud
        GPvGaviA0VJWEGJoSFUF95OdCsAU+xSEsUN8eupddP4u7h7NL5qorTg9itvZTI55ERN8bip+6OD
        0We0f4p2kGqnggnn/iX806CSP5GSf
X-Received: by 2002:a6b:e608:: with SMTP id g8mr12060597ioh.188.1552105496544;
        Fri, 08 Mar 2019 20:24:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyD2wPkM4tveOpnEy6CUMu08svaGx3WPCoER8ruyDZ0iynDLF54UG5St7YOlrmdw9xhEu4Q2w==
X-Received: by 2002:a6b:e608:: with SMTP id g8mr12060589ioh.188.1552105496308;
        Fri, 08 Mar 2019 20:24:56 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id d6sm3787611ioc.44.2019.03.08.20.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:24:55 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: i915: fix a missing check of get_free_page
Date:   Fri,  8 Mar 2019 22:24:50 -0600
Message-Id: <20190309042450.4188-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the allocation fails, return false to avoid potential
NULL pointer dereference

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 9a65341fec09..ad54fc3551df 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -227,8 +227,11 @@ static bool compress_init(struct compress *c)
 	}
 
 	c->tmp = NULL;
-	if (i915_has_memcpy_from_wc())
+	if (i915_has_memcpy_from_wc()) {
 		c->tmp = (void *)__get_free_page(GFP_ATOMIC | __GFP_NOWARN);
+		if (!c->tmp)
+			return false;
+	}
 
 	return true;
 }
-- 
2.17.1


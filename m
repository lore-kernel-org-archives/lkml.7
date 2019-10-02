Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C0AECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5521920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BzZzg2bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfJBQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54612 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfJBQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so7884055wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRFi4rfGVxo/22nPvuuu86rpUTMyTPBuv+pN3ClhaRA=;
        b=BzZzg2bJ7NBTDqS6TlK6sZp+14BNTwAU5b9IQ8LXsUVrttws1RwGRLhGA65o7rpKT+
         z/7uCkEmsywxKA2xgLrN76TwL+6tE6ZmF7lAc3b494frNcm4VrUlY4SIK+6HKB2qA1/o
         qdL42Em3EAg7qec/Qxiy183vPIyh8gkhYMOhES5GcHnvhDsdUqoEXQEEsljcoWwwF5Ok
         toZRnMgqrmIMETpidWWTwY+QOQ3+y26dAWvxIhNbhuU8lnwHE/TL71TGRaieTiCZOiAn
         6WOSTDUF46pzZ+JCIlPM4cu3bZggZ2UMUNR61umTcDNDyCl9M5kzAvUGg2FQX3FxCiiR
         qlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRFi4rfGVxo/22nPvuuu86rpUTMyTPBuv+pN3ClhaRA=;
        b=FdU9xR9Zy5NXV0yuXb6F8UWZjX4EYw3T2L3vTJAewnyiHGQ2yGKMtW9+CXu8X+dZTx
         RW6La1RKOuRje5fntL6oPJcM0G3UEWWbuerg+tJ0sCKUNpr6zkWtOpVZBcxQy3G3zxFz
         /iZUDlXhh4omCPg2DxQx85cV8IEOXVMfSsj+sYACX1XwqNmf7ib7tjA3SuA5/AdqkYgu
         O0U9S7WBy/mnMx3de7ggFpDSLxK5LUfU3pWFabuxaxh+WkI1AvnCuokqWA4cSselDItz
         yIvHu1zAvdGvrbVxv2IY4QWbKII4RJ15aukl6CJTymBbC3RMzetwcUfhuLLQQEpQchoL
         VZZQ==
X-Gm-Message-State: APjAAAXUSTMafMiuO8//M8aIKjm0hIAaOoDhPTU2GBloRUpteIt4B8bj
        UEyU37wWSms3rnz+yj00ARdxgg==
X-Google-Smtp-Source: APXvYqz2z7eJu+lmpcal5gG8NewORG7oMMRF1eXCTyrmNkUXsgpQ5bbwR5V9zRM080JcHnfrq1CIKA==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr3596645wmb.27.1570033540142;
        Wed, 02 Oct 2019 09:25:40 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/5] Documentation: devres: add missing entry for devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 18:25:30 +0200
Message-Id: <20191002162534.3967-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002162534.3967-1-brgl@bgdev.pl>
References: <20191002162534.3967-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

devm_platform_ioremap_resource() should be documented in devres.rst.
Add the missing entry.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index a100bef54952..8e3087662daf 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -316,6 +316,7 @@ IOMAP
   devm_ioremap_nocache()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
+  devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_iounmap()
   pcim_iomap()
   pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
-- 
2.23.0


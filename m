Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB18C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F8F20867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oVl5LU49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfJFFjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:39:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38722 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJFFjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so5168790plq.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRFi4rfGVxo/22nPvuuu86rpUTMyTPBuv+pN3ClhaRA=;
        b=oVl5LU49d89LqIDZeOa9aYk0vwmjcd/sZs05Bv/MkQ2z7kCcMMD7wR3CrikSxuG07M
         PYdoWglIcyD6VOXZMp8QOhPv/4QDpAz5xbQj3UePlyw8f36K0Fam2vFDHI4xsO4W8TSY
         vPJtEd0iEnyBsY6knGqEPjZsqcoQPmyhHLY+IgfxkViA/RLe6JKUqMw5qaNmLBbQ21yj
         wJ0EIxr7ij2yQbw7K72WlF5s5RlsFLOYY+/PEFzh53N4v/Z9tOMVtJ+IfdMxZtyTw4z3
         o9RWSsjlNK5AhvsN8rQY0MNeblgvq4atWji2anPe1F12TUuIpeIsa+uJX4VJjjXs05uJ
         WXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRFi4rfGVxo/22nPvuuu86rpUTMyTPBuv+pN3ClhaRA=;
        b=t2eZXLjpg4E+/tTC1S56g2azLC9P0unCihhVsCaMAYUWkBUfjEPnPwBaSUkBBhrSs4
         Ohigd4o7QLnvG9LVz972XxN255F/XxN2L8x7KYf3jQxalWydYNVjwLfCxcbXX2oVFpa3
         jSKwg4ZlcFt57BxlxkNBdpBXbLcesXekEjkCIbmzGNodQ3BLaFpvyiuzAi0WMfZtNDT1
         7LPNyjqjqg3RoJmHUYREw1H37nXBVWDioJGiHuL6G/OqFKlSVboW3GWr+CdR6sBYF+hV
         YBG40+1cpaml9XgtKPUUktjIxcfN2scEYajO6rnoZ2PaHlBP+BFYBbbgZ8v1Feo/11dx
         CBWA==
X-Gm-Message-State: APjAAAWZ8eD+w5J8f2MyMFbh+umViP6T5XT/2WN9EN1PHxL+ftKgQZUm
        gloXNPca4tbUaWT/YzPzPez8zA==
X-Google-Smtp-Source: APXvYqySY6t5rz3QEK4U7cpA6VIPiaiWwSW6FZVB45BlCnEniS3t1SoUBNk7RCscBZ+4i6EgqgCKvQ==
X-Received: by 2002:a17:902:bc46:: with SMTP id t6mr23561392plz.307.1570340378268;
        Sat, 05 Oct 2019 22:39:38 -0700 (PDT)
Received: from debian-brgl.local (50-255-47-209-static.hfc.comcastbusiness.net. [50.255.47.209])
        by smtp.gmail.com with ESMTPSA id q30sm10019320pja.18.2019.10.05.22.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:39:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/8] Documentation: devres: add missing entry for devm_platform_ioremap_resource()
Date:   Sun,  6 Oct 2019 07:39:09 +0200
Message-Id: <20191006053916.8849-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006053916.8849-1-brgl@bgdev.pl>
References: <20191006053916.8849-1-brgl@bgdev.pl>
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


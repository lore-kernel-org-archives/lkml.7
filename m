Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF012C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B720838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fWJHS0KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfGNTea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 15:34:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46275 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfGNTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 15:34:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so14805861wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhnuICTjRq23HCJQ5Jg+Jm2C50pDZEMDXOMuwqOun54=;
        b=fWJHS0KOjOoXlcCgFk5sM+yTro6WdlPFpC8ezD73k21HuEy/AKr3Xh9JcV+lcWNRhi
         9LZmQ17q/aHtAzNyJtt0GXkd8MppSyBdFZPwXD8cEK58OF7ORCMnr5uP1SZYES5eFgoC
         3jOJtl4yyEY7LfKshSUtbhEyZQAMYTcWlWtNqNA1da7Lm4XwHkpuXUnDzVGzzzxysGTh
         IFeJLcKy0+yo07+5A5MdHEAGod6ux2WjdCpqnjXVvK7eSjWZOEvW3zduMX895VZWs7GD
         ydKfOlcUvJJWCRKXb6e0omDNsZu2A3TVXBrgC71noqjrG7TaMRxPMOFttzoglDu7K9eJ
         fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhnuICTjRq23HCJQ5Jg+Jm2C50pDZEMDXOMuwqOun54=;
        b=gVHxRtgI+OoffzFBGVBbGe6t3oMLXZ56DVqazjH5i8pQwBwK6ykiNP2hiY8iyahuEu
         30RjDeNJmfprZlHv1MQ9b6IOjvycE52XDDKvWAnnb6edsc+jEZwb3X3mG0iGYwAcWyKy
         5KoWPEOvRaXPA2kB0fEU+w0LLyhQZ33fAbOwlnHHV8n1LlOIZCD+pQj63GJgSkumO5cq
         /aER1p7pblf8Lbfp6aKKPtUjtbQgKgxYblGBMCqdMGnUI98KGvsGbGzy7oboiZglypTf
         9iWb39B9vhMmxVCc9DbhEEMtPG0yRUcLJylCx275BzMIBKJauly3Ox9lGdkBL1OMIZw/
         ePCQ==
X-Gm-Message-State: APjAAAVBmuMHLHBkw8rsEdwCSbAdGRBWg0ULeVAbQsA+fHBMiXCMTmF5
        qmXDC7pWOMXGG4sKBJf6lP+034chcfE=
X-Google-Smtp-Source: APXvYqxLdMe0yMtuIfgMLk7wTunNEL8RaXusTBPLFBdOC1Nqf5aM0RDfTsJtvxlssPJAjpw9MJQmDA==
X-Received: by 2002:a5d:4ac3:: with SMTP id y3mr24972454wrs.187.1563132867809;
        Sun, 14 Jul 2019 12:34:27 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id t13sm16558937wrr.0.2019.07.14.12.34.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 12:34:27 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] MAINTAINERS: add new entry for pidfd api
Date:   Sun, 14 Jul 2019 21:33:44 +0200
Message-Id: <20190714193344.29100-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add me as a maintainer for pidfd stuff. This way we can easily see when
changes come in and people know who to yell at.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1be025959be9..e8a2e44656cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
 F:	arch/arm/mach-picoxcell/
 F:	drivers/crypto/picoxcell*
 
+PIDFD API
+M:	Christian Brauner <christian@brauner.io>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+F:	samples/pidfd/
+F:	tools/testing/selftests/pidfd/
+K:	(?i)pidfd
+K:	(?i)clone3
+K:	\b(clone_args|kernel_clone_args)\b
+N:	pidfd
+
 PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-gpio@vger.kernel.org
-- 
2.22.0


Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EA4C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B08F2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnuUwkk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfKGLT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:19:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:19:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1967721wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwdRFDOXkMcHZuF7dT3xdj3njNrFX7fm3v4BU31vZyk=;
        b=tnuUwkk9ZmM2/TYgNZYHyFz6ylE2usvhuyCX/ajLgnZUOknA13MLnl+Uo7bIqL74eb
         nLLfx7EIhM0AEHzaHt3LwRFsOuZCEL9zRLrfMz8/wMdBexw6giTTUqnizP81QyJJsgTx
         0E4oeLldDhsfz5+Zzl54IoWXeeUKDhHeOHg0mR1Ez8s4K8jFl7csKx6u5hJOpbmcQgYQ
         PwqYSvbZ1u7N927ATftjr5mzVu1XN+ifUJgClGSC5tguZFmmAl+Xw6Jr3ugorTuH8dL7
         fyT4c6qoAbWYGNUjmsgQbm9iBMhREF3CMrGRYQmQg6x/SzkbHojzmjW77SJLLtdiR1vF
         Q8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwdRFDOXkMcHZuF7dT3xdj3njNrFX7fm3v4BU31vZyk=;
        b=BMdNjrLo7WFiwCZrr8GD9YwbSvvFvhRbmVzk/SZOexCvnvPP3QYxVI7WGt0HI2P1+w
         UZBD5YluUoUEF5imZQLEh4lYUIsDWj7MAU1P/mV+rEp00nx/+zt067JiROPPjxorfqab
         2rNDQWOdn1juUiNCtwLen/xNs6Rvtg9VH36PdrZFpGIphFXDjRna8ZwLeZD0FWS5/SUC
         3xFO4og9B99Xpsh6iwkSev3SaLKuLwnJnFRatLoLqaz4jygok89GuOEP6NmBqVqxc9vc
         x1soE7w/HNqnJWhTI/uaeZDBDtln9esze9ukBFXB79QxjKw9lMUNDaBKOXXrfJlzvjv2
         whoA==
X-Gm-Message-State: APjAAAW7IArZ+mJ6W2D5o4jvSNGKx/uG98wtYk2YbkUZGcm59eA+Q3lw
        i18R74xTjjlPQxsQ3jsqMUMQJQ==
X-Google-Smtp-Source: APXvYqxEPRhIVj+JQur9UlC44Bjo5MEJwHKQbFmC1ZGMMz3NkKm9ScOCnspb3A8Tfggc1Z+2SEmicg==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr2207030wml.99.1573125593844;
        Thu, 07 Nov 2019 03:19:53 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm2566002wrf.80.2019.11.07.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 03:19:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org, arnd@arndb.de,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>,
        Barry Song <Baohua.Song@csr.com>
Subject: [PATCH 1/1] mfd: mfd-core: Honour Device Tree's request to disable a child-device
Date:   Thu,  7 Nov 2019 11:19:50 +0000
Message-Id: <20191107111950.1189-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, MFD has assumed all child devices passed to it (via
mfd_cells) are to be registered. It does not take into account
requests from Device Tree and the like to disable child devices
on a per-platform basis.

Well now it does.

Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
Link: https://lkml.org/lkml/2019/8/22/1350

Reported-by: Barry Song <Baohua.Song@csr.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index cb3e0a14bbdd..f5a73af60dd4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -152,6 +152,11 @@ static int mfd_add_device(struct device *parent, int id,
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				if (!of_device_is_available(np)) {
+					/* Ignore disabled devices error free */
+					ret = 0;
+					goto fail_alias;
+				}
 				pdev->dev.of_node = np;
 				pdev->dev.fwnode = &np->fwnode;
 				break;
-- 
2.24.0


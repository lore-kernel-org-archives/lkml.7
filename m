Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFBC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A1020725
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpu4xCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLURaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:30:35 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46132 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:30:34 -0500
Received: by mail-pf1-f174.google.com with SMTP id y14so6967335pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tA5n+MS99hLt7UrGO5aQuIcYbHEyaKTUjD6lDsujPqU=;
        b=jLpu4xCdCF7/gqPm5AADxSMJv9kYQnm+VzK6QiLtk8WXYyP3o9iKtEUTQEQi4Q6AQP
         TuVHapjeOs4pQntlxvtDryBfeMVSXf/Jk+l9v6S1uvCiqhN7F0uOYqboD43wNZYpkBEg
         UcV+A3D+tCAAjiJoN2Hc/YF8YmFogl4Fjvm9epQVTyOtsajlmyOGUvr2u/ZPL3NwfWSm
         D8E0rRb4kAyY2mq2q/v1tih9pFEMy7UAeoq+o+8qUG06q3MgOTWP3gLK4zZRBH1orr6X
         ArnTbjY96XqHRL8asCZXPYh7gKe1oE/ypwWm0KUddTe9bMuMSgWW/ptUaSCBEcWy6GwF
         cNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tA5n+MS99hLt7UrGO5aQuIcYbHEyaKTUjD6lDsujPqU=;
        b=T3u8cSv5FUCRzd+wvCRjPUX7X8DA3G/u7UtrcJnBEis1XUu64Wr7HLYyWMw/nKt/is
         0NfNf9hhk7sr36ZfQKcQc4GceVHk9qHJGaI2+kZJgh20lzl9kL3aCrYkfggXk/ez2+xu
         Qq/fIp3OSLLUnSLN+Jk8JGsCHKFULtBrltiOibgn0qd8AjMdNzWdY1kdb82V2fYBZOuO
         vVSB4oU3LgW+SETLJZqBe5YEMBdkvjHKx6mPF1mgGX13jEvXBkgQY8UpkLMtO6yAEyQG
         XozTcFQLMbHNJ9iUxk+D6y6CgNhejsbEnDNsodCfsBuSkd3zePLmHGWbZbUFCJh5h2bc
         5y7Q==
X-Gm-Message-State: APjAAAUFtNfvBxJCdUEWC/d8N8gHK5wVeKLz1c11AQ/XTkgqFeq/Va1h
        ewY0wfOkiBZyVkriCw7zxlY=
X-Google-Smtp-Source: APXvYqw7uM4AfJR6AyG3FMicAztoDoM/GI7ymDap2IbyRGF3fYlm5WFjuvobVFixhDfIhDw6o9nPpA==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr22687574pfq.14.1576949434011;
        Sat, 21 Dec 2019 09:30:34 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r66sm18282015pfc.74.2019.12.21.09.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:30:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 0/4] clocksource: do some cleanup
Date:   Sat, 21 Dec 2019 17:30:23 +0000
Message-Id: <20191221173027.30716-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. convert to devm_platform_ioremap_resource api
2. switch to platform_get_irq
3. a small fix

v2:
-split changes to two patch

Yangtao Li (4):
  clocksource: em_sti: convert to devm_platform_ioremap_resource
  clocksource: em_sti: fix variable declaration in em_sti_probe
  clocksource: timer-ti-dm: convert to devm_platform_ioremap_resource
  clocksource: timer-ti-dm: switch to platform_get_irq

 drivers/clocksource/em_sti.c      |  7 ++-----
 drivers/clocksource/timer-ti-dm.c | 18 ++++--------------
 2 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.17.1


Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1253BC5B57F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A75208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwuH2uaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfF3VEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfF3VEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so10907552ljc.11;
        Sun, 30 Jun 2019 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=GwuH2uazD7a5fjNzYLECCC4dX4M3f6c3wMYJiSK8d3xDdkqY0BcgeElJry3jLCOjhg
         1MPBGK02Tn9HjanuDNOfm7fCMX6gPvL7wQ5+CxV3RQM8fHdSMzjTr3PAbADmAn/iAwq1
         DKt9WOQWTyc+JTJ4zcnHWq4rXrDK0qKeEHGUG9g+cmdHpNMOFbk5XgCZo2TO/RYg2AVf
         MZ0pd08IoqwIg/J/INcXHNwNsOqfWUywQ3VT9qZyuhg7DspMkJRXAdaw/I76ds8blQ3+
         embNhAkgCxSeH2wKmwssenScLFfs9KzfAN0coU/znHZYxefW5QVempfoWfzZRqgaOxzD
         t7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=a0DWVd9B9WZZTybeACxwQMFZ0qvBi95bwWwVHoPh4pa+ajPgSRqUwQl0gp1OmYdnlV
         jvuU0Deby3MPBHMbIP6P3rUhLnVVqo/2DT+kqBuTp4ZcsOoprGbkmW9VOjUM4j3AkKhR
         ke7lbc18CcZ4xFZVXacptakgoAnhBHlcsihwvNmPWUIGEt6ZDPDxQj4Cvc1G7BDy1bJl
         BN4ZmAloVilZwx5mAVvilNDWU4o4df4veW6/zPMFlnwjAw9PYxUbOE0k8Z37Kipwweq2
         SjIiqhVGxhbJoEsL6BsWQ3w95aaHvMtEBhDGfgJ7SVtYgaXi/DqscXXzMmIRvVWPqB4S
         H2aw==
X-Gm-Message-State: APjAAAUVbgccIzPEdiEpAhlOS7wxfJUp3mTQkl9e6SMm2jPzhKmeuZFB
        Ndw0qeOUsNV3OTf9KPH3H9Q=
X-Google-Smtp-Source: APXvYqz1gbCAO5FXx7jWCEQUDrL4yEr+Os4/tmGK2gQRAIZxBRTx7k0VfEu3P/AqQR6pDstvj4158Q==
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr12351177ljj.129.1561928680719;
        Sun, 30 Jun 2019 14:04:40 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/15] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Mon,  1 Jul 2019 00:00:08 +0300
Message-Id: <20190630210019.26914-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b519f02b0ee9..1ce351dd5461 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.22.0


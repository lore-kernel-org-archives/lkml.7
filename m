Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62808C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA22175B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn4km8bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDNSGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:06:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44653 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:06:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so7423887pll.11;
        Sun, 14 Apr 2019 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Wp9ZX4IrDtvv191nSQHNek0qy8aM14PPdz/DGwaRqw=;
        b=Jn4km8bEyVSa/GSNPQfTxL2VtM2UGH2BW5cP8LqdbkCHOer9MZtckcTLjnevSHR+B6
         AVJ92NF0vmXJX4qvr1J6dR6pLrVs0BF5AJl3nScD6sxSjd/PwArlgjRrXIdmiRcni/i8
         +PJnm4fxvBqwICcxyRHtae2E3oFlGsskC0YM5FW9Oa/8xZAISIyu590Kn1ebGPuGZEWG
         JK9PDHXd3ziTMRhYtet25oD30Fz0MTIhYcqeBG8AzhcJ374p7T2ZWjKhoBoR5KDdpkQT
         tM0l1zh30Z9b9wBRkm1U9dk0eTQy8NRee14QSXglu3QJMchaYtHfWQZULOSTrmjZjys/
         tjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Wp9ZX4IrDtvv191nSQHNek0qy8aM14PPdz/DGwaRqw=;
        b=n0OlOlLs1AWhe1yqdPwLpqCHcz6YcxThFwj17TepXKrQKuD0/pigLcXdP8QU28TfKO
         6xLYidwakAQ5pi/8SaUiskBAIrsTAFWpJIzSoildV3/iPymQ6H4UNvsA04MmIyYAOmlr
         m89TiSDTZTw4ifgFCgLoq4UPhFKtKbvcpnDj+nbzDjAFT2Hq5MaC15GoeLUdziBAAd6/
         DFctLNQ9IoLtYhSAqNwGs4sUzraSkYNvqbL14zvDs8qmb9uOK+LCfj+J1NjY3yWkBGdY
         Az3CiGAr8/L2WAzD/dgHXneCKjBxgkwiN5LKU6xVQEVbDBbW8oPO6DBudaCKpsiZcZ6a
         Qfpw==
X-Gm-Message-State: APjAAAW2H0rrb6Vu4QwdByUzhUu1jT8GgPT6HVfSQLj513agVkqplz4x
        Kq06WcLlKiMb1ssgbtxy1A4=
X-Google-Smtp-Source: APXvYqyx1LKs5dsK0RofeD/yNfbOJIc+3HKTwVjSw7EnSwVVelSty02wgHRzLibNZTng75TRiBLdyA==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12mr21580007plb.192.1555265169312;
        Sun, 14 Apr 2019 11:06:09 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:06:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/6] regulator: core Bump MAX_COUPLED to 3
Date:   Sun, 14 Apr 2019 20:59:37 +0300
Message-Id: <20190414175939.12368-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
References: <20190414175939.12368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra20 SoC's couple 3 regulators, bump the MAX_COUPLED accordingly
to support that case of coupling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 25c5a1862af2..25826f2b0ceb 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,7 +15,7 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
-#define MAX_COUPLED		2
+#define MAX_COUPLED		3
 
 #include <linux/device.h>
 #include <linux/notifier.h>
-- 
2.21.0


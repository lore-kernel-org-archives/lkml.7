Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922C720818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9aDlQBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGQGMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:12:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38988 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfGQGMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:12:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so11391344pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX8hf9utWo00QXSsxtdhEp75HuksEWkyDN5DV1hGs/c=;
        b=C9aDlQBqiWF6wX4UpDuCRAK0wSVSUY8S4julEUtAgSAQ4JK2huok+EwaIQyXMDSmoP
         FJfMYo7rE64OK5UFoprt8hIW3B0WFiNnIi9f0CwJ8EJsUrnyNI/uI6dZdah5yhJ4Y3QN
         JjVo8YUwD0dBemQZMYmyko/aTBBuk3ZFd6Se0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX8hf9utWo00QXSsxtdhEp75HuksEWkyDN5DV1hGs/c=;
        b=KjPd/LkQ2Dt9H7fE3gSzmQwpbfU9tb9wHdaDU6FcVtTNs+EJqON/4G0i/ZsgzDXC0R
         JwKHdoIWbDZzmlGMCXpbUvNbBcu4BE7QgZy0UeN1rcRAuy5fCQK0huJL+kf+TJuA0QTQ
         0xgyWjTiM3ByM7Cw925JFeCNzIqVSBvM5eELH6Gxigek6awD4GOfzQuEilOxIeQdscxm
         jDJ8aottnn4dmt+1xLMbqJXEnCaxSURy2qEBmlbqz9I27ejP1NvSEDW80KF9FWp6atpB
         04ZM1QiipEFQ4CuCNrrGl0KQHWZOps7XblFffXnzWgdHM+wEGCzU+7/ppWgJY8ffsJQc
         Lmyg==
X-Gm-Message-State: APjAAAWFVn/rQlm8m30hCJ0BdegDJ7+0hgRCE4fOFHidta8x3QF+XDfq
        eTuCgbbmSZjPbYXm7Rohgj2oMw==
X-Google-Smtp-Source: APXvYqxNE13JnywfYhewdRhwTWC8GYKJF1jON6Pv+BmrCJJvKvetxpRVsPZ30aJ03cT3aBK85DHdQQ==
X-Received: by 2002:a17:902:b43:: with SMTP id 61mr41949977plq.322.1563343935979;
        Tue, 16 Jul 2019 23:12:15 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id y23sm24079706pfo.106.2019.07.16.23.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 23:12:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/2] Use cpu based scaling passive governor for MT8183 CCI
Date:   Wed, 17 Jul 2019 14:11:23 +0800
Message-Id: <20190717061124.453-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on following series:
1. mt8183 cpufreq and cci devfreq from andrew-sh.cheng
https://patchwork.kernel.org/cover/10946047/

2. cpu based scaling support to passive_governor from Sibi Sankar
https://lore.kernel.org/patchwork/patch/1101049/

This series uses cpu based scaling passive governor for mt8183-cci to improve
performance and deal with shared regulator voltage setting issue.

Hsin-Yi Wang (2):
  devfreq: mt8183-cci: using cpu based scaling passive_governor
  cpufreq: mediatek: Support vproc shared by multiple component

 drivers/cpufreq/mediatek-cpufreq.c   |  16 +-
 drivers/devfreq/mt8183-cci-devfreq.c | 239 +++++++--------------------
 2 files changed, 68 insertions(+), 187 deletions(-)

-- 
2.20.1


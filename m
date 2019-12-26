Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BCC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE56206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i8vuntsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLZTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:12:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 14:12:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so11719361wru.4;
        Thu, 26 Dec 2019 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o51048wYw9BEZaiitxLj90ZEMjEnTK72AipdZVc4KuA=;
        b=i8vuntspkDhdm9kb7ZKWY0l4L1kEyaFhXOKywZwoQEtIaTXSCJ21zDm6faFsybW7u/
         rYJ0iw3mK/ofkusOEzVsR4Czh4xj7ICqWfnKe0hRA08VcrczuT6A6HIUmZlrtUKj166M
         Q36OV++Jsv1YL+0YSYhnbDj206025nkSTx+JaHQg8BHZkA16NAlmZ4tr3IxMB/bQTm8b
         C3mIqUNInWBkia2ZA64gUEB4yOEJZQydUbNm/6mjCS+BXBHg4pe4rtQePnS9FnN9Ts7l
         1pTSRiMRAO9R5EaL9MLhurhiHxtu3+Jpk8qGoVdgX4Wgu5UgSuHly8WSQhO+4dGm5E79
         TBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o51048wYw9BEZaiitxLj90ZEMjEnTK72AipdZVc4KuA=;
        b=fplzXlBACgHW7s0Lrnm3TM+o2001fsiiaNL4NYWcYfnta0HswPz8wII6lhBTF+/7jN
         xf4fm2uQaFRiK+dIKzSeGxdWJ054R5k2gqRPIW7l2z5ywFXezzVUL8JWD0ofyhq8LWfB
         FTOmAVF71iPB0Tw7d5hAxzc3e4MT1q1wVODJ+x3mhnnD3eIM1PS67fLd70p0x7gRToVd
         zm279xbi7nIFP7hDRhKpf1UsT601OtzWbsxJqYFu09CFQwxe4eGVhuGZHRTAWhYhl3tS
         UH8V/vG9Wcy9kWGzJezBUPoRUPqNO9V81WZ8aHTnWAo0yrVzZDiqGBe7yqGWu41nfPmu
         u7Pw==
X-Gm-Message-State: APjAAAX2paWV8jFxp/Rhm+rvvlyLXug6t31mUNtCio1kZv3Ad9hS3bV0
        hIgK8FgGPVMs+2C1hbwcdXVbtPDAXhs=
X-Google-Smtp-Source: APXvYqyLfiM/yY8EI/4Sm/i06hdMrdhfhj1HyNFKjcjBqFpoHTDendyzweHnTqvKQ5F4jw+c9GzBnQ==
X-Received: by 2002:adf:e609:: with SMTP id p9mr45201687wrm.397.1577387563096;
        Thu, 26 Dec 2019 11:12:43 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o7sm8965937wmh.11.2019.12.26.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:12:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        sboyd@kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] clk: Meson8/8b/8m2: fix the mali clock flags
Date:   Thu, 26 Dec 2019 20:12:22 +0100
Message-Id: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with devfreq support for the lima driver I experienced
sporadic (random) system lockups. It turned out that this was in
certain cases when changing the mali clock.

The Amlogic vendor GPU platform driver (which is responsible for
changing the clock frequency) uses the following pattern when updating
the mali clock rate:
- at initialization: initialize the two mali_0 and mali_1 clock trees
  with a default setting and enable both clocks
- when changing the clock frequency:
-- set HHI_MALI_CLK_CNTL[31] to temporarily use the mali_1 clock output
-- update the mali_0 clock tree (set the mux, divider, etc.)
-- clear HHI_MALI_CLK_CNTL[31] to temporarily use the mali_0 clock
   output again

With the common clock framework we can even do better:
by setting CLK_SET_RATE_PARENT for the mali_0 and mali_1 output gates
we can force the common clock framework to update the "inactive" clock
and then switch to it's output.

I only tested this patch for a limited time only (approx. 2 hours).
So far I couldn't reproduce the sporadic system lockups with it.
However, broader testing would be great so I would like this to be
applied for -next.

Changes since v1 at [0]:
- extend the existing comment in patch #1 to describe how the glitch-
  free mux works with the CCF
- slightly updated the patch description of patch #1 to clarify that
  the "mali_0" or "mali_1" trees must not be changed while running
- add patch #2 to update the clk_set_rate() kerneldoc because we agreed
  that clk_set_rate() should do a root-to-leaf update (it does already,
  it's just not documented)


[0] https://patchwork.kernel.org/cover/11293177/


Martin Blumenstingl (2):
  clk: meson: meson8b: make the CCF use the glitch-free "mali" mux
  clk: clarify that clk_set_rate() does updates from top to bottom

 drivers/clk/meson/meson8b.c | 11 +++++++----
 include/linux/clk.h         |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.24.1


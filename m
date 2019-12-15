Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A469424673
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mbTNiwGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLOVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:02:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34498 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 16:02:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id f4so3567567wmj.1;
        Sun, 15 Dec 2019 13:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ev5ncFOZ6pn1RKGaLQHfd+wzEPLZWc48NhzIDiNBMKc=;
        b=mbTNiwGcGxLE8/AdKDrOeX57Uprrn9eqyB81r57F+OM3HGhuGvrgA36mxHrmlPRJba
         /X14+icOF2sMXk5Mqv6TthEzJrFbUyTbSvMh8DuRy7YeVKuBYTM67UNLMaODykgVD+CU
         92nj1crd5sSqmkJ48fbBs0Yt+R0zSa6cV4SSEbM/07aqpwAkn4hi11KoFOuV2knaFyOK
         A2QEgkmo6As7ho30gQBmWD3kTyRqXf9B3O9y+KyG3RffpFc1T0DMLCJ4bSQqNAMGyQhv
         g0egWnkhevjUEaPsbvLV84h5+D5HZboktSorhwu1x0BVMV1/LliPL0ozW4jX96DuOCF0
         oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ev5ncFOZ6pn1RKGaLQHfd+wzEPLZWc48NhzIDiNBMKc=;
        b=ZcdVHVJXxVqRBV5rHCcF6I84S9ikzSE6+T1Y0bv5uiJzCuvRg7i/wMM1iMUUd09ATr
         f4cnQqTvyrxGSlwC/L/9dSG/Q5n8nAphdGcfzaLaYu876a1XTbdzfY9aE2doKbCriqBm
         4Ty8xOuD2gmlSyrUOy+nmtMSqY0lbB33Jd+owDHaa7eQLgKiLZqwewVXtO5PCxwYNBzK
         /H2DdIqTpvgyB0TDBus6XDV5nSrOlmB1E3nnMYzoU0vw7CzJ0ib2YbJ3QciZaRFza+/j
         SPbNJg3BRG8p9ZHmDQLZJTuX00Pljg2Wqt/+OhA43QuO+Lk1pCawJK65jz1u2oOuIeE1
         YjPA==
X-Gm-Message-State: APjAAAWXRliCH/L3nfTbe+v3abquV1BPW5exhP0RAs7togWPctC04+E4
        L6kv4WASa8vNi++gZeCCpJ10J3kc
X-Google-Smtp-Source: APXvYqy4zElZG4fJVBRHzoUncu70+64m8M5QJ/eiHjlk/oa09t06tGUW1wwLeUN7ztldupMxZzQZgw==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr25825846wmk.50.1576443732500;
        Sun, 15 Dec 2019 13:02:12 -0800 (PST)
Received: from localhost.localdomain (p200300F1370FCC00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:370f:cc00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f1sm19565645wrp.93.2019.12.15.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 13:02:11 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] clk: Meson8/8b/8m2: fix the mali clock flags
Date:   Sun, 15 Dec 2019 22:01:52 +0100
Message-Id: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com>
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


Martin Blumenstingl (1):
  clk: meson: meson8b: make the CCF use the glitch-free "mali" mux

 drivers/clk/meson/meson8b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.24.1


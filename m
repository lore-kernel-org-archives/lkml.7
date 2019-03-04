Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25172075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XfO/TAm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCDNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51345 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:11:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so4537578wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ByMeJQ3l9j8hP/2REzdKcxDU8ddE1rkkcDZy1jUeYQ=;
        b=XfO/TAm7cR+p96HOzcB/8OAud/WqzOqUOkRmr+XcZcnpdwwN1gt93roK1BneKFiTQJ
         VHeDqpWSzdjIofblxw20+cqYUYaSreiTElpHGEXinGJGZmdAaBfbmTejdnii8Fr0MJKI
         WP8SEBXWzffSYbmWFRi30jznZ1wntrXDV4jZF0yuSpEHYB00T/zV6rzNcgAcg6d9Q5uM
         jXjoNRcOH2TcvMd/A93z4RQN9MgoDWETcgIYU0klZK1l4yHXQdFqUi6fhyrfHQWWqTFM
         DQBkLAAoioiX2I6wPgRt8vXA2m/XtEjSLQO2NMbaebxQPqsBbyN0Z3R/Jw2cBP+Fr9GV
         GMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ByMeJQ3l9j8hP/2REzdKcxDU8ddE1rkkcDZy1jUeYQ=;
        b=Ssuyziy8RvrKK1MEW9CzBSH2sgOSGm1ZQ7sb7IpQsFlxTCsKGUn7lRCtE2scn4kiFL
         DM8Dd8Be0jdqpWL97mO+npW/nNAtxX2R9bAe33rgvKtCxfVl8Itr2OWS0iOVICqPi1MA
         b6miJE9ktwg/ReDVied0kJeYQqDzCeUnRFtnJb93H9gIaFa9wm5kfFseP0Vdw/xexY+R
         kFdNF3R+uLdbECjHneSaWRsr8Vd9OcTE2LleFxNzV+DmU82eMZl2x0FN+3HrNYaq5oXt
         rnp+L8stIqFxBYQpZY9yTQj3RJPhTi3962IEG08q491ST0mnF+4Q5hk2Od7YMEkLHjLN
         RnKA==
X-Gm-Message-State: AHQUAubaV0Jz0bRe1CEBl+cQ1Rag6eQV9yjsA2pzXepLHsNRjVYfcq8q
        dArxddZ5ii+BHBd+PDC93R86WQ==
X-Google-Smtp-Source: APXvYqzzFavd/62ZTJ/V7mMSg8QxpPP0ckAYCGyy3yx9qza4Eb05t7uGWI+n3CF0mZ8dnt2hLrGzhQ==
X-Received: by 2002:a1c:700a:: with SMTP id l10mr12225623wmc.13.1551705092066;
        Mon, 04 Mar 2019 05:11:32 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a8sm11695624wmh.26.2019.03.04.05.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 05:11:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: meson: g12a: Add CPU Clock support
Date:   Mon,  4 Mar 2019 14:11:27 +0100
Message-Id: <20190304131129.7762-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the clock tree feeding the 4xCortex A53
cpu cluster.

This patchet does not handle clock changing, this will be added in a
secondary patchset.

The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
muxes.

The CPU clock must be switched to a safe clock while changing the clocks
before the non-glitch muxes. Proper support will be added later.

In this patchset, clocks are set read-only.

Changes since v1:
- moved to clk_regmap_gate_ro_ops for R/O gates
- added comments with datasheet field names
- moved pribate bindings changes to driver patch
- removed invalid PCIE IDs

Neil Armstrong (2):
  clk: meson-g12a: add cpu clock bindings
  clk: meson: g12a: add cpu clocks

 drivers/clk/meson/g12a.c              | 350 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  22 +-
 include/dt-bindings/clock/g12a-clkc.h |   1 +
 3 files changed, 372 insertions(+), 1 deletion(-)

-- 
2.20.1


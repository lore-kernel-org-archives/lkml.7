Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66EAC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7CD22DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfICFbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:49352 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfICFbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Sep 2019 14:31:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id DA5F918028D;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 3 Sep 2019 14:31:04 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B002D1A0E9F;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 860471204B3;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 0/3] spi: uniphier: introduce polling mode and fix bug
Date:   Tue,  3 Sep 2019 14:30:58 +0900
Message-Id: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces new polling mode and fixes bug.

- Introduce new polling mode for short size transfer. Either the estimated
  transfer time is estimated to exceed 200us, or polling loop actually exceeds
  200us, it switches to irq mode.
- Fix a bug of register overwrite.
- Minor corrections.

Keiji Hayashibara (3):
  spi: uniphier: fix wrong register overwrite
  spi: uniphier: remove unnecessary code
  spi: uniphier: introduce polling mode

 drivers/spi/spi-uniphier.c | 85 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 17 deletions(-)

-- 
2.7.4


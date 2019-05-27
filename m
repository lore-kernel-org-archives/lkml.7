Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2INj9p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE0Uzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54957 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0Uzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so611195wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ur+WNbALZbEGPYM1YE6I5hTSUWBeND5/RyZBRQmTaD4=;
        b=D2INj9p03NHKUheHBSr4k6xqjLvyDDFn5a56ckp2YQ8f6z9VkIhyk/j8uzXyR3+ump
         SmRXNF7GJnz+wfjeWsSQM+fM3s1mvL8VqiXzWOfzbnWvVkveoEzheuFxpOLaqy5gk0DG
         bREd0UPsW/hKEUMOPG+Ws/J6MD96gWr7zVVNvocKil93Jv0oMBTbjm7OypB68NwPDxNW
         srUrgy9ETNbJXLkVlPo9O+eyeyYYiOjugj02J4TsyTwDAYx6eIoyScP9TNcjS8/fkQJ/
         dahzoQV3eBRPnj+WaCcgyaulXprxdA0cM8LPBrDKlhi+aRsaIGBiqPNrotBZilz/jLUa
         Hqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ur+WNbALZbEGPYM1YE6I5hTSUWBeND5/RyZBRQmTaD4=;
        b=AYZlAez5zITO2C/x7iNvIHwViPXLpQY72wJrNtSvraqlNn+TwtPKcx0COl461+FYkM
         VzI5NF8fX0su9GwCEsQrok6O/0nT5bbefhjgr2irFEBLp0SROCcvNqi3HU1DWXJB3y7c
         f7PnguowMdDvoSeMQmt0PuYYeewneA8CEdmLlT46Wlk2SGCiiJjzszPZzwPI6r5s8eOI
         zkqAAlQw+73/RbIOH3gyMfmLqVUOp4f3KUEHuFMNZyXuSptLC101AhTn6T1KIz/jnxzM
         riW4JjkDJyjwGCpGn4V7/4Fj+Bpa2ux4QcmBGer8AfywB64+/lHnGiqe+IJ55OHuz+/8
         g22Q==
X-Gm-Message-State: APjAAAWpgd3KVX2QrIoEvrsGaKsKpnGi7xXD3O6B8AKOBjk+szwq5sfe
        7uHlMLJ9W8pkyVyGVLR2D0VkdS62nas=
X-Google-Smtp-Source: APXvYqwLwB0pRjoqmGzO2S0GaGLUcXJr4MC6N55C2MNQyCl5LlJdPSxNYPvVsgCHGLCR0AmiyAqRqQ==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr617944wmc.25.1558990540404;
        Mon, 27 May 2019 13:55:40 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 0/8] genirq/timings: Fixes and selftests
Date:   Mon, 27 May 2019 22:55:13 +0200
Message-Id: <20190527205521.12091-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a couple of fixes, an optimization and the code
to do the selftests.

While writing the selftests, a couple of issues were spotted with
the circular buffer handling and the routine searching for the pattern
multiple times.

In addition, a small optimization has been found while investigating the
bugs above.

In order to write the selftest, the routine needed by the core code and
the tests are wrapped into function which are always inline so the current
code is not impacted by a new function call. There is no functional
changes in this part.

Finally, the selftest uses samples to insert values in the arrays and
use them to predict the next event. These tests cover the most difficult
part of the code.

Changelog:

V3:
  - Removed patch using the min macro
  - Fixed comment typos in patch 1/8
V2:
  - Removed defaulting to 'n' as it is already the case


*** BLURB HERE ***

Daniel Lezcano (8):
  genirq/timings: Fix next event index function
  genirq/timings: Fix timings buffer inspection
  genirq/timings: Optimize the period detection speed
  genirq/timings: Encapsulate timings push
  genirq/timings: Encapsulate storing function
  genirq/timings: Add selftest for circular array
  genirq/timings: Add selftest for irqs circular buffer
  genirq/timings: Add selftest for next event computation

 kernel/irq/Makefile    |   3 +
 kernel/irq/internals.h |  21 +-
 kernel/irq/timings.c   | 453 +++++++++++++++++++++++++++++++++++++----
 lib/Kconfig.debug      |   8 +
 4 files changed, 442 insertions(+), 43 deletions(-)

-- 
2.17.1


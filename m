Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC8C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6119A21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/aG573v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfEMKaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54618 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfEMKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so7467459wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MHFzWqswHjXCmx9iDo70lNLJIGlzKp8n1GuO5jx4MsQ=;
        b=S/aG573vDpGh576nyKOcsUPjoQG+N5NDt4CjHHz7eBJan46Kl1etoz4Ov/8/PnYAvP
         QQUeleHnmYEly28lCqdxXPgzXqG7JvxBER+O8ZeLMwMN0qZPKJTsvnFL2PR0TEYRzHfk
         BKxcvYW1fwvwoW+iRYJPNIbNpQzgG/2nMKgTMnCWg+TvcGSDNtCYrfzboWube3Vf5mla
         SqMzZYOawYKDPyjItt9OjGOiF7+FvHAYQVL/bXl5dqb5a7kI46x/FnXxgobpwSHa4EH7
         /yGTslmVlmk+CFXoa1k+ikpArPMNAWAnvF+dRG29MEXNnaO6lkUTMkmJGR5ooPH2R79K
         ET9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MHFzWqswHjXCmx9iDo70lNLJIGlzKp8n1GuO5jx4MsQ=;
        b=GosCLa5BxCLHSdKctqqRnSsWLRBZaSSHNJ89Ym9POGgb5o08LSIC8TkwtvHv+kroo2
         CFEz/FuEAva6gLGrIK2inj9e6TxOR6Z5EnaIhGHol36eU3Xn8x8GZP13gYZxNUsKuTyJ
         e0EvzZb+grqcaq4NN8i/LN7R3abpabB5nkPn4DDHOvYUwOxhvYT5OOQ0dZkm9MZ/SBe2
         8YpxdX8FzcURZTAWyN7NtVgXmCi2UF1HwmdIxe9hHwsw1OSZIJFUi6Cy1KMYvOE/fJMo
         AZArxsPXb7Qp2mV8Sgn8LPk20RwhGSShEMCIYCYrjN3gkb6FNFy/uYDJ52qc3OBOIxCe
         9gLw==
X-Gm-Message-State: APjAAAWUxYkFm+3HZswgFJqyuEAHIzoAoC6O3Hdj92Jo11IYxvJMq8dS
        90H3wTKWnOX2sJnhb1gq/atKy4pfV+w=
X-Google-Smtp-Source: APXvYqxl2SJxkgm4awwduQNHIax8aqgfU27B4OI1sL2cxyS9zEUgxoQclgx68AFGm0tPMzLpNukxoA==
X-Received: by 2002:a7b:c093:: with SMTP id r19mr9084380wmh.35.1557743403448;
        Mon, 13 May 2019 03:30:03 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] genirq/timings: Fixes and selftests
Date:   Mon, 13 May 2019 12:29:44 +0200
Message-Id: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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

Daniel Lezcano (9):
  genirq/timings: Fix next event index function
  genirq/timings: Fix timings buffer inspection
  genirq/timings: Optimize the period detection speed
  genirq/timings: Use the min kernel macro
  genirq/timings: Encapsulate timings push
  genirq/timings: Encapsulate storing function
  genirq/timings: Add selftest for circular array
  genirq/timings: Add selftest for irqs circular buffer
  genirq/timings: Add selftest for next event computation

 kernel/irq/Makefile    |   3 +
 kernel/irq/internals.h |  21 +-
 kernel/irq/timings.c   | 458 +++++++++++++++++++++++++++++++++++++----
 lib/Kconfig.debug      |   9 +
 4 files changed, 446 insertions(+), 45 deletions(-)

-- 
2.17.1


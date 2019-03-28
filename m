Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A66C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308C42173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zxlDHLil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfC1KDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:03:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43557 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1KDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:03:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so14110662wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9gJSVONBxLIZb3KhJ3D+2GYvPMFJcj7xfXWOLFiI6Uk=;
        b=zxlDHLilTbuIYbU26AeGTVV/M7lcLD3piIwWEn+kfoI5PeUr1EH659o+mN2QoKQCYN
         IGFce3yqQ1SemDjVbBWXRieNM3eNf21odTEXhLWJj9Fg8DYNCIjKFQ/x5PBvBaL923kD
         iIjU6C2/nDuTeW2uIP49utyuhxbUifue7kA6wR7a2AZ9cqQ/SbMoujGX0+1OUhB3oH9l
         Ww9Lmft8psz+7LlVxcdgqrME81kqp8FUYw6+u6i7zsQad/ASPcb4ZqjSVkw3vHQLFx9X
         O4k522kusVOmJmlr6Ws1K32E2EKufYuH39EFGQ4n9UVFGYS6Kkagl0X9ZAQeNpMAX2B5
         kIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9gJSVONBxLIZb3KhJ3D+2GYvPMFJcj7xfXWOLFiI6Uk=;
        b=HdK3V3EaXaud9oWLY4vhxXpJ8N1KUoNKZEGOkIF2LtoKDir27yOef5WHJaZa6KElTk
         WKnshDtF7kRVHa1ca9uheZGqPIiShaPSIf3FxGJC4xv0WUrtlb77o6mEkKRHVpgPxNAR
         w1J253kWCcb0e6llMa0mSbQFffu3Ib0SVWWW3JHyatJCR8LhGjIe+Uz6LGuVYl9X22rr
         WE7pJN7n2eBlRSiJSRx92aS/Gf3IKIzKt+DhwxIRJMoNqlI0EzbkevFqRdKIDAq3mUEX
         nlfZRFHNfAPBT2JtMsjgFVB8SkUebWenoX1MZZRqfAcuD7vN3fso64xzpx6aZqf5QgX5
         laNQ==
X-Gm-Message-State: APjAAAULzPIJJdBqonJBJ2vvbqjvGEa6s4qune2pjD6uZBelrEGFmqm7
        9b/yNsulDESPUQovWFIhLN80RA==
X-Google-Smtp-Source: APXvYqw2yqQKQj1kI2ejA42NFiNPUKiW5WbXfqc+JuhFpMjuqGNxZ9Jz6fojhMdlFduIHlKWrA9fAg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr26822461wrs.278.1553767395366;
        Thu, 28 Mar 2019 03:03:15 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q8sm1230315wmq.35.2019.03.28.03.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 03:03:14 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/1] gnss: get serial speed from subdrivers
Date:   Thu, 28 Mar 2019 11:03:08 +0100
Message-Id: <1553767389-22857-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's a patch that moves the currently hardcoded, default serial speed
to the subdrivers.
If the default speed is not specified by the subdriver then it is read
from the device tree.

Please let me know what you think !

Cheers,
Loys

Loys Ollivier (1):
  gnss: get serial speed from subdrivers

 drivers/gnss/mtk.c    |  6 +++++-
 drivers/gnss/serial.c | 21 +++++++++++++--------
 drivers/gnss/serial.h |  3 ++-
 drivers/gnss/ubx.c    |  3 ++-
 4 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.7.4


Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2487A217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfIBKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfIBKW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:22:27 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9898F2A09AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 10:22:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a17so8589819wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 03:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEeiAvszbxAnk0W0OeGR1SCbvK2gSsI+MgoJstXil1Q=;
        b=QjUrzqRSL8wIOsjWxoCi5AfIqQ6bKiPlkwBawZq/bve5XWaQK6P9SYTAx7KZ4jymWK
         n37FfRpizIZYvXwBvm2yacMcRAJ8j1REYn2Vs1qePtD1fPLItp2PkuK9iF9csbcGleic
         GKmkmeBQbVhFRxJQqbH/17kkzjPAJRG6CZvHPOehz5KNjChOA0X0GUaV4W3GW6a8mYzy
         NONerhWAcbvz0In88nHlNyMIRXlQvtyFWlHK+wamMuKjNv22pgcFQb3+owGxgWJ++ktZ
         QaWmohXAMEYiRPuI2BxyRF0Wxii15NW3qFkDky+4YAAw17dIZGG3JSDGFSld3ld7drDW
         6fKg==
X-Gm-Message-State: APjAAAUPNA+1r6PUF6+mWwSmvKabMcJCqR2FyC+yKbawSNZQLkw8rTF/
        VkiAK0Z6hVWak8uAdqwHr6c3KUA47x28G+V7mV9Fdx24qpikVFgn2aP0HaUKfnkjyQDazK30KMU
        UwxcpE3L/RXqzFds7WrD0hDcp
X-Received: by 2002:a05:6000:b:: with SMTP id h11mr19503081wrx.270.1567419745322;
        Mon, 02 Sep 2019 03:22:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxsYAVAlXDrurLgSjDGUBmX9a2kkFqZL1X+GoLeUx1TkB89k+TrUHluPTa8s3E8CdQ7zTV9A==
X-Received: by 2002:a05:6000:b:: with SMTP id h11mr19503065wrx.270.1567419745133;
        Mon, 02 Sep 2019 03:22:25 -0700 (PDT)
Received: from mcroce-redhat.redhat.com (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id h23sm15824669wml.43.2019.09.02.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 03:22:24 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next 0/2] mvpp2: per-cpu buffers
Date:   Mon,  2 Sep 2019 12:21:35 +0200
Message-Id: <20190902102137.841-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset workarounds an PP2 HW limitation which prevents to use
per-cpu rx buffers.
The first patch is just a refactor to prepare for the second one.
The second one allocates percpu buffers if the following conditions are met:
- CPU number is less or equal 4
- no port is using jumbo frames

If the following conditions are not met at load time, of jumbo frame is enabled
later on, the shared allocation is reverted.

Matteo Croce (2):
  mvpp2: refactor BM pool functions
  mvpp2: percpu buffers

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   4 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 272 +++++++++++++++---
 2 files changed, 235 insertions(+), 41 deletions(-)

-- 
2.21.0


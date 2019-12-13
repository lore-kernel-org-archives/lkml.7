Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706EBC34024
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B705246F6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g1iXLIo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLMPGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:06:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfLMPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:06:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so6955929wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ju2DWoiSq3sCuDuOb3+XYRdjorlT9EWL8zOGsU8XDDE=;
        b=g1iXLIo/06Kgq3WDGPDVgVT+dPEQkkBmZcNL8L6XydyHZ7GfAdqmfYqPndZeAvGQGt
         /t6PsCE9lUZVqouc69Bnp6C5ai60/+NnmgliBf3XyLWXTRgZ5DGPFbx0Kpy1WlW/ntvD
         BWkbjcwC0rVhyhVfL1QgJMImUFQw1mBaVPont9fDoxfopk5qWAgvz1erPZoP1sV7qQJB
         DCJF2MbO7JhOVmzxOnMlFvMVAXh2aev5pH5HvQlzb0CQ2a16xRAHTFzculCzFU/ybRf7
         QUgSpalpMqHDmxsrs4B6W+I3zV2d0brp2nfRvZzQZdUuBGkZcZ84P6RXej9pWfUibaGa
         m6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ju2DWoiSq3sCuDuOb3+XYRdjorlT9EWL8zOGsU8XDDE=;
        b=GY5sv+vB3LDXP/OhtmsSvG9R1qTOFXhO/w0th6A5aAjh+UquRe80xVOZBPEgcX4UqS
         2ReovHrz8pnFP39abBtNg3HAbzfsq8lrS5ZGf0mjZLTx/wNXzLODWfto9KeScVSzmSV/
         brGOVJi0D8Usw+mrfN1ZLR/qsniAOBaiJmYWKO5G3O1uAv+oOO66g3/jp79r17sziV4q
         SdWJrexmi9HT9HiXk/C39fGOP95buNKsHv5T27oFMzuEJ8DabmU57F9ecZfIhPqpfJrM
         0wxaJx4QYwZrmNrDxp+VuJu7rASTdNRfAXTZn8syPFtivPpW6Ummi6JwM60N9/ScjFqw
         CRRQ==
X-Gm-Message-State: APjAAAWdl7ybTzVr9l0Vb5gkZ/5cXEbcgT0/r7hwVGNJJ4emamN8zfHq
        T6M30zQMiPnaC6Lk9qS304M3Iw==
X-Google-Smtp-Source: APXvYqwzvmODMxjLHMVJJ3sYjesIygUUveBwEjPG8EIcf23ZpBReBW0v3BiPhCwaQpNzmlNSkOMTwQ==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr12906181wrs.330.1576249585032;
        Fri, 13 Dec 2019 07:06:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id x16sm10449403wmk.35.2019.12.13.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:06:24 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v5 1/2] dt-bindings: net: bluetooth: add interrupts properties
Date:   Fri, 13 Dec 2019 16:06:21 +0100
Message-Id: <20191213150622.14162-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213150622.14162-1-glaroque@baylibre.com>
References: <20191213150622.14162-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add interrupts and interrupt-names as optional properties
to support host-wakeup by interrupt properties instead of
host-wakeup-gpios.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index b5eadee4a9a7..95912d979239 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -36,7 +36,9 @@ Optional properties:
     - pcm-frame-type: short, long
     - pcm-sync-mode: slave, master
     - pcm-clock-mode: slave, master
-
+ - interrupts: must be one, used to wakeup the host processor if
+   gpiod_to_irq function not supported
+ - interrupt-names: must be "host-wakeup"
 
 Example:
 
-- 
2.17.1


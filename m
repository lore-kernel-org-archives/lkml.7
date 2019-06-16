Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D51AC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3D2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAsh4YgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfFPXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43689 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfFPXgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so7467645ljv.10;
        Sun, 16 Jun 2019 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLcVzTC0IaxbESeka8YOusn41kpWSvPViTyvRdxCIn4=;
        b=YAsh4YgDg7WErbR21/+wFVb57h35BN/D7dwoqVfRSbLsa+1mJfsZKft9zNEeM4FaYm
         +4cyKvqhbD3cNV52b8j/ESBPvr8hpXw4Le3dbzzmNsiT62YxTGQvmkesDvXC6yNm6KaM
         vuMMCpeQzEh/jptv7uZZtShzw8D1ROTp/H9o5fQGPPYmPmVW3VwtBBKZgd9/N/1pQsva
         6kUJXtCjexQYhXNNf33VhnImnKjS5OQQ9Kbt+2E9igelolFvV1DEZMsvoF5ice8qDeMm
         0jG4GNmfcgTGH8TTbpHezAA4uwWBANxit1NaqK1z9Z1hMypnWoEklRSkcdoQvnPYbpHM
         okmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLcVzTC0IaxbESeka8YOusn41kpWSvPViTyvRdxCIn4=;
        b=rtqn2PVcYdJtrYVyQy4VA0xlGvAn3GcPpuzzAUcWeIDksYIZfbihTIDl0tdY3sVXva
         Qw2VS4Yxmaji6orCQA6D2G7nbmjsRGCQZg0q6Sr1IQqQjOE28l20VQx/WsRjFdkDCjAP
         GM3Di2D93yY8usMRq5A/bX0uictXT2ngwIu2dyxRH+CuuOHdPXMXiNW3HFAr6Suyio77
         kM+Nzjnt2QYEA0kLzkAoo7P4W4Oty5xFmBzSOB9nEbmlexYmaEdac/0+pn6VgbD0KDBx
         ssdlFBU1fU++6wcWFgjonlCKilKQo2wo+5aSN1+yDOgdGifEsvTkkcY+tdGibT6bHs8k
         iXsw==
X-Gm-Message-State: APjAAAXa/ENDdNfkdQlzYFKQ2umVgp/zVwyNtc8UZAkWBPwlviripoB1
        DJLlx1kAZA1L36LowGEd28Y=
X-Google-Smtp-Source: APXvYqyuvXRfe8AHcpXDXE1lcVXJXVWk482SzjTXIDhIq9j+KWdEs9H6/aBgi9YfgzrZG+jjW+a48A==
X-Received: by 2002:a2e:2b57:: with SMTP id q84mr10518197lje.105.1560728169216;
        Sun, 16 Jun 2019 16:36:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/10] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Mon, 17 Jun 2019 02:35:45 +0300
Message-Id: <20190616233551.6838-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index d3e1f898d745..43aef3614b65 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.22.0


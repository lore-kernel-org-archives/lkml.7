Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DA8C32756
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F22147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oahMoOm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHKVBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46315 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so4553323lfe.13;
        Sun, 11 Aug 2019 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=oahMoOm4p/vTtEBBtK5p7lG8L3eOLIMI0I9LpsHAKi+Zx81Wijz0Kuvdzjtg3DRNjt
         +GTl59I8f0xsAtgc8+/8jfevxHGamY7jb8qGm50zBeZw0on/gULp4vqhHtU8A29crvze
         3zcCO46LQRLvWX5EcqbIFaJW73oFgiLNuVuuwGXNrposp+vFaIEjKBCFeHDSxkp8NLLe
         eG8Q5/ipGAFgKYoDnSO/lMOx6jViTbvZrnKbNilnWPQRMwZvgTF78OcQmONlq1yVk53D
         RdBYj6mlJnjG1KUWPU8e0jd7ESPrGHdcxPinyz5edFY9TJ7jUlS6AiT38pOkDS2vZUDq
         cVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACV2ZWfTaEmtxdFrYT9DjBnIgPftGulBSmYYyCGemp8=;
        b=iKj2tjRjBeL3TVmFcs3gTHoqZk2omAdaQP40vyCT1cg3L7gaO7V1ZjptdV0iNMfixj
         psDccfmYwWyGv/K3xlaatWOC7xXrYjvaBeowycXoBQNlI6rV1cPCc0u6ktpu8IPpYFFg
         OM4Vz4hh0WUP30RfHx3tl082v7FJGjt80/MJFTx314mme4Bgq0s73Iyxgsi6BLUsuKF2
         KHk1cfeScmPKR3aCnkZZpMf30dCkc4dzsVQkM+mV8VtazqSDPfogflyMiYxXrExyVM9U
         aReI2TpiD+27cXUr+/7GXwxsxAa4SkKXDukK5wtwT/SasjZ2us5gGCAywi7jrDL5IRgv
         ZflQ==
X-Gm-Message-State: APjAAAXpkGyaE79XOeXM4Kxx8rTyGy1tOEm2adu6plviDqBtU7c6j2/9
        UkDiiJJ6i5m53KxHDPdnRv0=
X-Google-Smtp-Source: APXvYqxtH2c3pbBC8y11UUgC+QRh+QcPtPKGSRMvpl6I+PP4PJvzo11zCTGN/5v7K8TE2MMMutNjxw==
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr18340455lfa.107.1565557293751;
        Sun, 11 Aug 2019 14:01:33 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:33 -0700 (PDT)
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
Subject: [PATCH v10 07/15] memory: tegra20-emc: Increase handshake timeout
Date:   Mon, 12 Aug 2019 00:00:35 +0300
Message-Id: <20190811210043.20122-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out that it could take over a millisecond under some circumstances,
like running on a very low CPU/memory frequency. TRM says that handshake
happens when there is a "safe" moment, but not explains exactly what that
moment is. Apparently at least memory should be idling and thus the low
frequency should be a reasonable cause for a longer handshake delay.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 25a6aad6a7a9..da75efc632c7 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -236,7 +236,7 @@ static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 	}
 
 	timeout = wait_for_completion_timeout(&emc->clk_handshake_complete,
-					      usecs_to_jiffies(100));
+					      msecs_to_jiffies(100));
 	if (timeout == 0) {
 		dev_err(emc->dev, "EMC-CAR handshake failed\n");
 		return -EIO;
-- 
2.22.0


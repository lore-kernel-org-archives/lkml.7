Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72622171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcktBYqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfG3Q6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfG3Q6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so66552652wrl.7;
        Tue, 30 Jul 2019 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=DcktBYqZILEehO0NUu6fQpEUJDZ42ARu1VpLw7J2sQ6sSapnkpoiHlZUq3dY7U79b3
         MKKTWgt0cP8dhEuAJFJICb2tbN+USsd6M6NChExAyyS7lt+erLQsLVttp1p5UdhdgevY
         fltEND229Z0H9fVT1X1SiiWx66Rn8YFRUTnSgWom26/aprT+JKAnSGGCPAUNBkYEIMcR
         /d3GihX4ze2UH0/YlwnCeHKF9riSxLq7PsWb4WBYNak3jEqFbfvggSu+2FIJhP4Wyuo1
         Xvolr0BUHH3lIlzg0Edk25xiL0Z25YLbAxobKlN22HxYdGiu3hKkOvV/NwK8UwqAWM2w
         m/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=OLL9R5Vux3FNfSU0jmz9/6Xyno0lhUvzbl+grpCTSINFmN3060EvYpxF1PBHpzh4Q0
         lIPN5JoJvmGy3Dqz/02D31veZMyNz2KTqhGbh9Q4RCZVqlkq//kSwrb0mfdJgq/mmnpZ
         oWBJIazJeocQRUBKhBPStaWazR5rg1hRfTxM+gBWe5Jky020aD+F/LdPRFsDWUkUSFBO
         r58neBxAYIzb5/TvS7FsBto7jMKHT0CE2Nq/K7lva47bhM/zk1NPawe4eLaHf7JvUCjn
         4T6MuV+DA/FCOOgy+la36IEPGbtQm0+Ul+/P+ribLiiinMT1hJEbqI3NF3yzjH7WAPAl
         QYGw==
X-Gm-Message-State: APjAAAV7ARtvgnX3ItAh6EVpjhIBhWcSuw5Nt0YM0VHgUiLe1KHRtNhH
        6VCdSeGBk2pGN1MpGys7eck=
X-Google-Smtp-Source: APXvYqw/R1cugSyqm4rkiFSz3sAu/xlDY72pY0qeOQNS1g2WWdzkYZzZu+5dQo0OIW3IHuGa3/gjMQ==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr33653100wrv.40.1564505899289;
        Tue, 30 Jul 2019 09:58:19 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:18 -0700 (PDT)
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
Subject: [PATCH v9 08/15] memory: tegra20-emc: wait_for_completion_timeout() doesn't return error
Date:   Tue, 30 Jul 2019 19:56:11 +0300
Message-Id: <20190730165618.10122-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interruptible" variant may error out, the "uninterruptible" not.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da75efc632c7..1b23b1c34476 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -224,7 +224,7 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 
 static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 {
-	long timeout;
+	unsigned long timeout;
 
 	dev_dbg(emc->dev, "%s: flush %d\n", __func__, flush);
 
@@ -240,10 +240,6 @@ static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 	if (timeout == 0) {
 		dev_err(emc->dev, "EMC-CAR handshake failed\n");
 		return -EIO;
-	} else if (timeout < 0) {
-		dev_err(emc->dev, "failed to wait for EMC-CAR handshake: %ld\n",
-			timeout);
-		return timeout;
 	}
 
 	return 0;
-- 
2.22.0


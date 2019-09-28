Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD06C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AAD207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3zKwuTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfI1KyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 06:54:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38075 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfI1KyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 06:54:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id l21so4445739edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NS2eJI7PMhTPoQcfqk7++VoekZp7OcJ892f8dwHw9bE=;
        b=F3zKwuTpzWFuROVFbuGA4Vl1Lr+KDC9TkuhSeDIxV6QLeyNMB+sm4CMURZkL+MGFPM
         OIQQWji13uOfCh6eHbm7FxAm5fikjRnt7wFgyAXzTdbebSiZRhWXjJOEyjKECKB0y3Dl
         uCPoYQsE5+qEl2xbhUNVjd46LEoQNxziZcsuKsSaKcpx1Qsd4gI0Y0V/v0bEMg3qz9p/
         dWPGm5P1wixQ/XCvWs4S60SuSXc0w5sY1/chKlxO8R+1wkomF4eGotdJDNy0hYlKVDvn
         NFbpYbF2ZvmIcPpbop1tplMilthNYQ5MLcw2a92A5XeZTiFkh3sYrL7sacBohQvOkuHS
         2OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NS2eJI7PMhTPoQcfqk7++VoekZp7OcJ892f8dwHw9bE=;
        b=ZPltz1ftxwD+n7ovTAOsXrlfmRXkeHd3RiMlMOfSHv7+zWDNT42UoWRdsTHzz98Yx0
         7utk6DXRLgIY0d+mghdvYA5sKfDIGm+YTK42xATi6h40g7BEEKeLbqPksH5cap9448dS
         xCG4excV8w2YfF/gc/Zg4Jobw/A03JZKJJJAMnLTVr1Ssy5tBbrfLBVVYQ2BJnYf25aR
         5CMvL9YG2wnZJskRqWV7qH7G/TVkyJpT2WeiT18YzZaTT4jFkTeJkNRy5fOuZNmJLwAL
         2NuQGVz0tX1UPssA4p1z60MkNiOVcRBGWrHSCLpMCf/knBPu6VDSW+mg9ghJUlUCcDTx
         JcvA==
X-Gm-Message-State: APjAAAXTIZXTImtyQFJW1QFaEkwbp3L68gKegTk/39CB9JrfBuSXgg0p
        f8BOFhGlRaH70clAHsUmk2tWWLoS48M=
X-Google-Smtp-Source: APXvYqw7NqgkTGbItGfUfu5qkpxPzfGQosNBDzaEAbbOmg6j3htj2T7E1ouf1V/bMD78KPiANwfApw==
X-Received: by 2002:a50:a532:: with SMTP id y47mr9230412edb.273.1569668040249;
        Sat, 28 Sep 2019 03:54:00 -0700 (PDT)
Received: from ws-ub.lan (46-127-124-166.dynamic.hispeed.ch. [46.127.124.166])
        by smtp.gmail.com with ESMTPSA id k40sm1130615ede.22.2019.09.28.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 03:53:59 -0700 (PDT)
From:   Walter Schweizer <ws.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Walter Schweizer <ws.kernel@gmail.com>
Subject: [PATCH] ARM: dts: kirkwood: synology: Fix rs5c372 RTC entry
Date:   Sat, 28 Sep 2019 12:53:44 +0200
Message-Id: <20190928105344.6788-1-ws.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the rtc-rs5c372.c driver the compatible entry has been renamed
from rs5c372 to rs5c372a. Most dts files have been adapted.
This patch completes the change.

Signed-off-by: Walter Schweizer <ws.kernel@gmail.com>
---
 arch/arm/boot/dts/kirkwood-synology.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index c97ed29a0a0b..217bd374e52b 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -244,7 +244,7 @@
 
 			rs5c372: rs5c372@32 {
 				status = "disabled";
-				compatible = "ricoh,rs5c372";
+				compatible = "ricoh,rs5c372a";
 				reg = <0x32>;
 			};
 
-- 
2.20.1


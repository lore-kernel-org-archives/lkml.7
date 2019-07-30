Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265ADC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C3E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7+Yqnzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfG3RYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:24:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37696 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfG3RYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:24:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so8608255ljn.4;
        Tue, 30 Jul 2019 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzusjStSC705ddcrZJxz4h/GqHJ0Wvp0CyBksrxFkjE=;
        b=K7+YqnzoAJbcU3re3wvsGQtqgYzrtZ1iEPoAqUapFLwAMFGLUNq+TVIRvNGosVXOA6
         nb6/RWLlyEBowGgmB+l8Z/G5X3JZC4GQKRYSUDSWJHK/2aX3UUWwJibvS04BBFsWodis
         Z8k96jE4jRqOa1mwwiQzTRw0bEdX3X2tZeOenCDe/D0n+JinOJBVyEpl/qOaJ43tZwNW
         vZul+f5+46IBmg68+jKhactPoiL17qj8Ico+KKuiJBeua5YcpvJDEGchyAv/8vyD7Cm2
         I/0a67mdWhDeWosKOQhnGgxegdPiMCC/n4pnc9jgM+Q3oFDu+EBXhXAOOFwlB9vlsc0g
         g0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzusjStSC705ddcrZJxz4h/GqHJ0Wvp0CyBksrxFkjE=;
        b=eDW1mjZ5BZrNHkd1phUzWSGVBd1rezAJq1Yg9Vx+IVU9RwGogYo3gfu74tv+tAFaCZ
         /9oklRIi+cGgiyVFyLYZz0EnbeV9EG7Ta8dCW6Zjv2GgBU+5+4M9vgcmWU1TRFKuJ0Uk
         pYFCQmVi8VVU4JCq7PLMdwFqbpumfnb5lS+hoW1NsBxf17I1tzMSEiO9VasNLR2dpQgp
         63NRCRsgdwLQLovCTJW+VhsqI1j/e/nTGuCGbjQh7m2RCLUXcbXeVYQnO7PKlvQ+yl7a
         6rtChjOO8Gc5gMcWDn/cHUKsQEEigl7eQndPykTqsldpCratUGTzv3mthWFpjE4q6WcX
         eBxQ==
X-Gm-Message-State: APjAAAUpVCpbTrKxdFIGkEM3E0LCTShdBCpn4nia38IjBg7L9Qqjn/Xj
        2yT+fnr1axmqd8g3I9VVdew=
X-Google-Smtp-Source: APXvYqxwOlxxTeAD55uAjPuC/+LQv1P7kUzP7AJk5u+SGEErv+gOa4wEFviXvLQNPBY4hxLZextcyA==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr16185563ljg.33.1564507452137;
        Tue, 30 Jul 2019 10:24:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c15sm13345252lja.79.2019.07.30.10.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:24:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
Date:   Tue, 30 Jul 2019 20:23:39 +0300
Message-Id: <20190730172340.14037-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730172340.14037-1-digetx@gmail.com>
References: <20190730172340.14037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unfortunate typo in the code that results in writing to
FLOW_CTLR_HALT instead of FLOW_CTLR_CSR.

Cc: <stable@vger.kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index df44828a34d3..53123ae4ac3b 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -44,16 +44,16 @@ ENTRY(tegra_resume)
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
-	cpu_to_csr_reg r1, r0
+	cpu_to_csr_reg r3, r0
 	mov32	r2, TEGRA_FLOW_CTRL_BASE
-	ldr	r1, [r2, r1]
+	ldr	r1, [r2, r3]
 	/* Clear event & intr flag */
 	orr	r1, r1, \
 		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
 	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, bitmaps
 				@ & ext flags for CPU power mgnt
 	bic	r1, r1, r0
-	str	r1, [r2]
+	str	r1, [r2, r3]
 1:
 
 	mov32	r9, 0xc09
-- 
2.22.0


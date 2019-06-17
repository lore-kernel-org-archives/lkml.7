Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B0208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DnkiSLYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfFQTaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:30:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfFQT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:29:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so635775wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pLDKBn/rLn9JtAy1R8FKXFV1pHYiHH80xHdW2AHq76o=;
        b=DnkiSLYsEq+K6UwHvuKcniGNMtC1VAAJVH4kaIlIK99n01SJqwxnXECrKm5rOyiBk9
         bkZUXZ8Mg+JGribMc6w1tilz4fe/n/lgi+P11r6Mprc0IQJDyhK0oTNjShwkIcCBxwM7
         TNVYXcWi50BYWcMPwXChvRnGZlOqi8pJvR5uk8WE3p8vRL1JXzk0BLKWQ9zLQohZDb2t
         ZAkRlxwj+prGx5/jOC0nOe8cxiiK5Bbl/LWGa4X9pw9JSWMdSveYfzJqI0zm64winfbc
         NqlGBlsdKQv/ABACo38l3rvGDQxtX+6X2ETn+94nbPJx7xxASEAGzZSKgoVofjMFOlfU
         yg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pLDKBn/rLn9JtAy1R8FKXFV1pHYiHH80xHdW2AHq76o=;
        b=YOiiC/ZblgNdYlfYz/oYUPAOigyDtEosJ1HdZbF4caINzxObnoolpSS1spBBpWz3lv
         Mt9qVfi8zosQJcfIeL6V+Wr4ej/oOP4RE4MLoQ51aqVXRZSFXCZcusl/YDIl0LF6dUUP
         JbEdyFxMG4LzO6CH6+XK7WvWPUteaAr9dq8xF/eWalj98STR+bUGjdwmgXJZll48psA+
         8LEywvCmPh1lIIm3clJ/pwOrDb9KAnahe5nHXgrhOFlEGaK9D8ED1tKRVwysc89x1CcA
         LZBZgISClLRwZ9nyjYcLgMwxAjQTIzV0CLBSkZb2RiQAouyJv8k4kUFKB+wUa6sxaKOn
         zUyg==
X-Gm-Message-State: APjAAAXYXJKgVe1NnTCDQEQhbqSc9AMJK4GSWBew07hH8Esgln15C23V
        10MWZMZHK9N+ipDt8dHOpOyv3Q==
X-Google-Smtp-Source: APXvYqwzSn6QF6/tx1P4ONWL+aQ1cDMzNSHZ+vQ7fVHmaZUy1tTyC2v6scoAFh5dLZLMBXMhszyC2Q==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr158418wml.45.1560799796773;
        Mon, 17 Jun 2019 12:29:56 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (cust-west-pareq2-46-193-13-130.wb.wifirst.net. [46.193.13.130])
        by smtp.googlemail.com with ESMTPSA id u18sm9412034wrr.11.2019.06.17.12.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 12:29:56 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/3] riscv: select SiFive platform drivers with SOC_SIFIVE
Date:   Mon, 17 Jun 2019 21:29:49 +0200
Message-Id: <1560799790-20287-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
References: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On selection of SOC_SIFIVE select the corresponding platform drivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 60dae1b5f276..536c0ef4aee8 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -2,6 +2,11 @@ menu "SoC selection"
 
 config SOC_SIFIVE
        bool "SiFive SoCs"
+       select SERIAL_SIFIVE
+       select SERIAL_SIFIVE_CONSOLE
+       select CLK_SIFIVE
+       select CLK_SIFIVE_FU540_PRCI
+       select SIFIVE_PLIC
        help
          This enables support for SiFive SoC platform hardware.
 
-- 
2.7.4


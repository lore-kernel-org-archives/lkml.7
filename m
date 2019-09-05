Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5992C3A5AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65C82246E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZv7yvLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbfIEMqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:46:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:46:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so1264574plp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WM6rR/Cv0t68SHx1bqGl5X9yzZvLLjOLxbj6KRGyY+4=;
        b=oZv7yvLoJTDRZLo4oJSgW5Vbu9DBHBlz5VFNa2fGOc9gpMnxnJvAG935dHVoC5a+zN
         wTZq/ijBq9l5KtlmXf8ZeuJXUSgPp4WSDeJlO/1PbZw/uq1tfe7UmIfkTx2kY+dBJCFZ
         YcXtFXj0jhREzVkOWXBtLPNxGCfTEzNwdq9GrvE378KwHnTh2j6j70Iv1Hqqqd8dSmEg
         qNB34Q1xU+IcalAz4dBUjy0HgTvcx2urOPoxaxqccjCwTpcERUPcKVWsIkGi4Zj2G0un
         vFucV/QwJID6dSnkaC6xpswL0D92EbXGeq0GRlc5jlNDpSEt2MrEgRFJBW4DO3FlM+D4
         AvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WM6rR/Cv0t68SHx1bqGl5X9yzZvLLjOLxbj6KRGyY+4=;
        b=cSmxK0XKo6UZRLftByTuFiPcu5kptt1MHyOIu+Z2LkeCSGRUcR/Q38uPdUUX459yuz
         uKK8O7Qs3oBZIxbi2pAdcoIbTPRWIESEFyS3+v54X9TSY4q75kq9iBCJ+F35jaAIfWfm
         ubDtDtN5pO/HrW5Owo/gJA/jJw25PSGRZkms0Vkvg/x/c3zFuq6ACbHmHXHgUvAFEoUa
         Ny2mjwoWYFx4JkWJ64k6fj8wSh1N7gdO/joyXi6Ef4wcxIGlNA6AKQusA7P1h+PwUAMi
         2Dg2NJGubHi7C4duxJqJmnpHl67oeWvCtu8kcfqxI+PGJTZYKL3xhbe91N1UT7dX0oIA
         Jycw==
X-Gm-Message-State: APjAAAWXPebhFGnrv3s/zVRqwrWS2j6fFDoep6/tGD5lwvOGIyLPm8k/
        kTcT8ZiwcIHwezGR5CCUsdQ=
X-Google-Smtp-Source: APXvYqwvTeYV5QQ51gK9PVjIDtCbPQnpHl/4CKedsvgU0dSTpgTqXJIt44Kdo8iVLocqVuZPfMevsw==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr3251485ple.192.1567687560305;
        Thu, 05 Sep 2019 05:46:00 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id 74sm3412635pfy.78.2019.09.05.05.45.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 05:45:59 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: dts: sifive: Drop "clock-frequency" property of cpu nodes
Date:   Thu,  5 Sep 2019 05:45:53 -0700
Message-Id: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "clock-frequency" property of cpu nodes isn't required. Drop it.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v2:
- drop "clock-frequency" property of cpu nodes

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 42b5ec2..a9d48ff 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -60,7 +60,6 @@
 			};
 		};
 		cpu2: cpu@2 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -84,7 +83,6 @@
 			};
 		};
 		cpu3: cpu@3 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -108,7 +106,6 @@
 			};
 		};
 		cpu4: cpu@4 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
-- 
2.7.4


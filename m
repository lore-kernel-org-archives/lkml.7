Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DCC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B591C21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HSJoWMFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfEMLgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:36:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33582 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfEMLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:36:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so7083470pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=HSJoWMFv4UI15gIGdN4HfDjc5OhV6HXuz3MYkrBjwP00M6gakQBeQxowVKWYS6I2yI
         9BaWSEiFwVMiwwovgnG9J2RS58YhJDvqzt/tXdqX5CatoCWGlCc3rCUjgpFPyPa8VG41
         YlZLfnGZBJr8b6qu3H0RPltYNK0DbQp1/pek3FUwXZN6KI0dJ7bSQ+nQQwqKbXzz08Ar
         c8jj2xlnT9+BIBb5UqQeq8zUcmLzt5JWQfzopBHpFBEQcoJ7CejVD8F3Q/StQtLCE0RP
         H1Hp0WBzt2wutw6XGRWYgUC2g7B86rGQRpaXUoK6Xlxq6n2NiuvXZXGbLgvnE0n3k5j9
         n6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=Oee7nLvZ5R9dI7gRqrSFCP9IkFQyfHPfCjMrQjmntnNUi988F0ubePEswHJH34Ywpm
         89aaZrp+JONydN+RwI4YtQuSWZmro13xhFhgjM016L/TkXnsxtPNpSEEMC8tIizxGjOj
         JWDlJ94RvT7xmwGcNXP+H0mCgsntFOQQeWmGoUIb/OfwhiSNm9iONvgh5hkZfDHbd+TA
         7UhG9p3mtSWmw+enMG+RyPPiyFthvp9O+FUfiTpdnsopgq5AZ2mxQumNT/FQn5gizlQw
         b7D6CmExivAN0rau6UImuiGwTXdvYPD8CceNd0r4BtFYn/2Lfxv66TCzmiLBy5+IP2w4
         f7Gw==
X-Gm-Message-State: APjAAAXj2pZ69mfA111NGl5Pg+0KqHumcrwrw2Az5m9Muh47vbghjr1p
        +9Frvxu22rjlB3KUg+x1x1qDIw==
X-Google-Smtp-Source: APXvYqwnqg4FD1C2vTFRZ8KsGeMOJ61L1IQ2YiYK+2uU2Zq+EO5XQf5nA3JLC0mQs/lpcQH4hSb3Cw==
X-Received: by 2002:a65:578a:: with SMTP id b10mr13960185pgr.161.1557747408066;
        Mon, 13 May 2019 04:36:48 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d15sm44657128pfm.186.2019.05.13.04.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 04:36:47 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        thierry.reding@gmail.com
Cc:     palmer@sifive.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v12 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Mon, 13 May 2019 17:06:19 +0530
Message-Id: <1557747380-12257-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557747380-12257-1-git-send-email-yash.shah@sifive.com>
References: <1557747380-12257-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..36447e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,33 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. All PWMs need to run at
+the same period. The period also has significant restrictions on the values
+it can achieve, which the driver rounds to the nearest achievable period.
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Required properties:
+- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
+  Supported compatible strings are: "sifive,fu540-c000-pwm" for the SiFive
+  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
+  SiFive PWM v0 IP block with no chip integration tweaks.
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 3. See pwm.txt in this directory
+  for a description of the cell format.
+- interrupts: one interrupt per PWM channel
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <3>;
+};
-- 
1.9.1


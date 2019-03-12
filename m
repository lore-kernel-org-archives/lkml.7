Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199C4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cJdRN6LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCLJV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:21:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37457 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCLJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:21:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so1363950pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ia76oeJ0OKOLuTxG9UecPXMwlP9RIrNjBsU3t/vewDk=;
        b=cJdRN6LEpm6O+ZG8lERn/MJMg1Of5WYN3YZ03nrVbS2A97QVfXu5OZP1xNRcK+vbec
         vP/hJhVRusIT0m7sFNREfIPXjovU9XWY94y305GbCVCHj8quVIWeR5Y6DRAJiYkc9C+d
         WSRr7YhOr5UcnMxINxC5qV3nsTAxzJGfpap3jttVdjmRkntk0lNtUljFaxL+UQlU1zA0
         CcLEKXivapOrP+lQwFDoqkNAoJdRrLrNnWXSilx1tp1jyAoWUpxPDDVaGoVjlTAujcq8
         /IsvfmAo5qfFR37Mi9iI/LuTCVfVfAQpksOMd6LB+Ch+Xanl1gEBamBLLZodKyBtdVPA
         I4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ia76oeJ0OKOLuTxG9UecPXMwlP9RIrNjBsU3t/vewDk=;
        b=qFSw/gPzYyrQGh+A6/P9EumyIw6kqeUBpIIDdZZkJiSYfo6F7oE0WwUQyZgK2SQ+Jt
         j4DDKwrwU/D8ad9Xu4DElS5ZioXN9o1HevJgCiizpn0ONhvx8FCq3UW01G0FCc8XOmvl
         RQbcDtn7Aum8uGe6IC1D4aIhBKdPF8iIsDKY/pbsF6uBDPfTGmfShFiEPJxR+CCVZrZz
         xURYBE5xTpMNhGSSNn8kJDETCUyf1Z3Csu04CRB4G8ybWKH/MDCLo7bBYkCTC9EsWgdK
         GrZr5W8JRmRH2jWcNKL4iLFONY2KKFCOBVVH9h3wcYG4TOUXQexSF/mZaSZQuzcNLats
         JQvw==
X-Gm-Message-State: APjAAAXKrrc9XSiyqUlPX56TupKwSELMVOCR8jHXFcdA8HFfWQijrdVO
        R6BUF7VIQ1dzbixTUwJGw0uDkA==
X-Google-Smtp-Source: APXvYqxqKI/904f6aIBRDYiNM+rEFTWxteAeCj2evYcWxsN7yUhpUz3Bj9tzIeTauvZoqc8iyLGtpw==
X-Received: by 2002:a62:3890:: with SMTP id f138mr38390720pfa.148.1552382484512;
        Tue, 12 Mar 2019 02:21:24 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d86sm17569638pfm.18.2019.03.12.02.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 02:21:23 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2 cache Controller
Date:   Tue, 12 Mar 2019 14:51:00 +0530
Message-Id: <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for L2 cache controller added.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/edac/sifive-edac-l2.txt    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac-l2.txt

diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
new file mode 100644
index 0000000..abce09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
@@ -0,0 +1,31 @@
+SiFive L2 Cache EDAC driver device tree bindings
+-------------------------------------------------
+This driver uses the EDAC framework to report L2 cache controller ECC errors.
+
+- compatible: Should be "sifive,<chip>-ccache" and "sifive,ccache<version>".
+  Supported compatible strings are:
+  "sifive,fu540-c000-ccache" for the SiFive cache controller v0 as integrated
+  onto the SiFive FU540 chip, and "sifive,ccache0" for the SiFive
+  cache controller v0 IP block with no chip integration tweaks.
+  Please refer to sifive-blocks-ip-versioning.txt for details
+
+- interrupts: Must contain 3 entries for FU540 (DirError, DataError, and
+  DataFail signals) or 4 entries for other chips (DirError, DirFail, DataError,
+  and DataFail signals)
+
+- interrupt-parent: Must be core interrupt controller
+
+- reg: Physical base address and size of L2 cache controller registers map
+  A second range can indicate L2 Loosely Integrated Memory
+
+- reg-names: Names for the cells of reg, must contain "control" and "sideband"
+
+Example:
+
+cache-controller@2010000 {
+	compatible = "sifive,fu540-c000-ccache", "sifive,ccache0";
+	interrupt-parent = <&plic>;
+	interrupts = <1 2 3>;
+	reg = <0x0 0x2010000 0x0 0x1000 0x0 0x8000000 0x0 0x2000000>;
+	reg-names = "control", "sideband";
+};
-- 
1.9.1


Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315AC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQhDmz+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbfGPWp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:45:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40858 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbfGPWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so9803376pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5NY9hcxy/qmq+InJeq+MZhB52hgL5/XHKuoEKWCJRY=;
        b=QQhDmz+Am7zIZWfhfkXcmZA4KTBLGRUoGtoM6MU/qb/jbJajF+li7TvgwLh/nbUZNT
         32HiuWT7lxFOy4PNA9GA48nPUnKmJFwf7Bo11YiNOfjWgG3s6g0vkINmqLZ2NxSzQgwW
         LpwQxIbjBSMF8oNuHBZJ04Clp3Ojer4C09NC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5NY9hcxy/qmq+InJeq+MZhB52hgL5/XHKuoEKWCJRY=;
        b=NzmVZ/2eVjOzGIzRXlkkgZgd4msXfYfNgqPm/O6yjeoVQ2D+z3qOr9iO8YWZjchbjd
         6TxFDmHGAQnwxLPrflzOdX3mwVQGBxtbxf/64oMR2FnFjELVika0XWBVeKvZz+K+lr1I
         +l4uPOvy9rutMHMCedi1rQIAxA06Hru34yENJdC8ndTJF2ctWETAxJN76PlQ9M9tJ3Ip
         KYA6eLraqIporFhGxx6jcYaJbPqivFnwSX+Yuf+OMOP0uwhooGWCWUEX72TaX3LBZxJt
         rwLPB1EaU4mq0GPj6dzV9JMZyBFnXnaZuTl+n+WzkUetodOzt2xcSUZLAVehhXQ0KwKB
         pikw==
X-Gm-Message-State: APjAAAWVruLUdA6kxcC1wtycbKS8ZHO8AEQZ5G6QFnAGMweqQlShjAsP
        WDlNsSTGgH9IOfuACK3p9Rj7vA==
X-Google-Smtp-Source: APXvYqy9H7LyEYLNDeFy27ZQi/NQGBvJDuaRVOmlwxY2kPGjQcHSYWDcwox3EfLdlVSqYkgPX7Bgnw==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr38933628pju.7.1563317123728;
        Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/6] dt-bindings: tpm: document properties for cr50
Date:   Tue, 16 Jul 2019 15:45:16 -0700
Message-Id: <20190716224518.62556-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..401f4ba281b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
@@ -0,0 +1,19 @@
+* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
+
+H1 Secure Microcontroller running Cr50 firmware provides several
+functions, including TPM-like functionality. It communicates over
+SPI using the FIFO protocol described in the PTP Spec, section 6.
+
+Required properties:
+- compatible: Should be "google,cr50".
+- spi-max-frequency: Maximum SPI frequency.
+
+Example:
+
+&spi0 {
+        cr50@0 {
+                compatible = "google,cr50";
+                reg = <0>;
+                spi-max-frequency = <800000>;
+        };
+};
-- 
Sent by a computer through tubes


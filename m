Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBF20644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8QiVoBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHTCGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:06:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46304 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so2241254pgv.13;
        Mon, 19 Aug 2019 19:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb4MN7frN2DQp05jBufAle0GF3E07hH+QYiE3G5P4OY=;
        b=r8QiVoBHXwhQTbODuclPFhZFepgsrvEkLetpZftMq0499yrWHA2di7DfMz4Nfqg308
         zbP0qfQD46Q1Vsjq/piuESya0/gUnykSMHZ9qOg0Cx6saAUHlWBT1u6A3mM0omHoUfaU
         Tr19s+dkHUJe6x1vi6z8dxoat2qCd88r9weeMCO7u4CyGaUnie6s524wtOinYgtih37U
         Eh5prRmhFGg827hy9X54TqPc86SsQwcB1P5tpVRVdk8pC9ayVTpxJKT7j+D4ZJ1a1W2h
         Y2Gbs8teS/Bqss02fVUJKnMGR5eTh4QXv/lYfUYUD8Zqs+VnOLSjNiy12Ys3JRBv6dBo
         DZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb4MN7frN2DQp05jBufAle0GF3E07hH+QYiE3G5P4OY=;
        b=LkaqlkChsuQdhjOCD15G1Co49U81MWS2ilZf2TnsuO+RaCUKdflDvrfpJA8g+vyDID
         /W5Mjmo8yJjYN98bZAaG6mTNOLvYF/WLLTq7KL58SAuuLKWFqJY3VwSGbq4JD3rhJoAA
         SWZLTgHAlYV5MhuZtbKxdLTXEJNVENvcKnN2ICcP3Xolg0Ot3GEoWIExzBBQ+b3l1lZe
         YmnugOgnqcwRvb76qVYDn9Vx0w8AGhLG0nPrYHq/0xd6XtUV9AQLloZufatVs62ftwt/
         61Pa2/UE4TBxUdlc2HkD97ejUynLIO1v2DTJGiapbJMlU/YCpCv+oLSLU8K4CUJ0aY6W
         yELQ==
X-Gm-Message-State: APjAAAULbStPc+64ZeSJKkifiWVrNNzTPLjHJuFgm3IILfq8Ks0S2GqB
        EuJpFahbjggg7jhkj8/e7Eg=
X-Google-Smtp-Source: APXvYqwxhXwoCjQtiTGscKrLHWs+YJ8m2dCq7BSnFMzAIXIDoBJNk36iUImwwmY+NLYF/Th8g5BAJg==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr22102292pgn.182.1566266814096;
        Mon, 19 Aug 2019 19:06:54 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id y14sm32343959pfq.85.2019.08.19.19.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 19:06:53 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V5 3/4] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Tue, 20 Aug 2019 10:06:50 +0800
Message-Id: <20190820020650.8334-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add the Genesys Logic, Inc. vendor ID to pci_ids.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..4f7e12772a14 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2403,6 +2403,8 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
+
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
-- 
2.22.1


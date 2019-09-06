Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE53C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E7B2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRr1SYAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbfIFCb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:31:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33845 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIFCb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:31:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so2590653pgc.1;
        Thu, 05 Sep 2019 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/gqa9V2L+P7ZTpCq0TlKj9v1dS5cmC4kjSw+65uCNc=;
        b=sRr1SYAaudA+kSuECzIoCIqqyWi5BJ8VPufG6rrkCb0hcSgGoItmXtoEhstYNM1aau
         G/Qr1cEupkKZJIg/tiAd8xEm0ViGPoSH3EJs6Oh2MTQGVD+yqf/ZYejaKK+tsT4VrNrW
         EEFJUxFS+cPTzHrfYTiPwrxPMM1iM4BmcFp8ritwJtKuOVupgJIHPFvgv98NS2FSvyBp
         kNwtOSSaCkRClJWnxRUoVbtjno7PLd+vLYgl0DyrNxfJc6RJ4JGqKYLQxdLPnweNY8Gz
         f51JrKAX4cf2VNV2GCTKqwgpYOC90z+EG/jtcXd+K7Wc9qx5Nq1TcTc+oBPDt5AlqqMa
         TByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/gqa9V2L+P7ZTpCq0TlKj9v1dS5cmC4kjSw+65uCNc=;
        b=SCTUBTPookhohDfALGsrqNy8Nml2MySUmKdip77lyp0hCWSCs2hutpQJmLRf/rVgGQ
         hDNdMkjxr3Uv7Kc/LmVy54qmjVa0cyxFUW9UbevH7etqWwBTsepS91nKo//dWQKQG8QS
         JgAkU5he7t6b7NWpYC6OYL1SDS4Uhg0TEmEhsZJo/dR3Bz11B0Y3h2Rs9VFdQiCOgQea
         id0CtvNWXQXntG/R51mB8PWeQhxGbxitxkVu3//+iOkUOBjCABrDUKjmpEs1CoMYCKim
         F2ZKiv7w6FiV6vqVFiTBPcf9RJDp1OSZHOzBRawGoOEvCSc1X7xeVmpdEVfusnzcNzDF
         cc7w==
X-Gm-Message-State: APjAAAU0Q5bGm93Lm2Yz6ZzWXJBVdrCrelnNeXHV/1dzCNSO9c9pQpld
        iqtApOz66/n7dteg1enbx3A=
X-Google-Smtp-Source: APXvYqxUvQF2FpuosJop/9aRW+1znZiDlir3wLoqBBUzScNDRpySke+xlxehhodmtxC6o1pU/7P6fg==
X-Received: by 2002:aa7:8510:: with SMTP id v16mr7814724pfn.113.1567737118419;
        Thu, 05 Sep 2019 19:31:58 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id k5sm5852121pfp.109.2019.09.05.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:31:57 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V8 3/5] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Fri,  6 Sep 2019 10:32:06 +0800
Message-Id: <860ef173fe110630d91e384ae44d7ad42cb72d3a.1567734321.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567734321.git.benchuanggli@gmail.com>
References: <cover.1567734321.git.benchuanggli@gmail.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.23.0


Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4ADC28D1D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E02070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqtX5hix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfFFMUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:20:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33036 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfFFMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:20:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so1735666wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7M+B9q9lRrsAUMz1P/KUAdPRcgyuXrSeP6+Lcb4/weY=;
        b=XqtX5hixeVU5KMlu3496DT2nqQuV/1j2lPbCDUVUmHCrW+1sUWxkyNjqPYjEkin+AV
         9pu9PFBjTKg5D6/lQ2csOZosTSsAKyKLRSY/k/AJmde6KqGJBfy3zgkwx8M1Y6z3gKnJ
         2nYcQWch3gTq1QWElTQm0Mjd3LBNF+5GHTUzfCkOgNVVdzlEbaOYEmdxFwy0wL6twXwz
         XtDjoF6atjVEZo7K86iUDatQT5G40e0D4dh5pCQ2er9wmgPqHMplwYOVSZ7R1Rgt4qeK
         pLyp0EKIbz3wk6nLW0V1JQ7AZcCWobfUpt/XzvbRkHNMx/yfOJkogphIg/u61ilgCEdd
         JUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7M+B9q9lRrsAUMz1P/KUAdPRcgyuXrSeP6+Lcb4/weY=;
        b=OjAe5hiMfhLjYsVVQOMinFj39GpuvC4743yY294+v9E9twJxJTgHyufJ3DfmyOmEPa
         iwZsTJC0usmmzPZSiH5L5IWu6uaANbnpRAmWzf3lZDAhG/krbCN68dRk/dsmYbOTBRYv
         d3+uQhOku1BYDjKWUg7WawJahjIp1g1sxEgyskUIF9FCi1/wHugJLhFlc9TaGPtfsVHI
         2Jo5NTu7dzWSw9x4AucU3TomZUOF3T6Hw2qyUPx8wkN5XhVED/Bpt3h3EJ68VP2/luHH
         4kq5ydjKoRQy7bGRh02KJRGOzt51yPitaNCIktxAIkC+eyhyEvQOQTJqPSAjSUP9HSFV
         GfYg==
X-Gm-Message-State: APjAAAUdaBUoseHzoNgbMYi7Rw6uNOqNeFfTP0VO7k8IOg1YRqKy/KIn
        O+APcLwZMk8cmfCpLLmYRxYjOyPJRNY=
X-Google-Smtp-Source: APXvYqx0f1XXQ8Z70y/VVakq3Eg9kmDkQBWae2jTa83LhP0cIWZQZ2aHNjYUysVpjfYoHscA0rTrJg==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr4703667wmc.133.1559823612708;
        Thu, 06 Jun 2019 05:20:12 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id a139sm1785899wmd.18.2019.06.06.05.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:20:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/habanalabs: update text for some entries in sysfs
Date:   Thu,  6 Jun 2019 15:20:09 +0300
Message-Id: <20190606122009.12471-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606122009.12471-1-oded.gabbay@gmail.com>
References: <20190606122009.12471-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the description of some entries in sysfs for the
habanalabs driver.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/sysfs-driver-habanalabs       | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 78b2bcf316a3..f433fc6db3c6 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -62,18 +62,20 @@ What:           /sys/class/habanalabs/hl<n>/ic_clk
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Allows the user to set the maximum clock frequency of the
-                Interconnect fabric. Writes to this parameter affect the device
-                only when the power management profile is set to "manual" mode.
-                The device IC clock might be set to lower value then the
+Description:    Allows the user to set the maximum clock frequency, in Hz, of
+                the Interconnect fabric. Writes to this parameter affect the
+                device only when the power management profile is set to "manual"
+                mode. The device IC clock might be set to lower value than the
                 maximum. The user should read the ic_clk_curr to see the actual
-                frequency value of the IC
+                frequency value of the IC. This property is valid only for the
+                Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/ic_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Displays the current clock frequency of the Interconnect fabric
+Description:    Displays the current clock frequency, in Hz, of the Interconnect
+                fabric. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/infineon_ver
 Date:           Jan 2019
@@ -92,18 +94,20 @@ What:           /sys/class/habanalabs/hl<n>/mme_clk
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Allows the user to set the maximum clock frequency of the
-                MME compute engine. Writes to this parameter affect the device
-                only when the power management profile is set to "manual" mode.
-                The device MME clock might be set to lower value then the
+Description:    Allows the user to set the maximum clock frequency, in Hz, of
+                the MME compute engine. Writes to this parameter affect the
+                device only when the power management profile is set to "manual"
+                mode. The device MME clock might be set to lower value than the
                 maximum. The user should read the mme_clk_curr to see the actual
-                frequency value of the MME
+                frequency value of the MME. This property is valid only for the
+                Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/mme_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Displays the current clock frequency of the MME compute engine
+Description:    Displays the current clock frequency, in Hz, of the MME compute
+                engine. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/pci_addr
 Date:           Jan 2019
@@ -163,18 +167,20 @@ What:           /sys/class/habanalabs/hl<n>/tpc_clk
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Allows the user to set the maximum clock frequency of the
-                TPC compute engines. Writes to this parameter affect the device
-                only when the power management profile is set to "manual" mode.
-                The device TPC clock might be set to lower value then the
+Description:    Allows the user to set the maximum clock frequency, in Hz, of
+                the TPC compute engines. Writes to this parameter affect the
+                device only when the power management profile is set to "manual"
+                mode. The device TPC clock might be set to lower value than the
                 maximum. The user should read the tpc_clk_curr to see the actual
-                frequency value of the TPC
+                frequency value of the TPC. This property is valid only for
+                Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/tpc_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Displays the current clock frequency of the TPC compute engines
+Description:    Displays the current clock frequency, in Hz, of the TPC compute
+                engines. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/uboot_ver
 Date:           Jan 2019
-- 
2.17.1


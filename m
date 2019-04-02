Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC996C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9245206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY/rqAec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfDBGcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:32:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37784 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:32:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so2783753ply.4;
        Mon, 01 Apr 2019 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BaIWJSTRjzWyLekqc6jwZik98Kx45p7haF3OxKPIA1o=;
        b=iY/rqAecGiREiE7KwkpM7WFZ9E2O5uDNptFluiCUlEkxi8HtGYA0RBDVBzWIktfM4/
         6mctHdCPeZENnSqZwNhzc4iVY8m0avdaYMCjtRtDPuzl4mIroXOspMhKxMsVxAdSZgPG
         XMRCUZL+0GIx9kEFF6NmI5pvOJAWrlPY0zK5LhygqyXJjJ9cnMa2dLLm/P3sW51W++H+
         /0rSULTv4EFhKDI8BSsDOG6bh49x8HRZSu66yb00MViAAEsECAJGgTOCa+uzYiLF+R49
         oyxD++ThX9qZ61Cdf12XjeT8RPhvNdrNhCAJB5RPiL/9GW6TjQokb4AzHs1P3Sx6n4gu
         lCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BaIWJSTRjzWyLekqc6jwZik98Kx45p7haF3OxKPIA1o=;
        b=rer0McuRsA7wZYqi2I4pkAy/UmOaS/eJ6sU9OImgiUs3YTsItzg+PluHZX3Qz1d3x5
         DJWl8VjVw+n2rXrjWSXOq3QgfpLM9P7UMp80SEkGG/R5ehEMPifw5QWh4Dtp85yzaPQ/
         czQqUVhoPvM6e8ODvQTGPopk9dv0cEGDTCQbmTVWeJlDYPOXWsrKGVCzZEDLi+7cNS/r
         IL3Krb5HPwMDVFeSYm/vt8u0Rf4dfmOR8DtLuzSqJyyzD2Bkvf+0JapvS0N76hcGVlPP
         vXllBm09IyhV+gUF7wcsp2HWJwc3gKJVM8qms+5An67UI9NsrEokVLcM3iPEqa1YpExC
         B9uQ==
X-Gm-Message-State: APjAAAWgwrc/81GlTJM7Xysr3fYEvlTVvNk8k5+kxjrVHkB4x+xzLBZb
        +xXwiAdTuQYRjLezl/Gl7Kk=
X-Google-Smtp-Source: APXvYqwVfrRByKFeOKBL9R1qbr5mt0aUWyMrsX8kZdL32AtyzhDeQxXCXY3D859wQjyCHhnQQSuqPQ==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr69299080plb.237.1554186732097;
        Mon, 01 Apr 2019 23:32:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:32:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 12/18] include/fsl: add common FlexTimer #defines in a separate header.
Date:   Tue,  2 Apr 2019 15:30:47 +0900
Message-Id: <4107a3897b6dc081bbf598d4faedaf3bc306a1d2.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

Several files are/will be using the same #defines to use the Flextimer
module. Regroup them in a common file.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/fsl/ftm.h | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/fsl/ftm.h

diff --git a/include/linux/fsl/ftm.h b/include/linux/fsl/ftm.h
new file mode 100644
index 000000000000..d59011acf66c
--- /dev/null
+++ b/include/linux/fsl/ftm.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __FSL_FTM_H__
+#define __FSL_FTM_H__
+
+#define FTM_SC       0x0 /* Status And Control */
+#define FTM_CNT      0x4 /* Counter */
+#define FTM_MOD      0x8 /* Modulo */
+
+#define FTM_CNTIN    0x4C /* Counter Initial Value */
+#define FTM_STATUS   0x50 /* Capture And Compare Status */
+#define FTM_MODE     0x54 /* Features Mode Selection */
+#define FTM_SYNC     0x58 /* Synchronization */
+#define FTM_OUTINIT  0x5C /* Initial State For Channels Output */
+#define FTM_OUTMASK  0x60 /* Output Mask */
+#define FTM_COMBINE  0x64 /* Function For Linked Channels */
+#define FTM_DEADTIME 0x68 /* Deadtime Insertion Control */
+#define FTM_EXTTRIG  0x6C /* FTM External Trigger */
+#define FTM_POL      0x70 /* Channels Polarity */
+#define FTM_FMS      0x74 /* Fault Mode Status */
+#define FTM_FILTER   0x78 /* Input Capture Filter Control */
+#define FTM_FLTCTRL  0x7C /* Fault Control */
+#define FTM_QDCTRL   0x80 /* Quadrature Decoder Control And Status */
+#define FTM_CONF     0x84 /* Configuration */
+#define FTM_FLTPOL   0x88 /* FTM Fault Input Polarity */
+#define FTM_SYNCONF  0x8C /* Synchronization Configuration */
+#define FTM_INVCTRL  0x90 /* FTM Inverting Control */
+#define FTM_SWOCTRL  0x94 /* FTM Software Output Control */
+#define FTM_PWMLOAD  0x98 /* FTM PWM Load */
+
+#define FTM_SC_CLK_MASK_SHIFT	3
+#define FTM_SC_CLK_MASK		(3 << FTM_SC_CLK_MASK_SHIFT)
+#define FTM_SC_TOF		0x80
+#define FTM_SC_TOIE		0x40
+#define FTM_SC_CPWMS		0x20
+#define FTM_SC_CLKS		0x18
+#define FTM_SC_PS_1		0x0
+#define FTM_SC_PS_2		0x1
+#define FTM_SC_PS_4		0x2
+#define FTM_SC_PS_8		0x3
+#define FTM_SC_PS_16		0x4
+#define FTM_SC_PS_32		0x5
+#define FTM_SC_PS_64		0x6
+#define FTM_SC_PS_128		0x7
+#define FTM_SC_PS_MASK		0x7
+
+#define FTM_MODE_FAULTIE	0x80
+#define FTM_MODE_FAULTM		0x60
+#define FTM_MODE_CAPTEST	0x10
+#define FTM_MODE_PWMSYNC	0x8
+#define FTM_MODE_WPDIS		0x4
+#define FTM_MODE_INIT		0x2
+#define FTM_MODE_FTMEN		0x1
+
+/* NXP Errata: The PHAFLTREN and PHBFLTREN bits are tide to zero internally
+ * and these bits cannot be set. Flextimer cannot use Filter in
+ * Quadrature Decoder Mode.
+ * https://community.nxp.com/thread/467648#comment-1010319
+ */
+#define FTM_QDCTRL_PHAFLTREN	0x80
+#define FTM_QDCTRL_PHBFLTREN	0x40
+#define FTM_QDCTRL_PHAPOL	0x20
+#define FTM_QDCTRL_PHBPOL	0x10
+#define FTM_QDCTRL_QUADMODE	0x8
+#define FTM_QDCTRL_QUADDIR	0x4
+#define FTM_QDCTRL_TOFDIR	0x2
+#define FTM_QDCTRL_QUADEN	0x1
+
+#define FTM_FMS_FAULTF		0x80
+#define FTM_FMS_WPEN		0x40
+#define FTM_FMS_FAULTIN		0x10
+#define FTM_FMS_FAULTF3		0x8
+#define FTM_FMS_FAULTF2		0x4
+#define FTM_FMS_FAULTF1		0x2
+#define FTM_FMS_FAULTF0		0x1
+
+#define FTM_CSC_BASE		0xC
+#define FTM_CSC_MSB		0x20
+#define FTM_CSC_MSA		0x10
+#define FTM_CSC_ELSB		0x8
+#define FTM_CSC_ELSA		0x4
+#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
+
+#define FTM_CV_BASE		0x10
+#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
+
+#define FTM_PS_MAX		7
+
+#endif
-- 
2.21.0


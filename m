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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89787C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583EB206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhk+UoUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfDBGdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45378 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:33:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so5713658plb.12;
        Mon, 01 Apr 2019 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SViyYrS1FftN56nFj/LUBMdZmL6citnsb/V8UFB/zw=;
        b=fhk+UoUSzOrDtXSxqqb3QYerakbuvYA/XLrrnRu2go7f0rY0KK4Eq1j0EjG7l9mctI
         MPxxWV45JWRPcRASmeIznO0nXcm03KnfzZIlpzxUQXbf7l16Hd6RPPb8fFP9ikw+FlYm
         zuVVSEVUzzyy52gVcfrI7d9qL5FBr/mp2ww+ig67ad/9j4RzixtxIoB20uGkiMK1pgRd
         p5O/1phRXB9Gmr64ZC26q8zE7rMt9QcfbIVZL5oZ+LbdGKR4b7y+9le3b6mdTmYKLEns
         6bpNwg2lE1x01CDTK9Ok/tirWTdKP02Et/Ym+o8xHkCN5xWXYmITdCHZmtUSyZqXVfwS
         D6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/SViyYrS1FftN56nFj/LUBMdZmL6citnsb/V8UFB/zw=;
        b=coTkH6GuDFQA7xXpi2RGuSs/vvrx8icMi6fLi0qqwB/diL+jNNe4WOCy14sZw6rL0i
         SC1CrDql0ArUKi2odrM66/ZsrJhUHQp+Ymfk6X2Uk1FnzWW63Gc72QlJE8+xzTbxXy1x
         KidJ6dKXnYcht8ROgh23LawDP59XHxPAk70jGeXKZB7f5jAcZEkHwxtUYYsv8A9nfZbD
         82rwn45YqTzChVYObAvYvywCQsQLwIHDYiRqapcObgpvWDixugs17Fp7QAVy/rve2Uvk
         S1ZMrElL4ItnTpM+J3QY91+J9yFmiQ5/KuZf8B8dFL3AQ+9QRZXC58d+fcOpzo6g+p+y
         8zSQ==
X-Gm-Message-State: APjAAAV4M8S/9lI2VecivH/QHj3QACtxsKhCHdqs6P9x5eKD0HXmz6us
        WtBxkSaAxxQSTrLoaInJxos=
X-Google-Smtp-Source: APXvYqx+LDaXvVGOMIPeO233vrs3m+tOzvhaXEMY4h32Y28CavB8ya4LXqA/dRJssrqtXHZkbEdfaw==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr70041345plb.22.1554186790652;
        Mon, 01 Apr 2019 23:33:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:33:10 -0700 (PDT)
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
Subject: [PATCH v10 18/18] LS1021A: dtsi: add ftm quad decoder entries
Date:   Tue,  2 Apr 2019 15:30:53 +0900
Message-Id: <58aec84fb201e7ba2e24ff51f8fd1b4261d6b895.1554184734.git.vilhelm.gray@gmail.com>
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

Add the 4 Quadrature counters for this board.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.21.0


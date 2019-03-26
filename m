Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F87EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3AF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxC9X3tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfCZN5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:57:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:57:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so6781134wrq.8;
        Tue, 26 Mar 2019 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F3qWvI4jIopqGlGnx5VwRistm1sctVMTNFXNU+ZDXNA=;
        b=fxC9X3tWuYqcuH6NKDO+7zmYghy2gEX/ChI4mLR1v9sB4K/9I/NZGImef7s0MD0OAk
         rYY+MeH2PhFWxGGNZzGvYMDRPEgpBA1PlukaX3X+3knwdVXB/TUf24iJ55U1TFkSbvOT
         bo16rBdwrl4k32vwOBZgpDzjJMOsH7m1+ZUQRpT6eye+gKpGvmeE8AbJTWWBQJ99lytL
         e6ddXWFga1UddHxGeT/vTfdmtVZs7nuDCQYQT6ms5RgOvXRab4B8TVUFtMSAZAyB+QYm
         ixAqOATcJJH/YA0g7HIg3uVWtl77LLw+aFKk/t3ts/sLVgnRlUe/RKJnDcQKf2+UHjcR
         KKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F3qWvI4jIopqGlGnx5VwRistm1sctVMTNFXNU+ZDXNA=;
        b=BL7FtDjiPBTRk/q8/pclBvpZOXF0s7pF5ssmdTH0IqLEC9ZSOjooyv6lmPwR87bmVv
         +4ewFZp1iWfFGuI6vYspwycaFRIv+8PLb+yXcBI2BSiJrZ+D7swnW5MimYoK44bvkaTw
         iNlWajrB8uiK9KO3Scjr5Kktbrykf9dBtrOLtqQjjMIVGHEqptMj3xzyWfZt07Gwfm1D
         miOgmU7pfUdwrwReh6fngzZNtz9eVTFqNRiEirgKZ0SseR+pRC51NlY1SY+QUARYDEYz
         DHDALIJWdbThk3fajVH/R8GSVp9G+kGOB9s4IaeMgQsG5o5NcfA0cYDYGJ7IzHkYi06K
         u5Rw==
X-Gm-Message-State: APjAAAWwNsiNduVYjUd8WqbOf3TlWHtRLsxJulBaLUSnq8XJdNxQC4Rk
        1ddOpuc9cMFshfa6NS9M1KA=
X-Google-Smtp-Source: APXvYqwQHM7RIqsKk2LRZNA+AtqZFLo5zsjoq6Gv++cntymUBEmKpZeTYY5gdVuCkpfOniDv9+LGRw==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr19812240wrt.13.1553608618021;
        Tue, 26 Mar 2019 06:56:58 -0700 (PDT)
Received: from localhost.localdomain (62-180-121-22.business.static.de.bt.net. [62.180.121.22])
        by smtp.gmail.com with ESMTPSA id d6sm21727364wrx.62.2019.03.26.06.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 06:56:57 -0700 (PDT)
From:   Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
To:     jic23@kernel.org
Cc:     Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: iio: Add bindings for TI TLA202x ADCs
Date:   Tue, 26 Mar 2019 14:56:20 +0100
Message-Id: <1553608583-29006-2-git-send-email-ibtsam.haq.0x01@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553608583-29006-1-git-send-email-ibtsam.haq.0x01@gmail.com>
References: <1553608583-29006-1-git-send-email-ibtsam.haq.0x01@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds devicetree bindings for TI TLA202x ADCs.

Signed-off-by: Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti-tla2024.txt     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
new file mode 100644
index 0000000..a4934df
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
@@ -0,0 +1,45 @@
+Texas Instruments' TLA2021/TLA2022/TLA2024 12-bit ADC driver
+
+Required properties:
+
+- compatible: should be one of:
+  "ti,tla2024"
+  "ti,tla2022"
+  "ti,tla2021"
+
+- reg: should contain the I2C Address of the device
+
+Required subnodes:
+
+The ADC channels are configured as subnodes of the ADC.
+The channels can be single-ended or differential, the input pins are
+also set in the subnode.
+
+Possible channels in TLA2024:
+  single: <0>, <1>, <2>, <3>
+  differential: <0 1>, <0 3>, <1 3>, <2 3>
+
+In TLA2021/TLA2022 only the differential channel <0 1> is allowed.
+
+Example:
+
+tla2024_0: adc0@49 {
+	compatible = "ti,tla2024";
+	reg = <0x49>;
+
+	v0@0 {
+		single-channel = <0>;
+	};
+
+	v1@1 {
+		single-channel = <1>;
+	};
+
+	v23@2 {
+		diff-channels = <2 3>;
+	};
+
+	v01@3 {
+		diff-channels = <0 1>;
+	};
+};
-- 
2.7.4


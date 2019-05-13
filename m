Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E0C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eUobuJlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEMVw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:52:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54186 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEMVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:52:57 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so1661823ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spz1frMWWtHxRQEXNjNtgkaY/6ePBOEmlsOI1xvvGpQ=;
        b=eUobuJlWsD+tXMvjyfP8LG+8hX5/OHN5o3k1eun6fh1/bVKcCBTfLxA/qsCoigDGHD
         rvE5NHiWuyIfArPgSX8dmmgBuG8iQVbZY94Drg2bf/mzew9kDwwP0j9V8+Np6ckuB3Wf
         ekQhRKprn4GOEdC2akwRQwV3udNz7F0aB0sIHz10SbHIP6+Ci3zJkBp47p6rV/c/6YhR
         BoqPYI4TDpmG3NWn8iw8Ejhkka5dM9cp8ekLnICbweCj5ODveLkIXYp2VePjw8jjtCJL
         /XfXbQF76c1UVpaqWX6QUREgTproaWmE6PDehw8rKUysHS3ynyOa//LDv9wkhDBFn7/Q
         1IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spz1frMWWtHxRQEXNjNtgkaY/6ePBOEmlsOI1xvvGpQ=;
        b=WSTSOV5wFnv9OLS4xRFpR8REAfkb7iP5cYmD54SFJlAecVp5ch3sjcQUT0s4Jem2nY
         ugk487r9zh4F73nZJBmgLOnmEb9e6zkwQ9CXkKQlVdKkptPNFN+9Hm/vI4VXPR7x1cZC
         gl8EemYnOySC6XuUEmkFjilNi7SoHVKjM0J4k0M90rq01DJJlfJmfhSuhQlNUNCJFCag
         8BglzX7ZH7uPJySkUoM/mawttwIvKpNv+mLjQSMyHyAopNDQTpuO7jg/+b6iChu2Aljd
         GXC7XNs4KX0y5r4NEBJxvIsY1Sux2ggOldw+faOrloct8LUCMDChVn5YRAXRMa0b/h+E
         eW/A==
X-Gm-Message-State: APjAAAVXBcVc8p0/8ulH1N1tVoErSZr5JOEunoObSZrgLeflPZziHpiJ
        iJazlbX/y69sxQbS5xfdrK8IDw==
X-Google-Smtp-Source: APXvYqwWa/47VoH+KTSKqgtWgxk99Zeoy+Ir0N2WjMp/XQzWj2496079XR5FH+BJQVnuy/4XehzeLw==
X-Received: by 2002:a02:c54a:: with SMTP id g10mr17221328jaj.43.1557784376402;
        Mon, 13 May 2019 14:52:56 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id u11sm2973863iot.44.2019.05.13.14.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:52:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] dt-bindings: sifive: describe sifive-blocks versioning
Date:   Mon, 13 May 2019 14:51:53 -0700
Message-Id: <20190513215152.26578-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IP blocks that are generated from the public, open-source
sifive-blocks repository, describe the version numbering policy
that its maintainers intend to use, upon request from Rob
Herring <robh@kernel.org>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: Wesley Terpstra <wesley@sifive.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

This second version updates the example URL, requested by
Rob Herring <robh+dt@kernel.org>.

 .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

diff --git a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
new file mode 100644
index 000000000000..beaa3b64084e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
@@ -0,0 +1,38 @@
+DT compatible string versioning for SiFive open-source IP blocks
+
+This document describes the version specification for DT "compatible"
+strings for open-source SiFive IP blocks.  HDL for these IP blocks
+can be found in this public repository:
+
+https://github.com/sifive/sifive-blocks
+
+IP block-specific DT compatible strings are contained within the HDL,
+in the form "sifive,<ip-block-name><integer version number>".
+
+An example is "sifive,uart0" from:
+
+https://github.com/sifive/sifive-blocks/blob/v1.0/src/main/scala/devices/uart/UART.scala#L43
+
+Until these IP blocks (or IP integration) support version
+auto-discovery, the maintainers of these IP blocks intend to increment
+the suffixed number in the compatible string whenever the software
+interface to these IP blocks changes, or when the functionality of the
+underlying IP blocks changes in a way that software should be aware of.
+
+Driver developers can use compatible string "match" values such as
+"sifive,uart0" to indicate that their driver is compatible with the
+register interface and functionality associated with the relevant
+upstream sifive-blocks commits.  It is expected that most drivers will
+match on these IP block-specific compatible strings.
+
+DT data authors, when writing data for a particular SoC, should
+continue to specify an SoC-specific compatible string value, such as
+"sifive,fu540-c000-uart".  This way, if SoC-specific
+integration-specific bug fixes or workarounds are needed, the kernel
+or other system software can match on this string to apply them.  The
+IP block-specific compatible string (such as "sifive,uart0") should
+then be specified as a subsequent value.
+
+An example of this style:
+
+    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-- 
2.20.1


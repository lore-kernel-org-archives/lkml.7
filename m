Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B7C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6FF2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2xDadpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfHKVB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfHKVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so1620707ljl.3;
        Sun, 11 Aug 2019 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWcZMErbEMwz64Th4LhHplqaGS7rwpGccz4nPiwxfZ0=;
        b=i2xDadpN8yLumYag0ApLbrotFtYdJt3gbWse6KUQ5CcunuT0fvaD7ysr0vePwqBebi
         WKWHQsJP+ASlRutcjVMNRNwtYvzRiVCITYw3Fxg4+VqYprbBjhlmzyzgPkIeMXgiiU3d
         eFiqD51YvO/Yj5avdmlY2KAViPf2ccQOGfziJUFztO1SsxeNyFUhHjwZiXj/MQPZtY3s
         YppqCboXNkJWn+mC1zWdzjiLXt7tFP16F6L4mEb7jFRTZ/epeMUe4uK3UJ1TiKTpcsOw
         WgeaPaHGa/dEAbVCcHlpglRczJompyiJZjViRHLtMaslXCfI+8/jEiQZ2NCJuySD7VgN
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWcZMErbEMwz64Th4LhHplqaGS7rwpGccz4nPiwxfZ0=;
        b=cjbm6e3qgAQZ/hmLXlQe1sSU7tXZ0VYpcguIkKTvGMiToq4UAi8MxXpDGOerMwo4dW
         Sjs/AYCp8gdrGFFE2P/UxYSbkhRwG88MFo0naabQTtiGbnRRu4IP13KUE/YxqgHXquzU
         0xAV3vYWkJKkf9uT+gF4NWEENzILSX2AcBuqpbE3cDlrPV7I26xaTSs2XdYAQBwnlFvn
         LGuUfCStp6bXNiK+hzq40lu2I3mNNyA1RPzYVmSVKnS6zfg+YXaaBVTLPvAgha6qt4UY
         hfO7ldB0f+h96GUwjFU+f2bV5v3JrSCrEmhVsgfG6Ht3DJNjHNdLsm8nju2dvtvRfinV
         es2g==
X-Gm-Message-State: APjAAAURw/RHWLC5TRMVkR70D47ARqq3JXGiZGlGuEINzAa8qBH/A/Ju
        ZL83yU7ydmxgR3Z6oJm0DFY=
X-Google-Smtp-Source: APXvYqzsq+jJu86A5udLDKWwbnjk8Rzglf66eSqbHtg31ag09ujY55Q+ByA5qZ2xssVx+RF5ibqH1Q==
X-Received: by 2002:a05:651c:1b9:: with SMTP id c25mr17261851ljn.25.1565557298014;
        Sun, 11 Aug 2019 14:01:38 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/15] dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory Controller
Date:   Mon, 12 Aug 2019 00:00:39 +0300
Message-Id: <20190811210043.20122-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
The binding is based on the Tegra124 EMC binding since hardware is
similar, although there are couple significant differences.

Note that the memory timing description is given in a platform-specific
form because there is no detailed information on how to convert a
typical-common DDR timing into the register values. The timing format is
borrowed from downstream kernel, hence there is no hurdle in regards to
upstreaming of memory timings for the boards.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../nvidia,tegra30-emc.yaml                   | 336 ++++++++++++++++++
 1 file changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
new file mode 100644
index 000000000000..02c70c776414
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -0,0 +1,336 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra30-emc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 SoC External Memory Controller
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The EMC interfaces with the off-chip SDRAM to service the request stream
+  sent from Memory Controller. The EMC also has various performance-affecting
+  settings beyond the obvious SDRAM configuration parameters and initialization
+  settings. Tegra30 EMC supports multiple JEDEC standard protocols: LPDDR2,
+  LPDDR3, and DDR3.
+
+properties:
+  compatible:
+    const: nvidia,tegra30-emc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nvidia,memory-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of the Memory Controller node.
+
+patternProperties:
+  "^emc-timings-[0-9]+$":
+    type: object
+    properties:
+      nvidia,ram-code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Value of RAM_CODE this timing set is used for.
+
+    patternProperties:
+      "^timing-[0-9]+$":
+        type: object
+        properties:
+          clock-frequency:
+            description:
+              Memory clock rate in Hz.
+            minimum: 1000000
+            maximum: 900000000
+
+          nvidia,emc-auto-cal-interval:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              Pad calibration interval in microseconds.
+            minimum: 0
+            maximum: 2097151
+
+          nvidia,emc-mode-1:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              Mode Register 1.
+
+          nvidia,emc-mode-2:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              Mode Register 2.
+
+          nvidia,emc-mode-reset:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              Mode Register 0.
+
+          nvidia,emc-zcal-cnt-long:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              Number of EMC clocks to wait before issuing any commands after
+              sending ZCAL_MRW_CMD.
+            minimum: 0
+            maximum: 1023
+
+          nvidia,emc-cfg-dyn-self-ref:
+            type: boolean
+            description:
+              Dynamic self-refresh enabled.
+
+          nvidia,emc-cfg-periodic-qrst:
+            type: boolean
+            description:
+              FBIO "read" FIFO periodic resetting enabled.
+
+          nvidia,emc-configuration:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description:
+              EMC timing characterization data. These are the registers
+              (see section "18.13.2 EMC Registers" in the TRM) whose values
+              need to be specified, according to the board documentation.
+            items:
+              - description: EMC_RC
+              - description: EMC_RFC
+              - description: EMC_RAS
+              - description: EMC_RP
+              - description: EMC_R2W
+              - description: EMC_W2R
+              - description: EMC_R2P
+              - description: EMC_W2P
+              - description: EMC_RD_RCD
+              - description: EMC_WR_RCD
+              - description: EMC_RRD
+              - description: EMC_REXT
+              - description: EMC_WEXT
+              - description: EMC_WDV
+              - description: EMC_QUSE
+              - description: EMC_QRST
+              - description: EMC_QSAFE
+              - description: EMC_RDV
+              - description: EMC_REFRESH
+              - description: EMC_BURST_REFRESH_NUM
+              - description: EMC_PRE_REFRESH_REQ_CNT
+              - description: EMC_PDEX2WR
+              - description: EMC_PDEX2RD
+              - description: EMC_PCHG2PDEN
+              - description: EMC_ACT2PDEN
+              - description: EMC_AR2PDEN
+              - description: EMC_RW2PDEN
+              - description: EMC_TXSR
+              - description: EMC_TXSRDLL
+              - description: EMC_TCKE
+              - description: EMC_TFAW
+              - description: EMC_TRPAB
+              - description: EMC_TCLKSTABLE
+              - description: EMC_TCLKSTOP
+              - description: EMC_TREFBW
+              - description: EMC_QUSE_EXTRA
+              - description: EMC_FBIO_CFG6
+              - description: EMC_ODT_WRITE
+              - description: EMC_ODT_READ
+              - description: EMC_FBIO_CFG5
+              - description: EMC_CFG_DIG_DLL
+              - description: EMC_CFG_DIG_DLL_PERIOD
+              - description: EMC_DLL_XFORM_DQS0
+              - description: EMC_DLL_XFORM_DQS1
+              - description: EMC_DLL_XFORM_DQS2
+              - description: EMC_DLL_XFORM_DQS3
+              - description: EMC_DLL_XFORM_DQS4
+              - description: EMC_DLL_XFORM_DQS5
+              - description: EMC_DLL_XFORM_DQS6
+              - description: EMC_DLL_XFORM_DQS7
+              - description: EMC_DLL_XFORM_QUSE0
+              - description: EMC_DLL_XFORM_QUSE1
+              - description: EMC_DLL_XFORM_QUSE2
+              - description: EMC_DLL_XFORM_QUSE3
+              - description: EMC_DLL_XFORM_QUSE4
+              - description: EMC_DLL_XFORM_QUSE5
+              - description: EMC_DLL_XFORM_QUSE6
+              - description: EMC_DLL_XFORM_QUSE7
+              - description: EMC_DLI_TRIM_TXDQS0
+              - description: EMC_DLI_TRIM_TXDQS1
+              - description: EMC_DLI_TRIM_TXDQS2
+              - description: EMC_DLI_TRIM_TXDQS3
+              - description: EMC_DLI_TRIM_TXDQS4
+              - description: EMC_DLI_TRIM_TXDQS5
+              - description: EMC_DLI_TRIM_TXDQS6
+              - description: EMC_DLI_TRIM_TXDQS7
+              - description: EMC_DLL_XFORM_DQ0
+              - description: EMC_DLL_XFORM_DQ1
+              - description: EMC_DLL_XFORM_DQ2
+              - description: EMC_DLL_XFORM_DQ3
+              - description: EMC_XM2CMDPADCTRL
+              - description: EMC_XM2DQSPADCTRL2
+              - description: EMC_XM2DQPADCTRL2
+              - description: EMC_XM2CLKPADCTRL
+              - description: EMC_XM2COMPPADCTRL
+              - description: EMC_XM2VTTGENPADCTRL
+              - description: EMC_XM2VTTGENPADCTRL2
+              - description: EMC_XM2QUSEPADCTRL
+              - description: EMC_XM2DQSPADCTRL3
+              - description: EMC_CTT_TERM_CTRL
+              - description: EMC_ZCAL_INTERVAL
+              - description: EMC_ZCAL_WAIT_CNT
+              - description: EMC_MRS_WAIT_CNT
+              - description: EMC_AUTO_CAL_CONFIG
+              - description: EMC_CTT
+              - description: EMC_CTT_DURATION
+              - description: EMC_DYN_SELF_REF_CONTROL
+              - description: EMC_FBIO_SPARE
+              - description: EMC_CFG_RSV
+
+        required:
+          - clock-frequency
+          - nvidia,emc-auto-cal-interval
+          - nvidia,emc-mode-1
+          - nvidia,emc-mode-2
+          - nvidia,emc-mode-reset
+          - nvidia,emc-zcal-cnt-long
+          - nvidia,emc-configuration
+
+        additionalProperties: false
+
+    required:
+      - nvidia,ram-code
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - nvidia,memory-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    external-memory-controller@7000f400 {
+        compatible = "nvidia,tegra30-emc";
+        reg = <0x7000f400 0x400>;
+        interrupts = <0 78 4>;
+        clocks = <&tegra_car 57>;
+
+        nvidia,memory-controller = <&mc>;
+
+        emc-timings-1 {
+            nvidia,ram-code = <1>;
+
+            timing-667000000 {
+                clock-frequency = <667000000>;
+
+                nvidia,emc-auto-cal-interval = <0x001fffff>;
+                nvidia,emc-mode-1 = <0x80100002>;
+                nvidia,emc-mode-2 = <0x80200018>;
+                nvidia,emc-mode-reset = <0x80000b71>;
+                nvidia,emc-zcal-cnt-long = <0x00000040>;
+                nvidia,emc-cfg-periodic-qrst;
+
+                nvidia,emc-configuration = <
+                    0x00000020 /* EMC_RC */
+                    0x0000006a /* EMC_RFC */
+                    0x00000017 /* EMC_RAS */
+                    0x00000007 /* EMC_RP */
+                    0x00000005 /* EMC_R2W */
+                    0x0000000c /* EMC_W2R */
+                    0x00000003 /* EMC_R2P */
+                    0x00000011 /* EMC_W2P */
+                    0x00000007 /* EMC_RD_RCD */
+                    0x00000007 /* EMC_WR_RCD */
+                    0x00000002 /* EMC_RRD */
+                    0x00000001 /* EMC_REXT */
+                    0x00000000 /* EMC_WEXT */
+                    0x00000007 /* EMC_WDV */
+                    0x0000000a /* EMC_QUSE */
+                    0x00000009 /* EMC_QRST */
+                    0x0000000b /* EMC_QSAFE */
+                    0x00000011 /* EMC_RDV */
+                    0x00001412 /* EMC_REFRESH */
+                    0x00000000 /* EMC_BURST_REFRESH_NUM */
+                    0x00000504 /* EMC_PRE_REFRESH_REQ_CNT */
+                    0x00000002 /* EMC_PDEX2WR */
+                    0x0000000e /* EMC_PDEX2RD */
+                    0x00000001 /* EMC_PCHG2PDEN */
+                    0x00000000 /* EMC_ACT2PDEN */
+                    0x0000000c /* EMC_AR2PDEN */
+                    0x00000016 /* EMC_RW2PDEN */
+                    0x00000072 /* EMC_TXSR */
+                    0x00000200 /* EMC_TXSRDLL */
+                    0x00000005 /* EMC_TCKE */
+                    0x00000015 /* EMC_TFAW */
+                    0x00000000 /* EMC_TRPAB */
+                    0x00000006 /* EMC_TCLKSTABLE */
+                    0x00000007 /* EMC_TCLKSTOP */
+                    0x00001453 /* EMC_TREFBW */
+                    0x0000000b /* EMC_QUSE_EXTRA */
+                    0x00000006 /* EMC_FBIO_CFG6 */
+                    0x00000000 /* EMC_ODT_WRITE */
+                    0x00000000 /* EMC_ODT_READ */
+                    0x00005088 /* EMC_FBIO_CFG5 */
+                    0xf00b0191 /* EMC_CFG_DIG_DLL */
+                    0x00008000 /* EMC_CFG_DIG_DLL_PERIOD */
+                    0x00000008 /* EMC_DLL_XFORM_DQS0 */
+                    0x00000008 /* EMC_DLL_XFORM_DQS1 */
+                    0x00000008 /* EMC_DLL_XFORM_DQS2 */
+                    0x00000008 /* EMC_DLL_XFORM_DQS3 */
+                    0x0000000a /* EMC_DLL_XFORM_DQS4 */
+                    0x0000000a /* EMC_DLL_XFORM_DQS5 */
+                    0x0000000a /* EMC_DLL_XFORM_DQS6 */
+                    0x0000000a /* EMC_DLL_XFORM_DQS7 */
+                    0x00018000 /* EMC_DLL_XFORM_QUSE0 */
+                    0x00018000 /* EMC_DLL_XFORM_QUSE1 */
+                    0x00018000 /* EMC_DLL_XFORM_QUSE2 */
+                    0x00018000 /* EMC_DLL_XFORM_QUSE3 */
+                    0x00000000 /* EMC_DLL_XFORM_QUSE4 */
+                    0x00000000 /* EMC_DLL_XFORM_QUSE5 */
+                    0x00000000 /* EMC_DLL_XFORM_QUSE6 */
+                    0x00000000 /* EMC_DLL_XFORM_QUSE7 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS0 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS1 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS2 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS3 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS4 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS5 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS6 */
+                    0x00000000 /* EMC_DLI_TRIM_TXDQS7 */
+                    0x0000000a /* EMC_DLL_XFORM_DQ0 */
+                    0x0000000a /* EMC_DLL_XFORM_DQ1 */
+                    0x0000000a /* EMC_DLL_XFORM_DQ2 */
+                    0x0000000a /* EMC_DLL_XFORM_DQ3 */
+                    0x000002a0 /* EMC_XM2CMDPADCTRL */
+                    0x0800013d /* EMC_XM2DQSPADCTRL2 */
+                    0x22220000 /* EMC_XM2DQPADCTRL2 */
+                    0x77fff884 /* EMC_XM2CLKPADCTRL */
+                    0x01f1f501 /* EMC_XM2COMPPADCTRL */
+                    0x07077404 /* EMC_XM2VTTGENPADCTRL */
+                    0x54000000 /* EMC_XM2VTTGENPADCTRL2 */
+                    0x080001e8 /* EMC_XM2QUSEPADCTRL */
+                    0x0c000021 /* EMC_XM2DQSPADCTRL3 */
+                    0x00000802 /* EMC_CTT_TERM_CTRL */
+                    0x00020000 /* EMC_ZCAL_INTERVAL */
+                    0x00000100 /* EMC_ZCAL_WAIT_CNT */
+                    0x0155000c /* EMC_MRS_WAIT_CNT */
+                    0xa0f10000 /* EMC_AUTO_CAL_CONFIG */
+                    0x00000000 /* EMC_CTT */
+                    0x00000000 /* EMC_CTT_DURATION */
+                    0x800028a5 /* EMC_DYN_SELF_REF_CONTROL */
+                    0xe8000000 /* EMC_FBIO_SPARE */
+                    0xff00ff49 /* EMC_CFG_RSV */
+                >;
+            };
+        };
+    };
-- 
2.22.0


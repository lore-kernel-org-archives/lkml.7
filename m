Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150582146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ockc1oTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDKXDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:03:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32805 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfDKXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:03:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so7106396ljc.0;
        Thu, 11 Apr 2019 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUrz/3Ufh4994n+5vQOz5T9B90eRK7QoMZct684RsN4=;
        b=ockc1oTV8dk/CuVHUaHDdxpGt8mzGw0HJ9fbGaCTQOV6S8ZxneHM5zrw69c13VkNSr
         qOGfWf3j3mwrngJk6zAFM4BLkRyCnzcTrTrb5xNUDTUkhzy3Iyz1eo3axVAU0GRvuMm8
         WfsteyHXk/Zg+Su/XquLxNFkP8ymPBiRvfPe7xZUPIdNf74XtsFmFSNFGmgPyfqT9I8v
         epvRJYzM+Qcp0C5E9Anar726rvLLflLFwQN5pHE4OkJQaNUrIMluKLOCl8JKpDCO4O1C
         4d6xar55yuheBstlPQ434dWGpTbuB6FW/LWg3uoNJSFb7XH3fkLFQh+Ut16hCb6UwYCz
         uWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUrz/3Ufh4994n+5vQOz5T9B90eRK7QoMZct684RsN4=;
        b=YIzbXyaUAy2Vi0VaoOWRIyWxcboE7mmAQZ8HdddYwHqLJ8JlYWJFC3bxwH/9IwzbZg
         7FSgWFU4hjPMVTw1HQ+vLR/zVLvaLR9iylGqmIl9l3+JUQJ2zmFRC+YeDnEIhzI1FlLX
         s4nM5a80yvI0eWKgyCIFKCLpDfVLFYFgFbtk0S14nAurZJfC542YW3N5ej9P3RbuPlJL
         WDHJ0LlcmsesY14D7KznRu51LXc080dAvGZFnzJzM/u2rmaT4BiZWV7HnHIA7x3tGM6L
         GZeFKOcajfGrE3HOI/vTX4Mg+PL3uffc3WHcfOX5jG7zm9ZCjGLgmuCBO4rEvoupXyRR
         62QQ==
X-Gm-Message-State: APjAAAV3CORj/SAxklIrBFEZgvMZzqNfZFTbgwmW/HgKSVT7hdAyX4Jk
        MGPB9qi5R6IdC4tnalqFpmQ=
X-Google-Smtp-Source: APXvYqwdYZrD6gQIehbV+e0oRBsfB/woSg2xvhagmDjpf2fBn+quyQqaRFJUJyTiYYnhsxpUwR/kkQ==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr28759044ljk.158.1555023806581;
        Thu, 11 Apr 2019 16:03:26 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id u19sm7764486lfg.74.2019.04.11.16.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:03:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory Controller
Date:   Fri, 12 Apr 2019 02:02:19 +0300
Message-Id: <20190411230221.31362-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411230221.31362-1-digetx@gmail.com>
References: <20190411230221.31362-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
The binding is based on the Tegra124 EMC binding since hardware is
similar, although there are couple significant differences.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-emc.txt | 257 ++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
new file mode 100644
index 000000000000..dffe396c5d79
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
@@ -0,0 +1,257 @@
+NVIDIA Tegra30 SoC EMC (external memory controller)
+====================================================
+
+Required properties :
+- compatible : Should be "nvidia,tegra30-emc".
+- reg : physical base address and length of the controller's registers.
+- #address-cells : Should be 1
+- #size-cells : Should be 0
+- interrupts : Should contain EMC General interrupt.
+- clocks : Should contain EMC clock.
+- nvidia,memory-controller : phandle of the MC driver.
+
+The node should contain a "emc-timings" subnode for each supported RAM type
+(see field RAM_CODE in register PMC_STRAPPING_OPT_A), with its unit address
+being its RAM_CODE.
+
+Required properties for "emc-timings" nodes :
+- nvidia,ram-code : Should contain the value of RAM_CODE this timing set is
+used for.
+
+Each "emc-timings" node should contain a "timing" subnode for every supported
+EMC clock rate. The "timing" subnodes should have the clock rate in Hz as
+their unit address.
+
+Required properties for "timing" nodes :
+- clock-frequency : Should contain the memory clock rate in Hz.
+- The following properties contain EMC timing characterization values
+(specified in the board documentation) :
+  - nvidia,emc-auto-cal-interval : EMC_AUTO_CAL_INTERVAL
+  - nvidia,emc-mode-1 : Mode Register 1
+  - nvidia,emc-mode-2 : Mode Register 2
+  - nvidia,emc-mode-reset : Mode Register 0
+  - nvidia,emc-zcal-cnt-long : EMC_ZCAL_WAIT_CNT after clock change
+  - nvidia,emc-cfg-dyn-self-ref : dynamic self-refresh enabled
+  - nvidia,emc-cfg-periodic-qrst : FBIO "read" FIFO periodic resetting enabled
+- nvidia,emc-configuration : EMC timing characterization data. These are the
+registers (see section "18.13.2 EMC Registers" in the TRM) whose values need to
+be specified, according to the board documentation:
+
+	EMC_RC
+	EMC_RFC
+	EMC_RAS
+	EMC_RP
+	EMC_R2W
+	EMC_W2R
+	EMC_R2P
+	EMC_W2P
+	EMC_RD_RCD
+	EMC_WR_RCD
+	EMC_RRD
+	EMC_REXT
+	EMC_WEXT
+	EMC_WDV
+	EMC_QUSE
+	EMC_QRST
+	EMC_QSAFE
+	EMC_RDV
+	EMC_REFRESH
+	EMC_BURST_REFRESH_NUM
+	EMC_PRE_REFRESH_REQ_CNT
+	EMC_PDEX2WR
+	EMC_PDEX2RD
+	EMC_PCHG2PDEN
+	EMC_ACT2PDEN
+	EMC_AR2PDEN
+	EMC_RW2PDEN
+	EMC_TXSR
+	EMC_TXSRDLL
+	EMC_TCKE
+	EMC_TFAW
+	EMC_TRPAB
+	EMC_TCLKSTABLE
+	EMC_TCLKSTOP
+	EMC_TREFBW
+	EMC_QUSE_EXTRA
+	EMC_FBIO_CFG6
+	EMC_ODT_WRITE
+	EMC_ODT_READ
+	EMC_FBIO_CFG5
+	EMC_CFG_DIG_DLL
+	EMC_CFG_DIG_DLL_PERIOD
+	EMC_DLL_XFORM_DQS0
+	EMC_DLL_XFORM_DQS1
+	EMC_DLL_XFORM_DQS2
+	EMC_DLL_XFORM_DQS3
+	EMC_DLL_XFORM_DQS4
+	EMC_DLL_XFORM_DQS5
+	EMC_DLL_XFORM_DQS6
+	EMC_DLL_XFORM_DQS7
+	EMC_DLL_XFORM_QUSE0
+	EMC_DLL_XFORM_QUSE1
+	EMC_DLL_XFORM_QUSE2
+	EMC_DLL_XFORM_QUSE3
+	EMC_DLL_XFORM_QUSE4
+	EMC_DLL_XFORM_QUSE5
+	EMC_DLL_XFORM_QUSE6
+	EMC_DLL_XFORM_QUSE7
+	EMC_DLI_TRIM_TXDQS0
+	EMC_DLI_TRIM_TXDQS1
+	EMC_DLI_TRIM_TXDQS2
+	EMC_DLI_TRIM_TXDQS3
+	EMC_DLI_TRIM_TXDQS4
+	EMC_DLI_TRIM_TXDQS5
+	EMC_DLI_TRIM_TXDQS6
+	EMC_DLI_TRIM_TXDQS7
+	EMC_DLL_XFORM_DQ0
+	EMC_DLL_XFORM_DQ1
+	EMC_DLL_XFORM_DQ2
+	EMC_DLL_XFORM_DQ3
+	EMC_XM2CMDPADCTRL
+	EMC_XM2DQSPADCTRL2
+	EMC_XM2DQPADCTRL2
+	EMC_XM2CLKPADCTRL
+	EMC_XM2COMPPADCTRL
+	EMC_XM2VTTGENPADCTRL
+	EMC_XM2VTTGENPADCTRL2
+	EMC_XM2QUSEPADCTRL
+	EMC_XM2DQSPADCTRL3
+	EMC_CTT_TERM_CTRL
+	EMC_ZCAL_INTERVAL
+	EMC_ZCAL_WAIT_CNT
+	EMC_MRS_WAIT_CNT
+	EMC_AUTO_CAL_CONFIG
+	EMC_CTT
+	EMC_CTT_DURATION
+	EMC_DYN_SELF_REF_CONTROL
+	EMC_FBIO_SPARE
+	EMC_CFG_RSV
+
+Example SoC include file:
+
+/ {
+	emc@7000f400 {
+		compatible = "nvidia,tegra30-emc";
+		reg = <0x7000f400 0x400>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_EMC>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+};
+
+Example board file:
+
+/ {
+	emc@7000f400 {
+		emc-timings-1 {
+			nvidia,ram-code = <1>;
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200018>;
+				nvidia,emc-mode-reset = <0x80000b71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref = <0x00000000>;
+				nvidia,emc-cfg-periodic-qrst = <0x00000001>;
+
+				nvidia,emc-configuration = <
+					0x00000020 /* EMC_RC */
+					0x0000006a /* EMC_RFC */
+					0x00000017 /* EMC_RAS */
+					0x00000007 /* EMC_RP */
+					0x00000005 /* EMC_R2W */
+					0x0000000c /* EMC_W2R */
+					0x00000003 /* EMC_R2P */
+					0x00000011 /* EMC_W2P */
+					0x00000007 /* EMC_RD_RCD */
+					0x00000007 /* EMC_WR_RCD */
+					0x00000002 /* EMC_RRD */
+					0x00000001 /* EMC_REXT */
+					0x00000000 /* EMC_WEXT */
+					0x00000007 /* EMC_WDV */
+					0x0000000a /* EMC_QUSE */
+					0x00000009 /* EMC_QRST */
+					0x0000000b /* EMC_QSAFE */
+					0x00000011 /* EMC_RDV */
+					0x00001412 /* EMC_REFRESH */
+					0x00000000 /* EMC_BURST_REFRESH_NUM */
+					0x00000504 /* EMC_PRE_REFRESH_REQ_CNT */
+					0x00000002 /* EMC_PDEX2WR */
+					0x0000000e /* EMC_PDEX2RD */
+					0x00000001 /* EMC_PCHG2PDEN */
+					0x00000000 /* EMC_ACT2PDEN */
+					0x0000000c /* EMC_AR2PDEN */
+					0x00000016 /* EMC_RW2PDEN */
+					0x00000072 /* EMC_TXSR */
+					0x00000200 /* EMC_TXSRDLL */
+					0x00000005 /* EMC_TCKE */
+					0x00000015 /* EMC_TFAW */
+					0x00000000 /* EMC_TRPAB */
+					0x00000006 /* EMC_TCLKSTABLE */
+					0x00000007 /* EMC_TCLKSTOP */
+					0x00001453 /* EMC_TREFBW */
+					0x0000000b /* EMC_QUSE_EXTRA */
+					0x00000006 /* EMC_FBIO_CFG6 */
+					0x00000000 /* EMC_ODT_WRITE */
+					0x00000000 /* EMC_ODT_READ */
+					0x00005088 /* EMC_FBIO_CFG5 */
+					0xf00b0191 /* EMC_CFG_DIG_DLL */
+					0x00008000 /* EMC_CFG_DIG_DLL_PERIOD */
+					0x00000008 /* EMC_DLL_XFORM_DQS0 */
+					0x00000008 /* EMC_DLL_XFORM_DQS1 */
+					0x00000008 /* EMC_DLL_XFORM_DQS2 */
+					0x00000008 /* EMC_DLL_XFORM_DQS3 */
+					0x0000000a /* EMC_DLL_XFORM_DQS4 */
+					0x0000000a /* EMC_DLL_XFORM_DQS5 */
+					0x0000000a /* EMC_DLL_XFORM_DQS6 */
+					0x0000000a /* EMC_DLL_XFORM_DQS7 */
+					0x00018000 /* EMC_DLL_XFORM_QUSE0 */
+					0x00018000 /* EMC_DLL_XFORM_QUSE1 */
+					0x00018000 /* EMC_DLL_XFORM_QUSE2 */
+					0x00018000 /* EMC_DLL_XFORM_QUSE3 */
+					0x00000000 /* EMC_DLL_XFORM_QUSE4 */
+					0x00000000 /* EMC_DLL_XFORM_QUSE5 */
+					0x00000000 /* EMC_DLL_XFORM_QUSE6 */
+					0x00000000 /* EMC_DLL_XFORM_QUSE7 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS0 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS1 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS2 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS3 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS4 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS5 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS6 */
+					0x00000000 /* EMC_DLI_TRIM_TXDQS7 */
+					0x0000000a /* EMC_DLL_XFORM_DQ0 */
+					0x0000000a /* EMC_DLL_XFORM_DQ1 */
+					0x0000000a /* EMC_DLL_XFORM_DQ2 */
+					0x0000000a /* EMC_DLL_XFORM_DQ3 */
+					0x000002a0 /* EMC_XM2CMDPADCTRL */
+					0x0800013d /* EMC_XM2DQSPADCTRL2 */
+					0x22220000 /* EMC_XM2DQPADCTRL2 */
+					0x77fff884 /* EMC_XM2CLKPADCTRL */
+					0x01f1f501 /* EMC_XM2COMPPADCTRL */
+					0x07077404 /* EMC_XM2VTTGENPADCTRL */
+					0x54000000 /* EMC_XM2VTTGENPADCTRL2 */
+					0x080001e8 /* EMC_XM2QUSEPADCTRL */
+					0x0c000021 /* EMC_XM2DQSPADCTRL3 */
+					0x00000802 /* EMC_CTT_TERM_CTRL */
+					0x00020000 /* EMC_ZCAL_INTERVAL */
+					0x00000100 /* EMC_ZCAL_WAIT_CNT */
+					0x0155000c /* EMC_MRS_WAIT_CNT */
+					0xa0f10000 /* EMC_AUTO_CAL_CONFIG */
+					0x00000000 /* EMC_CTT */
+					0x00000000 /* EMC_CTT_DURATION */
+					0x800028a5 /* EMC_DYN_SELF_REF_CONTROL */
+					0xe8000000 /* EMC_FBIO_SPARE */
+					0xff00ff49 /* EMC_CFG_RSV */
+				>;
+			};
+		};
+	};
+};
-- 
2.21.0


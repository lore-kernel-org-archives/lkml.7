Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64826C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0402084B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPQ1Epw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfFPXm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:42:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46315 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPXm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:42:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so7479238ljg.13;
        Sun, 16 Jun 2019 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zmeHzzYN11auCChypR1/YdJ8WJyBi3KdavNBioRpMw=;
        b=rPQ1Epw6j667p+z7dMOzLSka8Si2P6mC4il+9+Bva2/qGnqqxYCfrgQ9XZk/0gnHSP
         tkU7AA492MTMcQ8RtNtJ5K3HUrV8INO2Fr23EnI/E0WrhFiYZvk0FktQuPTZ20xfYbx6
         dJCbdguRSw7i8K5lVpsZIRmfCPugFJ1jVXsu6tpg99bFS9xCRNqKAVN8M/1wPKDu7cC7
         BPDr04MJMEre+c9fjTMfgLzq9mS7u6kuW6JtvGz9j/lyaEOqfOn4DBqEsPe8JzC7vwaF
         R0JLcJ/cHrhhcYRJtwN8S8ZFvfhA4Lwq7MFadG3Xy0jddNnAuS/OORDz3vGgI2a8zLcy
         TSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zmeHzzYN11auCChypR1/YdJ8WJyBi3KdavNBioRpMw=;
        b=EHiJlLVW17OPdLjlqGqovrr96885rnMkWfmmMP8IPR4nzfMlOBJbzJGOHAUzgoPfoE
         /GA824s4LSqXjD0+G7rd/CtIGp+Q/SAZji4XSvoNNjvDGpL1gxgghlikx/ZG4kCcjeao
         ZSiTjxWBu/JQQB0UptUomBnPyWRJl/l6jZ0o4Wmei0FH6OvsNhAB/w7i8UGXot6oGGiA
         Zkmi+lrN5qgbhiKGRwj+Vvd9vSsLvxrt6hc1HE9aq8qE+Nb+5jGQUlO+fPxNDVTHq11n
         tBLTNyd3OtjtSe8Z5HciM3u1k9pPy+9m4iYAcd4OXf+Xro/AIc1CRnDMvdCgEJ1X3GLV
         kUcw==
X-Gm-Message-State: APjAAAX4+nJ0dsdkctOkFGoOakluO7E7QGPolqsmRncqM5Gl7G5pNxu0
        dGd8xpdSI0UNVh4LEr36kRY=
X-Google-Smtp-Source: APXvYqwH3woxgpSYQZj8q0cWZ8c8B0EgaquLbIoNKASbILJOqCyJP85h9E9gWW9n8MidSaQlJrSaMA==
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr23052972lji.64.1560728171346;
        Sun, 16 Jun 2019 16:36:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:10 -0700 (PDT)
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
Subject: [PATCH v4 06/10] dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory Controller
Date:   Mon, 17 Jun 2019 02:35:47 +0300
Message-Id: <20190616233551.6838-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-emc.txt | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
new file mode 100644
index 000000000000..c2bc1dbcaa07
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
@@ -0,0 +1,249 @@
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
+Example:
+
+	external-memory-controller {
+		compatible = "nvidia,tegra30-emc";
+		reg = <0x7000f400 0x400>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_EMC>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
+
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
-- 
2.22.0


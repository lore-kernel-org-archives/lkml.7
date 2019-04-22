Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28246C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D269B20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d5COIift"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDVOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:38:19 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:6308
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbfDVOiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThPU7Eu7TWG4AlYUZebQSujwexxiAGytcn8ClfZxxnY=;
 b=d5COIift2zwaGmC4uAM2wBG/3+ilj7CfCYagq+hpYUB2vJHcAOsqwLktcjm4LJ1c3Azifnup1LQfK27ZWORey+aFR3ihPuxYLEMCn1TpnXE6qUySg1p65xmffBa6B14FXbBTuPC4rw932mDxgjq0Qn80kF6QXlk4W5KzcaUF7h8=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by BLUPR02MB501.namprd02.prod.outlook.com (2a01:111:e400:88c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Mon, 22 Apr
 2019 14:38:11 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 14:38:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 14:38:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa5B-0002ao-5F; Mon, 22 Apr 2019 07:38:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa56-0002k7-1Y; Mon, 22 Apr 2019 07:38:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3MEbuNx023911;
        Mon, 22 Apr 2019 07:37:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hIa4y-0002Zf-8T; Mon, 22 Apr 2019 07:37:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 77971121026; Mon, 22 Apr 2019 20:07:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <Jisheng.Zhang@synaptics.com>, <olof@lixom.net>,
        <dinguyen@kernel.org>, <amit.kucheria@linaro.org>,
        <stefan.popa@analog.com>, <dmurphy@ti.com>,
        <marcus.folkesson@gmail.com>, <tmaimon77@gmail.com>,
        <ricardo@ribalda.com>, <xc-racer2@live.ca>,
        <contact@artur-rojek.eu>, <geert@linux-m68k.org>,
        <smohanad@codeaurora.org>, <charles-antoine.couret@essensium.com>,
        <stefan@agner.ch>, <max.krummenacher@toradex.com>,
        <lee.jones@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Mon, 22 Apr 2019 20:07:48 +0530
Message-ID: <1555943870-15353-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
References: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(189003)(199004)(50466002)(63266004)(48376002)(478600001)(50226002)(76176011)(16586007)(42186006)(186003)(70206006)(110136005)(36386004)(8676002)(47776003)(81166006)(2906002)(90966002)(316002)(8936002)(26005)(81156014)(103686004)(72206003)(44832011)(54906003)(70586007)(2201001)(356004)(6666004)(36756003)(52956003)(7416002)(446003)(11346002)(476003)(126002)(336012)(426003)(5660300002)(486006)(6266002)(51416003)(4326008)(2616005)(106002)(305945005)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB501;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c729e350-e69c-404a-adcd-08d6c73024a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR02MB501;
X-MS-TrafficTypeDiagnostic: BLUPR02MB501:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB5011C0A1B3BCC26C177B398C1220@BLUPR02MB501.namprd02.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EPpWg89tZacfIVIgLsw3oLUdIrI9c7mi2USUEY5bxLWZJ1k6Ukr2mf4WeIUnG36DwAZVeAfZzGgGPNMQ0lzSLWFmhSE4y5vCUfcFGvE4HY7PGN8XsGfYAnzn9uI3nmXTNXozIZ6DjR2I33a6mjkcc910J8kca7i4b9fTq+QqP/BOUcPH37der0a5G2eBq+XInLR94ZtuUNOw/asUt4vIMmNdAoXZmRgDb6/a5nCa5MZfhc0N3MG1TiqH6hNCMya/ur6z3q1VHvUrPT+g8y95gXAzCDlxtwL34N51GqUC1UOcU5ByUUcf7jtwUsm35/VqVY9A/vLBsolxX1PZ7kd4MytXHlBeY4rQYtfkLpgnAUE4UXMwKT1hydNhcvolgAGA6DcWUzd4cHHUFbsMPMqjc168skFQBSZdUAe/KIKRJ2o=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 14:38:09.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c729e350-e69c-404a-adcd-08d6c73024a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
new file mode 100644
index 0000000..cacb6d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
@@ -0,0 +1,183 @@
+Xilinx AMS controller
+`````````````````````
+The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
+that can be used to sample external voltages and monitor on-die operating
+conditions, such as temperature and supply voltage levels.
+The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
+PS (Processing System) SYSMON.
+All designs should have AMS registers, but PS and PL are optional. The
+AMS controller can work with only PS, only PL and both PS and PL
+configurations. Please specify registers according to your design. Devicetree
+should always have AMS module property. Providing PS & PL module is optional.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams"
+	- reg: Should specify AMS register space
+	- interrupts: Interrupt number for the AMS control interface
+	- interrupt-names: Interrupt name, must be "ams-irq"
+	- clocks: Should contain a clock specifier for the device
+	- ranges: keep the property empty to map child address space
+	          (for PS and/or PL) nodes 1:1 onto the parent address
+	          space
+
+	AMS sub-nodes:
+		- ams-ps : Used as PS-SYSMON node
+		- ams-pl : Used as PL-SYSMON node
+
+
+
+AMS PS-SYSMON
+`````````````
+PS (Processing System) SYSMON is memory mapped to PS. This block has built-in
+alarm generation logic that is used to interrupt the processor based on
+condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-ps"
+	- reg: Register space for PS-SYSMON
+
+
+
+AMS PL-SYSMON
+`````````````
+PL-SYSMON is capable of monitoring off chip voltage and temperature. PL-SYSMON
+block has DRP, JTAG and I2C interface to enable monitoring from external master.
+Out of this interface currently only DRP is supported. This block has alarm
+generation logic that is used to interrupt the processor based on condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-pl"
+	- reg: Register space for PL-SYSMON
+
+PL-SYSMON optional sub-nodes:
+	- xlnx,ext-channels: List of external channels that are connected to the
+	                     AMS PL module.
+
+	  The child nodes of PL-SYSMON represent the external channels which are
+	  connected to this Module. If the property is not present
+	  no external channels will be assumed to be connected.
+
+	  Each child node represents one channel and has the following
+	  properties:
+
+	Required properties:
+		* reg: Pair of pins the channel is connected to. This value is
+		       same as Channel Number for particular channel.
+
+		    'reg' value		Channel Name
+		    -----------		------------
+			30		VP/VN
+			31		VUSER0
+			32		VUSER1
+			33		VUSER3
+			34		VUSER4
+			35		VAUXP[0]/VAUXN[0]
+			36		VAUXP[1]/VAUXN[1]
+			...
+			50		VAUXP[15]/VAUXN[15]
+
+		Each channel number should only be used at most once. For
+		more details on channels, refer to the table given at the end.
+
+	Optional properties:
+		* xlnx,bipolar: If set the channel is used in bipolar
+		  mode.
+
+
+Example:
+	xilinx_ams: ams@ffa50000 {
+		compatible = "xlnx,zynqmp-ams";
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4>;
+		interrupt-names = "ams-irq";
+		reg = <0x0 0xffa50000 0x0 0x800>;
+		reg-names = "ams-base";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#io-channel-cells = <1>;
+		ranges = <0 0 0xffa50800 0x800>;
+
+		ams_ps: ams-ps@0,0 {
+			compatible = "xlnx,zynqmp-ams-ps";
+			reg = <0 0x400>;
+		};
+
+		ams_pl: ams-pl@1,0 {
+			compatible = "xlnx,zynqmp-ams-pl";
+			reg = <0x400 0x400>;
+			xlnx,ext-channels {
+				channel@30 {
+					reg = <30>;
+					xlnx,bipolar;
+				};
+				channel@31 {
+					reg = <31>;
+				};
+				channel@38 {
+					reg = <38>;
+					xlnx,bipolar;
+				};
+			};
+		};
+	};
+
+
+AMS Channel Details
+```````````````````
+Sysmon Block	|Channel|			Details					|Measurement
+		|Number	|							 	|Type
+---------------------------------------------------------------------------------------------------------
+AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
+		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
+		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
+		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
+		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
+---------------------------------------------------------------------------------------------------------
+PS Sysmon	|7	|LPD temperature measurement.					|Temperature
+		|8	|FPD temperature measurement (REMOTE).				|Temperature
+		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
+		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
+		|11	|PS Aux voltage reference (supply3).				|Voltage
+		|12	|DDR I/O VCC voltage measurement.				|Voltage
+		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
+		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
+		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
+		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
+		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
+		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
+		|19	|VCC_PSADC voltage measurement.					|Voltage
+---------------------------------------------------------------------------------------------------------
+PL Sysmon	|20	|PL temperature measurement.					|Temperature
+		|21	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|22	|PL Auxiliary voltage measurement, VCCAUX.			|Voltage
+		|23	|ADC Reference P+ voltage measurement.				|Voltage
+		|24	|ADC Reference N- voltage measurement.				|Voltage
+		|25	|PL Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|26	|LPD Internal voltage measurement, VCC_PSINTLP (supply4).	|Voltage
+		|27	|FPD Internal voltage measurement, VCC_PSINTFP (supply5).	|Voltage
+		|28	|PS Auxiliary voltage measurement (supply6).			|Voltage
+		|29	|PL VCCADC voltage measurement (vccams).			|Voltage
+		|30	|Differential analog input signal voltage measurment.		|Voltage
+		|31	|VUser0 voltage measurement (supply7).				|Voltage
+		|32	|VUser1 voltage measurement (supply8).				|Voltage
+		|33	|VUser2 voltage measurement (supply9).				|Voltage
+		|34	|VUser3 voltage measurement (supply10).				|Voltage
+		|35	|Auxiliary ch 0 voltage measurement (VAux0).			|Voltage
+		|36	|Auxiliary ch 1 voltage measurement (VAux1).			|Voltage
+		|37	|Auxiliary ch 2 voltage measurement (VAux2).			|Voltage
+		|38	|Auxiliary ch 3 voltage measurement (VAux3).			|Voltage
+		|39	|Auxiliary ch 4 voltage measurement (VAux4).			|Voltage
+		|40	|Auxiliary ch 5 voltage measurement (VAux5).			|Voltage
+		|41	|Auxiliary ch 6 voltage measurement (VAux6).			|Voltage
+		|42	|Auxiliary ch 7 voltage measurement (VAux7).			|Voltage
+		|43	|Auxiliary ch 8 voltage measurement (VAux8).			|Voltage
+		|44	|Auxiliary ch 9 voltage measurement (VAux9).			|Voltage
+		|45	|Auxiliary ch 10 voltage measurement (VAux10).			|Voltage
+		|46	|Auxiliary ch 11 voltage measurement (VAux11).			|Voltage
+		|47	|Auxiliary ch 12 voltage measurement (VAux12).			|Voltage
+		|48	|Auxiliary ch 13 voltage measurement (VAux13).			|Voltage
+		|49	|Auxiliary ch 14 voltage measurement (VAux14).			|Voltage
+		|50	|Auxiliary ch 15 voltage measurement (VAux15).			|Voltage
+---------------------------------------------------------------------------------------------------------
-- 
2.1.1


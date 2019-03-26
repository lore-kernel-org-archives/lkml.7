Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9115C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9D620685
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HyPHHPbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfCZObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:31:36 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:5281
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZObf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxlUa9cRoRslUi+pqwrM2YRaRcawTDwdfE+KZbSVlok=;
 b=HyPHHPbI0huHxR9QgHZHXRMl4r2FGWsBAEIOC5GGhGZgufnSPcGutI5xAW1lNsYT7C1DmRVSmsfXdVME7+ypnBAmqjroHVGQY3unwGeSbBFdGvfzR7oKHA7Qj01pWy0JBu08rRJWVS/fETsTyUlteap95cPPVQfZJQeKt+oI3fU=
Received: from BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36)
 by BLUPR02MB1650.namprd02.prod.outlook.com (2a01:111:e400:525f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Tue, 26 Mar
 2019 14:31:31 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0131.outlook.office365.com
 (2603:10b6:208:35::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 14:31:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 14:31:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n6w-0003nS-DP; Tue, 26 Mar 2019 07:31:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n6r-0002us-9n; Tue, 26 Mar 2019 07:31:25 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2QEVN4s031902;
        Tue, 26 Mar 2019 07:31:23 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h8n6p-0002t5-AW; Tue, 26 Mar 2019 07:31:23 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 0/6]dt-bindings: Firmware node binding for ZynqMP core
Date:   Tue, 26 Mar 2019 20:01:23 +0530
Message-ID: <20190326143129.2608-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39850400004)(346002)(2980300002)(199004)(189003)(36756003)(50466002)(1076003)(106002)(36386004)(16586007)(356004)(110136005)(316002)(2201001)(48376002)(47776003)(5660300002)(186003)(77096007)(6346003)(426003)(305945005)(26005)(486006)(476003)(126002)(2616005)(336012)(51416003)(7696005)(478600001)(8676002)(9786002)(81156014)(81166006)(2906002)(106466001)(63266004)(50226002)(8936002)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1650;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec9d135-6403-436f-353a-08d6b1f7bd6d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:BLUPR02MB1650;
X-MS-TrafficTypeDiagnostic: BLUPR02MB1650:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1650B6CC1131452D88D56A76C25F0@BLUPR02MB1650.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rmMJmpMaGZwM5v+kuo2M+vnyvBjw+8LfeSWXsAxzJFJbn2V+lyNxS8sBGBgwvpWbCkvByf9vrGnV8+XHGRD/pbDbRnfZuTCfEY89yLnCh/SNVVss7DjihRtXhcrXYGpSccRkKOei3HD9OyEcG5hG0kWiy2zla21AChoClZ4iUs12pevLlYFsBEAn40J47Hqp5pWxwHN80mR8+kxO15ky8pUeEponQ36TOtGHDpwBOQkw0BNQ0bB8VT+uhVV3/9iEyDtYz1ntY4F5zjjSKSyK6/j1Ygigki1k9lHyhoFo5qRdZMkQiyomNuGl7huZhwupYYwPHY0L+jZStZ9iJ9wTkpstOdiKtddCEb5+V6MIqSPs1wQMdPjOTtbtMKs3TpDtS7QU7L0QhFbMW2trwlNL0xYFZJ/iXluJfWNGEvJZbGs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 14:31:30.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec9d135-6403-436f-353a-08d6b1f7bd6d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base firmware node and clock child node binding are part of mainline kernel.
This patchset adds documentation to describe rest of the firmware child node bindings. 

Complete firmware DT node example is shown below for ease of understanding:

firmware {
        zynqmp_firmware: zynqmp-firmware {
                compatible = "xlnx,zynqmp-firmware";
                method = "smc";
                #power-domain-cells = <1>;
                #reset-cells = <1>;

                zynqmp_clk: clock-controller {
                        #clock-cells = <1>;
                        compatible = "xlnx,zynqmp-clk";
                        clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
                        clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
                };

                zynqmp_power: zynqmp-power {
                        compatible = "xlnx,zynqmp-power";
                        interrupts = <0 35 4>;
                };

                zynqmp_reset: reset-controller {
                        compatible = "xlnx,zynqmp-reset";
                        #reset-cells = <1>;
                };
 
		nvmem_firmware {
                        compatible = "xlnx,zynqmp-nvmem-fw";
                        #address-cells = <1>;
                        #size-cells = <1>;

                        /* Data cells */
                        soc_revision: soc_revision {
                                reg = <0x0 0x4>;
                        };
                };

		pinctrl0: pinctrl@ff180000 {
                        compatible = "xlnx,zynqmp-pinctrl";

                        pinctrl_uart1_default: uart1-default {
                                mux {
                                        groups = "uart0_4_grp";
                                        function = "uart0";
                                };

                                conf {
                                        groups = "uart0_4_grp";
                                        slew-rate = <SLEW_RATE_SLOW>;
                                        io-standard = <IO_STANDARD_LVCMOS18>;
                                };

                                conf-rx {
                                        pins = "MIO18";
                                        bias-high-impedance;
                                };

                                conf-tx {
                                        pins = "MIO19";
                                        bias-disable;
                                        schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
                                };
                        };
                };

		zynqmp_pcap: pcap {
			compatible = "xlnx,zynqmp-pcap-fpga";
		};
	};
};
		
Nava kishore Manne (3):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  25 ++
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  47 +++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 .../power/reset/xlnx,zynqmp-power.txt         |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt      |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |  39 +++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++
 8 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

-- 
2.18.0


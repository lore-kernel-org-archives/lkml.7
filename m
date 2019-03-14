Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6285B2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BkwhNVTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCNOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:01:18 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:64994
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbfCNOBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH7g+LLBxtAE7Mx1P+e00ZvdplOTquTiZDgt/j9pgDg=;
 b=BkwhNVTE+Tza5KZE2arm7SMXU6THKFOPWKPORc2IzPowB1ShZlDaseFamBlR8qcZc1lxZnr3rJS8g9zrePsL+V0iERSbCr8jf5vogCJECRyjdAIcFijzGjQB9x6320Ei76Cv3eRH6O20WYPY56obsFt/eHf9M/f3+KwH5dTTpZM=
Received: from MWHPR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:301:73::28) by DM6PR02MB4956.namprd02.prod.outlook.com
 (2603:10b6:5:11::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.20; Thu, 14 Mar
 2019 14:01:12 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MWHPR0201CA0051.outlook.office365.com
 (2603:10b6:301:73::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 14:01:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Thu, 14 Mar 2019 14:01:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51576 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qv0-0002k0-5P; Thu, 14 Mar 2019 07:01:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Quu-0005BB-Ul; Thu, 14 Mar 2019 07:01:04 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Quo-0004xG-8T; Thu, 14 Mar 2019 07:00:58 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 0/6]dt-bindings: Firmware node binding for ZynqMP core
Date:   Thu, 14 Mar 2019 19:31:16 +0530
Message-ID: <20190314140122.23372-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(305945005)(106466001)(426003)(336012)(2616005)(126002)(486006)(476003)(2906002)(1076003)(36756003)(478600001)(2201001)(63266004)(26005)(48376002)(51416003)(50466002)(7696005)(110136005)(5660300002)(106002)(77096007)(81156014)(81166006)(36386004)(9786002)(356004)(8676002)(6666004)(16586007)(186003)(316002)(50226002)(47776003)(8936002)(921003)(2101003)(5001870100001)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4956;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28fde714-adc8-484e-0ed0-08d6a88583b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB4956;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4956:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;20:iJalU6RfMhc9m0jvJWn3HYrP2ybvSp9xqv6UN+j0aOLVi+cQ7VwmtyvqwiD1JJMWVW1ueJYBJR4wwCiHxMXDK/eC3N7DX1EWoLBZ56KhsIDDXlb14Acot3fdWoG/9m/Nb8q+Ri3U2h5hMsbjIXkxc3Wx/yE91hEkUQxTXMJ1X0Gc+eHJKpa6Ct77SSsIQsug2ad37gJ707BDpuavuPDj2qj9n1EzWDgt31RC95ZSUX9adDq0NDu6NbPOYQHlWXTIr5W6p1ukJnyN/yhha/etQUHc3976MuhWFdf+8OFKfCgUheRAkTzZ7BeBYDKs1lCbm0NDZHjjX8tMl13gqT0lLpChS/ZJV7QRDK+W4qAXZ1mIdMNSXPwYNgqFo7UDTtJCnFHJu8jSoKVBHgigOFFCHqt4VpVgrEufPJzHhGMTWneSPjKL4lLPH2vBGbRivWhHPPc7Hr+4NSlMEdRSddzMHvP1cIWBg/va9nglKBk0HdF1kw3EovnIYgpKGEfWqv9Y
X-Microsoft-Antispam-PRVS: <DM6PR02MB4956335AD349C39B726ED1F1C24B0@DM6PR02MB4956.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4956;23:z+7PKBs6viB8eM/wmLY5QFQ9tnKa9ipoy/3jvJy+4?=
 =?us-ascii?Q?V0KrJU+53nT+ryHISN5m8A+0KPOSB39EzEbU/pqNdhfmtpFPFWUxl9PZlzxD?=
 =?us-ascii?Q?tQgwJNeXx81v75SrW5Es0aQ+gmFnTK7gs7JOHMWuK47LRASQFN9wijk76rV1?=
 =?us-ascii?Q?JpXCjeR8dWqPk136qAGpNpjF6ZS+B3rls33AucY5UPpGSaOfLmwR7cyeQWMY?=
 =?us-ascii?Q?UtAXWbWXtncyVM0g7g9p74ZBnyCPgwpH3caXMvj2ctbdh6Wc2mjOpLpaT5gL?=
 =?us-ascii?Q?rZkozhlmVgmwL5wVVYTilnVssINwljGM3u9p5e1MlB0J2G1ElksTAYWiEVCd?=
 =?us-ascii?Q?CMnWzWHdLuCKrrLVS8LQWBC2g58ohLs8ZWvkKY7Yel9ebbJhf5+IJbQAKC3u?=
 =?us-ascii?Q?NxejCjCaqseOiEjLEtUFRe5PZhFNjli6GwFpThtoCi8/XqgAgWLCEmodbSAx?=
 =?us-ascii?Q?MTuTka1co+DUNE6KuwdygqNEwkp1+Vklr3gzuOae/8vfdKEN+9DElLgPJ7YM?=
 =?us-ascii?Q?6Nh/RSHtEPYwL1vEaVCHkLos03WTY42G2WkqQSsNfsXkw9waB6q4JFgykkrX?=
 =?us-ascii?Q?4WP/VfPOPAqNZ5O6PUwOHYGLQsUjz1gcXMcEctZhLbg9h4uaZ1OVu9ZR3x0i?=
 =?us-ascii?Q?r3I9FnhdLAmuzqg4ZBytOUovrHlDU9Ix47t8F6wglMQew7cdESJMPkM/a+qE?=
 =?us-ascii?Q?gKDowH+0KY0IdHSmkcRFCcT6YSQ6SNr30Mk6wgreIWVrXxE2SKUivpKaPriM?=
 =?us-ascii?Q?IkfC5rlEzG71xJuyqq0XDDyjtasjqtnSD3QnVqGKyQZ/NzkzXtOIolZo9HCL?=
 =?us-ascii?Q?Of+AvpShHaJ20GMPAQudcvwGqvK6UDnBrOqAoPdIaibmgEIcFEtaB3y4fGma?=
 =?us-ascii?Q?z4wJvReYraPD/GTEnLKbahCJ11253u2PwFcD1MlSMpqs53mpAtPR8h4Gzbgj?=
 =?us-ascii?Q?xNDsifOhCJpqgXpb1Pus7FYVzUkJZwKrb9Z6d8Ly7QIYwthbPvb191Pr+uFX?=
 =?us-ascii?Q?93CdC7DP8UL14AMKsYX9SMq46EFB+WfRdkEF+XFosC7dwK9GHL9Lp8ElMqgV?=
 =?us-ascii?Q?hPxsskDFQHpH5BAKKrWKDUxkJRatUgTlAwbVsfZynuDf2/kew=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8w49DDc4gHz3NuE4t2+58p5d+oHCzRkOkV4c78tXHvdVdjof5mtacMHAFcpAKNyfGcBMbF8wLP9xzOBRRuoLIzmYpQNtj7O/OwRjVGfi5BlG8Gco1tzQiL28MhsoHokaarCzSywJGC366tFeusGOt8zWrfn504zeWlTRnYIsUVJVi8U9EIc2jScqJeKSqYukJw+6qLBjHB5cxidFdTjmGWGtxnBlEPt4vP1YH8yCMEdTMTL0zBynMVHDEEuMqcFAyaNdJhdei1q3zEOFDD334j99DgrRzH+yZfUJze7r6/zB66veOCpo6kqXEp9Wczk7j+fx71QndeeQ37sPsTJGtpmeBoNez/VJooGA4PZGyqTqK/bNjjeOhghF42YqO1LMmWfcDihPjkznvtYNkpsyA6siavrKovAKT6g81q54y2Q=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 14:01:10.7368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fde714-adc8-484e-0ed0-08d6a88583b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4956
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

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  11 +
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  47 +++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 .../power/reset/xlnx,zynqmp-power.txt         |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt      |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |  39 +++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++
 8 files changed, 613 insertions(+)
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


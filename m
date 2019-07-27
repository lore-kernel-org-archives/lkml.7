Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81672C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B292084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tflsT0Ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfG0IeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:34:05 -0400
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:42291
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728487AbfG0IeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQs7Kd7fzolszVepkB5yMw7EdSCg1hPwSl3nKD4AYodRYAzSwo7/2N3Ik+Zg34awI6L2FWXMj2z29S8NhK/zxQJmSXzC2TMcYmcX8bdMpN6H8YkMZeIjH2JWQ1L5PYKXBaElAoBB/5cvwywQDSde9Sx8hpT3dwySYTbLGNoX9EeEO+w6uLXaOCmdISQsrFBOvQpuQlRiBun9Wx60yZKQjEK9Qs3Y8hyCt3RZ8ylXs8L0mUUjxYGb5qt84vvEc7ETxdUeLL4/NfGxOoourvdZ10FnSLG2M/gqsW4fUAxslayMOfNAOVbdGK+OsYYZYbsWxQhtDOCK++sY/7Hm9aZxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGNLe8BATWGu0tVLqNDAOcnKFx0PCrilC04wo+c6P0g=;
 b=mdAvitiNlFrS0vLPEqJh9kEsOEuuyIS9xWzmy0pwQ/RYjygpfT7btetGPrz8mC5lWl97WnNTDg8apBHuqHWewGjD+q/gz+EkiWCbEYZWi82S8pdSRaJuAYrkm4QONCNBqeJsB3QD13j7fapcuEYY5DFMSMktUTnYxC4gKTto9okAS+0Qt1cAz7soYuPrR5jWRPAda1DK4DOxRl4rlQ1BeZpbm3rpx7ortwXVJfxSPWUG/TQKg7ibPL6aPhmnobuLOBmHhN3CL4w0IEkkPmZLlYe8GB2z54HWndmMVz2dJMhR1YuufNKNerF8KAk8wrNfY8gOyMK732ky7CXHd+/r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGNLe8BATWGu0tVLqNDAOcnKFx0PCrilC04wo+c6P0g=;
 b=tflsT0OwTWUHeLo9zxx3aViZbqwEphr8xynfPipLrBIqMwNEL7VmgZWUcOgtzqED7KrRG5lqzDZ+4piQbSGrqk/wQruMgSQYFiFoiIttVKN84Baggx4okmm9IF7WHnP/mXNhBPDHM2zJn+T9orA35XCosIqoQt6lAV2UFsqYbiY=
Received: from BN6PR02CA0097.namprd02.prod.outlook.com (2603:10b6:405:60::38)
 by SN6PR02MB4768.namprd02.prod.outlook.com (2603:10b6:805:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Sat, 27 Jul
 2019 08:34:02 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR02CA0097.outlook.office365.com
 (2603:10b6:405:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.13 via Frontend
 Transport; Sat, 27 Jul 2019 08:34:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2115.10 via Frontend Transport; Sat, 27 Jul 2019 08:34:01 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Jul 2019 09:34:00 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Jul 2019 09:34:00 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=40508 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hrI9Q-00027X-0i; Sat, 27 Jul 2019 09:34:00 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V9 8/8] MAINTAINERS: add maintainer for SD-FEC
Date:   Sat, 27 Jul 2019 09:33:58 +0100
Message-ID: <1564216438-322406-9-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564216438-322406-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1564216438-322406-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(47776003)(50226002)(7636002)(48376002)(9786002)(8936002)(305945005)(50466002)(246002)(4326008)(4744005)(36756003)(5660300002)(26826003)(2906002)(76176011)(28376004)(70206006)(71366001)(8676002)(186003)(60926002)(2201001)(2616005)(956004)(44832011)(478600001)(336012)(26005)(107886003)(76130400001)(36906005)(70586007)(356004)(486006)(426003)(476003)(51416003)(126002)(11346002)(446003)(16586007)(316002)(7696005)(106002)(54906003)(110136005)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4768;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91a8f3b-7c85-4704-5935-08d7126d2d90
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4768;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4768:
X-Microsoft-Antispam-PRVS: <SN6PR02MB476899C53FF32230CDF6F64CCBC30@SN6PR02MB4768.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 01110342A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fBSx66tayDz2nTHoyXsHvTEsASPcjM7oF4RssH22VDneet3DErg52sUUVI1rGT12kYznGxsN3iqaXKyif1YwqIMoWpjI6TNe8Eri39x5hhu0oRNdjk8FBwMmO6xYFR0jVfg/HtMxmCx03cZF8Ke0FDmfA+SRwX1FVEy42CPRxLQBEu3P1RLy+Sd/gy11zv8+IYUIGUKj3ZcxqlZUW7Mf3aBz8+V6QB0LkfsnS9xFLfx8JRw39ECr+XSkjnXIqeEhP4M6XAYkN3AXOgZhEAOVFPcegwRx8YwBbsBJ/0ViNjleUXuoLXx81YtDOYp/kLgaC5+4D17Di6NNmhP64paUvAc73PbcTHGo5plCl5SZvbX204BP7U/1zlsZ7j3OcMUYM1ATdISFA4EQp0y5ycB9vjxI8iU48HWsK0A0dCmQDg8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2019 08:34:01.9753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91a8f3b-7c85-4704-5935-08d7126d2d90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support

Add maintainer entry for Xilinx SD-FEC driver support.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8c506b..2ae7376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17693,6 +17693,17 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
+XILINX SD-FEC IP CORES
+M:	Derek Kiernan <derek.kiernan@xilinx.com>
+M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/misc-devices/xilinx_sdfec.rst
+F:	drivers/misc/xilinx_sdfec.c
+F:	drivers/misc/Kconfig
+F:	drivers/misc/Makefile
+F:	include/uapi/misc/xilinx_sdfec.h
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.7.4


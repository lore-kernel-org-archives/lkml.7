Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59783C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cBeRc2H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfLLPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:20:37 -0500
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:41952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbfLLPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:20:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ/+gti7pJhmiaVqI6Eq0LPqsQGO4w7jZ2TDjutZ0MKusVzkQhHfoZXXcG/hn+Qd3ZtOcLPhs8p7P91Ervn2ZkmNDLrObj4GDugZTzQDLLNSgunk75LYw45Kp68WK0ym35jVuhvGwGTxpV9nEWhxTuoQjM0nskLDqufn/x0y4X4zfy9VV+DiiQe/vwL8Z3MXMTzQk8PeSed4uLxBWGGfm+OaKXVTE3sukxsdGKO1lxvOhUnXiipxSdHwEHqAvPrRRkNP/WoC3JQ7rMTtmIUvcgFttzlM5L7mWrveOF6dQfOsJUWBpsbrOwP2ghaxO8uWAoys+t+Lf+3fTbq3ID8xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ZYh05nnimXrzwEyippHh0SjTjSjicYw/pFpoJXIr4=;
 b=Q11sWkKBAkFTFhubm+Mn0j0VsJdW1yLZ+C8eRz21xaxE3FcQIPJu9tq+I4ZjJArYhkzp9eqHZ56/wsWxGsM7ZjBnyErBs0MH/CP0ylNvoiqlLQOh4asK6boswft/vCmcMYNP348JqCCvmd8pfi8lf2bbYsPyfS2pGlGasdJkgvKPMLovK0N5t4xcE0mRXYCFBzvM41T16sNYd0biAbaQRoPBCBSuuCPANrrlpSMV3G/Vo2zartI7KWOSkxWSuESSeiMDXxKRpqKFPxsIH7WcqmLyBGbNjUj1+8R8tz28twv9kezSoOv2AKUCFHbNTQsvAO4Xbqp3q2C9CF08AC76oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ZYh05nnimXrzwEyippHh0SjTjSjicYw/pFpoJXIr4=;
 b=cBeRc2H3femmyeyUicKphRIbiUxsmrJ9Sm4K1iiUdvQ6aMyJiSUSMw53wDcvWMHN+FgEBk6VlTL20rOb/BRiwW9SBurYa4JgK2Eq1rfcdXSjuAs2RZWSucoeHmg8rx9RJ3U+D2RMMe1IYYtNt2gepqY0EdBDkgTYDX/p7tIz/T8=
Received: from CY1PR07CA0022.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::32) by BYAPR02MB5416.namprd02.prod.outlook.com
 (2603:10b6:a03:a4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 12 Dec
 2019 15:20:32 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:e400:c60a:cafe::f4) by CY1PR07CA0022.outlook.office365.com
 (2a01:111:e400:c60a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Thu, 12 Dec 2019 15:20:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Thu, 12 Dec 2019 15:20:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ifQGV-0000st-78; Thu, 12 Dec 2019 07:20:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ifQGQ-00020b-5j; Thu, 12 Dec 2019 07:20:26 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ifQGJ-0001tX-Vj; Thu, 12 Dec 2019 07:20:20 -0800
Subject: Re: [PATCH v3 0/6] clk: zynqmp: Extend and fix zynqmp clock driver
To:     Rajan Vaja <rajan.vaja@xilinx.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        m.tretter@pengutronix.de, gustavo@embeddedor.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <19c5f918-7e00-75e4-10d1-53f0a30748b2@xilinx.com>
Date:   Thu, 12 Dec 2019 16:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(44832011)(478600001)(5660300002)(356004)(6666004)(316002)(31696002)(2906002)(186003)(7416002)(2616005)(70586007)(70206006)(26005)(81156014)(8676002)(9786002)(31686004)(4326008)(8936002)(81166006)(336012)(426003)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5416;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28beec8f-f34d-43d1-aa85-08d77f16d403
X-MS-TrafficTypeDiagnostic: BYAPR02MB5416:
X-Microsoft-Antispam-PRVS: <BYAPR02MB54167FF2CFFAB545DF502865C6550@BYAPR02MB5416.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0a3WD9sCbd39HX/IL+atXIfZ0uxDGmY2b7xlYgKaHbfW1PRsu+HK40WXC0wFlZUap+MEwFZV5DoOWwHAWMUNr2fpMjRTthENgEy3mddPXAiYqPHWknvT0xrc/PhxRxT2N9Oc82vNeQ121Nxr1wO2nsVtktOvvExQjHRREJVIWELpcWgTgKyMk3OYLmmSFfYf+pggu8Xgh+LazAubl40zAidEJS/h2BfyKftuRwBFvlQ1i8X/vfOGDcIRQdc4vmW34ypNpS5hAYeKJm27+nKIsBvW3SdkJNXD5QdXjkB+35HT7QQA5GwW6QDJKX8VJpR7flfSVR6yVRd4DFiVA0Ks0lpj17BDVSDXWrHi9InWS6VXpb7KHm3RrRdipcC7Hsr+XQXQoClagQVciUxxqMc/tgqqkK31VbdKUjR0czM/jvruQ/bLnbLmqouYDo/alWv4whBFDqG740H6w12TJgiJDw0PSxoidetyMNQVE5gI07FIeuodJbI3pGjJSG1c218
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:20:31.7921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28beec8f-f34d-43d1-aa85-08d77f16d403
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 19 7:35, Rajan Vaja wrote:
> ZynqMP clock driver can be used for Versal platform also. Add support
> for Versal platform in ZynqMP clock driver.
> 
> Also this patch series fixes divider calculation and adds support for get
> maximum divider, clock with CLK_DIVIDER_POWER_OF_TWO flag and warn user if
> clock users are more than allowed.
> 
> Rajan Vaja (5):
>   dt-bindings: clock: Add bindings for versal clock driver
>   clk: zynqmp: Extend driver for versal
>   clk: zynqmp: Warn user if clock user are more than allowed
>   clk: zynqmp: Add support for get max divider
>   clk: zynqmp: Fix divider calculation
> 
> Tejas Patel (1):
>   clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag
> 
>  .../devicetree/bindings/clock/xlnx,versal-clk.yaml |  64 +++++++++++
>  drivers/clk/zynqmp/clkc.c                          |   3 +-
>  drivers/clk/zynqmp/divider.c                       | 118 +++++++++++++++++++-
>  drivers/clk/zynqmp/pll.c                           |   6 +-
>  drivers/firmware/xilinx/zynqmp.c                   |   2 +
>  include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h               |   2 +
>  7 files changed, 310 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
>  create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
> 

That firmware changes looks good. That's why feel free to add my
Acked-by: Michal Simek <michal.simek@xilinx.com>
to that patches.
If you want me to take it via my tree please let me know.

Thanks,
Michal

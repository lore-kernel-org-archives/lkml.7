Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC4C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dmpYQpjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfLLPTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:19:04 -0500
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:13857
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728939AbfLLPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:19:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVmSlPGkBi1hiK9HoI4OpqLj36kdJGCfprqkb5onf0eWQXNFpPdJWaMsgi0jFFcxGJUXPvJezwlfk5mR14SfFRp4vOo6ASPyeojSe5iYCBLmrB/zlsmR6X62Qikee8USvj9i8uNHytC6N8KR9iEzUA2QFPdPRFWha6spmunMXQjwW0hthPVmoMq8hHFItFbuoHI3bxTSU4u2Q1UdVIh8UwjsAnwy6imo7/r+DUlktZSu3P7fDTPSxiwCDiAkUSS/PP0twyv77P4KkLD6d6pM0WrHXxorRz5HmBJORwEZ5P0Oy5D2ghkJqchOc0HIoDJV/LPp4VQ72laNTrEITfr5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJJv3P06TWBoz0r1qkCGrkPitSj7R+BTsEaEZez33U=;
 b=FhJXc01NT1+f6Wj+Zvxq0JAyzEid9ZTVCmKDurWdJlkv56QogYALbeph8CxTft33wpQ/1p58jD5ZEsJqP9X7zJGvVhmrcopcCrwvOzWh+wIqQ7b6ktWDXUpVwaRI+gFiIgofyb2gvP1uvpDMQ84O684PiW/1uv7bWRZpZ0JasjwlpbJD4B4hWLbinglWDAYiIX8IBuxytka75Lp/S2nIO9b4kiQC8mRVpqXmV2sA5n0z4NFaKF50BzVV2InNDkw5N6j2SPLWBVT7tYA2fDoQJdZznbd9uelsZO0nBSiDKK7ktk89uEaPFLawr7qwDSidYombIp2r5HngUT9WcjpoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTJJv3P06TWBoz0r1qkCGrkPitSj7R+BTsEaEZez33U=;
 b=dmpYQpjMXSqJeT4aVMcusS8ITf+uAjYh8i1ePirWtPyyejKpeOuQu7Vsk+2xURtDJ45VDCrd/SQTRFa6Ws9b88FyjKFJBGhDZvAZBQp945xyXLLIvYYzjuLYPNap7phu9X8ToYrphSrPkszgQgP7f35pVXUu+pqkHcKnF6dciTU=
Received: from BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49)
 by DM6PR02MB5819.namprd02.prod.outlook.com (2603:10b6:5:17d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Thu, 12 Dec
 2019 15:18:21 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0108.outlook.office365.com
 (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Thu, 12 Dec 2019 15:18:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Thu, 12 Dec 2019 15:18:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ifQEO-0000p8-E6; Thu, 12 Dec 2019 07:18:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ifQEJ-0001FO-Cm; Thu, 12 Dec 2019 07:18:15 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ifQEE-0001El-QD; Thu, 12 Dec 2019 07:18:11 -0800
Subject: Re: [PATCH 0/3] arm64: dts: xilinx: Update dts for zynqmp
To:     Rajan Vaja <rajan.vaja@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        harini.katakam@xilinx.com, jan.kiszka@siemens.com,
        ulf.hansson@linaro.org, xuwei5@hisilicon.com, mripard@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <10b437c8-fe31-1d67-7072-9dc2115a0963@xilinx.com>
Date:   Thu, 12 Dec 2019 16:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(70586007)(70206006)(7416002)(9786002)(8936002)(44832011)(478600001)(186003)(26005)(31686004)(356004)(6666004)(316002)(426003)(4326008)(5660300002)(36756003)(31696002)(2616005)(8676002)(81166006)(81156014)(336012)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5819;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3c029b7-59c8-409e-d081-08d77f1685f4
X-MS-TrafficTypeDiagnostic: DM6PR02MB5819:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5819F4B59BE568DD09A00EDCC6550@DM6PR02MB5819.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPOCVIekYDPHyj0V/t2BFhLSAz53P8ogzCiy/VG0Ewhw8vR2ZwkT7EQWnYqoZdHKKC3A1PdhfG0WkF/uANeuBNJ6QUfEU85H921RSQI/UxN20rdX6sxBQ6N4vsUrTZd/tPO2UPEmjwG1QJT4AujF0LqNec2zyIn6XWAg6Km5ejpfSv+CQs7+2NKVwwoGJRURg8WdeJiFyIOqxL7SscEc0TlaN8LMpMh9KNjg4KPJS1UK8taXTGLfl8ZvDulX6CjmJJVaQdCdrjGO4hbC70TzqxqjiEeIrtWoTX/561XuIbsBu4kLu1AN5Q9H9FDafKwUM9QeBdls/SLMpJiFEHPsK974qU5umEo+mKCihNji8VR6MvcxX38Kd44NO8Hpt0TNGcYM3QFUCxBEXq87dERAiPGCh/VyFSV02x3i9seDF7bAp5NHD43Vfe+N1kqnomAqMFpjJ13a9jdGD7425Mwy3H8bLV9g4rB3CFT7fwUKJo2Yb/w3RLULDYSqUXz0zzMG
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 15:18:20.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c029b7-59c8-409e-d081-08d77f1685f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 11. 19 10:44, Rajan Vaja wrote:
> Add support for clock and power domain nodes in dts for zynqmp.
> 
> Rajan Vaja (3):
>   arm64: dts: xilinx: Add the clock nodes for zynqmp
>   arm64: dts: xilinx: Remove dtsi for fixed clock
>   arm64: dts: xilinx: Add the power nodes for zynqmp
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi         | 213 --------------------
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  72 ++++++-
>  16 files changed, 318 insertions(+), 239 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>  delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
> 

Applied all and rebased on v5.5-rc1.

Thanks,
Michal


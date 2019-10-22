Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20369CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25B5214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eCRGo85T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfJVMNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:13:16 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:57216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388106AbfJVMNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+tSwfuwhpSIBRx7nIVmPXSW6av1dgAnPPhnqc5S2yfezqalj2EoRFPHRxmPgLhWWa9+4UB1SHY8EQRN0EYJg85kODxNSyOT2LTeASt+mb1ZN78QIY0cBzv+AFQq3chUM40QXjdRqu1AxQc5D1NzWPAeEDQOFnXAgGEw4K3elJQCLex58I5qDptgu9ir6b+tfMDORFcLcOESDdi4vgOz5n0BJEey9R0IzG9kjaKmKdxNrsgxdFKp/AOxf0+Bfxyq9Q5S2iRPIR+WBjj1urmclcZ5ZxLuL1nSvE0WCH1xcm4p+ayyhXVVB24F290kF+e1I7ZLPu0JIl0HwYE1dz4IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erZ4S0w/Qq6IL7i2I6z2gT3RJ9w/1cUbTZHg77/V71Q=;
 b=HDtSlmhBh0rb40sL1ZpZ23nh1+IOn3pLdjoQRnoLH1a6JcrSTkFJwS3ZVAhkRo22IqY3v4Gi/CbISZOMQPdwpb7MCIIAJb0WQ4ZtfNd5TFbl8DWtDuH187wiqf3dfC91VWBaRniRC6+WZ00r6XkM4yA6bGUzotRg9RgGUBiS4M5jkyEfOKaJ8Ex9thPzohI4tBzdk2RTUOftGOb1/+2h9i5Jt6l4g5I4eHwn8JGnWpwcI7c+fxUIIAUAcrcpCBuKlQ1WmdsKVIHMvIHus1HBg05hl9mA0gR5s0oJQELsbQvb1Ox0llOFqYWMPoCG3k940aJFbL70QWJjwnh2Y1d53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erZ4S0w/Qq6IL7i2I6z2gT3RJ9w/1cUbTZHg77/V71Q=;
 b=eCRGo85TPBe0pLfVRiJJJXyc9+tr/UWE19fQZnYw592TwDYhC3SMZcYjVVqvspisa3UaI2GuveVl8A5BxIrGxUuuKwt+27p1FeOYZe4fjjWh15UWXy9cNralbhLeYzfwthadYfeaVM/OmtFtNUGGVkUdAldJCybfgRhePAowGaA=
Received: from MWHPR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:301:74::44) by DM6PR02MB4970.namprd02.prod.outlook.com
 (2603:10b6:5:11::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Tue, 22 Oct
 2019 12:13:12 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0031.outlook.office365.com
 (2603:10b6:301:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Tue, 22 Oct 2019 12:13:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 12:13:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iMt2F-0004ip-16; Tue, 22 Oct 2019 05:13:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iMt29-0003wM-KR; Tue, 22 Oct 2019 05:13:05 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MCD179027641;
        Tue, 22 Oct 2019 05:13:01 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iMt24-0003vN-KB; Tue, 22 Oct 2019 05:13:00 -0700
Subject: Re: [PATCH] reset: zynqmp: Make reset_control_ops const
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, kernel@pengutronix.de
References: <20191022115517.19886-1-p.zabel@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0b42b11c-d4c4-e7fc-1dc3-c6ac07ab8b1d@xilinx.com>
Date:   Tue, 22 Oct 2019 14:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022115517.19886-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(476003)(58126008)(36756003)(106002)(9786002)(31696002)(23676004)(2486003)(8936002)(126002)(486006)(31686004)(446003)(336012)(6246003)(4744005)(186003)(229853002)(76176011)(70206006)(70586007)(426003)(8676002)(230700001)(65956001)(305945005)(47776003)(478600001)(2616005)(2906002)(11346002)(65806001)(50466002)(316002)(5660300002)(356004)(81156014)(14444005)(26005)(4326008)(36386004)(44832011)(81166006)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4970;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc0759c-05ee-47fa-d1e9-08d756e93552
X-MS-TrafficTypeDiagnostic: DM6PR02MB4970:
X-Microsoft-Antispam-PRVS: <DM6PR02MB49703237A8558966E9A2E8A4C6680@DM6PR02MB4970.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxdmQgYYfXf0MzIFvMNbjE77Cktq7vuHCgZg8Tw6S0dqr79kdNgnONuM4GRGZcG+Put9H6rS04AFysq9+k7n4pCmaiNychtFiuXgriPGIURJFYdoDN7bpC2jBp/k50nvWx+mIeFG/hi9oWXBDRsdC68QRg20jFSFKNyRIqYfGnc3u/Nsn3YKZWaJJFWIU70Sx+g3d1vfIviYmErUeNRfWa5o4lEcwtj/YRZbiMBpIxfWE730FRF3IJ7C0eUAaNv8eUbEukFmMApbS9wrzaN2Q6zQ5wFWNhslIdoZhTkd/mWQar0iGRUf0wxHqUA0L/IoATqYh3InjfZjEFI4PLDWwC/ElnuGER2cQOG+GYR5c+/ltgmyaUZ43+8gkuNZw0X8WKjKaJErVgxtwcbxOlRL1eml032XWm+Op9KyfWzd6mt/7BNNLk6u0Oov9jhH35aa
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 12:13:11.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc0759c-05ee-47fa-d1e9-08d756e93552
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 10. 19 13:55, Philipp Zabel wrote:
> The zynqmp_reset_ops structure is never modified. Make it const.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/reset-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 99e75d92dada..0144075b11a6 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -64,7 +64,7 @@ static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
>  					    PM_RESET_ACTION_PULSE);
>  }
>  
> -static struct reset_control_ops zynqmp_reset_ops = {
> +static const struct reset_control_ops zynqmp_reset_ops = {
>  	.reset = zynqmp_reset_reset,
>  	.assert = zynqmp_reset_assert,
>  	.deassert = zynqmp_reset_deassert,
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

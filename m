Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87117C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aIij8mqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGaIcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:32:06 -0400
Received: from mail-eopbgr740132.outbound.protection.outlook.com ([40.107.74.132]:52128
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfGaIcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:32:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akZUoaeD55sykwhXFVF8MDrAqNurcT2xU4jgb8+03NQLb8m5ndUwt8dZINYOjByBXxLrPgMwlC0qfeH0UVZ8qgYe+SY7DhMLf5fxM+QjaEvy6PIZR16sHFx4lMFOCBAY6cXKpW/h6jcz3/qeae7Fp5wDdgyWSgo4BrL2wAxI3++AgK6AdqXH0e3WbQANig9oOq3LIKeDGbksO086a6b9+iKL4/woWAdNySynVkavlWayaZ5PrcxOoX8eslCUcYjWkYAZPiKe0XrYBkgW5om48tRX9C5i/yzk1RsYhs0o2q+IwBKpON4JqyIocYKkDZWnTgC6YhaFMZEhS5P+UJ+ykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zekd39eQr2pi3ucUXZFD/9EGlz/9JLqNmFHI62TiDIc=;
 b=nykaZW3kgGaH1rQ8TO3iZXBenl665Hudjwj0f7ScW3uz6IqA1tanA66YJJuZYT1GNt5dXmWgtUoJoi1hPAYUCz/IRPpcf163RAwZDrS8PvPXvRCMzIz0Dz+xRKimcJik9/itUJ3HBr4Qw6GpvlM3kXwgM6aJEIhTXHcqeCd2K4brRmA0qa5ggL2cOZV8UO2Dz+jgXFyvB0ZIJOqXwwN6O+sgPVWs3wApkmZWANpKS0yrNbikolmHy2GuKS0z2/4d+7WitmyYLnTIis163paKj48fKKXq1piJih4peIuAgjPIJ/fPELMrJ+hQGGcXgwgCBAylHYuLpmpghcM1+IwVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zekd39eQr2pi3ucUXZFD/9EGlz/9JLqNmFHI62TiDIc=;
 b=aIij8mqfFiQU4CIlQFfwFkJaEVzFYMvEk4Zl8tHpKOEXgB30WsfQ7aKOB6++4HyYm8vFnqZR9ueI9jH1TEg3JwgZOuUhmavDjRmwpCpXjoQ8EPAavy6aKyrRCdbQ2yQFRn7tt+tyBrPQqhg1OENBqHByINqAWMciq8vnLlJW7ao=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by SN6PR02MB5120.namprd02.prod.outlook.com
 (2603:10b6:805:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.15; Wed, 31 Jul
 2019 08:32:01 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Wed, 31 Jul 2019 08:32:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Wed, 31 Jul 2019 08:32:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hsk1g-0006ld-9F; Wed, 31 Jul 2019 01:32:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hsk1b-0002Rh-4j; Wed, 31 Jul 2019 01:31:55 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hsk1X-0002RS-MH; Wed, 31 Jul 2019 01:31:51 -0700
Subject: Re: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before
 goto
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        jassisinghbrar@gmail.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190709172841.13769-1-nishkadg.linux@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
Date:   Wed, 31 Jul 2019 10:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190709172841.13769-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019001)(6009001)(438001)(164054003)(51704005)(24454002)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(63266003)(74706001)(36756003)(23676002)(76786001)(76796001)(81542001)(54356001)(31686003)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(77982001)(59766001)(56816005)(33646001)(80022001)(65956001)(76482001)(90146001)(65806001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(83506001)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(97186001)(80976001)(31696002)(64126003)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002)(65826005)(36386003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR02MB5120;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 684c5fb2-6f08-4547-ce62-08d715918f01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB5120;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5120:
X-Microsoft-Antispam-PRVS: <SN6PR02MB51203F498F8438AD8BA8073EC6DF0@SN6PR02MB5120.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 011579F31F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /1kQKUl1EGLi70K4VNaZ8qsvOA5XC6HnZLqJWr4VQXwt2oXqkr2vfZ4auFaWepEBOWcZ3fzWNvZQJv2JKEY6bVgZylL+GJz0CNQ6Pw+uwUX69PI4J/rNwo9HMjZQvK/t+lSP6sIuaxPdNk3D6kxo2z5/gL0bqxcRr+00A0bTCuGsg18jv+HCslhK40S+gGdAYaodaLeK9rPp39dGL8v2LQ0TRzRlFPGHbB0koWwmLszOjXvT3pkPQfM8CWo359FKmrhgDiI4KPQeJpzfS5zmCcf7kJ3cshUJO4JLvnaLxOF50TydotKGQ+/v5peKpL6V9ynS/SEA5zhciKoyHnLHQSBp1cBeNDW/aEMirVERLYc3snxenonvEKBMpvZgKtEWF9wnRMScqRHH9ezdottzmG91mBAeSwpHFw1agaGTGQ4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2019 08:32:00.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684c5fb2-6f08-4547-ce62-08d715918f01
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 07. 19 19:28, Nishka Dasgupta wrote:
> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a goto from the middle of the loop, there is
> no put, thus causing a memory leak. Hence add an of_node_put before the
> goto.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 86887c9a349a..bd80d4c10ec2 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(dev, "failed to probe subdev.\n");
>  			ret = -EINVAL;
> +			of_node_put(nc);
>  			goto free_mbox_dev;
>  		}
>  		mbox++;
> 

Patch is good but when you are saying that this was found by Coccinelle
then it should be added as script to kernel to detect it.

Thanks,
Michal

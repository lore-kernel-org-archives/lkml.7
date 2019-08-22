Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656FCC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EA12342E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RUtygxMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfHVI1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:27:40 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:55632
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732346AbfHVI1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXfTr132TZ0D0FdInuWws2a4RIiQ3Pq5vkDD5um7MeT4+knvRm9wRbZIIAp07AeiOmIn1q+zBxy+EmA9U7poTagkwaAALiWH28lL7WXrujJjpwiqPcblb2WKPnEfbPJEfJOP7k9efuuoB67sM8WxIv6AvqA0IBAsP4hNDEdClySa9s3wSEC3kjNNBRsYdV1Z7y4G3bQ6x0xfpEt7BFEbJjCpzZEtY+OjWG80BtpZhL7ulrZfEc3n5Aj83JicT8VSmt9OK77svAkl14Jd1RzpBCfaT9tyvENxm2M7xoXNy35i8DZl6TFMlp56ijIlLaRiHrBs4tdP52SPRMZTHG5hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcOgSEHbhWyj1ZoJs6Im8xbZNuXWELSDYSvabHCDzLg=;
 b=oa3GJwXNjJ3PIi84JHU63jCH1wPKN4736UYyox2QQGZb+5dnbpYoFotmLGj30tU9PVmnNK6Ky4KIQ+EFZCfVcYZhvAg8pzwmKDQWj1PzCxTfU50d258ONIOd0Wp8iZDUtUUtc9isSQrRtRG0CKH3wSJy1823QRQN14OXUrLjz1N2dZSZOAnWM4EIn5HgRTvZgykXEtMGQarNUOjR4poPaNihB+6Ug/0wLkS2FGbAKvSznOXWzFZP4d24PpnfYSQsbiL9QQsZ8jzHpQfKdDcA+VZ2vKs3Bn0f4T33OuLUwypcAFaTXhcB7cUi/Z3yqNRXhGeCDHt0TsBEXP2K35pg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=oracle.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcOgSEHbhWyj1ZoJs6Im8xbZNuXWELSDYSvabHCDzLg=;
 b=RUtygxMJvb0MJ3FDIovpq5SiHjUScioWzHzmDDrS1NweAUnOtTN7MAgs0M9GOOlLteGvdyYOZZVgrH4qA9jsuvk1S4oKd9R+WM0mWIshhTnoygS8S8is0t1WfNHlfW843gjt9K61KLw6Ub2FfY1OgLtuXdZuhgv9fb5E9tQ6+4A=
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (52.132.27.47) by
 DM6PR02MB5306.namprd02.prod.outlook.com (20.176.116.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 08:27:35 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18 via Frontend
 Transport; Thu, 22 Aug 2019 08:27:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Thu, 22 Aug 2019 08:27:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0iRS-0004yQ-8j; Thu, 22 Aug 2019 01:27:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0iRN-0006lk-5Q; Thu, 22 Aug 2019 01:27:29 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7M8RNBS020312;
        Thu, 22 Aug 2019 01:27:23 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i0iRG-0006hj-Ol; Thu, 22 Aug 2019 01:27:22 -0700
Subject: Re: [PATCH 4/4] misc: xilinx_sdfec: Prevent integer overflow in
 xsdfec_table_write()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190821071122.GD26957@mwanda>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ef4d7882-db4a-589a-2aa5-2e329e80fa45@xilinx.com>
Date:   Thu, 22 Aug 2019 10:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821071122.GD26957@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(199004)(189003)(36756003)(50466002)(478600001)(36386004)(76176011)(126002)(426003)(486006)(44832011)(476003)(2616005)(11346002)(336012)(26005)(186003)(446003)(31686004)(23676004)(2486003)(52146003)(9786002)(8936002)(81166006)(81156014)(6246003)(8676002)(6636002)(229853002)(356004)(6666004)(31696002)(4326008)(14444005)(5660300002)(47776003)(65806001)(65956001)(58126008)(2906002)(54906003)(106002)(316002)(70586007)(230700001)(110136005)(70206006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5306;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892bd4aa-01ac-45eb-a7ae-08d726da958f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB5306;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5306:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5306FD9FE69878257591ADE0C6A50@DM6PR02MB5306.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 01371B902F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KZv3ZO6cRYb5v6R0UaKOHA4bR5pzEY11Hv/kEQEfyzTekXGI6/jAeVb+UjopNi8WuGeSX1aHD1zZDL0MsYcHD3giU7d+9A5HcoCaL99bPICuKzeQDEbEktQEb9PAU1Heite/g4yBSz25pyYJ5kspF9JyMe9t0dxCO0ccqT4E7Ej5HHZ7Fr1vDPFp3bBEhdfRJYQQnoniELVO55SQJD8QP0dUhM56xCvI/m2XMO/v45j5zrBL45/jUQ/fIlizcBqlpyVhUkgkWtdDPQKaUK+ciYwdw3dC+xeKGcFD3dUXM+MVhXF5U+M2B9JOWKfnFsFZbpsWJb008qkTXNM4zKMIwuoliZiN7ci9q7qYGM/SP/HuV7pcI8ujFj7uLqhJlzdMAT2hhlN3SzRLXkIwlPpVmlR+J/7TK8aTx42zkXyYCdI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 08:27:34.8411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892bd4aa-01ac-45eb-a7ae-08d726da958f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 08. 19 9:11, Dan Carpenter wrote:
> The checking here needs to handle integer overflows because "offset" and
> "len" come from the user.
> 
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 3fc53d20abf3..0bf3bcc8e1ef 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -611,7 +611,9 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec, u32 offset,
>  	 * Writes that go beyond the length of
>  	 * Shared Scale(SC) table should fail
>  	 */
> -	if ((XSDFEC_REG_WIDTH_JUMP * (offset + len)) > depth) {
> +	if (offset > depth / XSDFEC_REG_WIDTH_JUMP ||
> +	    len > depth / XSDFEC_REG_WIDTH_JUMP ||
> +	    offset + len > depth / XSDFEC_REG_WIDTH_JUMP) {
>  		dev_dbg(xsdfec->dev, "Write exceeds SC table length");
>  		return -EINVAL;
>  	}
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

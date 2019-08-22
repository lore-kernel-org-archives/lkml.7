Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DC8C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3157B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F5DQYhoE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F5DQYhoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfHVKcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:32:24 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:38054
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387699AbfHVKcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHDX2RpRypXDPWAxacLC+zdwfeWDhRf+LOPHFXhlpM=;
 b=F5DQYhoEmtzPMkFJtXqj07DK2RsVSuPJSUmoO0jBIl5B6BSqS8urundifisSjR0xXxIWOA3LnS84zGx7Gi7ExqYXl1C/IWF25Zfvwd9ryPF3muo95FIGj3QH5Q00nDxqddwrIwQCd3xhI42ATNP1XUtnYJHqUsWB02g8Ys9OUnI=
Received: from VI1PR08CA0220.eurprd08.prod.outlook.com (2603:10a6:802:15::29)
 by DB6PR0801MB1848.eurprd08.prod.outlook.com (2603:10a6:4:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 22 Aug
 2019 10:32:17 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0220.outlook.office365.com
 (2603:10a6:802:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Thu, 22 Aug 2019 10:32:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2199.13 via Frontend Transport; Thu, 22 Aug 2019 10:32:16 +0000
Received: ("Tessian outbound 578a71fe5eaa:v26"); Thu, 22 Aug 2019 10:32:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fee4d2d60cf96bf4
X-CR-MTA-TID: 64aa7808
Received: from 7acac4e281d5.2 (cr-mta-lb-1.cr-mta-net [104.47.6.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 26328F1E-338C-4D56-9249-ADBE108028CE.1;
        Thu, 22 Aug 2019 10:32:06 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7acac4e281d5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Aug 2019 10:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdnHXR6VaXQ8hC02tpULiE9xJdWS6qTlJbBP19I8u0tWk/Fj+AGeozgcQ8LEicCxNBeQieygm5bGhFvEo96Ii8HkDHf6M+iZ7nyzj2tW2MGwEXULnj12BBLa/QBcR3+Tiqg/TSHCRqZUYXTEHFiE01ulgWdW2SKrQdVy8LaJ1aIIkTYT5ZAovKzAraf9Ram9faIy5ExlvOhz4zeSd6IeXN4s8Q44jCDFdpp4I567fzcbboFD/jrlc8LCrHuBwEs3qLnW/0xXlMC8I6UAGp2IC/Chi1FGpfVJpcomD0nKQcR3Lhgb9ocjcf0O9pHPwLii67fDMN+cZOEMva4jKYft9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHDX2RpRypXDPWAxacLC+zdwfeWDhRf+LOPHFXhlpM=;
 b=ZlvBQ/0a00yvqu1xwW28xUbS0XjVk/irHpQo5a8scWTE1/4QakJUzI0nkHRx7oN79u/9ZPXAgrlUPovudoQI+awcgCZIuC2IQ2inmOB64ULD6GjDqGYD0DOPbGosYX607NiKezHGMyfCqHhyLupXK0iTSLhEBgH1cRlWWluM9g/A3CQLto66b0fcjwA17CEJ4oCXhFLXtXsXLY+j45dJ2KJ9zxuo1th20Nz0EFl4/BKOvlggAwgW36iYQ7UsDc6dMmgNhyrVyOb6f3odkI4NJKGLVpAvwQ4cO2RGrkXwoJbVQOYgR79zHWBhY8BBhKHxmBR/Ab8/ZTl/8mhZb3bb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHDX2RpRypXDPWAxacLC+zdwfeWDhRf+LOPHFXhlpM=;
 b=F5DQYhoEmtzPMkFJtXqj07DK2RsVSuPJSUmoO0jBIl5B6BSqS8urundifisSjR0xXxIWOA3LnS84zGx7Gi7ExqYXl1C/IWF25Zfvwd9ryPF3muo95FIGj3QH5Q00nDxqddwrIwQCd3xhI42ATNP1XUtnYJHqUsWB02g8Ys9OUnI=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB4436.eurprd08.prod.outlook.com (20.179.32.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 10:32:04 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55%4]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 10:32:04 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH] drm/komeda: Fix error: not allocating enough data 1592 vs
 1584
Thread-Topic: [PATCH] drm/komeda: Fix error: not allocating enough data 1592
 vs 1584
Thread-Index: AQHVVmRfb2zs0H17zEmg1qVsSJCUdqcG/OOA
Date:   Thu, 22 Aug 2019 10:32:03 +0000
Message-ID: <20190822103203.GC29026@arm.com>
References: <20190819080136.10190-1-james.qian.wang@arm.com>
In-Reply-To: <20190819080136.10190-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::19) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 98c9d6d4-51e8-460d-dd4a-08d726ec00d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB4436;
X-MS-TrafficTypeDiagnostic: AM0PR08MB4436:|DB6PR0801MB1848:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1848A9ECF0B69476FD0C8C4AE4A50@DB6PR0801MB1848.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 01371B902F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(186003)(81156014)(486006)(54906003)(4326008)(102836004)(6636002)(316002)(44832011)(66946007)(37006003)(26005)(6506007)(386003)(11346002)(478600001)(2616005)(476003)(52116002)(71200400001)(446003)(66556008)(81166006)(1076003)(2906002)(71190400001)(66476007)(14454004)(64756008)(6862004)(14444005)(3846002)(6436002)(6246003)(76176011)(33656002)(66446008)(8936002)(256004)(6116002)(66066001)(7736002)(86362001)(36756003)(8676002)(25786009)(53936002)(99286004)(6486002)(229853002)(5660300002)(6512007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4436;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kzyUgbK0jpufI/OJncVmtO3EJQGcFBeHQR2b8BFUSjs917obV3mTq5vXOTmQPjUhGxQ520Q+75SGPgNCDdTRntNB2avwUJbJIquTreevTMGl+AOqDnAYaVqat4XpGac8igUI8b5X/0gZA4iKAbnOlJxvo4xKSVPfGO0F+8hGTi+up/Hhm7N51zpgLbLhbQ5EdQnI7F4XPsWJZz8b17QgAZE6hbuqXtmGTkVCbd/FCscyy26jcO4bSk8bq5nGxIy3rj6M/ukB7CkG1dnciYSk4UeArX+df8EOTgq9AqlNZjSwv17qrYo2IOzijOJSvehEVr4XpsXJufe4/drEz/60c77OMjR8AJhSjsHOBMPpdixgj4WG87PHaon1bIgGL2+USphWDF1PdV3L06/x0F/jOSEuuYDYb4CXCHkzMrVBJrs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A70856D291BC5A4DAD604462BF30ADFC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4436
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(8746002)(336012)(8936002)(6512007)(23726003)(76176011)(8676002)(33656002)(229853002)(99286004)(186003)(81166006)(6486002)(81156014)(2906002)(47776003)(356004)(46406003)(6116002)(2616005)(63370400001)(126002)(486006)(476003)(63350400001)(3846002)(50466002)(7736002)(305945005)(66066001)(37006003)(316002)(36756003)(6506007)(386003)(26005)(102836004)(76130400001)(54906003)(446003)(70586007)(26826003)(11346002)(5660300002)(14444005)(1076003)(6862004)(25786009)(86362001)(14454004)(97756001)(70206006)(6246003)(6636002)(22756006)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1848;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 166d1b36-8340-4ec7-27e1-08d726ebf941
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR0801MB1848;
NoDisclaimer: True
X-Forefront-PRVS: 01371B902F
X-Microsoft-Antispam-Message-Info: 3okotI/zxEQPeqN1UFSCmmKEdLZCEDnL47eX6ZkayuBgLoKg0XjnEQvDHt9lHUzeUdT0BLT9I0VKN3FYuVAyKs4huwsKY974nMIwxoOTCg7EDAay+XSGTqoU2opPu//FxDwBTEwQ2s6xTi/rh1BbHOLWA88hbWHGZw+lLIXQCHDNRRY7kzSrz76r6q1e7HDGM3+B7tkfrPn2YcxIOklKCyybRvZ1ObVo49HhhHKEi1ldsL9Y1lc8ROQRRTtPp3yBi/MCP1rD+DEPXhoOmfyBNsI0uYrM5SId0pioum/+XiUNQmuvEkEDOD2ZcpuPIzhH/VZDVvvfz4IJav3m8sY4YyF5UYbGYeSbgqb6C59RBv/00DhMsZFPCPvVXxMvEc6NwFm56aiGAy7+LYn0tYc2DgfgbWLzJB30X0wwPLfzPOY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 10:32:16.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c9d6d4-51e8-460d-dd4a-08d726ec00d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:01:57AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> The patch 5d51f6c0da1b: "drm/komeda: Add writeback support" from May
> 23, 2019, leads to the following static checker warning:
>=20
>         drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c:151 kome=
da_wb_connector_add()
>         error: not allocating enough data 1592 vs 1584
>=20
> This is a typo which misuse "wb_conn" but which should be "kwb_conn" to
> allocate the memory.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 617e1f7b8472..2851cac94d86 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -148,7 +148,7 @@ static int komeda_wb_connector_add(struct komeda_kms_=
dev *kms,
>  	if (!kcrtc->master->wb_layer)
>  		return 0;
> =20
> -	kwb_conn =3D kzalloc(sizeof(*wb_conn), GFP_KERNEL);
> +	kwb_conn =3D kzalloc(sizeof(*kwb_conn), GFP_KERNEL);
>  	if (!kwb_conn)
>  		return -ENOMEM;
> =20
> --
Reviewed-by: Ayan Kumar Halder <ayan.halder@arm.com>=20
> 2.20.1

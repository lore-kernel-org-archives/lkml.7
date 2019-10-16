Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA532168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vQPPZRV1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vQPPZRV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbfJPISF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:18:05 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:65175
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfJPISE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le/Ej3S8rS/gZETD3lUVB4HpAvqBPqFQ6ou+eF6oOVo=;
 b=vQPPZRV16Wr2UFKk0haadTKKAkaANbV9O43Ms7GjxgdmOkE7cT5/6GHcFtYjAPwTrd5t9kRO22eFRBoxX5E2M4cuXAJi68hkzUk5EXmSiaKHjH1U7gWAPvGvEiRkVGIBA6Yd710ESxm5NqKWjO8TmN1jqrTSgjBbZ6/qLTU5NbE=
Received: from DB7PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:5:16::49) by
 HE1PR0801MB1739.eurprd08.prod.outlook.com (2603:10a6:3:85::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 08:17:53 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB7PR08CA0036.outlook.office365.com
 (2603:10a6:5:16::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Wed, 16 Oct 2019 08:17:53 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 08:17:51 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Wed, 16 Oct 2019 08:17:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e4048fbe81d140cb
X-CR-MTA-TID: 64aa7808
Received: from 3ddf269df2b1.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 71997669-784B-4729-9D74-71C87DA38C55.1;
        Wed, 16 Oct 2019 08:17:41 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3ddf269df2b1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 16 Oct 2019 08:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHjERqKVEYA4XC+0l2jFctucNNUHHQ5vPvM587HA4Jw6GYrdgTWsngNX5oH9f7cUSqgLKYfXs+3q5YVDGTw9JuUZn4OviotMn3VXcm8PHdkNzOTSB73MGxR6CpUlFqa25DkGek/A7hvhL7sTzbIgKLZ8CIcJStDhJjSG1yeXgR/D3HIeMzoQ1MwsyBDBjyL+jNAX35icC6unES1soVVpu3lIBHx40TGLrtye01ZdQ/f71u+4o7A6zww6fWEIvs7frrMYsss81tpCXsekI11tQxHiwzvqxUPxvkYwTquq/o+QR0GCBTPt/z3sW0bGhAR4v7eWvtRkSg4iO2rR/i9/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le/Ej3S8rS/gZETD3lUVB4HpAvqBPqFQ6ou+eF6oOVo=;
 b=an8Gid9o6dmccu/vtQCnhxORjKFCoUpwvCDbXoApE0cnPun+6h/gATuetgL5z1cqfLXZBw8zmOWHOviH7AEy81b5o8BUab1ZtzzjHHOAKaTRDMzktL87JeEHXS5cx3CThBXpZhBupE5HKcWAYTiYoJN4jX8cfZOPFST1Xtn8Y9fjEseuoKeQLwtnMWt/9RUMrjLhm6UgqdmAz0iuu8f7tfgeOvLcYINu96fchV+byj8xfWrP9R08rnF8xmfxtfTlvxDdow82RBN8pOyb/LZv5F5+IoxmlyZgFLQ5kjUtie+Lww6KcT7iWuHKa+4xxDZyV01dd2kStYTAdc99Ufe6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le/Ej3S8rS/gZETD3lUVB4HpAvqBPqFQ6ou+eF6oOVo=;
 b=vQPPZRV16Wr2UFKk0haadTKKAkaANbV9O43Ms7GjxgdmOkE7cT5/6GHcFtYjAPwTrd5t9kRO22eFRBoxX5E2M4cuXAJi68hkzUk5EXmSiaKHjH1U7gWAPvGvEiRkVGIBA6Yd710ESxm5NqKWjO8TmN1jqrTSgjBbZ6/qLTU5NbE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4797.eurprd08.prod.outlook.com (10.255.112.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 08:17:39 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:17:39 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     David Airlie <airlied@linux.ie>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Topic: drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Index: AQHVg/otF4CnTywlm0G0XgUOe/TvGQ==
Date:   Wed, 16 Oct 2019 08:17:39 +0000
Message-ID: <20191016081732.GA16502@jamwan02-TSP300>
References: <20191015105936.50039-1-mihail.atanassov@arm.com>
In-Reply-To: <20191015105936.50039-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dbcf9876-f75d-4a1a-bcaf-08d7521156c7
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4797:|VE1PR08MB4797:|HE1PR0801MB1739:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1739546D89476333C3CEB46DB3920@HE1PR0801MB1739.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:186;OLM:186;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(305945005)(54906003)(2906002)(7736002)(1076003)(99286004)(25786009)(6486002)(52116002)(6862004)(478600001)(6116002)(3846002)(33716001)(58126008)(6246003)(229853002)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(6636002)(4326008)(76176011)(86362001)(33656002)(316002)(14454004)(66066001)(6512007)(8936002)(486006)(8676002)(256004)(9686003)(6436002)(71190400001)(186003)(476003)(81156014)(6506007)(11346002)(26005)(81166006)(446003)(55236004)(71200400001)(386003)(14444005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4797;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zSB27xuwHSoFqwPHJFo8jCR8P9Usd+poxCOlqhhSwao9zq9K2IUli1bHc9T0EjbGm9fl79ikE7HimiExcbgH+pUOqlMIONBUvVs5TSEL/sKfXM3XO4/vCBjzXhqe8I9cZxKngFs+lJZ6BFhRDuP9VdU8bzF0Yyo0pJFJuSwQoKY/0oeSRSqOSTNGkQ8FdZr1bBkJDgXiSAPXYAbV9hc+DMfhBi6eQn2acL+m9eROqaS89jKcpJLNVUOfSkqTEzVYa11FcVkaC0liGQRRMYwtGUUtLFl6SIvVk26d10tLDbelncmen/9Xach3YA48IIwMnumyNn6p2zgDBytu9p2l8OKZg5gpLGDNoqfSHxa/eTQAaIuf201bE77B2RwFBGX45QV7VSfRgI/KC47kx0ImgEiUcx+xKd00iQI/C6Xh6Pg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F8A107BCB336F4F965370125CADD953@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4797
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(1076003)(102836004)(81156014)(33716001)(6486002)(229853002)(81166006)(8936002)(86362001)(6506007)(14444005)(478600001)(6862004)(6116002)(6636002)(76130400001)(386003)(50466002)(22756006)(8746002)(6512007)(5660300002)(9686003)(186003)(26005)(76176011)(47776003)(356004)(63350400001)(66066001)(486006)(336012)(126002)(446003)(8676002)(11346002)(476003)(305945005)(3846002)(97756001)(36906005)(14454004)(58126008)(7736002)(25786009)(99286004)(54906003)(70586007)(33656002)(2906002)(107886003)(6246003)(4326008)(26826003)(46406003)(70206006)(316002)(23726003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1739;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3a2af3e6-ab8b-4703-2ea0-08d752114f6d
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hfeybvj8ccPZg5ZeGsiYmPfYZTWUhkUBTcRnVwB3tCg8vRV4KSufh9CcQc3lBOSYR++1ufFgwvfKsfICaTeN5Lj6Uhze9kLHT4firZS+uIkYgPXhvx5Np6YcxnNM6efzwJ9N8EHO/IHxOUp4ExQdtQYPDsFwlHNLUwhJx+ieZXjj/Y9Bx8MNThY+/iq8SxDtAE/ZNDVuExyoyAIwdmsNcUwYMx9VVJ/tC1ScZN+lkkqZQgXVTJmIOAdh8oxh63Aa+NWTNGEx3ABzo+Bgz+nUc0jbpdUC+s9bH49XbT81I/gIzAPlJ4e9ezJ2acmVcbaIfiKZWe6ksmdpxIgKHNaN4eQ4FTMSYupDgsVZBXskVdQUJMHgxshVNaNmoRnkSOOit25aP6C6nXeR5rHM1xIi8+446geyRUWYuObAsjQUNyI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 08:17:51.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcf9876-f75d-4a1a-bcaf-08d7521156c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:00:01AM +0000, Mihail Atanassov wrote:
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..7252fc387fba 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -703,7 +703,7 @@ static void d71_scaler_update(struct komeda_component=
 *c,
> =20
>  static void d71_scaler_dump(struct komeda_component *c, struct seq_file =
*sf)
>  {
> -	u32 v[9];
> +	u32 v[10];
> =20
>  	dump_block_header(sf, c->reg);
> =20
> @@ -723,6 +723,18 @@ static void d71_scaler_dump(struct komeda_component =
*c, struct seq_file *sf)
>  	seq_printf(sf, "SC_H_DELTA_PH:\t\t0x%X\n", v[6]);
>  	seq_printf(sf, "SC_V_INIT_PH:\t\t0x%X\n", v[7]);
>  	seq_printf(sf, "SC_V_DELTA_PH:\t\t0x%X\n", v[8]);
> +
> +	get_values_from_reg(c->reg, 0x130, 10, v);
> +	seq_printf(sf, "SC_ENH_LIMITS:\t\t0x%X\n", v[0]);
> +	seq_printf(sf, "SC_ENH_COEFF0:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "SC_ENH_COEFF1:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "SC_ENH_COEFF2:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "SC_ENH_COEFF3:\t\t0x%X\n", v[4]);
> +	seq_printf(sf, "SC_ENH_COEFF4:\t\t0x%X\n", v[5]);
> +	seq_printf(sf, "SC_ENH_COEFF5:\t\t0x%X\n", v[6]);
> +	seq_printf(sf, "SC_ENH_COEFF6:\t\t0x%X\n", v[7]);
> +	seq_printf(sf, "SC_ENH_COEFF7:\t\t0x%X\n", v[8]);
> +	seq_printf(sf, "SC_ENH_COEFF8:\t\t0x%X\n", v[9]);
>  }
>

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>  static const struct komeda_component_funcs d71_scaler_funcs =3D {

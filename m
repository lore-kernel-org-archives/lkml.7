Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A14C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F89720880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nGIhuBBd";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nGIhuBBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfHEIlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:41:02 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:45403
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfHEIlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vp6aG4sKqr/LQ8Xi/AfLJ5ouovrCgNMRFrKkMXJXGY=;
 b=nGIhuBBd/wkxKb9RVSpWx5oPB0hr5PmOk54VtGFrz4mHznVQWKTlC2cy9Y7os8xzXiWNRd/QmLNEb8hf40JlmbmgEH9KhZHsd6xvKvJrt0wp9YEp1RHYaZTlkrLykoJBJBHwxIk6pT4HNJBi22iwOjxD+J2v+ZeOR4DktPlMaxY=
Received: from HE1PR0802CA0006.eurprd08.prod.outlook.com (2603:10a6:3:bd::16)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.16; Mon, 5 Aug
 2019 08:40:55 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR0802CA0006.outlook.office365.com
 (2603:10a6:3:bd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.15 via Frontend
 Transport; Mon, 5 Aug 2019 08:40:54 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 5 Aug 2019 08:40:52 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Mon, 05 Aug 2019 08:40:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc347d17b374c023
X-CR-MTA-TID: 64aa7808
Received: from a605b71e38b9.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 34622C4C-1D02-4B57-B3AC-5B41A1CBE432.1;
        Mon, 05 Aug 2019 08:40:41 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a605b71e38b9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Aug 2019 08:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3SzBNkSG3U+Lry+kt7xKxCZijwBKE7atmbz/dHDkp/pb8N2kay/sYzxnA5WZS6h5MRhbHdBP/u58BrFEG7FuOx1NpaJHzfhWOEqfnXMpq1PS1of2kUAM/jMsuHlLzVyaMOvxCsjAT2RGqvG8goXN41XC5b8AM1X5uAWw+TKnxJmuszFBD86hSUpT7tfyde8y9ynZCrkCteVk11H2SVwQwlWHB48BFV/FvBN/JY061742Tb8auL+5RRHKiX4eI55KKKvrJ+Rs8ZmIrailFFOun0sLVMbHGe3TsqFaOmizaueNTm89SPIFaF0au00dg/lP3O1keOP+UlxnTd5BYZyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vp6aG4sKqr/LQ8Xi/AfLJ5ouovrCgNMRFrKkMXJXGY=;
 b=VfY+Fc+9+zvOOuABBcMmewSAUlSH52EnT6MxC8o038Arty5ccMl4qa8b2Zt1EIQl4kAlzgVF6GAQhGm41/NRcss60RUYujH1Srg0Wc9rboIjpovCdbosxdFlNsTTQxbJiBrgsHyyRt+t8SCxxKDitnNkbNFKyzER/v/kuY1W/oYzM54PBcZOwphyme0K8K+jMtlvcUhrVL0uUcnB3X6orZbZSRXAsBo8heniBboSyaI0lNYH/4PbZYzPMSz2spzsCIVuboO9v0dGAeqluMUXLoAkfmFg/YQ9kDb9GvP7ZBGaE9Igwhdr2YdnbvZXF62CGCsMmk5KDXnaZVcLt4DVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vp6aG4sKqr/LQ8Xi/AfLJ5ouovrCgNMRFrKkMXJXGY=;
 b=nGIhuBBd/wkxKb9RVSpWx5oPB0hr5PmOk54VtGFrz4mHznVQWKTlC2cy9Y7os8xzXiWNRd/QmLNEb8hf40JlmbmgEH9KhZHsd6xvKvJrt0wp9YEp1RHYaZTlkrLykoJBJBHwxIk6pT4HNJBi22iwOjxD+J2v+ZeOR4DktPlMaxY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4959.eurprd08.prod.outlook.com (10.255.158.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 08:40:39 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 08:40:39 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Liviu Dudau" <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Topic: [PATCH] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVSUA0/7/jB3Z3jkicHuuMk5vdZKbsQGEA
Date:   Mon, 5 Aug 2019 08:40:38 +0000
Message-ID: <20190805084032.GA25315@jamwan02-TSP300>
References: <20190802143951.4436-1-mihail.atanassov@arm.com>
In-Reply-To: <20190802143951.4436-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:2e::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dd05a254-1cd6-45de-ba05-08d719809fe5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4959;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:|AM5PR0801MB1841:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841BB64E021A556D6A6C12CB3DA0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:901;OLM:901;
x-forefront-prvs: 01208B1E18
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(68736007)(6246003)(33656002)(14454004)(6862004)(54906003)(81166006)(81156014)(58126008)(4326008)(2906002)(8676002)(316002)(33716001)(478600001)(6116002)(3846002)(229853002)(66946007)(5024004)(8936002)(99286004)(66556008)(66476007)(305945005)(7736002)(486006)(446003)(11346002)(476003)(25786009)(256004)(64756008)(76176011)(6636002)(66446008)(71190400001)(71200400001)(55236004)(186003)(1076003)(5660300002)(102836004)(26005)(6486002)(66066001)(386003)(9686003)(6512007)(6506007)(86362001)(6436002)(52116002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4959;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: bF3Sco0sIFq6VB0KSKc/JvJ9BGjQ6OfRS18kyylF/41YkSEIw8el+Fv44BhpXLd95uxG7iGTOK1uprmxUYkhWiNxV0+zXGVf2BEk233vyVnzy3InJ+hdT0fQHqRQJS/6xuO1KF3BRbi183vm8SIEk84zQCpNIxgNnD2AjRXxOs7JJK6X2ixMEJ4ck8XF+HNtStvL3ErjfMJgf49OLOuaaW2gTk4QOAHZcA2UumHXPZwWQHFKew1g2KhQaTONQ3JGgQFsTCSOOuZqw5LczTVv3CLCzJxbabE66LEw17dSvf+wZhGpGgL1/IYxxiesilQq5zk2nOL6qMxn52n9FU/w2wSBROKIU/uQWXi1XBkfEn0a8VeXRSwbqe7m9kpJmXMjqdmmEGp63K/bm2gcVf2ZyST/nKw5WzL/6dcvGsovm8g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAAD54D554A4C74BBE758086FE240BC2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4959
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:NLI;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(189003)(199004)(2906002)(5660300002)(8676002)(476003)(5024004)(336012)(70586007)(70206006)(11346002)(446003)(63370400001)(63350400001)(4326008)(6636002)(99286004)(81166006)(81156014)(305945005)(76176011)(97756001)(7736002)(22756006)(8746002)(386003)(6506007)(33716001)(1076003)(86362001)(126002)(486006)(50466002)(102836004)(8936002)(186003)(47776003)(36906005)(54906003)(6116002)(3846002)(58126008)(316002)(23726003)(9686003)(26005)(66066001)(46406003)(478600001)(14454004)(25786009)(229853002)(6862004)(6486002)(33656002)(6246003)(356004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1841;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2a882cef-e683-4c40-db4d-08d7198097a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0801MB1841;
NoDisclaimer: True
X-Forefront-PRVS: 01208B1E18
X-Microsoft-Antispam-Message-Info: 4T+0TvqcZDZV+EJ/9r82YB8205mtk6mCwNu1uIirswXNRcqA0ER8BqYoeVYJF1QQQqQ5lzIBthTwg2i3MlQSbcoN+n8KTm+xVLZhbeEvwgEx/C2TWSiJ6IiGEzlQP7RrauOZy32pp+moqBie8nivDKEntv5sRid8d7UNdp6YDHcwgX1wJANUvZNPAB57yXiFsctfVrFC2OEXxiVG/NCbqmjPuRVWPJI20s5NrCc39NknKxFnek9AUgm5Lwvqs3NYqEi2ErcuSnGaWYQz8ikNlZzmBLrh5M37D8j32waWGgi42x6FqNyRkRZIPQbCgdtTpdDeF3uGXbcq+5pYCIs3KG94VDnzrGdHUlx3mVCG9YtYn4tYF7nNnj9PnCfImAzRbsZ2l2xdB2VzU/XnSVOgnO5i8+Kecgz9slVKBbK1cuo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2019 08:40:52.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd05a254-1cd6-45de-ba05-08d719809fe5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail:

On Fri, Aug 02, 2019 at 10:40:19PM +0800, Mihail Atanassov wrote:
> The 'memory-region' property of the komeda display driver DT binding
> allows the use of a 'reserved-memory' node for buffer allocations. Add
> the requisite of_reserved_mem_device_{init,release} calls to actually
> make use of the memory if present.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index cfa5068d9d1e..2ec877ad260a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/component.h>
>  #include <drm/drm_of.h>
> @@ -32,6 +33,7 @@ static void komeda_unbind(struct device *dev)
>  		return;
> =20
>  	komeda_kms_detach(mdrv->kms);
> +	of_reserved_mem_device_release(dev);
>  	komeda_dev_destroy(mdrv->mdev);
> =20
>  	dev_set_drvdata(dev, NULL);
> @@ -53,6 +55,11 @@ static int komeda_bind(struct device *dev)
>  		goto free_mdrv;
>  	}
> =20
> +	/* Get the optional framebuffer memory resource */
> +	err =3D of_reserved_mem_device_init(dev);
> +	if (err && err !=3D -ENODEV)
> +		goto destroy_mdev;
> +

Hi Mihail:

Thanks for your patch.

Since we have a dedicated function for DT parsing: "komeda_parse_dt",
seems we'd move this into it as well.

thank you
James

>  	mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
>  	if (IS_ERR(mdrv->kms)) {
>  		err =3D PTR_ERR(mdrv->kms);
> --=20
> 2.22.0

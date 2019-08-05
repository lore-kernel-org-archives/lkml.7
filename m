Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD85EC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E2E2087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fxy8s4IR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fxy8s4IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfHEKN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:13:59 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:60142
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHEKN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnKkDQoeygPs5m6UATFQGs8f4tiOJVzK3YjQlOVYBYQ=;
 b=fxy8s4IRqUPgr37CQK1PrcthaYqTFx+OpHNrFzohybNePmeMWqrtbUDPdglheUWBJnnaMoMxePYEhXTegxFhigbuJ9X3rFWqPxpDZcv//mjeToO83Alzw64g7qYS1OzBetr27BmLJg2t2TKLuVxYOmA1RvNkZH84ijXnLpN5r9E=
Received: from VI1PR08CA0222.eurprd08.prod.outlook.com (2603:10a6:802:15::31)
 by HE1PR0802MB2604.eurprd08.prod.outlook.com (2603:10a6:3:db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.20; Mon, 5 Aug
 2019 10:13:49 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR08CA0222.outlook.office365.com
 (2603:10a6:802:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Mon, 5 Aug 2019 10:13:48 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 5 Aug 2019 10:13:47 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Mon, 05 Aug 2019 10:13:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b20d286513b3dfb5
X-CR-MTA-TID: 64aa7808
Received: from 46d34bccf823.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C089A12F-4DDA-4ED4-A5F0-8F48D515BF2A.1;
        Mon, 05 Aug 2019 10:13:37 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 46d34bccf823.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Aug 2019 10:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMiPS47X8K+KpprTBGqV4+rXvgtSVjNKwmoaczTewlVaKKcMjHndD7P3s2gA5najIeJy4luNSF35u2Ttv/yOspUXM7rwQDGQQ6u1ng2eQhyH5seMaqGfqWoznH1LwKxuFhIDLN3NIP/9mo9FMe23oUmACFHQ981Pt0YogPHrCOFvYKZJqtC4Gllv8h24jwwE9hQvX6umf6g9NO1cRXFA+X/OfqHpGawjv1O2cR3dHFF9Pc6uG86cBopMmsLEABuABUUFmp/WP67WHwupnO2MGSeafPRF25pOX7N15kEKQ/tTvxnUPiHLMcsnslwBpj6OaRQ9TH6Dw5smemsQQb+1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnKkDQoeygPs5m6UATFQGs8f4tiOJVzK3YjQlOVYBYQ=;
 b=nxoDm6mUwPrTDyq+w8zxf3LJktt+iyY+Xv91TDgdbo7hbx2lpy298luizO+X2AUr1gJUnsh3sDFtU21QtaXQf4fya9ufltCRsRSArAWd2AcpaibbXIXjkGaRZn+MWN/qPf+Y9zx8/nHkD8skPIHrmy3sNv0zupN+8/trWPDWapwmrP+hzt5VtIhClIaIE7Tp1T4ToBAl3xBOY4VHTWniEUP5XdmHqGwvDjbjhJGy0ec1Qgf0hsOEVlfipDbIUvLpOsTYh7mvoAyFbRem9PfqJYM6Tcw46Nm3InwLbamH0kX/aXBkSAxg5s0QExeguEdvIdWFPDBeztncfZHAfxeTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnKkDQoeygPs5m6UATFQGs8f4tiOJVzK3YjQlOVYBYQ=;
 b=fxy8s4IRqUPgr37CQK1PrcthaYqTFx+OpHNrFzohybNePmeMWqrtbUDPdglheUWBJnnaMoMxePYEhXTegxFhigbuJ9X3rFWqPxpDZcv//mjeToO83Alzw64g7qYS1OzBetr27BmLJg2t2TKLuVxYOmA1RvNkZH84ijXnLpN5r9E=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4990.eurprd08.prod.outlook.com (10.255.158.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Mon, 5 Aug 2019 10:13:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 10:13:35 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Topic: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVS3QM1TQJ/XVHokO2F4Ib3nbRwKbsVfKA
Date:   Mon, 5 Aug 2019 10:13:35 +0000
Message-ID: <20190805101329.GA26357@jamwan02-TSP300>
References: <20190802143951.4436-1-mihail.atanassov@arm.com>
 <20190805095408.21285-1-mihail.atanassov@arm.com>
In-Reply-To: <20190805095408.21285-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9c82a4e2-f401-4e16-c780-08d7198d9ac1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4990;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4990:|HE1PR0802MB2604:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB260484EDD79A0248B9638034B3DA0@HE1PR0802MB2604.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:568;OLM:568;
x-forefront-prvs: 01208B1E18
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(76176011)(9686003)(6246003)(6436002)(6116002)(99286004)(58126008)(6512007)(86362001)(81166006)(81156014)(68736007)(53936002)(33656002)(25786009)(486006)(1076003)(6862004)(476003)(8676002)(229853002)(186003)(4326008)(5660300002)(66066001)(71200400001)(71190400001)(66946007)(8936002)(64756008)(66446008)(52116002)(305945005)(6486002)(7736002)(256004)(2906002)(316002)(66476007)(14454004)(55236004)(11346002)(6506007)(386003)(478600001)(26005)(6636002)(66556008)(446003)(54906003)(102836004)(33716001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4990;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kx2j+QcQI0+cAgUjxfN+EiB3pTJnDGIt3L+1gOmXIy6A4Gbh7s0C1TPSD7gCl48eUavDWjj4Cy3XEAUz0pjesBuTboCM3nBLliZb7lWurmCAua6Ycbe9RsPaFMpgot5WpKVeQt/c8FBrQULcM+lSBLUzuZxgjbMZgpIBqCEjfU4K6LRT8TsijOWbwEpKfHaMgXSNpRjbRGkPEsmaMxUMKwdLxkFhjWSlE2andBS2gX+bf09vOIio8V9TFLVMBIpqNUo03XmyekZZfAWWXZR1FWTi8hvh22GpdYuL7M0dEMajJdHrTPHaSrMWzrBbNQYGiYHd/6tivYiGHWvXpBtiZNJFQQ4yZTuNP3rSXa/Yty81Uw9Jcaz6plLkv19Kkd4RcWAS/DmtrKM9evFahk6v2y8UccFqgXyiiEzDjFohAtw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6ADE09C3D72D084489D86BAC215FC774@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4990
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(199004)(189003)(126002)(4326008)(476003)(46406003)(63370400001)(356004)(50466002)(5660300002)(86362001)(11346002)(70206006)(446003)(63350400001)(33716001)(26826003)(14454004)(7736002)(305945005)(1076003)(70586007)(76130400001)(6506007)(102836004)(386003)(486006)(97756001)(6862004)(6246003)(47776003)(66066001)(6512007)(8676002)(81156014)(81166006)(316002)(23726003)(336012)(99286004)(6116002)(3846002)(33656002)(8746002)(58126008)(36906005)(76176011)(54906003)(9686003)(26005)(478600001)(8936002)(229853002)(6486002)(186003)(6636002)(2906002)(22756006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2604;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 573274d8-6632-4bea-3df2-08d7198d9373
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0802MB2604;
NoDisclaimer: True
X-Forefront-PRVS: 01208B1E18
X-Microsoft-Antispam-Message-Info: TQ4ZG498Q0ZzrJvtIj50YnIMeAulqaFLjBTI4yPwi//HGNSZ7ChMPNCKbIx9oSnNuFW7RbySIa7r7UNP0z1nSRJFb6k8XTUzYwosIjyBwAPv5A+JaeRGwOuUt/BQoc7mHZoYIoREp1vH/PSOzByL6g9HCxQqTj5s+kG4jmAjJiXJOUScn6OFmdMCS0MpilKOExzLmtuAb4SwHLpxGNMyOEj0pERCY4M9MVccgY7nT0FANqWlyxIQHgt34jReJDW5gE555to2LUFUXCkiBFzqfyGgwA4r0goniG5pyoOP6lE4FB78xXFeB9VKPq1zgXqCqQ2w8o68Zu4k9ycrQzxm3PpnUXAvUTvRdRi1+LZz/Rc57HxbGQQsV7czEzJw7W+zPwObJbHMLOhvJ36BgCMQzK1+JrlR7LuebjueBl7D5Uo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2019 10:13:47.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c82a4e2-f401-4e16-c780-08d7198d9ac1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:56:25PM +0800, Mihail Atanassov wrote:
> The 'memory-region' property of the komeda display driver DT binding
> allows the use of a 'reserved-memory' node for buffer allocations. Add
> the requisite of_reserved_mem_device_{init,release} calls to actually
> make use of the memory if present.
>=20
> Changes since v1:
>  - Move handling inside komeda_parse_dt
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 1ff7f4b2c620..0142ee991957 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -8,6 +8,7 @@
>  #include <linux/iommu.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #ifdef CONFIG_DEBUG_FS
> @@ -146,6 +147,12 @@ static int komeda_parse_dt(struct device *dev, struc=
t komeda_dev *mdev)
>  		return mdev->irq;
>  	}
> =20
> +	/* Get the optional framebuffer memory resource */
> +	ret =3D of_reserved_mem_device_init(dev);
> +	if (ret && ret !=3D -ENODEV)
> +		return ret;
> +	ret =3D 0;
> +
>  	for_each_available_child_of_node(np, child) {
>  		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
>  			ret =3D komeda_parse_pipe_dt(mdev, child);
> @@ -292,6 +299,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> =20
>  	mdev->n_pipelines =3D 0;
> =20
> +	of_reserved_mem_device_release(dev);
> +
>  	if (funcs && funcs->cleanup)
>  		funcs->cleanup(mdev);
> =20
> --=20
> 2.22.0


Thank you.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

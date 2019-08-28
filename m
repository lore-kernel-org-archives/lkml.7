Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AEDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4127D2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qHOkV4LB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qHOkV4LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfH1OPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:15:42 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:28798
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfH1OPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZqcVlCLan3/+bLPZskwRqac0IqP+LojW2MhkLBeCH0=;
 b=qHOkV4LBeMliPdoNBluQIvr4xyhvvzJFziLmPi/oWXS/s7fs4j8laWZVc/jC/6m6hE+W1hke6+wgeIiM5314XWLN3DnzHMpKj47vV/xZxBH38etGqf6mj2z7RiB2/yt0hm3dJ/c5AzW/ZZqOeXyiBvj+zVaNhffJYal4BpQsQhE=
Received: from VI1PR08CA0272.eurprd08.prod.outlook.com (2603:10a6:803:dc::45)
 by DB6PR0802MB2597.eurprd08.prod.outlook.com (2603:10a6:4:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Wed, 28 Aug
 2019 14:15:34 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0272.outlook.office365.com
 (2603:10a6:803:dc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 28 Aug 2019 14:15:34 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 28 Aug 2019 14:15:32 +0000
Received: ("Tessian outbound f83cc93ed55d:v27"); Wed, 28 Aug 2019 14:15:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f6fd50135d310d0b
X-CR-MTA-TID: 64aa7808
Received: from d5fa0f03b023.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 42BE70C4-5852-4A8B-8BE1-86D65CF91CAD.1;
        Wed, 28 Aug 2019 14:15:18 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5fa0f03b023.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2019 14:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCaztgUMiYNXIdfgQ43le807idTIVgNTNu1fO/zdl9QhJs0idAgzKgBnb96b0ztNX8+zsRWK/n5CELWWCJGRCo6NFt8riYrYQ+br/CAJOzyKHJ78VjxrHO0OHKAc/60sT1+zk+muLXwBSb7QAUTMVo4SnWb2egbqA83HZEo1IR44wDUTXNBUVYwpAMd/g1d4vKCElvLfWcM1LmqopS7oCfBX5kR4Emcyo44rWGS0GHETyt73qqGTuEoMIOJWD2RjJtUVNUShlINdFBSz2mYMU60J8JLHU7GMgEypwrNK5N/i8CDDs8Y0ZGim79WfTkH1FrcrfVKxQ30vSjBqX/+Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZqcVlCLan3/+bLPZskwRqac0IqP+LojW2MhkLBeCH0=;
 b=UHstXD2KJPih/AUbqrqC/vFcVakO+ps6N1hEb+ziAGzcVAdex+6olYW5HcIcRUAd+P9AtIoCBTsO8NGiPLjqSoEa3BFp8QtBuxgurPBfWfoBh0tZGpFySg6QrUmj6fF2l9B4gZB3B3iPv6uPOt9hpyzjPQJEgYriPnUPS+TUUeEyHPyT+FrCLlahZi5hd+Wc/bDV4J8HAMdjI2dE5jTvW7UOLe56OXPL17+tinQB1CkEJCv7LJunKT1mQsRw/MGC8NkhUQnpqdvr82XRo9PrIa1CyDGh9TPv8cWak3aOd7/DkBKbKOMcJ/YmHiyif+us90wxSJmsClt9TC32acnTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZqcVlCLan3/+bLPZskwRqac0IqP+LojW2MhkLBeCH0=;
 b=qHOkV4LBeMliPdoNBluQIvr4xyhvvzJFziLmPi/oWXS/s7fs4j8laWZVc/jC/6m6hE+W1hke6+wgeIiM5314XWLN3DnzHMpKj47vV/xZxBH38etGqf6mj2z7RiB2/yt0hm3dJ/c5AzW/ZZqOeXyiBvj+zVaNhffJYal4BpQsQhE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4878.eurprd08.prod.outlook.com (10.255.113.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 14:15:16 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::d9f5:7cb8:41e8:17af]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::d9f5:7cb8:41e8:17af%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 14:15:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Add ACLK rate to sysfs
Thread-Topic: [PATCH] drm/komeda: Add ACLK rate to sysfs
Thread-Index: AQHVXZBFvBwgvZ1PNEmL4p2YP+CqdacQmt0A
Date:   Wed, 28 Aug 2019 14:15:15 +0000
Message-ID: <20190828141508.GA6738@jamwan02-TSP300>
References: <20190828110342.45936-1-mihail.atanassov@arm.com>
In-Reply-To: <20190828110342.45936-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d18be38b-f981-4aa7-bccd-08d72bc23031
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4878;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4878:|DB6PR0802MB2597:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2597A14CD1C306CED284EE62B3A30@DB6PR0802MB2597.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:478;OLM:478;
x-forefront-prvs: 014304E855
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(33656002)(71200400001)(6486002)(305945005)(5660300002)(186003)(2906002)(7736002)(81166006)(14454004)(25786009)(8936002)(33716001)(4326008)(76176011)(81156014)(8676002)(6246003)(486006)(476003)(446003)(99286004)(86362001)(6636002)(478600001)(11346002)(229853002)(52116002)(53936002)(26005)(316002)(6116002)(58126008)(386003)(66946007)(6862004)(102836004)(6506007)(55236004)(54906003)(1076003)(66066001)(6436002)(71190400001)(3846002)(6512007)(256004)(66556008)(66446008)(64756008)(9686003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4878;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: lUkPCCvL738cnEv/3KMkyI4dEGJ6xwPuSKlPypqCwodRpVXO7PBH7zaufUrH94xTZXtcuBcIgpSFSveDaALBHC2qsjcoUdHN1XJDyptEVzhNLsrJszn+3RMkr+LoadLQfzYcWZdGCY/+5KfIBJzDArL4BcLMA8V3PRA3lbnd4f+5P93dlw5+q8NLLsJ9V7HexlvWl6RPDsh4wk80C/SbUeH7aycaDRKVJ88GYK3S0974BuwNgA78b0lEVdsIflPBzYlKbSaKbZFuIdjRs+fHwcmET/0IFtFdOfWgyFdOs4tMmNdT7ab6i6dxPFdakQxbAH5Hxah/t6kzgjrqXYAefNgExmH8xmtKKknOOYWONP+ebD+J7CmkVYmfUlgY607cOiV/0YILKPGQTvHiSIQwrg7k6YS1qAcySaAV8yTJ368=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C0F61E017C2E44C94A001AFC8D43881@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4878
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(6506007)(6862004)(446003)(316002)(386003)(50466002)(102836004)(6246003)(229853002)(11346002)(476003)(126002)(486006)(186003)(2906002)(36906005)(97756001)(76176011)(336012)(63350400001)(63370400001)(6486002)(4326008)(76130400001)(356004)(9686003)(6512007)(5660300002)(26005)(33716001)(70206006)(70586007)(1076003)(25786009)(8936002)(478600001)(26826003)(33656002)(14454004)(305945005)(46406003)(6636002)(81166006)(7736002)(81156014)(22756006)(23726003)(3846002)(6116002)(8746002)(58126008)(66066001)(54906003)(99286004)(47776003)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2597;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10d378bc-9074-43a2-e6e5-08d72bc2257f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2597;
NoDisclaimer: True
X-Forefront-PRVS: 014304E855
X-Microsoft-Antispam-Message-Info: ZUZbBL+2J2ZlypxcllTIKr7T+OuVWOb8hmbJ8Hdlil1GRvgK3J7/w+WQfjB9+nwNGEWaYiKsb51tOHegE6T0dlITd0RFdzkUjVnRzrHmBxhPwqzG7CJDa8dvRY4DjUN4cYRxkVX6qnb58ETHUwXaX7wTeqLyW+QPhtcWAhzPMleLrmomWDyl3CB1sZfRLfrEN5Xj5HUiZFlPDjOGqABBtRroDiF6NTjB+lAnXgrlZzyzRaxDSAMUX/oIjFQzGCHyWM0BjBTdENatRQuIFAyqSX5T229JhKCSqOsDtMzN4krQ7w3jQ7RBMQQWEjgIV2oinZMu8igz9WGdxRnKJkTyaY92tIiMEyHa4iqM3BWMv/DFfbJ1iCpWHBkcwVUJYvXqsv2tbJgSJVtmHlX5/DZnnzxSJaDtFjAw/7Bzr6G0ZOg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 14:15:32.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18be38b-f981-4aa7-bccd-08d72bc23031
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail:

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

James.

On Wed, Aug 28, 2019 at 11:03:49AM +0000, Mihail Atanassov wrote:
> Expose node with the name 'aclk_hz'
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 0142ee991957..e8d67395a3b9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -91,9 +91,19 @@ config_id_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(config_id);
> =20
> +static ssize_t
> +aclk_hz_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
> +{
> +	struct komeda_dev *mdev =3D dev_to_mdev(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%lu\n", clk_get_rate(mdev->aclk));
> +}
> +static DEVICE_ATTR_RO(aclk_hz);
> +
>  static struct attribute *komeda_sysfs_entries[] =3D {
>  	&dev_attr_core_id.attr,
>  	&dev_attr_config_id.attr,
> +	&dev_attr_aclk_hz.attr,
>  	NULL,
>  };
> =20
> --=20
> 2.22.0

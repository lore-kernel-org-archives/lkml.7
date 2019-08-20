Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DBC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842E622CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AKY5e6vj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AKY5e6vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfHTKbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:31:47 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:54176
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729589AbfHTKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b7lqGuRSa50VuZO5PCO1BgkpGBGkRM9w/GlpC/EAJs=;
 b=AKY5e6vjaFoO/YKsRRGPBwuAtuP9J4tTjOc3rmZvgy3FZ4+uc8MSCIzCswNjIczzQRgvtjk1xO5yA4o7v44ruE5oU4IYnwBAC2SUTWrtEk246afFjdDj9AQIGIeORBOUMRtIwzxBpysEszZD/eYElJHskG5z5qx5YhTaqAfogfw=
Received: from VE1PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:803:104::48)
 by AM5PR0801MB1844.eurprd08.prod.outlook.com (2603:10a6:203:39::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Tue, 20 Aug
 2019 10:31:37 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VE1PR08CA0035.outlook.office365.com
 (2603:10a6:803:104::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Tue, 20 Aug 2019 10:31:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Tue, 20 Aug 2019 10:31:34 +0000
Received: ("Tessian outbound 40a263b748b4:v26"); Tue, 20 Aug 2019 10:31:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83a7ab6a20af4a12
X-CR-MTA-TID: 64aa7808
Received: from b22da5af5d15.1 (cr-mta-lb-1.cr-mta-net [104.47.13.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A5B44930-460F-47B2-95C9-5A764B224246.1;
        Tue, 20 Aug 2019 10:31:24 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b22da5af5d15.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 20 Aug 2019 10:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgd2/ycIJ1bwxNwfVq5I9I3E7Rfi/cSjE3Ayu8VNL8kcDha1/ezGcKLbl2Myo2/46ezy9q1Yyon5/ZJAk8aSKAUXLppq8j4Ic2ICDBeCWbYlUhhXAtOXDJY+Z7c5C3a0kcGtAZ6lBvvLYOoYaxhM21ITH714mO9d6HfKrO1LYRqV9qBODjAMdE8KPu9agXwHQzeaV4sK/WVz2h976Xz8kFeiND0x2vSHbSDb/vpFPzxbrtXnhP/7Wg0eZKdg71kq4/KCP1iUQir5bPHuwuo3zS+WEgKn/hpCq3FQcS5tsnJOVqdstzEzvGk2G2Lpjeb/DN4eUcgz6Ov5NF4zp/RqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b7lqGuRSa50VuZO5PCO1BgkpGBGkRM9w/GlpC/EAJs=;
 b=n2zpk3EOwdW+ZMLDuWpUm9zyx9UkwSGtJdCAAG886I9uHm2ssB+5A8t/n3F2gBjQmIgzABK8pqEJkHegmO3qrPGGYTJPYkQIXqTyDee9EtqPuP2Bp+kwsrdOTAUNuT7hwO9wGp7hmi1+sf69x9cDjfq6RjglgKQqycTP6Ma1IiQJe0jPeNp6bCoqpmU+RDt9vtfvazg3wzlEMebO8FTNdGUKFbi+M+ldt7q6gmNBDy44QoD+Z2K0dRJIzDJ9kFbwRlAr6DWWTxqW88LBbSO7kDXy1gE7w7LALDIXtyTyhY1SxxqVJ/vcPXIy7XGZJrnIub2euVsPuMJZyfuNTrmw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b7lqGuRSa50VuZO5PCO1BgkpGBGkRM9w/GlpC/EAJs=;
 b=AKY5e6vjaFoO/YKsRRGPBwuAtuP9J4tTjOc3rmZvgy3FZ4+uc8MSCIzCswNjIczzQRgvtjk1xO5yA4o7v44ruE5oU4IYnwBAC2SUTWrtEk246afFjdDj9AQIGIeORBOUMRtIwzxBpysEszZD/eYElJHskG5z5qx5YhTaqAfogfw=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB5075.eurprd08.prod.outlook.com (10.255.29.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Tue, 20 Aug 2019 10:31:21 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 10:31:21 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Topic: [PATCH v2.1] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVS3QRJOSbL91lbUCdjgcCuZ6gZKbsVfmAgBeX74A=
Date:   Tue, 20 Aug 2019 10:31:21 +0000
Message-ID: <20190820103121.GA676@arm.com>
References: <20190802143951.4436-1-mihail.atanassov@arm.com>
 <20190805095408.21285-1-mihail.atanassov@arm.com>
 <20190805101329.GA26357@jamwan02-TSP300>
In-Reply-To: <20190805101329.GA26357@jamwan02-TSP300>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c1add18e-b269-40f8-8830-08d7255992fe
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB5075;
X-MS-TrafficTypeDiagnostic: AM0PR08MB5075:|AM5PR0801MB1844:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1844CFFA6F04AFF65D079BF4E4AB0@AM5PR0801MB1844.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:272;OLM:272;
x-forefront-prvs: 013568035E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(54906003)(4326008)(6862004)(25786009)(99286004)(66066001)(36756003)(6636002)(8676002)(81156014)(81166006)(6246003)(53936002)(6116002)(3846002)(256004)(71190400001)(71200400001)(8936002)(305945005)(7736002)(33656002)(6436002)(476003)(44832011)(66946007)(386003)(6506007)(26005)(102836004)(486006)(64756008)(66476007)(66556008)(66446008)(11346002)(229853002)(1076003)(86362001)(6486002)(2906002)(316002)(478600001)(14454004)(6512007)(446003)(5660300002)(186003)(6306002)(37006003)(52116002)(76176011)(966005)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5075;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: ZxF3liX1hQclDVV+Laq8IEPXfKXbVw+vvzc2Z+CUy5vUXL3IDODXS9tNBWmQXK8fPNryUOUaeZGouhmHM3BwiwYt7rmBLqp7Zfk9S90leRuhJm+wOoNxoTVIURPK/vXUImrK7hmX1uWtDoNZ5MtrzItiblv0IRHEbIlSNsTWhwV5a+sDFwSTUXy7Yf/QTS/DKD4WfZmceS8OK9vqL/RAQtFLnnHbWp9k+iMcMInGGYNrd0XrDW1096ChZ2MbsecCF+/YkEW0KPABaVy+mclZg4rfYG3T9qPT/qXIqVk+WW2UJwuhOSBFkoLj3GnLqIe1lacGk2CkQS2sld5OUXFFUoggYhCPm9/YtJQp4tymbLDdg+G0mfbFgDDFk9f+WcKk0nW+JD4aFeJHXXi1kLVr0AFbGE8xSuj2uwOKKxF/jII=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5093786B163DAA47BFF4EA2B456E6A10@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5075
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(189003)(199004)(6246003)(37006003)(54906003)(2616005)(316002)(6306002)(476003)(126002)(6512007)(26005)(23726003)(25786009)(46406003)(2906002)(5660300002)(6116002)(3846002)(36756003)(97756001)(336012)(14454004)(11346002)(66066001)(102836004)(47776003)(486006)(966005)(86362001)(186003)(478600001)(6506007)(63370400001)(386003)(446003)(26826003)(63350400001)(229853002)(70586007)(305945005)(7736002)(76176011)(356004)(6486002)(4326008)(50466002)(70206006)(99286004)(81156014)(8746002)(1076003)(81166006)(6862004)(76130400001)(8676002)(8936002)(33656002)(22756006)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1844;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10d85748-2471-436f-765a-08d725598b5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0801MB1844;
NoDisclaimer: True
X-Forefront-PRVS: 013568035E
X-Microsoft-Antispam-Message-Info: mgejRyf1B5+rBzFHqxIcj4EP92tuUfsgMp0ovsIz0Jz/zCp0HMlSVWmvk5hvBXJnzzsLDLyxNCOdHf4d/miqLVNl+7G3mCJ/oImt91z0/VaoOey6s4Jrmonk1eXh3LQKqFP9R0/OIe3h9iOs0wOuvvIpuYzIBODexPkhjcKFG4kTZygLvIyCjqAQfVIxPAdiEX5IB9+cyhFepS5BdyxRmQKcn2ztxGBdXXuh9Jgl2Ua1V1IAXlPDUYVx99yI8ux7yGs9OHufnDlkTf9vtqjn0wKU+tejOtbwprdiW3KNJ7+fEC/ikMZUu6BlW7HPbcfQrfjC8no6m6KUwV+SOL631Bd8od9Q4A/GxKd2GwNEzqHZ3Up4FH4bwpaS7VK37OD1flWS7Qq+y6xVK8c4PNgydp1YcyW6T4sSQo6LO2p6pFw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2019 10:31:34.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1add18e-b269-40f8-8830-08d7255992fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:13:35AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Mon, Aug 05, 2019 at 05:56:25PM +0800, Mihail Atanassov wrote:
> > The 'memory-region' property of the komeda display driver DT binding
> > allows the use of a 'reserved-memory' node for buffer allocations. Add
> > the requisite of_reserved_mem_device_{init,release} calls to actually
> > make use of the memory if present.
> >=20
> > Changes since v1:
> >  - Move handling inside komeda_parse_dt
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index 1ff7f4b2c620..0142ee991957 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_graph.h>
> > +#include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/dma-mapping.h>
> >  #ifdef CONFIG_DEBUG_FS
> > @@ -146,6 +147,12 @@ static int komeda_parse_dt(struct device *dev, str=
uct komeda_dev *mdev)
> >  		return mdev->irq;
> >  	}
> > =20
> > +	/* Get the optional framebuffer memory resource */
> > +	ret =3D of_reserved_mem_device_init(dev);
> > +	if (ret && ret !=3D -ENODEV)
> > +		return ret;
> > +	ret =3D 0;
> > +
> >  	for_each_available_child_of_node(np, child) {
> >  		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
> >  			ret =3D komeda_parse_pipe_dt(mdev, child);
> > @@ -292,6 +299,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
> > =20
> >  	mdev->n_pipelines =3D 0;
> > =20
> > +	of_reserved_mem_device_release(dev);
> > +
> >  	if (funcs && funcs->cleanup)
> >  		funcs->cleanup(mdev);
> > =20
> > --=20
> > 2.22.0
>=20
>=20
> Thank you.
>=20
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Pushed to drm-misc-next - a8c16b7593bd1a4e613164a47c526ca9d1be764b
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

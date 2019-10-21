Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5FA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rpYInWLQ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rpYInWLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfJUNmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:42:44 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:4099
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbfJUNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjVYJUAgwy0Lb91imj1bSlCNu46WVVt7WPYXMRLAb8=;
 b=rpYInWLQziejGuRjznXl23zuWz4zCYC4uvnu1eoPpx3zFg0lYgedXN8vLiA0pOIrIcQW49kAUBTgeEqbtdfY9k9Sc1o0Vj1y+0O/Fa5edPHj6qoxoPIVtkP4CnX1UpJMGAuT/vXOfvV6BjWirAZs+n/nWGJJWT4kYXcLak2vMfU=
Received: from VI1PR08CA0137.eurprd08.prod.outlook.com (2603:10a6:800:d5::15)
 by AM0PR08MB3682.eurprd08.prod.outlook.com (2603:10a6:208:fb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Mon, 21 Oct
 2019 13:42:36 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0137.outlook.office365.com
 (2603:10a6:800:d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 13:42:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 13:42:35 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 21 Oct 2019 13:42:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 48fcaf8f549d9f92
X-CR-MTA-TID: 64aa7808
Received: from 84494209b4f2.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CF677C97-3AAC-4E25-84CC-E450A83748F7.1;
        Mon, 21 Oct 2019 13:42:24 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 84494209b4f2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 13:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgbG+yHKBsmtEh1xGT6MITKBK8k6I921PIVatfZ0JDKgvoYVN3oBL9oNtwG8MVMdWgAssdHpZJfYoOty9G7eG1Jzk07++y5P1GcaXWnCmVmxu0OOT8a/k4mZVzrMq+unCCKpIwmWHELB4MM4zJGiTzDMudld/OHMBH9vcAMgo31W1iJ4vFVkMPOdGxJPh5NewaDFcBtxFlgskLRWLWwqijR/NJILqezlkcSaCDwh+Zdw4vm1eKN4guAVNVb6UdkjNuUyi0tLeqnlvxCwXAu9tKHu81HnocK0TSEVS/Tzd3ZAV9MKlo1bQS/ImKke8AU+TvL+3EdHTe0gjQISD1+30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjVYJUAgwy0Lb91imj1bSlCNu46WVVt7WPYXMRLAb8=;
 b=Dut6h8zKBjZ3h/R65NXjTUIKMwcr2ygdwVSe+0rg/vxDhfkroXE8notKDDhrtO0DT0FMK2s/LWGZmFEl2zilFFApuzZThPIxJaV9LVCie3gSn31XgnM/cNlvFwN9zHGpoRbb8B6qX++2PNkPXI7X4/Wib4Q1f25i26RqTBjGA0Nl5J+VHsk+TkbzMqrIGM9wHfug/GgWTMprLs0nbkXMpFhhZUjWx61lVtqkeAhN07MA2ZHI26hJ4wEy2YSnkU/lqJBYIuIir+Zzh7tQOcadBwyjSb5HVebJ/zwIUmLZYAHztASITGC1zsLXKUgf7zeJ3O/WHnVRJv1YvsFz73Amwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjVYJUAgwy0Lb91imj1bSlCNu46WVVt7WPYXMRLAb8=;
 b=rpYInWLQziejGuRjznXl23zuWz4zCYC4uvnu1eoPpx3zFg0lYgedXN8vLiA0pOIrIcQW49kAUBTgeEqbtdfY9k9Sc1o0Vj1y+0O/Fa5edPHj6qoxoPIVtkP4CnX1UpJMGAuT/vXOfvV6BjWirAZs+n/nWGJJWT4kYXcLak2vMfU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3200.eurprd08.prod.outlook.com (52.133.15.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 13:42:22 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 13:42:22 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     David Airlie <airlied@linux.ie>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Topic: drm/komeda: Dump SC_ENH_* registers from scaler block
Thread-Index: AQHVg/o0KxTrmwItXUCRsuGzgIiHJadlIsWA
Date:   Mon, 21 Oct 2019 13:42:22 +0000
Message-ID: <2007868.TRdzCC70Pn@e123338-lin>
References: <20191015105936.50039-1-mihail.atanassov@arm.com>
 <20191016081732.GA16502@jamwan02-TSP300>
In-Reply-To: <20191016081732.GA16502@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0457.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc7dfd5-574e-4284-2b97-08d7562c87db
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3200:|VI1PR08MB3200:|AM0PR08MB3682:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3682421973BE644C393D8F7A8F690@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:243;OLM:243;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(14454004)(66066001)(6116002)(76176011)(8936002)(81156014)(8676002)(6636002)(2906002)(3846002)(6862004)(486006)(33716001)(476003)(81166006)(86362001)(478600001)(11346002)(446003)(66476007)(66556008)(64756008)(66446008)(66946007)(52116002)(25786009)(26005)(9686003)(229853002)(99286004)(186003)(316002)(5660300002)(6246003)(7736002)(386003)(102836004)(6512007)(6486002)(256004)(54906003)(14444005)(6436002)(71200400001)(71190400001)(4326008)(6506007)(305945005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3200;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5+w2O/zDI2RSHHHN/WGi/ALkSZ39O7aCqO0VF88za1RIgAjyoWGwwqVwTh/8VkHRXmp6wFs5vr8jQmYZzA4PBThal4mrdtBzJY1xsAXH93azQebrQyVoM85JclJ5aL9zO8bSnPO7flcNToPvY6BlnPjOS7Mq9RkMPe3RxLeAzUOB1yDmI4B2vLf0uY5m9r9k7wtDjJ8Hqb/Si0lCFQ3ttIwnb9YxO7rFqf75Yv0+4e9CxdtY/xSY55sIDN0TArepXrhfOcpXUP5uEN1oqZ2Czl02TmEqV8+vbdYTcvrXMgvqzAaDvXHGOX4v68uJHb+aP/FztNV3UeFt0NLSQ6suOovUIc6/MiQf4Lb2UfinFlQFAQSN/9hbKu064sNxMpw+NHL6OFfXXyKSJx98I9TsdWyJCV8eMo+3NgJRTkbna5Hom9uYYaOeslQlpGnq2svo
Content-Type: text/plain; charset="us-ascii"
Content-ID: <009174014AA0154EA8732811A9E1E04D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3200
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(66066001)(6486002)(54906003)(76130400001)(99286004)(22756006)(9686003)(6512007)(70586007)(46406003)(36906005)(70206006)(229853002)(6246003)(107886003)(6862004)(47776003)(102836004)(386003)(4326008)(8676002)(26005)(356004)(14454004)(6506007)(186003)(81156014)(81166006)(8746002)(26826003)(478600001)(33716001)(97756001)(336012)(11346002)(7736002)(8936002)(6116002)(25786009)(63350400001)(126002)(486006)(23726003)(305945005)(14444005)(3846002)(76176011)(2906002)(86362001)(5660300002)(476003)(50466002)(6636002)(446003)(316002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f36e0597-17eb-4df1-7221-08d7562c8018
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7c5wq9rcYkhOc8srg0eVsvfn4L2NNiyNw/6IF+1CusxkUHJQcpiApMVJAFBmtjk7tTCLeoGtyj00oOMsN91XwA8wcWDSXQOIs7ozP8ZvfylvxfOk//9FG1eS/rplqNiOi5heuOazDJhtZ8l5Ye4c8r+Sar5GeVJkd0YHDv47oHqZT3lnScBYxbd9kV/NMCTnPHTpKcmS6DsnHSrVTsCdOZ+2U54FSJySZpBMeJ4cbzDHnstZ9GBXWvl3MVCeIt0LbUi5jirgUVWkpgNNxXJfica5vbWpNIHRrstwyhDhJrdLrcfxO+A/qbylZrG0jgcXW+gPmR8n5emC2gqHdfRFBCwDhEzp/ia+XoL577Y4wKl69YiNnaXlspx9ylqcK1EChBHlFqpxK2Xldv+IulM+6Cl+42YdoC3Rnc7+Kfqg/4TP9BfFQkytHObGjGkQchK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 13:42:35.2931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc7dfd5-574e-4284-2b97-08d7562c87db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 16 October 2019 09:17:39 BST james qian wang (Arm Technology =
China) wrote:
> On Tue, Oct 15, 2019 at 11:00:01AM +0000, Mihail Atanassov wrote:
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/d71/d71_component.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c3d29c0b051b..7252fc387fba 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -703,7 +703,7 @@ static void d71_scaler_update(struct komeda_compone=
nt *c,
> > =20
> >  static void d71_scaler_dump(struct komeda_component *c, struct seq_fil=
e *sf)
> >  {
> > -	u32 v[9];
> > +	u32 v[10];
> > =20
> >  	dump_block_header(sf, c->reg);
> > =20
> > @@ -723,6 +723,18 @@ static void d71_scaler_dump(struct komeda_componen=
t *c, struct seq_file *sf)
> >  	seq_printf(sf, "SC_H_DELTA_PH:\t\t0x%X\n", v[6]);
> >  	seq_printf(sf, "SC_V_INIT_PH:\t\t0x%X\n", v[7]);
> >  	seq_printf(sf, "SC_V_DELTA_PH:\t\t0x%X\n", v[8]);
> > +
> > +	get_values_from_reg(c->reg, 0x130, 10, v);
> > +	seq_printf(sf, "SC_ENH_LIMITS:\t\t0x%X\n", v[0]);
> > +	seq_printf(sf, "SC_ENH_COEFF0:\t\t0x%X\n", v[1]);
> > +	seq_printf(sf, "SC_ENH_COEFF1:\t\t0x%X\n", v[2]);
> > +	seq_printf(sf, "SC_ENH_COEFF2:\t\t0x%X\n", v[3]);
> > +	seq_printf(sf, "SC_ENH_COEFF3:\t\t0x%X\n", v[4]);
> > +	seq_printf(sf, "SC_ENH_COEFF4:\t\t0x%X\n", v[5]);
> > +	seq_printf(sf, "SC_ENH_COEFF5:\t\t0x%X\n", v[6]);
> > +	seq_printf(sf, "SC_ENH_COEFF6:\t\t0x%X\n", v[7]);
> > +	seq_printf(sf, "SC_ENH_COEFF7:\t\t0x%X\n", v[8]);
> > +	seq_printf(sf, "SC_ENH_COEFF8:\t\t0x%X\n", v[9]);
> >  }
> >
>=20
> Looks good to me.
>=20
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Thanks, applied to drm-misc-next -=20
2b6f5883edcc47ef6146832112a0125810d28f78.

>=20
> >  static const struct komeda_component_funcs d71_scaler_funcs =3D {
>=20


--=20
Mihail




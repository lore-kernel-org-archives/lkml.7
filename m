Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F26CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E468B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZgIuiV9C";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZgIuiV9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfJVCIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:08:30 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:14914
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730304AbfJVCIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR8iV/tyMbIIJ8GiB9jNBi5ecWSfy1bS6qo6urZ7LF0=;
 b=ZgIuiV9CML5+OviTXbo+GXcUbupE3Q0q+zYqkTBvaQ5MmrLwsQsIQ3zBAMif3KRJswfVF8Fjwe/FKWGVpLNJSG9CQ3hkS/UEilUhHGupWNdMNindXtKt1b4aSu/A9mhv8F+m4jsKmUL76IgO6Jb71PrWYFWoC/kXI1fUJEj92B4=
Received: from AM4PR08CA0078.eurprd08.prod.outlook.com (2603:10a6:205:2::49)
 by VI1PR0801MB1743.eurprd08.prod.outlook.com (2603:10a6:800:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Tue, 22 Oct
 2019 02:08:25 +0000
Received: from VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM4PR08CA0078.outlook.office365.com
 (2603:10a6:205:2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Tue, 22 Oct 2019 02:08:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT032.mail.protection.outlook.com (10.152.18.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Tue, 22 Oct 2019 02:08:23 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 22 Oct 2019 02:08:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a26d323599904e58
X-CR-MTA-TID: 64aa7808
Received: from c36084a998ff.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E81ACF25-D81E-4C88-A515-D29E7257342C.1;
        Tue, 22 Oct 2019 02:08:11 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c36084a998ff.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Oct 2019 02:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn7ngodZve/YJuI7lYY+gadxiX5tGkXk4zTmJBOD96KfGYq7jR392KVh9nGMNnZLFIjrvYSeBYsh2MSjVc+PVSsWgxlBoRPniqQgw3Yi6KYVm1ujE8d/4FRTJ4t+KmO20WW2ryT6oVeJttVlN7SRvYdGYVpiauZV5wk3ARRjb7onGFoWGgYKvWj2C9qTuKGOfp00jqehBd6ffwUcjb56WvuRmZkDbqeCXHyUarjMGBzbUfRBfYrWA5wOwOjGXxF+lI3wikpLn1B1HSaaJYGkJlAeRemWbLgwl4RHhwwGhn9o16Ti7gYIaepYekqJ/23rq/jia0wiZ7bakqD7IOZqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR8iV/tyMbIIJ8GiB9jNBi5ecWSfy1bS6qo6urZ7LF0=;
 b=c+GFwiH2XUrknIj7DgjbvZnmwsiQ4CvVhsYWBA5VtnabBGrVjh7ANAyywKi7LJJ1q8vFG4J3C3T85KIMxod9Wd49ekPP5CN0BPLpx1B+Z5LUFcpaJxo7DM28o2/SmLEQytxFNAlnokvsqFBQNquoG+Y1LaMM6acp+FpIzdzyrQ8wz3Sb11evzak47eNGSDLioIH1VGkSYwnuxkeKGhsPaRr6fzSC8kDXXKfOXD+91rIJ7RFMXmHwNVtuuEmUMIAvEeHxc/R9TinLOiafTWYn4nTyTZgUDAdLAMTPe89JmlmRshjp7OK+p/zFQgZYMYP00SVIoDqrHnyKY/Tef4hS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR8iV/tyMbIIJ8GiB9jNBi5ecWSfy1bS6qo6urZ7LF0=;
 b=ZgIuiV9CML5+OviTXbo+GXcUbupE3Q0q+zYqkTBvaQ5MmrLwsQsIQ3zBAMif3KRJswfVF8Fjwe/FKWGVpLNJSG9CQ3hkS/UEilUhHGupWNdMNindXtKt1b4aSu/A9mhv8F+m4jsKmUL76IgO6Jb71PrWYFWoC/kXI1fUJEj92B4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5037.eurprd08.prod.outlook.com (10.255.158.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 02:08:08 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 02:08:08 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Sean Paul <sean@poorly.run>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Mihail to Komeda DRM driver
Thread-Topic: [PATCH] MAINTAINERS: Add Mihail to Komeda DRM driver
Thread-Index: AQHViCB7QBCpqKK/Z0mgls76GftRf6dlX0SAgACLioA=
Date:   Tue, 22 Oct 2019 02:08:08 +0000
Message-ID: <20191022020801.GA25296@jamwan02-TSP300>
References: <20191021150123.19570-1-mihail.atanassov@arm.com>
 <20191021174835.GD85762@art_vandelay>
In-Reply-To: <20191021174835.GD85762@art_vandelay>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7266e0e1-c29c-4a5b-47f9-08d75694b80a
X-MS-TrafficTypeDiagnostic: VE1PR08MB5037:|VE1PR08MB5037:|VI1PR0801MB1743:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1743F98D8D18F68117613428B3680@VI1PR0801MB1743.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1468;OLM:1468;
x-forefront-prvs: 01986AE76B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(33716001)(81156014)(305945005)(52116002)(76176011)(386003)(26005)(6506007)(66556008)(3846002)(486006)(66946007)(4326008)(476003)(6116002)(102836004)(55236004)(99286004)(8676002)(316002)(6512007)(9686003)(4744005)(14454004)(64756008)(8936002)(66446008)(81166006)(66476007)(7736002)(5660300002)(6246003)(58126008)(25786009)(66066001)(71190400001)(186003)(71200400001)(6436002)(54906003)(446003)(86362001)(33656002)(1076003)(6486002)(2906002)(6916009)(256004)(229853002)(11346002)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5037;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qe56CWEp7dWpMDb9FB1lop+X+Wb6ydA2vhcEt4kuCO8QixrO1EWVjl0LbOlllHOA8ZZXWosWs/uu2RUnyr+hNI0PmDvDwtq1/iF2ZJ2egtb9p65f5dKEEr3DmhMurBSsUDmsXq9TKMfDItunpCkgB2J34oRnArw+FmnXvVVcGGFJrqd+ARzUNHbCIwsW1JWXZ9j0glExutwFg6uGINyKWUVfu9EbP3AItZ+/BOow7nHs1C3ja0C2NUmpHDFpYGyPyzQ2fyDKStoK98tHtpl8IQP+8mEACpCRcIwtYmLVZLmnxwrgmFie4RfeZE84VL0qvUlFCz5+2AW9pL0g6hM0VukDpZ5eXs4aRspE8209a1FRf9N3iGFLUpaLAxTGHSyyDEs0nN4asFvOXVgduQd7BQ6n1ARYxslaebIe4PCAaIwnPzga6gz1yOn8uSfRFhHb
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5731EEF4BEB554ABCE63D26A2759993@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5037
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(76130400001)(336012)(33716001)(46406003)(356004)(76176011)(86362001)(70206006)(70586007)(36906005)(99286004)(6486002)(54906003)(25786009)(8676002)(58126008)(316002)(1076003)(8936002)(126002)(33656002)(476003)(66066001)(486006)(6862004)(26005)(23726003)(22756006)(102836004)(186003)(6246003)(11346002)(446003)(63350400001)(6512007)(8746002)(81166006)(81156014)(5660300002)(47776003)(50466002)(478600001)(305945005)(229853002)(3846002)(26826003)(6506007)(97756001)(9686003)(386003)(2906002)(14454004)(7736002)(4326008)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1743;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49dd79d8-e8cf-4235-0982-08d75694aeb4
NoDisclaimer: True
X-Forefront-PRVS: 01986AE76B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6G5MLs1RdfGYhheQs1JpPLPeyFTScapgu0lEwyVbBuDMtK19VCkuoeqolb1wqjT1GVWvfhpf13deGth7y2SKI2uOD8Tp2l9q5Q+7tBTAVaFI7VP0Sh7cWu50FfQgupva+7HlFxlch5WBDbjoC/7Iup3NEwlbtgTdqYugyBWbhRAq4yLSdeHpIRUig+A7HDdxizlHfCIgKkxmOVEgS6cvenxa8JW/yQCPhHv03QEHe/Q/MR1cH4mWI5bhhKDW8RU8GsDWr0MkB0Hwz9H4db+h3M5pHGmAifpEeVIuxxqEWZpQAqvH7AnmdIzm5u7fLK/n004wbkbNEjdZoGA1EJsA4C9DpizS0kJcNhaR7/Xw4xFU0/Y/9DiNXXY6wQrM+NNQ/xfHGmq4AcFfXRa9CFmE5PczN5chG5tF9f/GZijWMwWrYrY0hbTlyKbEe6sS7/j
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 02:08:23.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7266e0e1-c29c-4a5b-47f9-08d75694b80a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:48:35PM -0400, Sean Paul wrote:
> On Mon, Oct 21, 2019 at 03:01:56PM +0000, Mihail Atanassov wrote:
> > I'll be the main point of contact.
> >=20
> > Cc: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> Acked-by: Sean Paul <sean@poorly.run>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 94fb077c0817..d32f263f0022 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1251,6 +1251,7 @@ F:	Documentation/devicetree/bindings/display/arm,=
hdlcd.txt
> >  ARM KOMEDA DRM-KMS DRIVER
> >  M:	James (Qian) Wang <james.qian.wang@arm.com>
> >  M:	Liviu Dudau <liviu.dudau@arm.com>
> > +M:	Mihail Atanassov <mihail.atanassov@arm.com>
> >  L:	Mali DP Maintainers <malidp@foss.arm.com>
> >  S:	Supported
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> > --=20
> > 2.23.0
> >=20
>=20
> --=20
> Sean Paul, Software Engineer, Google / Chromium OS

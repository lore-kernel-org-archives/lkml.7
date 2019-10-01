Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F5C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E260521920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="B3cyGJ0q";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="B3cyGJ0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJALGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:06:42 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:62821
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfJALGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPbdsl91p57gKwQNkVs94dzoFvXrmXL0I73f3wh5vOU=;
 b=B3cyGJ0qUjhjK76e2OiD9F43bSvNHFiwfgXCZtKHgqlun6yr23NgOUiIf29M1OF2lV+47Gq/UL3mc6LCjCJwSGvS899JcDYJIyRbE9b4wVhpvitB6tUriYAZV63FcVAdAWYgPuzmjkaJ5uIzXEwqqE77j8YvLd3l7rFgbwkmThU=
Received: from VE1PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:803:104::48)
 by AM0PR08MB3697.eurprd08.prod.outlook.com (2603:10a6:208:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Tue, 1 Oct
 2019 11:06:36 +0000
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VE1PR08CA0035.outlook.office365.com
 (2603:10a6:803:104::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20 via Frontend
 Transport; Tue, 1 Oct 2019 11:06:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 1 Oct 2019 11:06:35 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 01 Oct 2019 11:06:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 79718c682a6069bf
X-CR-MTA-TID: 64aa7808
Received: from 523e2a29ea3a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9A716C71-C38C-402E-8493-B1C51E1EFC45.1;
        Tue, 01 Oct 2019 11:06:27 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 523e2a29ea3a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Oct 2019 11:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoX7g6S2lY2ZHueVmL3RU6tf4g7Afhz8/9iEpXeTAlm16zySGlgjD3GqoCVqS8Hcg+bu8wPleyYi9xoeMLHy0kN787Nu3IdHjY6UNABhrGwKK/2MPNHTv0ouBuDv+qgPLuaeedpV0AB0SYWKTxskDJd70ygO0TWrz7yFyl4c/NImaexbXLSJLm6m7OJXdIDSzbFrucVE0mkANuFmBiAKYwi64lJPpJcjTxcCDIXwWYJHcCvJhfNzc//AV0kcXxcMsszZGHz4maitbhRgmiEygPpFrzMyqAA5aYUfCEuNzbCyaTCY2dk9xFv56bIJlYE03oYkHhKZAcZM9/z06Gaq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPbdsl91p57gKwQNkVs94dzoFvXrmXL0I73f3wh5vOU=;
 b=KqlnUAQBlmkY603D2+iv4PZQc/gyM3VH85JizWvn9WQ7E+WO+k3imdKRaNwQbWfELbOPExam171IV6g7JcfcAmiwwvT7r2L/6qPtZVOwXaf+wLpr/VoHqlQIhJ+yZGRpkYxMNCiuC3luvvypt/gVV4LdKWCICOKJuI+vHoF5HdUKxP9iIZMJlJrBJ7f2/qImjSFe6ip+HU8kJAFZeFGGRaEW2sy04g/xMzLzKP/B0tvP1nlvoXKSwisNGXXRSoapPuZevLfOKplM9QeyQXgbXz1XkwnRQVSPTAhrpStdwUEDMEUWlUtpHqb/A1YGYeBLg9OC5LaQ9Am2n7OqzOe2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPbdsl91p57gKwQNkVs94dzoFvXrmXL0I73f3wh5vOU=;
 b=B3cyGJ0qUjhjK76e2OiD9F43bSvNHFiwfgXCZtKHgqlun6yr23NgOUiIf29M1OF2lV+47Gq/UL3mc6LCjCJwSGvS899JcDYJIyRbE9b4wVhpvitB6tUriYAZV63FcVAdAWYgPuzmjkaJ5uIzXEwqqE77j8YvLd3l7rFgbwkmThU=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5509.eurprd08.prod.outlook.com (10.141.175.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 11:06:26 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 11:06:25 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Topic: [PATCH] drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
Thread-Index: AQHVb8XpefZcvGvZNkuWrwlyThjxiKc4kUoAgA0fsoA=
Date:   Tue, 1 Oct 2019 11:06:25 +0000
Message-ID: <20191001110624.GA5422@arm.com>
References: <20190920151247.25128-1-mihail.atanassov@arm.com>
 <20190923024136.GB24909@jamwan02-TSP300>
In-Reply-To: <20190923024136.GB24909@jamwan02-TSP300>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0105.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::21) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9ceb4ad6-a7c2-43f3-ea38-08d7465f6c83
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:|AM7PR08MB5509:|AM0PR08MB3697:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36975EC4E4272D325E8FCD46E49D0@AM0PR08MB3697.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 0177904E6B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(64756008)(305945005)(6116002)(2906002)(81156014)(8936002)(229853002)(3846002)(66946007)(476003)(66476007)(66556008)(36756003)(81166006)(8676002)(76176011)(11346002)(25786009)(66066001)(5660300002)(99286004)(2616005)(6512007)(446003)(486006)(478600001)(966005)(66446008)(6306002)(256004)(14444005)(102836004)(6862004)(6246003)(52116002)(6636002)(71190400001)(4326008)(316002)(386003)(186003)(71200400001)(14454004)(37006003)(54906003)(1076003)(6486002)(86362001)(26005)(6436002)(7736002)(33656002)(6506007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5509;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CRW5dQhSX44aSYN/21hZsJ4G08SWJ93cGjg/Xih7YuUzGcFvy8XmNtGtN9U66Pyj/ieMP2YFMT9TYI6+MA3FNiX6njq0QhnrI/7wXFRk2okw2Bya6NGslcx760zBsESQv91uFr+h3VNGhigoEKygAeJ1p3Jj77ccy+2arYLuizMgk9KG3JHlRe290pvG1FpwUwPME2XfG2YE3BeP9l9sjJ1Qft2TgnybRV9q6yQrCrybZwOgHjdaCNdOzP7vdf4QcRStw5ATY9G9w5SIL81P5oyJamwSbWLXbYILGV9KXR7US1IFgLiwYWAaSXFZ8TZm/pQ0wgaMqNLcbV/VeqqYqjHXGQyL3T9rKU/mMeB5F8ZqQJFJt1TvQasmnCjVkna2e+9kK0n+dMO4LDhFyFgbl8SJM+nSHW20xfZq0fGWgisnf9MWpbW6auqBfBppQaFUCfzqvtDGiKq62/oQbfai5g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C705ACD005EF445A19252DD78E49E98@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(478600001)(37006003)(6246003)(70206006)(6306002)(336012)(33656002)(316002)(486006)(6486002)(229853002)(11346002)(446003)(476003)(126002)(70586007)(2616005)(356004)(966005)(1076003)(63350400001)(14454004)(54906003)(76176011)(102836004)(386003)(26005)(14444005)(6506007)(99286004)(26826003)(6512007)(50466002)(6862004)(6116002)(4326008)(76130400001)(25786009)(86362001)(3846002)(97756001)(23726003)(6636002)(22756006)(8936002)(5660300002)(2906002)(186003)(81166006)(8676002)(47776003)(8746002)(66066001)(81156014)(36756003)(46406003)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3697;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 662f1e4d-1361-4c4e-45f4-08d7465f66b6
NoDisclaimer: True
X-Forefront-PRVS: 0177904E6B
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUPfaooL53FZ1bKOP4pl0yjfaYFdWFQjdJIHNdB+3T/0Q6Y3u3CaTcVwpmiqm89VFxcfNFbrY6B7EcwfDGT9Vpp0A4MEiP0oV2Z2uuKknBXH5qpv9plpINkn6HC85sqElKnX4XcR5Iq0WiCbIkwbfP3R/u1daAdM+lp8uNz2fMPTopsK+2jIgdt68P9wpUmszb1MmExasTWXuw3r9VcelSROvWOp31t4jeqG8+acXA1gth/kEcpOgI73WDo4sKKvBuuCIe6ALYYDm4mEP00V04ScDK5Z9q+7Zm4lCmgoIToLZnNvn9hQ2qr6YrXkNRdQ3kCjqPswZ7LVcUTuzIiUlnAi+HNlYSMEGs7E0uA36mgTpCmeyxE+xaooJ/pykI1GC9eL4vejPIkQC81jJYjNSm0QCVOcCd63CdF1RtmLngpdJ8iv42jDSVq5iDDAm5dOZ1i5oA7yT6vzBv7Q/bZDkQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2019 11:06:35.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceb4ad6-a7c2-43f3-ea38-08d7465f6c83
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3697
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 02:41:44AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> On Fri, Sep 20, 2019 at 03:13:08PM +0000, Mihail Atanassov wrote:
> > No change in behaviour; IRQ_RETVAL is about twice as popular as
> > manually writing out the ternary.
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers=
/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > index d567ab7ed314..1b42095969e7 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > @@ -195,7 +195,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct kom=
eda_events *evts)
> >  	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
> >  		evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], gcu_status);
> > =20
> > -	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
> > +	return IRQ_RETVAL(gcu_status);
>=20
> Hi Mihail:
>=20
> Thank you for the patch.
>=20
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Pushed to drm-misc-next - 4b39582a8fb3c749f0fa96ec920d138f61bf00d6
>=20
> >  }
> > =20
> >  #define ENABLED_GCU_IRQS	(GCU_IRQ_CVAL0 | GCU_IRQ_CVAL1 | \
> > --=20
> > 2.23.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B63CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A5C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Nb0+QvrI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Nb0+QvrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395397AbfHWOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:42:20 -0400
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:29023
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393140AbfHWOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuhjvdM7G1gpIQVdFeJsk7zVs9W4t1IdQ8LPV0+Bm4s=;
 b=Nb0+QvrIQwOkrEkPLocSYfysAEDCtKhacjJyfNalEVr0Se98w7BhWBlxNRAQcjqpa/Lwi8eq/UVFSDH8H9+JGhYG68lbmxJtvLM5+O/aK/2iMmZze5y+69+uqNCaaeoxp24/hXEFFIPVxl9rHnMWdpHCZKaI3FasnJmXc9qOU/w=
Received: from VI1PR08CA0211.eurprd08.prod.outlook.com (2603:10a6:802:15::20)
 by AM0PR08MB4945.eurprd08.prod.outlook.com (2603:10a6:208:157::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.19; Fri, 23 Aug
 2019 14:42:02 +0000
Received: from DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by VI1PR08CA0211.outlook.office365.com
 (2603:10a6:802:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.15 via Frontend
 Transport; Fri, 23 Aug 2019 14:42:02 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT043.mail.protection.outlook.com (10.152.20.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Fri, 23 Aug 2019 14:42:01 +0000
Received: ("Tessian outbound 4f2e8f9f1994:v27"); Fri, 23 Aug 2019 14:42:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 36ea321b04fb1883
X-CR-MTA-TID: 64aa7808
Received: from b86af291acb5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 880753F1-37A2-4F7E-A4AF-30CD6D47E209.1;
        Fri, 23 Aug 2019 14:41:55 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b86af291acb5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 23 Aug 2019 14:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAdrvbDIVRsk2Su+faxT8WeRunaNizB9TjJZugz4cdo2DrK0dFuneVdqDFEfJw4mPSdpURm5XAjwgrqWh+nOC/maOy5LcEtvdC9VEbpc0XcFkoCvnY2hjkS3wbF5kkxv29GQz4QfxD1EZ6gpgvjk9Pxsh+7Zi4i0O6BBUG5AK0k3A6/mlES5tZbalnLarJBy1nxVqslkr63ZP0FRiYn4iyy39gTq+IUVlVotvOhb2oBXGgVz6mofo3T6zqNyQtl7hEmG6oWk1aWYEzQ0uLirKtYjEE7vkf8FeLt4BfNDtP7Mlrvqa+6PNXN0QC5mz5wvkQybOVRzA30VPxUhBs5KbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuhjvdM7G1gpIQVdFeJsk7zVs9W4t1IdQ8LPV0+Bm4s=;
 b=GSmfvFSArr7k9a7tu/16Z8tmOrXu3w/CuDdS0F++n4DpojPDyw6c5f/67MsfgoEkEAjkEQ9XMKrORJNAjUWd9mWI2+e5O+UJLGbiVB5mxEaYYWdFyEdisr83p/FrRKYt7QhVMrUtHZzFkeXyJFZe4V4AYWoGct2eL34vKCpuzS8tS05dEVdhxqvQClFaTDSWDpy+dudqylYEvBetTtjTroflDT9g5QfbHIzEHJ6MN1rISrsVfQ5n21Jd2jdwdO+4SmD1dbvG9L7+3+vFgewJpaQYm0iuM6j3Ojxt7YLit9Efe6Ljoa1ajA8OX52bSkf14oiR6NcEnWhyKA8fCue+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuhjvdM7G1gpIQVdFeJsk7zVs9W4t1IdQ8LPV0+Bm4s=;
 b=Nb0+QvrIQwOkrEkPLocSYfysAEDCtKhacjJyfNalEVr0Se98w7BhWBlxNRAQcjqpa/Lwi8eq/UVFSDH8H9+JGhYG68lbmxJtvLM5+O/aK/2iMmZze5y+69+uqNCaaeoxp24/hXEFFIPVxl9rHnMWdpHCZKaI3FasnJmXc9qOU/w=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5493.eurprd08.prod.outlook.com (10.141.175.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 14:41:54 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::842f:3fe:54f9:b18a]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::842f:3fe:54f9:b18a%2]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 14:41:54 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     David Airlie <airlied@linux.ie>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Topic: [PATCH] drm/komeda: Add missing of_node_get() call
Thread-Index: AQHVV2pPVPebZtWZiUahUiy3IZo+PqcIwsGAgAAQOYA=
Date:   Fri, 23 Aug 2019 14:41:54 +0000
Message-ID: <20190823144153.GA30942@arm.com>
References: <20190820151357.22324-1-mihail.atanassov@arm.com>
 <20190823134348.GA27922@arm.com>
In-Reply-To: <20190823134348.GA27922@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::23) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 15483fc3-24e5-4578-e092-08d727d80ed9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM7PR08MB5493;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:|AM0PR08MB4945:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4945FAB951BDC92CEF3561B8E4A40@AM0PR08MB4945.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:154;OLM:154;
x-forefront-prvs: 0138CD935C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(6636002)(6436002)(52116002)(1076003)(6862004)(66066001)(44832011)(86362001)(2616005)(66476007)(486006)(66446008)(66946007)(476003)(11346002)(316002)(6306002)(66556008)(305945005)(446003)(6486002)(6512007)(36756003)(4326008)(54906003)(71190400001)(71200400001)(37006003)(478600001)(25786009)(2906002)(33656002)(76176011)(53936002)(6116002)(3846002)(5660300002)(14454004)(6246003)(99286004)(256004)(229853002)(81166006)(81156014)(386003)(6506007)(186003)(102836004)(8936002)(26005)(966005)(8676002)(14444005)(64756008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5493;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 1jK+a9Ui1yMrxBUjL0ukkF5e516Y13qEvg7uHgnvpecJ90ZuWlq+RDdiAJVL0OCqOmbiuSannLDqgXDYn/M4W0V45I6i4YcR5hdHnmqfYAQAS4miIOpdkJYej4gaHmM5nvO54at0zdNNaHK9V7Eelnzg60MH8SfD25v4kFFJ2nOA1CwkEv7cPnOVK9B1Ui9TDUcG830MPrsUnccNGkB/HNnjLtZE0pyoWLzgML/xqsPhPpTEACeKFajOFS1tCUsSFLxsZRxo1l7vMdk4iE+p40SQwD/rTKWVkFP+suIAnj+hmw0aPBIsET0IdPuTcKVeRKwfP6+sI6s7i7mS5SSED8VCRf/zorgbPvOrZEU8Gl+GRG3C3sZkFa6CvGygjpbpVqmpDwJBQ/OvmCemFIoI3wl5RyLM2zcktVmbu6JWRTU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11AD029DF8A9364E88E757663F247DF7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(199004)(189003)(6506007)(63350400001)(386003)(186003)(229853002)(97756001)(22756006)(36756003)(2906002)(26826003)(6116002)(6862004)(86362001)(8676002)(316002)(4326008)(6246003)(3846002)(47776003)(7736002)(23726003)(76130400001)(305945005)(14454004)(966005)(33656002)(14444005)(6636002)(70206006)(5660300002)(6486002)(66066001)(70586007)(99286004)(478600001)(25786009)(8746002)(81156014)(46406003)(81166006)(126002)(26005)(476003)(76176011)(356004)(8936002)(6512007)(6306002)(2616005)(486006)(102836004)(54906003)(50466002)(1076003)(37006003)(11346002)(446003)(63370400001)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4945;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5c221f92-086a-4322-3cc0-08d727d80aaf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR08MB4945;
NoDisclaimer: True
X-Forefront-PRVS: 0138CD935C
X-Microsoft-Antispam-Message-Info: JoQyVBsh8k7/o/ExKe5p7OABgMdaCC+OKP5x4P6+RuRi0Z4dwNR/Sfh1KehDiu7/f0hmTjuUgNvC0sWQfMNiE8HVzrFnJnExrcbGpCwbu+Vy49kPSYVe2fFNZqzyc0FNMo1SFqOSiM/wryk23YIkInJ2UZLo73grUifkYLFWHK+PIgCZ2m7BlM2T9IX1lSKrOO5auDd/2990W2ya8+uqjkD7QaEOsM/JOydUhPXTk8M2SR2peL8ubleJRnuRvxEl/SomDyrbnYA/zj+h9MhKoaQ3pW4jw4z3r4rQnr17ThXuFevgiD0X6jt05mdJAVfTnTPer5FA/XL2aDfTZUTKTP9i/pSS8urUlgoTBD9CkoZtXGGNwl9bpSOTTeM6cPGk2EG2Ukgrs89Cbde2ATw9jV3DpwUoiNX1+tE2RjTqaqc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2019 14:42:01.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15483fc3-24e5-4578-e092-08d727d80ed9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 01:43:49PM +0000, Ayan Halder wrote:
> On Tue, Aug 20, 2019 at 03:16:58PM +0000, Mihail Atanassov wrote:
> > komeda_pipeline_destroy has the matching of_node_put().
> >=20
> > Fixes: 29e56aec911dd ("drm/komeda: Add DT parsing")
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index 0142ee991957..ca64a129c594 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -130,7 +130,7 @@ static int komeda_parse_pipe_dt(struct komeda_dev *=
mdev, struct device_node *np)
> >  		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> > =20
> >  	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links=
[1];
> > -	pipe->of_node =3D np;
> > +	pipe->of_node =3D of_node_get(np);
> > =20
>=20
> Good catch.
> Reviewed-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >  	return 0;
> >  }
> > --

Pushed to drm-misc-fixes - 51a44a28eefd0d4c1addeb23fc5a599ff1787dfd

Apologies, I accidently pushed the gerrit change-id in the commit
message. Surprisingly, "checkpatch.pl --strict" did not catch the issue.
> > 2.22.0
> >=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

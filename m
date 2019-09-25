Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF23C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51EB21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Hv/iJ2r9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Hv/iJ2r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411839AbfIYF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 01:59:48 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:61585
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411815AbfIYF7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4/w0pL5IokLsy5MZI9XnBSldWZqNoC5W2AIqRQNc6U=;
 b=Hv/iJ2r9E64mjWdCDZ0Gr4Ph2k1fgc0xwfNFRfEvaqF0K1re8Z+or/L1dlYd/TM0FjVfFh+liALDOQVmc6aKBOlGk5og89c/VRJGBbUgcqdYsY68mGG80zy0yZur3AytVFP2KhyLmQc5JQBLpkJJgfXem3SHN7eZq31TLHvcMmQ=
Received: from VI1PR08CA0086.eurprd08.prod.outlook.com (2603:10a6:800:d3::12)
 by HE1PR08MB2892.eurprd08.prod.outlook.com (2603:10a6:7:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Wed, 25 Sep
 2019 05:59:36 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR08CA0086.outlook.office365.com
 (2603:10a6:800:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Wed, 25 Sep 2019 05:59:28 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Wed, 25 Sep 2019 05:59:27 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Wed, 25 Sep 2019 05:59:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 388c28d4e391fd87
X-CR-MTA-TID: 64aa7808
Received: from dce0bc606223.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02F3B035-E903-4083-8DAB-E0D89493FA97.1;
        Wed, 25 Sep 2019 05:59:22 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dce0bc606223.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Sep 2019 05:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9BCPYMnm1fibs48XEBEXtDUXb33lt55PiwjjvmoGATIDvFnehvG0pVooR71HjYudDmh6JomnJfNPPcgUmWYoeis0DyLAfrRctIGuffLJPeHWk2cQp9VVQE5ITkXwhiM/y59UuN/AT4duTy4MH9MCpWNrIgpE8y5IOFxWwTnKR5ByrTRBJUfZWG4Fpu347CFvVvfDKpjNXQl1DWKD0sOyA1tgHFD6KZTnUYe+/Y0qzY0PsIrgFOrkHVvs2LO46gecrbCvl4qxdHskj9AWwpFVj79FUbMoR7BwfWgDihg7RDMD/X4ah85rnLtKy5N8KuHxUw61sfXGLd4H+CauUtOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4/w0pL5IokLsy5MZI9XnBSldWZqNoC5W2AIqRQNc6U=;
 b=lcyxpV7+1Q2643jCY4bMRMopU0SO0XU5xOm6Ad+/a9kcnmOjd2TfbCNR6isZGalQ/97qD1DFvKrW5+Avbp7MG5ak3Hi+Og75IywYO79TBTJqt+Anam6wh3VB2EpYlGF/HxB+FLxRo6DCDVV0vYm19RFxasW1yxdxmimOJB6u0ymaZBPR9QlIP5VGXiH7kY6HcljHUMhA6j/gPM7QMQOOYudTCm3pn7TGUrbGbdipkPbLXGi9hPuIwsw3byviF4nbLsJqeIuoY+FGoUyQMsgxQrgSGye0mwG9KwZfpASxk6syU1XZpE/EQ04yuL/Uq6RrEYWTyx1Eb+pmufXKZ6iVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4/w0pL5IokLsy5MZI9XnBSldWZqNoC5W2AIqRQNc6U=;
 b=Hv/iJ2r9E64mjWdCDZ0Gr4Ph2k1fgc0xwfNFRfEvaqF0K1re8Z+or/L1dlYd/TM0FjVfFh+liALDOQVmc6aKBOlGk5og89c/VRJGBbUgcqdYsY68mGG80zy0yZur3AytVFP2KhyLmQc5JQBLpkJJgfXem3SHN7eZq31TLHvcMmQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4829.eurprd08.prod.outlook.com (10.255.113.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 05:59:19 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 05:59:19 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: prevent memory leak in
 komeda_wb_connector_add
Thread-Topic: [PATCH] drm/komeda: prevent memory leak in
 komeda_wb_connector_add
Thread-Index: AQHVc1n//vysXyMGDEaxrhE/kSCsmac75gEA
Date:   Wed, 25 Sep 2019 05:59:19 +0000
Message-ID: <20190925055912.GA27846@jamwan02-TSP300>
References: <20190925043031.32308-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925043031.32308-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7d5cf295-7e02-40c3-dd66-08d7417d864a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4829;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4829:|VE1PR08MB4829:|HE1PR08MB2892:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2892494E06B92A15EF4B3233B3870@HE1PR08MB2892.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 01713B2841
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(229853002)(76176011)(9686003)(52116002)(11346002)(6512007)(8676002)(81166006)(6436002)(14454004)(3846002)(6116002)(25786009)(99286004)(486006)(256004)(55236004)(446003)(476003)(14444005)(33716001)(81156014)(102836004)(386003)(6506007)(8936002)(64756008)(66446008)(26005)(66476007)(186003)(6246003)(66556008)(6486002)(66946007)(5660300002)(478600001)(305945005)(58126008)(86362001)(7736002)(54906003)(33656002)(316002)(66066001)(2906002)(6916009)(4326008)(71200400001)(71190400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4829;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: oQiPdJDVvAQ3+raflbzjJOOD9f8nBPaVLgu2DYcwPxzytfhbrTK8eksX0b2V1xDX+bopQe6IhC6F7+1lCqOfypJu/H/HvthpiTPDTk+HiPTVgS4Af/uDuF7BHMHaACWeZ6/Ch7AuCH92rd38pYr9OjmyEr9WRKokbgt9xpv9MP0YIzCVSE/9dwqxl3CwU7nlmm54zFd4+VerN25QUo0WgLY7BosZeqKNhUN0LkKmwjNHTFC0Z7Luz4uNRsxlGzw+qa6JlCIUeCcF1TKKqaOF2y+Kh3Zl8ghgHR38t2OtPuK0VIpix3GangcgaLDRptrg2eprWUdydIFi1dwCQiWQcyYzdtrLtqsEYTs6U0XFqZmt7BIBNV/VgF9MIrNjY+V8f1HOYkCjJG59By4VfEStyzgq/cp1nr3c0aaS8rhCXO8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AA98EFFC17CAA419B3A4DEC6035C371@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(66066001)(14454004)(54906003)(47776003)(6246003)(102836004)(22756006)(6862004)(99286004)(33716001)(4326008)(186003)(50466002)(26005)(446003)(316002)(11346002)(476003)(36906005)(486006)(58126008)(336012)(126002)(386003)(26826003)(14444005)(76176011)(63350400001)(25786009)(6506007)(478600001)(7736002)(356004)(33656002)(81156014)(81166006)(8676002)(3846002)(9686003)(6512007)(305945005)(6116002)(6486002)(97756001)(2906002)(5660300002)(46406003)(1076003)(8936002)(8746002)(229853002)(70206006)(86362001)(70586007)(76130400001)(23726003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2892;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58d60162-fcbb-485f-7d2c-08d7417d80fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR08MB2892;
NoDisclaimer: True
X-Forefront-PRVS: 01713B2841
X-Microsoft-Antispam-Message-Info: /FoTlk3qQa9dd00E004vrRhYqS7vjTDFhAvwgyPw0npjduI1LRvYdy4JQMKz2zv7AJGJYf3xHbNsdsh6c5q7Sc639T6RAdnB6ShaEHKDZSAmtye0tZt0syE8k4xYuwAaadoDGH1Mn46HZSMPp5xpBMAVfEFELTzZTHwnkyYdyTVjMTZ33ODwWAbOY3h+8L7gFVJ4i23sIigdvCgdfptFOTBeRGv7TXpgsNLBJ1f3BjnqqUpHskb0VKWkQxinTSWMQ4EbVTmO/I+83XnUO8mOeTGgxFhF9T8DzgfbbVdEvybnyYloUFwnDsmFDx8pDAt5OvTmVMsU9Du+Zfw+i1OqezqgeWlE7yW8rZjAwVEDk/oSqNszOeyTISQ9RK+/dBKMIa3Ala+iOFfkvus2xsfjOReTlgpiPSycz82foQzKdNI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 05:59:27.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5cf295-7e02-40c3-dd66-08d7417d864a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:30:30PM -0500, Navid Emamdoost wrote:
> In komeda_wb_connector_add if drm_writeback_connector_init fails the
> allocated memory for kwb_conn should be released.
>=20
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 2851cac94d86..75133f967fdb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -166,8 +166,10 @@ static int komeda_wb_connector_add(struct komeda_kms=
_dev *kms,
>  					   &komeda_wb_encoder_helper_funcs,
>  					   formats, n_formats);
>  	komeda_put_fourcc_list(formats);
> -	if (err)
> +	if (err) {
> +		kfree(kwb_conn);
>  		return err;
> +	}

Hi Navid:

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> =20
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> =20
> --=20
> 2.17.1

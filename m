Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED30214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vL2sd83T";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vL2sd83T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfHLKTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:19:12 -0400
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:39947
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfHLKTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgRokyRXgBvag74LNZBWLnXA/hzof2HlLf2l9yU8Bxc=;
 b=vL2sd83TNw0IVgDAdCvUswOLBrZM6H/2HSAeBS7KjHgjJdXnkOluUX4Uq7tthlgbMztA85hSZywFO53i2QZQxY86D3rtSQQTyFfeLemTHtRJ6PEZ7CEkDNCeZYJtivhIAgFLrw7u61jiz1LWaDgNIkwj66+PBHG2A8Q0fHM/udw=
Received: from VI1PR08CA0226.eurprd08.prod.outlook.com (2603:10a6:802:15::35)
 by HE1PR0802MB2604.eurprd08.prod.outlook.com (2603:10a6:3:db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Mon, 12 Aug
 2019 10:18:25 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0226.outlook.office365.com
 (2603:10a6:802:15::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Mon, 12 Aug 2019 10:18:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 12 Aug 2019 10:18:23 +0000
Received: ("Tessian outbound 6d016ca6b65d:v26"); Mon, 12 Aug 2019 10:18:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 813c41e795a2f42d
X-CR-MTA-TID: 64aa7808
Received: from 0dec9f8233c3.1 (cr-mta-lb-1.cr-mta-net [104.47.12.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5DC0A41F-4642-43B1-A07D-40CDFAC87404.1;
        Mon, 12 Aug 2019 10:18:14 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0dec9f8233c3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Aug 2019 10:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwkH2ALQS6vdC6PxxAHvVCtyRW4L8b3kOV1Ua9TAeYCUcaSFFRbCdAV3rQz19VrMNAsdxs35uxwe7XGCLBL/UsTq+ZcpC42+A4D24Zso8LY0GSKXzQyC87eG+yWw1/yiztWXh1zBfRyGpK8B5xqzaEelzAbTcKnbIjmZZdCBNPI0kIRq4wIkIZqxAuD0WNp4nAE8B+WnVEuFwxnx2C22h7e9o6PRGbmk91n6AGHTbj8oUDkie9yxJo228IlrH4OifE/JEk4d2BzV6voWrkPLioe0tdM4YiaD54+7Gl1SRnZtnKf3b8R4qa09F9IypPDXPH8P7jjqNhXw9PZ51VEAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgRokyRXgBvag74LNZBWLnXA/hzof2HlLf2l9yU8Bxc=;
 b=H9m/gRMvSzP0wK/B3EjQECTNl53xQzNVkUV4cynu9F1h3hgryzehU/G0WsJP+atwI9P6SKMDDk902xtcg+qA80CjUZddfcEKPXjUVIN/8yW3hQfwB3L6/VGbhL01l3FPY1aFVn9Aqg+Kj0DsSAImp8KoGTX2oSaufAF96Q8kK0X4i92asCM/8x/61Ul/IQGURwSgIQeNc/yhYUAiE2SN4k2x47eHRFSudHEJx9/ebpaFFtMHSUGhu9AmerntzwRBm0dY6e2LSydN84ofrkn/nN5+LAXponRYN/mCmOWh4YjIeQ916m8rGk4FB++MrDjf9jMlPUsEcCssDaKLQH6Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgRokyRXgBvag74LNZBWLnXA/hzof2HlLf2l9yU8Bxc=;
 b=vL2sd83TNw0IVgDAdCvUswOLBrZM6H/2HSAeBS7KjHgjJdXnkOluUX4Uq7tthlgbMztA85hSZywFO53i2QZQxY86D3rtSQQTyFfeLemTHtRJ6PEZ7CEkDNCeZYJtivhIAgFLrw7u61jiz1LWaDgNIkwj66+PBHG2A8Q0fHM/udw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5262.eurprd08.prod.outlook.com (20.179.31.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Mon, 12 Aug 2019 10:18:11 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 10:18:11 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Fix potential integer overflow in
 komeda_crtc_update_clock_ratio
Thread-Topic: drm/komeda: Fix potential integer overflow in
 komeda_crtc_update_clock_ratio
Thread-Index: AQHVUPc+rOyABKz0zU+Ka9N6ADVAww==
Date:   Mon, 12 Aug 2019 10:18:11 +0000
Message-ID: <20190812101805.GA3984@jamwan02-TSP300>
References: <20190812000801.GA29204@embeddedor>
In-Reply-To: <20190812000801.GA29204@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 45db476a-d921-457a-5c11-08d71f0e6887
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5262;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5262:|HE1PR0802MB2604:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26048875C77ABA6ABC620D66B3D30@HE1PR0802MB2604.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 012792EC17
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(199004)(189003)(256004)(478600001)(55236004)(9686003)(5660300002)(14444005)(66066001)(446003)(386003)(6506007)(6512007)(6436002)(4326008)(33716001)(6916009)(6486002)(14454004)(66556008)(64756008)(66446008)(66476007)(486006)(25786009)(33656002)(58126008)(11346002)(476003)(66946007)(316002)(53936002)(71200400001)(71190400001)(305945005)(7736002)(52116002)(76176011)(186003)(54906003)(81156014)(81166006)(99286004)(8676002)(102836004)(8936002)(1076003)(229853002)(26005)(6246003)(6116002)(2906002)(3846002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5262;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: ew0GeRtp7ol15ddFfV4fSVSxMKCN+A+JSGCdXOVQV/P6o9mGOCc+M93y+qFNuYWRrUillRoI2jhGjgVxEUN7hJYk4UKlrjSHnH4zEvcEzZRK7b/NkA7QE4Z25gzE0hksoo6lXe1ZTWuTyca9D463bryAUxNuK9RxU84Clly12KEY/oO+O43g9HpV0pSAdYn71IgEP7QtZ6UlVPfM+LWcOKi0OQSoNeMzc0Vei/7045Gf0upv2sq5LPlkvKgZ5RrxUYfH4Kk/BeLq0WRCJbf2gGoBDp7y2mngmGFLNDcAjtXWi9zczx010PntTx011BzKSVw1NKszaSteeVB16JwZQnEA30cBXwmtMONYqaHz8+qZgNL7tKyU/+44VjNQTSxEfEfAE9WMWhewMumML3Ag1ll2fHl99QsOdjXWzZFyufI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE7B14B9F6B9C2438521F2DBE9603114@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5262
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(478600001)(50466002)(14454004)(26826003)(1076003)(46406003)(356004)(70586007)(70206006)(33716001)(97756001)(23726003)(76130400001)(5660300002)(22756006)(6116002)(3846002)(33656002)(316002)(36906005)(58126008)(8676002)(54906003)(186003)(336012)(229853002)(6486002)(386003)(6506007)(102836004)(8936002)(8746002)(47776003)(26005)(76176011)(99286004)(7736002)(81166006)(66066001)(81156014)(14444005)(4326008)(25786009)(6862004)(86362001)(6246003)(2906002)(63370400001)(63350400001)(11346002)(446003)(486006)(476003)(9686003)(6512007)(305945005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2604;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f6d94a0-2257-4df0-5618-08d71f0e610c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0802MB2604;
NoDisclaimer: True
X-Forefront-PRVS: 012792EC17
X-Microsoft-Antispam-Message-Info: WCIttBV2jG5Cc+WOlnhrn1fpinNZoRaS6HVcoxo6ycTc0053yvbopXm7bpakAFozJ5fL0JFfn/UMEfsJOxVSy9O0wfoHu9hspP2VA+o/ht8SthwYdO1ximLtlR4GI0gCLW5M6kzNAuOxLhPGD7oz5sg33vvMXcFBWcgespq4ZcbGO9CC8ARx+FWBDQ8efJpAcOYgXchViQrwJCkktEvNfY4qWNpnHn6oxAzQ8zpL81dEjV1TzHphqC1N9qx4DS7b9pAGz5EUGEAOdGCFwx5evZNSdiQ1J2QzkcOYrn52zpdA4YK053eOD9kpVPgXiQk0MRZjbvoOKqcHtOcANyoTyuZbEZHa6XGAL7Px5yJdW6r+q2YlLsbLwSyo0Q1jWB3nJuMoW54C3+lwyoLyWIyJAhbnLazz+6seHwXpmxmfYqI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 10:18:23.8588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45db476a-d921-457a-5c11-08d71f0e6887
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 07:08:01PM -0500, Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 1000 in order to avoid a potential integer
> overflow and give the compiler complete information about the proper
> arithmetic to use. Notice that this constant is being used in a context
> that expects an expression of type u64, but it's currently evaluated
> using 32-bit arithmetic.
>=20
> Addresses-Coverity-ID: 1485796 ("Unintentional integer overflow")
> Fixes: ed22c6d9304d ("drm/komeda: Use drm_display_mode "crtc_" prefixed h=
ardware timings")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index fa9a4593bb37..624d257da20f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -27,7 +27,7 @@ static void komeda_crtc_update_clock_ratio(struct komed=
a_crtc_state *kcrtc_st)
>  		return;
>  	}
> =20
> -	pxlclk =3D kcrtc_st->base.adjusted_mode.crtc_clock * 1000;
> +	pxlclk =3D kcrtc_st->base.adjusted_mode.crtc_clock * 1000ULL;
>  	aclk =3D komeda_crtc_get_aclk(kcrtc_st);
> =20
>  	kcrtc_st->clock_ratio =3D div64_u64(aclk << 32, pxlclk);

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

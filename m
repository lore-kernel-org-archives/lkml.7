Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6266C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED11233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VHdIxRpX";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VHdIxRpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfHVK2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:28:51 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:9407
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfHVK2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p6Q7odru/J9uZS71kADmdehKMTksW1nCjp4UQZHLhg=;
 b=VHdIxRpXSvb91rx494f0h/qbUoi36RoBvcq59005TkOKp90kqT6RprUP4tSGa2LSb/omoLzDaK35JH8vRqGqL3LSiWZn5ahxpH7gHBEhG3RwmOnTm2sySUSzdLXlj/wP40DYbNhJdQjbOvm+XU8cilXSBjV/aD/8+ni9Dt551qw=
Received: from VI1PR08CA0112.eurprd08.prod.outlook.com (2603:10a6:800:d4::14)
 by HE1PR0802MB2601.eurprd08.prod.outlook.com (2603:10a6:3:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 22 Aug
 2019 10:28:03 +0000
Received: from DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by VI1PR08CA0112.outlook.office365.com
 (2603:10a6:800:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Thu, 22 Aug 2019 10:28:03 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT056.mail.protection.outlook.com (10.152.21.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Thu, 22 Aug 2019 10:28:01 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Thu, 22 Aug 2019 10:27:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 017bf09d4afc68db
X-CR-MTA-TID: 64aa7808
Received: from a3df77e06e02.2 (cr-mta-lb-1.cr-mta-net [104.47.4.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 75BA95D5-95BB-4392-BA1E-C4B7FBB21310.1;
        Thu, 22 Aug 2019 10:27:31 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a3df77e06e02.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Aug 2019 10:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOmK9ji19w5IiLISTADaP3GVo/Fyy/hlxWi5UulmwJwH3A8YGkvkbJNqmZXkis/B9/YCYg6w3PFLosx6oLgSGZRoxO3bvcJmJ+BvBG2lGxSEpY6Gm+dGQ+Q83KzSK/4kcdYhH0ffSTZU/KcVoJJkGN9z1owvIbsobUVb32Eo4hcljlzfEOG71lj6vMLZwGJ0HYuHx+0zPLKkfe5LpgYkb3FylK9ZwMRNoP4e49mJqwdPdVhuRDdHkGmucwJD12xccz5Ij1us+yofJDyKte4SbTqIaZEJW5Rma1pvGzv7sjbahjtCL+mzC36EvogVPIxUAlY6Hz7a9MNHFRGjbQ1YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p6Q7odru/J9uZS71kADmdehKMTksW1nCjp4UQZHLhg=;
 b=E4+fdz7KTzn6wgcRYXQxMePJikXizSZuQciQfWvYh0TiSsWQ1LVLNS3BiRcXc/aESpI927hup84oZqm7W1llfaRY0//cM6oxRvY4FknkaFW3n2W7n0g4PwWEFTJVUTWH0EpjTMYY9EQNMk6VbXTbGymopbV3zxTnSYX0S2YiQ9k6/G1OuohxE6ISSfLaSyjjJMAltmGrtt7lyBGRF2sn4Rxs2AlJIq+dJwc2opvX52HnD5qFgdBpSQlCJNDpV4PemJIGcjiCFWyXe4VGnWQ+l5d3C0YNDUOWfvSPulfTEwXyvGa7m16lUPj+tKAfKGfyzggB5BWfsLqD21vlkV7dSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p6Q7odru/J9uZS71kADmdehKMTksW1nCjp4UQZHLhg=;
 b=VHdIxRpXSvb91rx494f0h/qbUoi36RoBvcq59005TkOKp90kqT6RprUP4tSGa2LSb/omoLzDaK35JH8vRqGqL3LSiWZn5ahxpH7gHBEhG3RwmOnTm2sySUSzdLXlj/wP40DYbNhJdQjbOvm+XU8cilXSBjV/aD/8+ni9Dt551qw=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.212.135) by
 AM0PR08MB5329.eurprd08.prod.outlook.com (52.132.212.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 10:27:30 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::7532:a9e4:63b6:6a55%4]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 10:27:30 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH] drm/komeda: Clean warning 'komeda_component_add' might be
 a candidate for 'gnu_printf'
Thread-Topic: [PATCH] drm/komeda: Clean warning 'komeda_component_add' might
 be a candidate for 'gnu_printf'
Thread-Index: AQHVUcdq4wh1p5uTvkWo2JsLoFstlacHBNeA
Date:   Thu, 22 Aug 2019 10:27:30 +0000
Message-ID: <20190822102729.GA29026@arm.com>
References: <20190813110759.10425-1-james.qian.wang@arm.com>
In-Reply-To: <20190813110759.10425-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::20) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::7)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 935fd807-d3d9-4f70-d184-08d726eb68c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB5329;
X-MS-TrafficTypeDiagnostic: AM0PR08MB5329:|HE1PR0802MB2601:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26016E4912FE4B56C39A4A18E4A50@HE1PR0802MB2601.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:913;OLM:913;
x-forefront-prvs: 01371B902F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(446003)(25786009)(71190400001)(33656002)(76176011)(6512007)(99286004)(81156014)(478600001)(8936002)(229853002)(81166006)(8676002)(6486002)(37006003)(2906002)(66066001)(6306002)(6116002)(2616005)(186003)(486006)(476003)(3846002)(36756003)(7736002)(305945005)(44832011)(52116002)(316002)(386003)(66476007)(26005)(256004)(66556008)(64756008)(66446008)(102836004)(54906003)(6506007)(6436002)(66946007)(11346002)(5660300002)(14454004)(966005)(6862004)(6246003)(86362001)(1076003)(53936002)(6636002)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5329;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Pp4BzVzMqS5LyWxv4d/QUMGlLlQYaA47y+FxOQ5V6rQSfB2t4wrVec87lxln2kBictDHdO+5F1me+o/VLlJRq9saWWBWVLn2Y5IDkbjSHcefrlEHb6T+oN0dqV1P8NoHDG/6DMBB5bjVSCJuXL+7nOlAAr5acwYoxKMySJ57kF7x7thXtd1/gS/skpSdBAnZ/bghlYKvsoUB/ckWOjpT3W/HrC+iTrtCQtLgRmp1wdz2/6/DEb7lphXC5OjWHrgEO90yZ+6NJkUgQtwNVtVXDRLvlopvXG7fZ/8RJwECJz0DrRUA49OYGcSCNxw9kLxkblOSQnVoW3DCRjyRW9AzW7UaS+xSo9EQMYnhnmcsEMqlwlmoC/LhHt/muDvGR6ncp788tL6JipdgJlhkCOpzNJAiHq2TwzI2uuHiyWw4588=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27C35DDF40879F448F0FEF61E14E3562@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5329
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(189003)(199004)(386003)(26005)(6506007)(476003)(2616005)(486006)(81166006)(81156014)(305945005)(7736002)(76176011)(63350400001)(66066001)(966005)(316002)(54906003)(126002)(14454004)(86362001)(478600001)(97756001)(70206006)(36756003)(446003)(26826003)(37006003)(1076003)(11346002)(5660300002)(99286004)(2906002)(76130400001)(70586007)(22756006)(8936002)(6862004)(6486002)(8676002)(336012)(46406003)(4326008)(23726003)(63370400001)(6116002)(50466002)(3846002)(25786009)(14444005)(229853002)(6246003)(6636002)(356004)(186003)(102836004)(8746002)(33656002)(6306002)(6512007)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2601;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 20de9417-f25a-48e6-0d77-08d726eb5609
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0802MB2601;
NoDisclaimer: True
X-Forefront-PRVS: 01371B902F
X-Microsoft-Antispam-Message-Info: Utg8MKT6Zzu3Bn1kDlSwTqtzp5YL1PvTp8yHaOsv3MdPXXUP2yPQULXqmNK3JNoahUWvoiuFZjnq0+jbj2Hl8aKnF2EYrzlXw9mFJxqzn4F5vXcUGHXwOVaLrTpD/AcNB9FSPCmvGpmfAgTfc+VlqN6A5UtEdRcYux1qLNr3ulthwpFNLN1mHnvsKwO+xVohKIxt5hoLlCJgWbt6jvEupqwQrDbIxbEWar982NEoqpG/qCvHCHJHr85JBC+/Cjc5Nz+J5CumN6XMfh0jdbyHaEhFHPlDOhKF5f6n6QNmtHMM91vvQ3W/IQ4gOTJ4BjomFEObW1GOgPoKj1YVTIPKBZH6deUrmV8ccwsqWvqWQLV6uk50Ci04sa1WjFthnuvIm7BaCGH7+76Sq3SIl+gHihQ2Cveo6/quwvtKqbrDJ1o=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 10:28:01.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935fd807-d3d9-4f70-d184-08d726eb68c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:08:20AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> komeda/komeda_pipeline.c: In function 'komeda_component_add':
> komeda/komeda_pipeline.c:212:3: warning: function 'komeda_component_add' =
might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=
=3Dformat]
>    vsnprintf(c->name, sizeof(c->name), name_fmt, args);
>    ^~~~~~~~~
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index a90bcbb3cb23..14b683164544 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -480,6 +480,7 @@ void komeda_pipeline_dump_register(struct komeda_pipe=
line *pipe,
>  				   struct seq_file *sf);
> =20
>  /* component APIs */
> +extern __printf(10, 11)

Took me a while to understand this and found this link very helpful :) :-
https://www.avrfreaks.net/forum/gnuprintf-format-attribute

Reviewed-by: Ayan Kumar Halder <ayan.halder@arm.com>
>  struct komeda_component *
>  komeda_component_add(struct komeda_pipeline *pipe,
>  		     size_t comp_sz, u32 id, u32 hw_id,
> --=20
> 2.20.1

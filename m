Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ECBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E772084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sS0MdmCa";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sS0MdmCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKLLyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:54:11 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:53779
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfKLLyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bcD1Rn3g/wvU88dm2YkWjdsS0Av12Mb0Z7Kg8i+b8=;
 b=sS0MdmCa8f2R+FnNhN2KoKBKqH7dHWJWg4cLOQxrA7aWlf9tfJ7558HTlvMSomUWPhHXV07JhdJOIVcHzvLnnVEoiTzoZl7fZjN1Q1chs4vYNXMuBnmbxsMfd7Sn5CJcQJnaxjlsyoqRqFXAOYSoRLUr1fCaTeWaSDQZPlSmDHo=
Received: from VI1PR08CA0227.eurprd08.prod.outlook.com (2603:10a6:802:15::36)
 by VI1PR0801MB1694.eurprd08.prod.outlook.com (2603:10a6:800:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Tue, 12 Nov
 2019 11:52:25 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0227.outlook.office365.com
 (2603:10a6:802:15::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 11:52:25 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Tue, 12 Nov 2019 11:52:24 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 12 Nov 2019 11:52:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 990fa87b6722da71
X-CR-MTA-TID: 64aa7808
Received: from e64fda5d0630.2 (cr-mta-lb-1.cr-mta-net [104.47.12.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 651B3BC4-FDEF-4813-9AE5-357136D0C3CD.1;
        Tue, 12 Nov 2019 11:52:17 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e64fda5d0630.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 12 Nov 2019 11:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzoNu+Oy2oTMbnpauQgss0KfpQAZ2dPITJgZvyhdw7skGCEeRku/uSqtVBpeyVCzL9NdXG1Fn1BQnbOTrtRAWzKPh9pu/QEyDJKN3Kgoq3P1MKJjh8gv8JEDCHTMVmV+xgXn6UiUMOGJIne0s9wjJy9kUA06ZfnKigN6/7GOVKfTbgTaRRoIKlsdrCuHzs5jTGAvTXiaVbgqVx51FZAB4RqT+GnNVAV6evOh6u7OCxCLS01MuymGeXdB0P8CcSvmDCCwvvEjuhkT7tm4FpFnpmMoh8+ZGFeyAmmBIQn3BLZCxGH8c2+g3sfZuyBC+xhskZQNbSSbFDkfYP/eGzqK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bcD1Rn3g/wvU88dm2YkWjdsS0Av12Mb0Z7Kg8i+b8=;
 b=VpR3NwRT5Xhmm1PbjEDEowJnC2ifZj3CQbVgs0X0cdUKkhbjomui3mnHWC1zM9PWDlF+XHsqaSP4jwZohZUycSI1IonyG2f7J7DzlA6tIX0m7WdjDAg0sqVGlWdsz78VaxHVCJ9OLUEpaOO1uG3X9+6JH5IVqq9nSpWuTwZeUl08h2rH9zLlynhBL4JBaJozFNJqvn0uZuMY0DcPJZtpLvN6f1O8dlZkrGH1CBOfKTGjCbdulACFbH3/phXFqmB7ndqTcB1kqLllDBctLVGDHhEJrmpnosrAnCsuu5KWQniXwAYMiIUyAnSEgJvW3A1a70bZpEnyu56uZsNWrisN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bcD1Rn3g/wvU88dm2YkWjdsS0Av12Mb0Z7Kg8i+b8=;
 b=sS0MdmCa8f2R+FnNhN2KoKBKqH7dHWJWg4cLOQxrA7aWlf9tfJ7558HTlvMSomUWPhHXV07JhdJOIVcHzvLnnVEoiTzoZl7fZjN1Q1chs4vYNXMuBnmbxsMfd7Sn5CJcQJnaxjlsyoqRqFXAOYSoRLUr1fCaTeWaSDQZPlSmDHo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3039.eurprd08.prod.outlook.com (52.134.30.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 11:52:15 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:52:15 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v10 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v10 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVmUmzadJRLQDUbEqKWZFNceLR8aeHbKuA
Date:   Tue, 12 Nov 2019 11:52:15 +0000
Message-ID: <6272646.IaTXCZQg1I@e123338-lin>
References: <20191112110927.20931-1-james.qian.wang@arm.com>
In-Reply-To: <20191112110927.20931-1-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb0c3694-373b-4f18-9cbf-08d76766c8bd
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:|VI1PR08MB3039:|VI1PR0801MB1694:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB16941B597770C70892FE8E3D8F770@VI1PR0801MB1694.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 021975AE46
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(54906003)(66476007)(102836004)(66556008)(64756008)(66446008)(478600001)(6506007)(386003)(3846002)(6116002)(6436002)(76176011)(66946007)(305945005)(66066001)(14454004)(99286004)(25786009)(229853002)(7736002)(5660300002)(966005)(6486002)(86362001)(52116002)(316002)(71200400001)(71190400001)(8936002)(8676002)(6512007)(186003)(446003)(11346002)(2906002)(81166006)(81156014)(256004)(6636002)(6246003)(14444005)(9686003)(6306002)(33716001)(6862004)(476003)(486006)(4326008)(26005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Sye+loC/mKW6gOJZO2KOEfk6fdkDcSD/x53pTJRM4EEvIw5eA0ITaQLvnuGolYd+z3xXxfM16LnKzYSntq015uYoSKI+X9Wa4iCEgsWnnbN819DK/gMJ0jj+idrHs23AJ2HxAq0wDglU2c6XISEp+4K8LhS+KqggsaQJ+FYqDpGuFAxV0KNKhGpwpSX+ErsGfi3ITRAl2ZeSvHjcDe+834p0PUqbZBg8+UoA6LoJYat8wCp4IEH9djML638HbHPnRK+RawlONolviIB6UFfwrNqfdRzQ15d+hMo+BTuiKdxuOwcnEQfilLoW8OjxzCQx7a1rlXaWChJnNfRaqZJfSf6OammBLcqQMPzaEq7mUSw1u6lpaj1ulWBsM0TSZBWTlK05nlOlUvhxI6vxP0Bat/S6BwcFO4D1C2+Nw9YVja1knMsMe7lbT5DG05ecsCX4sommHiif7kabM2NVs2BDgCfrx/xEsAU6UUj54Llci+o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B99FC4C389AC0645ACAD19F6294BC3A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(346002)(39860400002)(136003)(1110001)(339900001)(199004)(189003)(6246003)(23726003)(26826003)(5660300002)(14454004)(6486002)(966005)(46406003)(478600001)(4326008)(6862004)(6116002)(25786009)(229853002)(76130400001)(70586007)(9686003)(6512007)(3846002)(70206006)(6306002)(50466002)(446003)(14444005)(486006)(105606002)(99286004)(11346002)(81166006)(54906003)(47776003)(336012)(26005)(8936002)(8746002)(126002)(476003)(8676002)(356004)(66066001)(6636002)(186003)(76176011)(97756001)(386003)(6506007)(81156014)(86362001)(22756006)(2906002)(7736002)(305945005)(33716001)(36906005)(316002)(102836004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1694;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f2eb443-86b8-4851-70c7-08d76766c2e0
NoDisclaimer: True
X-Forefront-PRVS: 021975AE46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcT77yy6wcmgxr962rlucrCCQmBtSzN7j6neb9bK07DUXkoTgcwaF6SjeU5jf8GeoDOPpW7kuBlkugq+mXECBeLu6LN1yxhVdtSuNjRGh8Wi7/VW9CoqBMuMj2XtwZz9Vek8C6EQPxiv9uTS6ygf5gqjvQGovlqubhL+QJi7IqS21QKyeWEv8u/hnGPbQOcCXCTHhCnP/cj4G+UBRqey4tf6Zjexm+ApmQR5KUEtmkY6DcdJYJnvjxxlYSkv6KvQl4jwqKR4EZ923EhTnTJHdBSyTnCPTcOWlyMcbr7ZkJnm1cqTtNHdIdfBUQHfTz5Zx3R54Geu2FJSdDObkSG+t3wbVqoglf/gWZg1Q5wM+55q3SHJJIIBnsstIrz3/N5ga76viaRbjUU6z89LYsZUHZjxJ48WGR9JrXy2Jaa6BGyTAI3zD0hIjoy3iKhWf1QgS1TqsaEDTzYRtSMzcureie7DskneyjNkb2EoRXUobhs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 11:52:24.7748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0c3694-373b-4f18-9cbf-08d76766c8bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tuesday, 12 November 2019 11:09:50 GMT james qian wang (Arm Technology C=
hina) wrote:
> This series actually are regrouped from:
> - drm/komeda: Enable layer/plane color-mgmt:
>   https://patchwork.freedesktop.org/series/60893/
>=20
> - drm/komeda: Enable CRTC color-mgmt
>   https://patchwork.freedesktop.org/series/61370/
>=20
> For removing the dependence on:
> - https://patchwork.freedesktop.org/series/30876/
>=20
> Lowry Li (Arm Technology China) (1):
>   drm/komeda: Adds gamma and color-transform support for DOU-IPS
>=20
> james qian wang (Arm Technology China) (3):
>   drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
>   drm/komeda: Add drm_lut_to_fgamma_coeffs()
>   drm/komeda: Add drm_ctm_to_coeffs()
>=20
> v2:
>   Move the fixpoint conversion function s31_32_to_q2_12() to drm core
>   as a shared helper.
>=20
> v4:
>   Address review comments from Mihai, Daniel and Ilia.
>=20
> V5:
> - Includes the sign bit in the value of m (Qm.n).
> - Rebase with drm-misc-next
>=20
> v6:
>   Allows m =3D=3D 0 according to Mihail's comments.
>=20
> v9:
>   Rebase

What's the difference between v9 and this?

>=20
> Lowry Li (Arm Technology China) (1):
>   drm/komeda: Adds gamma and color-transform support for DOU-IPS
>=20
> james qian wang (Arm Technology China) (3):
>   drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
>   drm/komeda: Add drm_lut_to_fgamma_coeffs()
>   drm/komeda: Add drm_ctm_to_coeffs()
>=20
>  .../arm/display/komeda/d71/d71_component.c    | 20 ++++++
>  .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
>  .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
>  .../display/komeda/komeda_pipeline_state.c    |  6 ++
>  drivers/gpu/drm/drm_color_mgmt.c              | 34 ++++++++++
>  include/drm/drm_color_mgmt.h                  |  1 +
>  8 files changed, 141 insertions(+), 1 deletion(-)
>=20
> --
> 2.20.1
>=20


--=20
Mihail




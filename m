Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF8C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ACl8x0ck";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HpNgouNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfJNJ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:58:44 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:50565
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731119AbfJNJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbmp5yY5l22KDnEiwvExVWxyRUqvXQysvfuvfmaDrCc=;
 b=ACl8x0ckSTf0I2FNQUUuw9yLvOrYf+SXg/Ac8glWMFCk0AMH3d3+SO4PYgrakeCL6mbhJYlVsimiu5P6Wi/BRKesOX9XoKnlptjP6Gw2k/DhB02zUPdX7vqqUa6M5VS7kn9yBt9wNEJKq5SSBfsheh1sriYV9Ys83unUJ6dL8dU=
Received: from VI1PR08CA0090.eurprd08.prod.outlook.com (2603:10a6:800:d3::16)
 by HE1PR0801MB1978.eurprd08.prod.outlook.com (2603:10a6:3:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Mon, 14 Oct
 2019 09:58:32 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0090.outlook.office365.com
 (2603:10a6:800:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 09:58:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 09:58:31 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Mon, 14 Oct 2019 09:58:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 54d6b1fa817abca5
X-CR-MTA-TID: 64aa7808
Received: from f1647cb90e25.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EA8AE79E-0D56-4573-A218-75A3FF46F1D4.1;
        Mon, 14 Oct 2019 09:58:22 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f1647cb90e25.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 09:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k31S/TY/JowacD01SCS4S7VxzYshPkVS6Hpwor7f13zT48cSPdmTpEwbMgRO+cskavEBYe+tEnYUQv26IrPzGSJGHMAn/4JCoCKQEgwQNz90yzd9nZ6ppNiCG2AUPzprsFoOInmsh+x/zE3c0dxj95BI06t5Zajy7NV65xPxVtdzhDACsyrTDPTToevhY2OvWAQ/yIO+GqNz4uflX1Rbn8G/p0xQSVSdtUI7cNNpQcNuP86hAG7TBIaa1MRuIG/5+JH80GZCHrIoLi80Thmuf0KI7IuBDhuStJ+hB2fAPYgkgY31dxpnWqtPqP3ffSzlMRdqpcsUKhTinZW/wSQ2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivrX0W/rePfA0VjXeBSGhKgFT13jFR53YTHAi7w3ooc=;
 b=g9MOGDRX0Mz5I5DQ5UCMH8/PgMh3PyYElPkXe/v+9B0FTEvJJpDtpYpdyhRWrTA+hnv2Z27Xt6iRmZ7qycvq2rBddsAzwCLdK+XcbbvhNq0SLhdOoJHXW/3+L1hAvZKMCeytZnb9YhaLZhpAGha90ux60/GAOnSyCDZpOuGggI5BeLdKtesJaOEXthdMFFJheunfFF+GcvSWNPYr6IFNgqhWRsb328k3T2owgfYKU1OP6FOd2hMjFQIt4bJoOxtbuUXnGfRmXTrin9JVf9hCVw0Wm+dJD+D3vAYCMugHBoUudbgJmsqiDrJu1hBwCIaoAs+7K3+07NetYrCqp/HghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivrX0W/rePfA0VjXeBSGhKgFT13jFR53YTHAi7w3ooc=;
 b=HpNgouNa/ITGGMINpd3xHKJvR6Xgc5On9iSwJcebTfvQVDU2lOr+r1kOldOh7HhiSQAb446sHsCefBjb1r926Ebu17fzYForLIoP6MdAu8PUt0w9MYAtw0ZIIafqsh2gRxrNtBEfiUnxH+lT7FCIb0/P5voJjxOn1YuxBaTsBvM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5229.eurprd08.prod.outlook.com (10.255.114.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 14 Oct 2019 09:58:21 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:58:21 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/bDNAzoDxuLVU+by7UkFix6lKdZ2n6AgAARXYA=
Date:   Mon, 14 Oct 2019 09:58:20 +0000
Message-ID: <20191014095813.GA15227@jamwan02-TSP300>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-2-james.qian.wang@arm.com>
 <20191014085605.GF11828@phenom.ffwll.local>
In-Reply-To: <20191014085605.GF11828@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d0309ae0-cb2f-40e8-b3e0-08d7508d11d1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5229:|VE1PR08MB5229:|HE1PR0801MB1978:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1978261AA5626ABE57C59D95B3900@HE1PR0801MB1978.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;OLM:4303;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(478600001)(305945005)(7736002)(3846002)(966005)(256004)(6116002)(6636002)(99286004)(2906002)(14454004)(33716001)(8676002)(9686003)(1076003)(81156014)(6512007)(6306002)(81166006)(66066001)(25786009)(6246003)(33656002)(71200400001)(71190400001)(58126008)(316002)(6436002)(6486002)(64756008)(2501003)(5660300002)(2171002)(110136005)(6506007)(52116002)(26005)(76176011)(55236004)(386003)(102836004)(229853002)(66556008)(2201001)(476003)(446003)(11346002)(486006)(86362001)(186003)(66446008)(8936002)(66946007)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5229;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fnKNND30CDoY9OPkGf+wVKHjzfRvPBgVCI6gF/w1cow3qdVgWguiNKocdwP/86QexiiKJXp2EwZh4mbimnVzN2shxEtaf0pUxKl/TbSH4PWa73OrSPaQ8/i+0W3E86oYZSgSa4vM1k6GGbrn9Eydl8ArEevFDiUHYK0MMchHeXcmUL2kW+0KhZM9u0Ii7qp6kupxmGjRrZgqQy/7dL+N3LoL0TaKg893cMn85HF2Tj7WOGzOhOoDaeVdgnEbfGGGrHxf7BjUECUbL3jAWzzCFQH4YNi+HAEBqG95NHODywiwVZ6zR6pOViQqXqGx2df0/pejcuZPLwT4y05xQL8wjBgdSowkjbE4zcSaj+ZRybT/pq/lVJ6k41u78embbNrcaL7OVd6UEOye0Eg1vZjC8UbTZCK+biOO16ifmhbfKlTFytQv5UbnpNgkHQG1i7nwy2JhuOjVx/IKTFVkgKfnxg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E14DA5AE9F7FDB4CA94BF9940278DB15@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5229
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(376002)(39860400002)(346002)(40434004)(189003)(199004)(33716001)(6636002)(305945005)(36906005)(587094005)(5660300002)(2906002)(316002)(486006)(126002)(110136005)(7736002)(2201001)(86362001)(58126008)(336012)(476003)(70586007)(1076003)(6512007)(5024004)(9686003)(6306002)(46406003)(2501003)(76130400001)(14444005)(229853002)(386003)(6506007)(446003)(102836004)(6486002)(63350400001)(70206006)(11346002)(81166006)(14454004)(2171002)(25786009)(6246003)(966005)(81156014)(50466002)(26826003)(478600001)(76176011)(22756006)(356004)(8746002)(66066001)(97756001)(26005)(23726003)(3846002)(186003)(6116002)(33656002)(47776003)(8936002)(99286004)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1978;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36981c5f-7317-4636-a4fb-08d7508d0b27
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnSlGjKWzAvDC0M6eRr/8WWhprutXdBIKfyhkzJGbLvI0y6ijTv/Aclh0L+JxowcboeunTe8I74tArou/6tSnonpdRDhLNN5Q0xgixs5jExlx6CLrsT5KbB9ckMTEvFcGpo2QP/7rWseKcRb+Y0VcI8nycsW/rdTh1YV4c/XEkjs2Y/hTcoNayqhchwLDSd14Qa4Om03JuHGl1pk7TMjqmB6uYi8HUHba+PJCBYXf5vk4EuwgsW6X6h6G7/faBdX1CyS3j8/NMIX4tbTKr7/+Hk8nqeImvhxid5JLMILCW8kN2JKEA7JRBKMuvS5h8rXtzz3N7pQCS40MUj91LxXO7SxeyNej5+e462ncNLirH4PBWK/88tuwbw/CAV8N9pFYLaEubWkv7Cyoj3om8/GIkfIxPJOQthoPk7Ubib7lv3Qc239lkNELFNUHWStwTlnxapGZtdcpIfuJrj2DVl14w==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 09:58:31.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0309ae0-cb2f-40e8-b3e0-08d7508d11d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1978
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:56:05AM +0200, Daniel Vetter wrote:
> On Fri, Oct 11, 2019 at 05:43:09AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> > convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> > hardware.
> >
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> >  include/drm/drm_color_mgmt.h     |  2 ++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_col=
or_mgmt.c
> > index 4ce5c6d8de99..3d533d0b45af 100644
> > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input=
, uint32_t bit_precision)
> >  }
> >  EXPORT_SYMBOL(drm_color_lut_extract);
> >
> > +/**
> > + * drm_color_ctm_s31_32_to_qm_n
> > + *
> > + * @user_input: input value
> > + * @m: number of integer bits
> > + * @n: number of fractinal bits
> > + *
> > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
>
> What's the Q meaning here? Also maybe specify that the higher bits above
> m+n are cleared to all 0 or all 1. Unit test would be lovely too. Anyway:

The Q used to represent signed two's complement.

For detail: https://en.wikipedia.org/wiki/Q_(number_format)

And it Q is 2's complement, so the value of higher bit equal to
sign-bit.
All 1 if it is negative
0 if it is positive.

James

> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> > + */
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +                                 uint32_t m, uint32_t n)
> > +{
> > +   u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > +   bool negative =3D !!(user_input & BIT_ULL(63));
> > +   s64 val;
> > +
> > +   /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> > +   val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
> > +
> > +   return negative ? 0ll - val : val;
> > +}
> > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > +
> >  /**
> >   * drm_crtc_enable_color_mgmt - enable color management properties
> >   * @crtc: DRM CRTC
> > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.=
h
> > index d1c662d92ab7..60fea5501886 100644
> > --- a/include/drm/drm_color_mgmt.h
> > +++ b/include/drm/drm_color_mgmt.h
> > @@ -30,6 +30,8 @@ struct drm_crtc;
> >  struct drm_plane;
> >
> >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_preci=
sion);
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +                                 uint32_t m, uint32_t n);
> >
> >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> >                             uint degamma_lut_size,
> > --
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BBEC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500ED214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zA42F4+n";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zA42F4+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfJNJoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:44:01 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:41444
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731016AbfJNJoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwHhXvt95GLMYq8v+LyaFwefKl1dUvimCCsOJm2miew=;
 b=zA42F4+nFXt2/teRr364Pu6NQKHBln7KZ7XfJ8Xk609i/aBMw1UUo8YFOvekQWJcJEtMPLKIXMX/Xz2DFA+2dhekZoCksKjbmIAT3QomUKt6zMqqxEo7n79b73i27pSWx+edZ+3Fl+d8OZqTJXADf7i1mlDBVhLuuoUwx2dJzto=
Received: from VI1PR08CA0212.eurprd08.prod.outlook.com (2603:10a6:802:15::21)
 by VI1PR0802MB2399.eurprd08.prod.outlook.com (2603:10a6:800:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Mon, 14 Oct
 2019 09:43:55 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0212.outlook.office365.com
 (2603:10a6:802:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.22 via Frontend
 Transport; Mon, 14 Oct 2019 09:43:55 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 09:43:52 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 14 Oct 2019 09:43:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3e5736c89d469c85
X-CR-MTA-TID: 64aa7808
Received: from ea05d2ded876.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 009FD6CE-8152-4893-A351-13EBEFD9070A.1;
        Mon, 14 Oct 2019 09:43:42 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea05d2ded876.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 14 Oct 2019 09:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgyFpF2T1Fk9I7SHJbpgE7Urwkc0KNPsu5Vw+5Rlt7RxHkYh3ezGGD27gwCKz1cDqZgWyjFIc6EUfHAjmM+82ISPtOrl+cL0lfIm1ugddJJ4xc32ZDx2a6DZiyex+hECltdWY2nsDQimar/pxfTRpXlRR6IHzJeANWG839lxSGOU5+WmhafX/vZgS/C8eUhrxjqzixmUYrIsiVadYAatssxPHBQsPdziJ3btQSjf081HGmiQ2AOESLh2/Qgdw5zkBwmWsE/VvPdEpDIgmB3Jfg3DT1lEGkF/uoFKp2Hf5DftN5U2jN/089sqd5tvBD7MYu1O387ZB9jVOPe+31qGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwHhXvt95GLMYq8v+LyaFwefKl1dUvimCCsOJm2miew=;
 b=ND4JDKq4w4Cb/pi9EsY8qOUcLMP0karaboM/k9AeQnGdHMtj6wGp0pYULj3sfoJkBZZ0HY8EQP9LEPM6C/kpqIj7kmAA0iCkL3bFqA4SB2k9cpPa+aoJ/mvXkppEXQY70BTmiuXeCNg+/vOdR0Z6E1z8hXnq7YUyicaapTgO9ELTr+YnOA4hnRDTCvHEvNC/CYRO8Zk+UaBGYqyiO0b8o6OyoJV3xVlcfLSnfQDsNPUvpB5DxhtJ/KG0oxCrtx8chG7D3LIsqnLbbcgYkbnIPCN3D5ks9JeeqeTmNi2ywTXVzePYCIgsfZ0manhgMnrFTKI9kRSkaB0fpd2eHWfvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwHhXvt95GLMYq8v+LyaFwefKl1dUvimCCsOJm2miew=;
 b=zA42F4+nFXt2/teRr364Pu6NQKHBln7KZ7XfJ8Xk609i/aBMw1UUo8YFOvekQWJcJEtMPLKIXMX/Xz2DFA+2dhekZoCksKjbmIAT3QomUKt6zMqqxEo7n79b73i27pSWx+edZ+3Fl+d8OZqTJXADf7i1mlDBVhLuuoUwx2dJzto=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4781.eurprd08.prod.outlook.com (10.255.114.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 14 Oct 2019 09:43:40 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:43:40 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
Subject: Re: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/cV8wl8pZbk8kmsplok4zd2G6dVG1eAgATMaQA=
Date:   Mon, 14 Oct 2019 09:43:39 +0000
Message-ID: <20191014094332.GA15094@jamwan02-TSP300>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-2-james.qian.wang@arm.com>
 <1622787.6FTe1jSl1W@e123338-lin>
In-Reply-To: <1622787.6FTe1jSl1W@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: cca437c9-8b43-42da-07de-08d7508b05d4
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4781:|VE1PR08MB4781:|VI1PR0802MB2399:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB23995569C1E6EA8FEFB2A611B3900@VI1PR0802MB2399.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3044;OLM:3044;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(33656002)(6512007)(9686003)(66066001)(71190400001)(476003)(71200400001)(386003)(6506007)(76176011)(7736002)(486006)(305945005)(229853002)(446003)(25786009)(26005)(102836004)(55236004)(186003)(11346002)(99286004)(86362001)(478600001)(8936002)(14444005)(8676002)(6436002)(81166006)(81156014)(52116002)(33716001)(6636002)(3846002)(6486002)(58126008)(6116002)(54906003)(256004)(6246003)(5660300002)(66476007)(66946007)(66556008)(316002)(1076003)(4326008)(14454004)(66446008)(64756008)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4781;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: scWtQ5gxG3QR61ygsrric09dtjBuEFHzjqUl2LGZlyi99BQ7udepCEpaZS1eOzWX855Be/9ssONV+VvnYSZl0fTWfQD3ZBMiq9+MSEedxAleYI2BI3cEJHNSdRhAc2vKURmSsUQvTEgAHf1mwGSy1bQYK/4sHW5RhCdMWvqA/jB3HYqfAHMBZvXM65qJTadQHGeg/S6VorR695P8BVxbhYbnJnpDpqQMhLhwngzTJX7gavK0Kjlt4dSkhfP1nKGvlkw/VflzdDpq9RPVK0Oxn9fdpanCqVfrBTv9uS8w9EyHb+JRi6p/klBtH2UK0/Epf9ubJZG9EHVNlNiktuGFD0LI5eYfERz8teiuO3pi9DfRSvh8ggGarsTEtStGwIkoL9aS0wEafxhQhUAG514x0oJPwdxcTjndJOreJkfIe/Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7382987736F7BD4E86B193C4D25E9A02@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4781
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(305945005)(22756006)(86362001)(476003)(126002)(63350400001)(25786009)(1076003)(26005)(33716001)(229853002)(11346002)(446003)(6116002)(14454004)(3846002)(50466002)(23726003)(46406003)(7736002)(486006)(478600001)(5660300002)(26826003)(97756001)(2906002)(356004)(9686003)(14444005)(33656002)(58126008)(316002)(6512007)(6486002)(4326008)(102836004)(99286004)(47776003)(386003)(6506007)(8676002)(54906003)(76176011)(70206006)(70586007)(186003)(76130400001)(8936002)(6862004)(81156014)(6636002)(81166006)(8746002)(66066001)(336012)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2399;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 88f8d0bd-c23c-4678-d397-08d7508afddb
NoDisclaimer: True
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VusNihEOudRV+eghGupSqS3nvSjAvYTj7BalpfiDICewo7N5GvCskeQ9up5NYoKx1OGnKQvJCi55nnr2piWLDjHVLGLrWzGbO8fD0QANircgd3sowGB9+dOE9dQuc0ue8ghG7ojkCT0rTHoLB91rX1DMpYjzhJ1RO0aH94VhiRXipgWFDnyigOY2QmgDN0blZ2QoCJBr/TWhTgdZZyQBT7v9jeKbDJRxYqbn8nMmsvEYA4QczIpvpHbBa5tPCx4RUOCJT1hQClW03C6P+0ImKNAGV5PLu5eD5gh/P8JVW1FVmsxLtCKjyLT093tRZFPuoAUtkPCHqXhyT358Q9FpYbDqo49w9lXWW8oHDW88pEZ8lFUI/X4aIMvBEDhOz9f6f+FFVRQqVpIjh/Sr1tocrTuEne/pFa4hWVeJVFFtTag=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 09:43:52.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca437c9-8b43-42da-07de-08d7508b05d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:26:53AM +0000, Mihail Atanassov wrote:
> Hi James,
>=20
> On Friday, 11 October 2019 06:45:27 BST james qian wang (Arm Technology C=
hina) wrote:
> > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> > convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> > hardware.
> >=20
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> >  include/drm/drm_color_mgmt.h     |  2 ++
> >  2 files changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_col=
or_mgmt.c
> > index 4ce5c6d8de99..3d533d0b45af 100644
> > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input=
, uint32_t bit_precision)
> >  }
> >  EXPORT_SYMBOL(drm_color_lut_extract);
> >=20
> > +/**
> > + * drm_color_ctm_s31_32_to_qm_n
> > + *
> > + * @user_input: input value
> > + * @m: number of integer bits, the m must <=3D 31
> > + * @n: number of fractinal bits the n must <=3D 32

@m: number of integer bits, only support m <=3D 31
@n: number of fractinal bitsm only support n <=3D 32

> > + *
> > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > + */
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +				      uint32_t m, uint32_t n)
> > +{
> > +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> This doesn't account for n > 32, which is perfectly possible (e.g. Q1.63)=
.
> > +	bool negative =3D !!(user_input & BIT_ULL(63));
> > +	s64 val;
> > +
> > +	/* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> > +	val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
> This also doesn't account for n + m =3D=3D 64.

Yes the func is only for support m <=3D 31, n <=3D 32

But I'm not sure, how to handle the unsupport case ?
Maybe just mention it in Doc is enough.

> > +
> > +	return negative ? 0ll - val : val;
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
> >=20
> >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_preci=
sion);
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +				      uint32_t m, uint32_t n);
> >=20
> >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> >  				uint degamma_lut_size,
> > --
> > 2.20.1
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20

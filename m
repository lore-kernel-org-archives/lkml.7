Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1FAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1083B20715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I8YqMMsj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I8YqMMsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLBFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:55:20 -0500
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:12477
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfLBFzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu0ywmh8Op6Pnnx0qa/DnOESAk3onyOlDBKYJfANAJM=;
 b=I8YqMMsjvklNLJoOXQh2MN4zL3gf8R4BbW8abPmX0I934w20J+USKqTiPOc+rlnRJaMAsQwcP5TahQc/Ks7qTuT3A1sK03uTOF1jEbv1eTqLB/wk5LPhZwWJUW1vIv3Nw/Ex2vUhTj29VyB7cBBicwjBqkqi3Q6OqGzauu9UU0Q=
Received: from AM6PR08CA0042.eurprd08.prod.outlook.com (2603:10a6:20b:c0::30)
 by AM0PR08MB5521.eurprd08.prod.outlook.com (2603:10a6:208:18a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Mon, 2 Dec
 2019 05:55:15 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by AM6PR08CA0042.outlook.office365.com
 (2603:10a6:20b:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 2 Dec 2019 05:55:15 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Mon, 2 Dec 2019 05:55:15 +0000
Received: ("Tessian outbound d825562be5de:v37"); Mon, 02 Dec 2019 05:55:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 835ec085f205b74a
X-CR-MTA-TID: 64aa7808
Received: from b07322a0e578.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 775CF5F6-37A5-4908-844D-F6183479093B.1;
        Mon, 02 Dec 2019 05:55:09 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b07322a0e578.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 02 Dec 2019 05:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKVr9nWuIjkcnyGH+3xN4Tr9PPAlo2bvS+ihi8Jt1mW0JycIqg//CKbgK10NH2WjLPpbexoWNcd6FX+lDPJHnoaLmJFAeaWz/xodSdR3CfckOzvBnR9EugIs8u5FnQQTddKSLS201VM4SR5kzws2hdChH1KM4PfkFFtlWhd3Gj0/sKzEHuti1yNDcUvuaAOev7T+i1aKrp2oYidERKQLVjPw7Ssq1WBdnezmOs3+rbj9YG8/U3f5KNKL/3shB1EqQcPPAY+EyQc4N46xqfNkrNHMZjlHUnbkV9RhwFhbYbcpf8QsmlaoLnU7h8xMZ0nDJMR1hZBl6vmhYhuu6tFIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu0ywmh8Op6Pnnx0qa/DnOESAk3onyOlDBKYJfANAJM=;
 b=I03txe1dBGy68jVue7fk67VkPR8apkapiunU+JYHPcebix37gpNW0OZb+8pDKYNo7NEiiP2CqsDxqGbo5so/fQhJiGHqVsXyapRWfKSiEVYHUQ77AFz0SdsBPKEzVom5+9ggDX9v35AU7J8lQtKLyWzjm+IzfjIdFUhXDU0wTKyfxFXxZBcx5y9UZ7cm0i8krIX4o8Ho2GNui9L+eQcebJk3uocMKyNlufG09pd5Rf7WCPItkxn0jIjBRIvJ0NPF/ef2PYXahwD9LYdB4vt3GJv8MY9rLMbxzwj4KBL4LSWRtNK7rvjPJ9mIaDv8usN38uM3OEo5q2baI01iMMqnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu0ywmh8Op6Pnnx0qa/DnOESAk3onyOlDBKYJfANAJM=;
 b=I8YqMMsjvklNLJoOXQh2MN4zL3gf8R4BbW8abPmX0I934w20J+USKqTiPOc+rlnRJaMAsQwcP5TahQc/Ks7qTuT3A1sK03uTOF1jEbv1eTqLB/wk5LPhZwWJUW1vIv3Nw/Ex2vUhTj29VyB7cBBicwjBqkqi3Q6OqGzauu9UU0Q=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5021.eurprd08.prod.outlook.com (20.179.30.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 05:55:07 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 05:55:07 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [01/30] drm: Introduce drm_bridge_init()
Thread-Topic: [01/30] drm: Introduce drm_bridge_init()
Thread-Index: AQHVqNUM0g5O7Fjga0S0liny7wKZ4A==
Date:   Mon, 2 Dec 2019 05:55:06 +0000
Message-ID: <20191202055459.GA25729@jamwan02-TSP300>
References: <20191126131541.47393-2-mihail.atanassov@arm.com>
In-Reply-To: <20191126131541.47393-2-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd796641-9060-439f-e863-08d776ec3439
X-MS-TrafficTypeDiagnostic: VE1PR08MB5021:|VE1PR08MB5021:|AM0PR08MB5521:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5521CF5AB66D4688060929E2B3430@AM0PR08MB5521.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 0239D46DB6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(6862004)(25786009)(6116002)(86362001)(7736002)(81166006)(8676002)(8936002)(81156014)(33656002)(66066001)(3846002)(478600001)(66476007)(66556008)(64756008)(66946007)(99286004)(66446008)(6246003)(256004)(1076003)(316002)(58126008)(71200400001)(71190400001)(229853002)(2906002)(14454004)(305945005)(9686003)(4326008)(6512007)(54906003)(33716001)(186003)(26005)(102836004)(55236004)(446003)(6506007)(386003)(11346002)(52116002)(5024004)(6486002)(5660300002)(6436002)(6636002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5021;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rQMaSN52zmrdiMq8oTdmyf45Tjr+N2/uGoVOx42yaOwhA9jmhymf6KSjTQPlInwwANk1CiDpphtgxWb8pJljyqdcI13okzKgFrPLuHYkY4ZPfjGpqk2Pnl0oE6F2ftL1NBsekJH62btspc7hE/xaCrCEeMcRZLBa7fO3BcOOkpBCaV/LvTuL12wOrFLXenbibxS9HwMFuT/kcaEZ26dT4ogVeXI93XtWxgNUdpl3ePmwyu5SjkYOOxlcVJs32L6zz4kQHbj3yzkqbLhZ4lokhcoa0tXDa4igTMjQ8/0WgcY0ZJo7NL9nItzJxgaaT/Iq+eYLshRlXJUXgiVUIBSMZa/IBx/s6if+RolKvs+wilRRgBtMnS1vYZTcbkbR9sjhgvFyUSzTnIntWQh2MvHeWDQwspml9eae27MEgwKi2hc9+3mixsCHvMKH3EBNguLS
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01F5BB3228854F4EB5681FE677A8A873@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5021
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(97756001)(6486002)(11346002)(316002)(3846002)(23726003)(6116002)(86362001)(58126008)(8746002)(47776003)(33656002)(6862004)(50466002)(186003)(25786009)(7736002)(305945005)(46406003)(106002)(2906002)(6636002)(99286004)(54906003)(66066001)(22756006)(356004)(26826003)(9686003)(5024004)(229853002)(478600001)(6512007)(76176011)(102836004)(26005)(8936002)(4326008)(5660300002)(386003)(14454004)(6246003)(6506007)(81166006)(81156014)(8676002)(76130400001)(446003)(70586007)(70206006)(33716001)(1076003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5521;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a77e7c33-0d44-4183-ef6f-08d776ec2ed9
NoDisclaimer: True
X-Forefront-PRVS: 0239D46DB6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW/dBxAeEczV3JnNmFItF/0hEmLbTq2c3MlJguH69asYAcWrydZMuNxXzU8xKpeE4EKh2/OEi8ia+MiTIWWq0qMazrZ1AC/X5V8jWcw7AO54UdI+NvejU3mwQE50da7oZS2owjmKNFnFeE+RTSObv3AtbRVwmB9f0N0GvFf2GUbUIDPUUMEnVs/FuqX96iFt7vssKWGUMpchKSJn36IapT9Uj50PoK2UyHHZUo9TrXEeb3mfro5n1CdOtt3FmLv/U10r0OOSxIIw7Bp8I1vJ9EFn2Mm5yo8D6xaFP5DhmJplrFU6t/vvtjdGfBDzNxm1N6iiDPXTCSQafA7v76Qt3NhVwo7u7pvuifN7g0msXMiexhTWtbdrSRFFMNh+Th7azouOhb332wMcNNeeknTu/qDO8Z8lVNugjHwVFl29GAC34eBm6XBSGRCFivPkjbJv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 05:55:15.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd796641-9060-439f-e863-08d776ec3439
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> A simple convenience function to initialize the struct drm_bridge.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  4 ++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cba537c99e43..cbe680aa6eac 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_remove);
> =20
> +/**
> + * drm_bridge_init - initialise a drm_bridge structure
> + *
> + * @bridge: bridge control structure
> + * @funcs: control functions
> + * @dev: device
> + * @timings: timing specification for the bridge; optional (may be NULL)
> + * @driver_private: pointer to the bridge driver internal context (may b=
e NULL)
> + */
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private)
> +{
> +	WARN_ON(!funcs);
> +
> +	bridge->dev =3D NULL;
> +	bridge->encoder =3D NULL;
> +	bridge->next =3D NULL;
> +
> +#ifdef CONFIG_OF
> +	bridge->of_node =3D dev->of_node;
> +#endif
> +	bridge->timings =3D timings;
> +	bridge->funcs =3D funcs;
> +	bridge->driver_private =3D driver_private;

Can we directly put drm_bridge_add() here. then
- User always need to call bridge_init and add together.
- Consistent with others like drm_plane/crtc_init which directly has
  drm_mode_object_add() in it.

James.
> +}
> +EXPORT_SYMBOL(drm_bridge_init);
> +
>  /**
>   * drm_bridge_attach - attach the bridge to an encoder's chain
>   *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index c0a2286a81e9..d6d9d5301551 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -402,6 +402,10 @@ struct drm_bridge {
> =20
>  void drm_bridge_add(struct drm_bridge *bridge);
>  void drm_bridge_remove(struct drm_bridge *bridge);
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *br=
idge,
>  		      struct drm_bridge *previous);

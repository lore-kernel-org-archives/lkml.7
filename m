Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E372084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hRLwLv8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCZLIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:08:45 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:21380
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfCZLIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnB6F0b3Kq+w5cO36CoL6V3ohVQONICp7SsiLQFAf4k=;
 b=hRLwLv8IvXlZhmrwix/0V+Y/6qZg69St1nScSBhOAzP2P8U/qmMN8iaXyRSdzFs3v6dOBWe6n9P9NyQBG54GopIq6ohZHGCBCQkqmNTm2z0WDGLnyBdLUhQgjIXRydSFr/meN2/B59GNsW/ot0NiZjFeHfuS9w1yfzd+lZRYX94=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1894.eurprd08.prod.outlook.com (10.168.84.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.17; Tue, 26 Mar 2019 11:08:40 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f%2]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 11:08:40 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH] arm/komeda: Compile komeda_debugfs_init() only if
 CONFIG_DEBUG_FS is enabled
Thread-Topic: [PATCH] arm/komeda: Compile komeda_debugfs_init() only if
 CONFIG_DEBUG_FS is enabled
Thread-Index: AQHU48RER6Bp9yQEpk+fKjsfAL05MQ==
Date:   Tue, 26 Mar 2019 11:08:40 +0000
Message-ID: <20190326110833.GA4135@james-ThinkStation-P300>
References: <20190325170114.20407-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190325170114.20407-1-Liviu.Dudau@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16fde614-a541-41fe-f05e-08d6b1db669c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1894;
x-ms-traffictypediagnostic: DB6PR0801MB1894:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB18944372F70EDBD6D6A33B8BB35F0@DB6PR0801MB1894.eurprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(6486002)(102836004)(66066001)(26005)(11346002)(6436002)(6116002)(3846002)(478600001)(6862004)(8936002)(6246003)(52116002)(4326008)(186003)(81166006)(55236004)(6512007)(386003)(9686003)(6506007)(8676002)(76176011)(53936002)(25786009)(6636002)(14454004)(33656002)(99286004)(5660300002)(81156014)(1076003)(106356001)(54906003)(229853002)(256004)(305945005)(86362001)(316002)(7736002)(446003)(71190400001)(486006)(58126008)(33716001)(68736007)(71200400001)(97736004)(476003)(105586002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1894;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lIXI5tJ7fX7pB06eA1IT4lKYw6w2F1S/0OeLm3e1D6fhMVXG1/X8vHVpF3f0NMy547HXBHTlz+bO9Mm2RxXuJKUvV/cUK2xbaf1rIBX6RCdnmls3wXqxYs9yVlRx95G9dc7RUU4bBeHGmegjmoXOmRRt5TZ2bmfHDPaS5gv3lIK2ReUeNPhzUHjpX3EeMb+ZAN0zcK/Z0L7KedEGp4hw5OvghOChIhod5UjaA8cjXtqySqaCOpgrEeZ8Vc23Ov/FGKjSCyIG/4PYVNUFRg3Gro+TS7jy4+hp1WKJ80BS06oLA+PI0+gx69t1RmDqp/HNL4QuBleNtXEXCGf63DSrZd0qW1OSQgQ03rk8yWB1WW5iGgqZjcDIMkj+puXAmbNg+DAbOHTMeWtapSM3NePYG5CQ472gAK/a4baqJG8BEJU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2B8DD4686B0ED43850DBA69A58B3666@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fde614-a541-41fe-f05e-08d6b1db669c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 11:08:40.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:01:14PM +0000, Liviu Dudau wrote:
> We don't call this function if CONFIG_DEBUG_FS is not defined, but we
> should not be compiling it either, as the declaration of the debugfs
> core functions is not included.
>=20
> Reported by the kbuild test robot.
>=20
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index b420c6205d6bf..24548b87e1827 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -44,6 +44,7 @@ static const struct file_operations komeda_register_fop=
s =3D {
>  	.release	=3D single_release,
>  };
> =20
> +#ifdef CONFIG_DEBUG_FS
>  static void komeda_debugfs_init(struct komeda_dev *mdev)
>  {
>  	if (!debugfs_initialized())
> @@ -56,6 +57,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev=
)
>  	debugfs_create_file("register", 0444, mdev->debugfs_root,
>  			    mdev, &komeda_register_fops);
>  }
> +#endif
> =20
>  static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_n=
ode *np)
>  {
> --=20
> 2.21.0

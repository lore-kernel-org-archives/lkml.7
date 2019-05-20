Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06594C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2920851
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dx4ZniVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfETFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:48:05 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:35458
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfETFsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn3uPf+qsc142rTyjYhchjXWHGnjJejz2pELt7VGsK0=;
 b=dx4ZniVe0r5IZ6gPmeTwc/4LRcD/lstaPtlPjvJlXZrcsN0fUWT479p9gSm7Kz71R4sDHR27R0xU/sz/rlZ7n5ZpmKGyHWIMJGWH0gq0//0b74orllKI4X1teTQo4GFPpse+Iepiwhxv5atmbLrfPnPavYa4a3kd6OCXgWtkltg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4736.eurprd08.prod.outlook.com (10.255.112.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 20 May 2019 05:48:00 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 05:48:00 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Clear enable bit in CU_INPUTx_CONTROL
Thread-Topic: [PATCH] drm/komeda: Clear enable bit in CU_INPUTx_CONTROL
Thread-Index: AQHVDs+VxH/zdzE1+0KX0rb+TfXFjQ==
Date:   Mon, 20 May 2019 05:48:00 +0000
Message-ID: <20190520054753.GA2220@james-ThinkStation-P300>
References: <1557889313-31326-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1557889313-31326-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27855e1e-edae-4bd6-c313-08d6dce6b792
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4736;
x-ms-traffictypediagnostic: VE1PR08MB4736:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB47368733DE963E294CA3AE85B3060@VE1PR08MB4736.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(386003)(14454004)(4326008)(1076003)(66446008)(6506007)(2906002)(6862004)(5660300002)(25786009)(66476007)(6636002)(58126008)(52116002)(76176011)(64756008)(33656002)(26005)(6116002)(102836004)(55236004)(73956011)(66066001)(66556008)(54906003)(99286004)(66946007)(68736007)(3846002)(186003)(11346002)(6512007)(33716001)(446003)(86362001)(486006)(316002)(476003)(229853002)(6436002)(256004)(71190400001)(81156014)(8936002)(478600001)(7736002)(305945005)(9686003)(14444005)(71200400001)(6246003)(6486002)(81166006)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4736;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PmkSqHqFv4TIAEWZIKqOnyB5fz/42fMP0ohW8qBGEO2lbOwNp+9WVU/+pAQ53WJpCNGRqcD/EJQZsR5kliOaY+pv2L+9sJVokdQMVI1Vz2/It0Kn7rrqfq4mhnSuDAmynrfolVjs0MVcGSUkyuzPTUDGxZEFi7bKOZZSr6QLKRMg92OMknJMarmfFu18CE93oSSUga65gov8YtLbDs/AYbRi6yPke6T0IdPbyvayFmSvALyxmgF8cEuUg63KfmCslHmtIqLwadt06c6drD/Dz0Ija5p7IDLtAgix/VfUpuIHaEGeBcI63DLKI3gHxe78N+fEICmx/hiEbBn+TJHXgu7y8sE5Nf/p4+gLUhgWlNdP0lq/G7vXUeaZ9gBX9csJNTHwjcpFw4QH02tdW2ctGUA9JQmfx/hCM6ZtQd/ni9M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60B30D87E134724B96583276AA081363@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27855e1e-edae-4bd6-c313-08d6dce6b792
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 05:48:00.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:02:05AM +0800, Lowry Li (Arm Technology China) w=
rote:
> Besides clearing the input ID to zero, D71 compiz also has input
> enable bit in CU_INPUTx_CONTROL which need to be cleared.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_component.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 1135e38..f8846c6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -435,8 +435,18 @@ static void d71_component_disable(struct komeda_comp=
onent *c)
> =20
>  	malidp_write32(reg, BLK_CONTROL, 0);
> =20
> -	for (i =3D 0; i < c->max_active_inputs; i++)
> +	for (i =3D 0; i < c->max_active_inputs; i++) {
>  		malidp_write32(reg, BLK_INPUT_ID0 + (i << 2), 0);
> +
> +		/* Besides clearing the input ID to zero, D71 compiz also has
> +		 * input enable bit in CU_INPUTx_CONTROL which need to be
> +		 * cleared.
> +		 */
> +		if (has_bit(c->id, KOMEDA_PIPELINE_COMPIZS))
> +			malidp_write32(reg, CU_INPUT0_CONTROL +
> +				       i * CU_PER_INPUT_REGS * 4,
> +				       CU_INPUT_CTRL_ALPHA(0xFF));
> +	}
>  }
> =20
>  static void compiz_enable_input(u32 __iomem *id_reg,
> --=20
> 1.9.1
>=20

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

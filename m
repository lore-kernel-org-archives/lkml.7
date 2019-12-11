Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF8EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4A2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mQs9vctT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfLKKU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:20:59 -0500
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:57792
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfLKKU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:20:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR6SGGeT4PVPpWx7D6pRRN3XsAr422k0W/p9fMhg/LpJPlk+OPDgIfPTfrn9vDyTVK/xJtYpBg6ShYoVH3KmBFi4Cn2Ho5hC7woneKasIWLssxTwiZuK/rR+i2FZtqvCEoVoOzBBStV/2Fd5Jr6JKb8OwY6fObmtavqlVi+EWdbypM0vEQHydUSq0aQA2OTBNeaI6xwvk/eEGQKlC1iFGlg+X6hPSvUKw1UTObUgFI4g4khPfQx6PEJEzs1h8I1lhjkgZdw84BQH8x1YbhxY8uAhHrrM/KATGNLYAr/BLRCcLXPWk1IHRmgqX2/tj1UaFN0bijq/BTxfc2pxl0WrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztugeV2lqUrmlTWU6kw5iEJsvKOXk6clMolLMukLndQ=;
 b=Q+7OT90CQPvCQLHm/pMWNryBY7MdI6/nhdHjC5ywE17VhmDX40ryrVN14s7jL0Az5Q8LueA5kdzuYK8fQCe1OWNRQIrcGaY9QeiY1v1MdiAafP7OHuEVSeaa8oWUt8G5OfXGN68i6QyGSVU7REDO3f9GWipbflxu0qFGWaMVFyBwxexZDZUPdbmQL+EjvEIJt5w4MSOjUD8fAEv2w+fTN1tDUHAinpoHMQFTYVQ8YtXVjx9SKH4WgRGTRv88YKhGAl0qlHfK5WgYD6tkghul5K5hZE2gjuQ3mc5FxHaJ5HWwum1TqccscIREmwQW6OXNqugvHoC4GGDKCapZBZSeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztugeV2lqUrmlTWU6kw5iEJsvKOXk6clMolLMukLndQ=;
 b=mQs9vctTYH+AYRIuut2OrvCL4ZvCzKfSAJPCgsNq+vIFeK2/2ZFg41Ob020YoWhH5V7WfrjeT7MmzMV2orlju762kekRk8Jwi3TkvbncbTTjVe+1KW18ExempTfAiz58x+NbbHR+P5XFKf4ewK09XxVHlcGm3DMFRH9t3mA308w=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB7071.namprd05.prod.outlook.com (52.135.39.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.9; Wed, 11 Dec 2019 10:20:57 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 10:20:57 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: prevent memory leak in vmw_context_define
Thread-Topic: [PATCH] drm/vmwgfx: prevent memory leak in vmw_context_define
Thread-Index: AQHVc1w64ObAevD51UiahaDVPzrR7w==
Date:   Wed, 11 Dec 2019 10:20:56 +0000
Message-ID: <MN2PR05MB6141D12006ACDAD96C2F673BA15A0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20190925044627.2476-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fa0db10-a6bd-493d-3f43-08d77e23cfb8
x-ms-traffictypediagnostic: MN2PR05MB7071:|MN2PR05MB7071:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB70717AB4F96368D1A21E5053A15A0@MN2PR05MB7071.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(4744005)(6916009)(478600001)(91956017)(76116006)(6506007)(186003)(55016002)(86362001)(7696005)(5660300002)(52536014)(54906003)(66556008)(66946007)(64756008)(66446008)(66476007)(316002)(33656002)(8676002)(2906002)(81156014)(8936002)(71200400001)(81166006)(53546011)(26005)(4326008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB7071;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPEDh7Z6c0wJ15O/TKtjeXMzQk58R7qyf9SRWCYfuLYLJ8JyAayMStWI+fhI3BDth7S1A2pZVBWILxt1LJce3nJD/cvGaq+ZDn7WtZVjB3Y6Pas+Qg2jhMGIGGY1UMQmEYepPoaqRABHReXJZ+McWVtlhucSVs5GKOFB2jL+xQl1Trr2vUunv8n0KYwztv2NgLOW0d6kEZz3b8RMfdPelJe82SSIpU5sfoNqEQm7xhwUwCSdTJyZJbtMcTSxiLvu1NdK54zNoYD2ev9wrouzFpV1SMLA2DlXwh/IUKLR7vUMB8bO9qMaM0TWtg2lBUFa74No+kV/X9vAmcGMhbom0HWYqJ1S/xVmiWf1Go2enNidPfbgvCHUPbWHBOnOc928XOFZQG6ipqnzK81DpGL/GdlsM8JWBTxowjc8xdrkhqTWs/btZJPk11XxOe56lj0T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa0db10-a6bd-493d-3f43-08d77e23cfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 10:20:56.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ITpknx2eFMY/Lpr7DSjzr87hNx+6M7elqAvrXIzD7JwWDIhLO4pwOm/z6Tpb4Rqr5sB+FUZUrb6cktXCIBlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 6:46 AM, Navid Emamdoost wrote:=0A=
> In vmw_context_define if vmw_context_init fails the allocated resource=0A=
> should be unreferenced. The goto label was fixed.=0A=
>=0A=
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>=0A=
> ---=0A=
>  drivers/gpu/drm/vmwgfx/vmwgfx_context.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_context.c=0A=
> index a56c9d802382..ac42f8a6acf0 100644=0A=
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c=0A=
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c=0A=
> @@ -773,7 +773,7 @@ static int vmw_context_define(struct drm_device *dev,=
 void *data,=0A=
>  =0A=
>  	ret =3D vmw_context_init(dev_priv, res, vmw_user_context_free, dx);=0A=
>  	if (unlikely(ret !=3D 0))=0A=
> -		goto out_unlock;=0A=
> +		goto out_err;=0A=
>  =0A=
>  	tmp =3D vmw_resource_reference(&ctx->res);=0A=
>  	ret =3D ttm_base_object_init(tfile, &ctx->base, false, VMW_RES_CONTEXT,=
=0A=
=0A=
This patch doesn't look correct. vmw_context_init should free up all=0A=
resources if failing.=0A=
=0A=
Thanks,=0A=
=0A=
Thomas=0A=
=0A=
=0A=

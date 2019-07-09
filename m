Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96443C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6B21670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yXwu/in0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGIQY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:24:56 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1564 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:24:55 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: zq5nIXG1+hmWDqopAW2SsZlZNdGqGrbS7syFp9E8b8nhay8fJxWjVG/nO5UZBVkN8bHiKHAAl8
 MpLqOD6ASftRqloKwdn4WimpXIWu/UimxwzjijOKxCHJvkLVd5RaH9J/l01TbNOzyu1KGMmg9K
 2dlKrFs2mg1+u9Xp+aOhwbpFY7Scqb4uXZ//Xd7uYLO3G9SdPc+B8w4vbb8iP706hdzrXiEyj/
 5PqxIrLivl3L2heVQsMBwLng6Fd6cLJJdCVLAYPm/UCFcmMKcmBCAoas0Z6PQIAoD726pV6jm1
 8yM=
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="37495532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2019 09:24:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 9 Jul 2019 09:24:52 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 9 Jul 2019 09:24:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzpU393+ErV/wSZV5KBYY30BN4kZCxO4qbcA3mHDmhM=;
 b=yXwu/in0Vrs4oBL6HVhKySdRxbf63fYcq4pBv/wlWQv7ynSFjJBfvz1rZfQdgEGSvGfiPMoDamdjTdVMWZgQCGOQBIxjfgYXzMYNaokVrG7iyYqhDr7H/8ytIl1s4T3RKvc1RD3PDL8PzC5GFUPFKwxlL64wXjdaE2uhFrcS7y4=
Received: from DM5PR11MB1658.namprd11.prod.outlook.com (10.172.36.9) by
 DM5PR11MB1308.namprd11.prod.outlook.com (10.168.105.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 16:24:49 +0000
Received: from DM5PR11MB1658.namprd11.prod.outlook.com
 ([fe80::ac00:e9e5:9236:a53b]) by DM5PR11MB1658.namprd11.prod.outlook.com
 ([fe80::ac00:e9e5:9236:a53b%6]) with mapi id 15.20.2052.019; Tue, 9 Jul 2019
 16:24:49 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Joshua.Henderson@microchip.com>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <alexandre.belloni@bootlin.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sam@ravnborg.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable replication
 logic
Thread-Topic: [PATCH] drm/atmel-hlcdc: set layer REP bit to enable replication
 logic
Thread-Index: AQHVNnLUp3D4BDdODU6yB+9d2PU0ng==
Date:   Tue, 9 Jul 2019 16:24:49 +0000
Message-ID: <13aa50e4-a726-3f82-b186-79b452199a02@microchip.com>
References: <1562686509-8747-1-git-send-email-joshua.henderson@microchip.com>
In-Reply-To: <1562686509-8747-1-git-send-email-joshua.henderson@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To DM5PR11MB1658.namprd11.prod.outlook.com
 (2603:10b6:4:8::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62245927-3bd6-4118-01be-08d70489f6dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1308;
x-ms-traffictypediagnostic: DM5PR11MB1308:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR11MB1308F77FDC29F5387E107390E0F10@DM5PR11MB1308.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(446003)(966005)(476003)(68736007)(2616005)(11346002)(26005)(81156014)(81166006)(8676002)(486006)(31686004)(8936002)(186003)(14454004)(86362001)(36756003)(6506007)(386003)(52116002)(256004)(31696002)(99286004)(76176011)(71190400001)(71200400001)(2906002)(25786009)(478600001)(72206003)(4326008)(3846002)(6116002)(14444005)(6246003)(66556008)(110136005)(54906003)(229853002)(66946007)(6306002)(102836004)(66066001)(316002)(53546011)(305945005)(6436002)(6512007)(5660300002)(73956011)(7736002)(53936002)(66476007)(64756008)(6486002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1308;H:DM5PR11MB1658.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 50CNWcAuCXwrGnE9pqzMPizA65j1Si8QXij5ao+SjCvZSM10OwHDgLX03DxlZo7bay5ZZF43LWwuR/ld82NKi5eXf/UnmIl8AWd4Qg0zhaYJJl9htWmIKv+imkVZjkviYAEpD3yhCRbSlhPsBWhfhAxowPRGNPMR/umGAE3gG3CNLo37NGFF2gx523K7y+GCjXVHVmHi4BcO9DL/cLGwtHUoVyA0SLXgBxETkLyJyeGs8LPXkUOTkaL9Fapn74JQwpz9Sc+u/UHaG8eiKw/8alHdUsnZYsT0WLLMdODTBTQcA+wdDS9c5HMQVVRYsASJztjnPMcHZpa1ZTVI97TDENryTQl3fhil2uken7elyi428n12WWG3CxrENAuNHqyUqhA1z7WzcMc2Kcx3rEjY9Jdayuz/yOZuElRLx7E2cLk=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FD2526B8CCCAF349AEF9DF04105D5153@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62245927-3bd6-4118-01be-08d70489f6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 16:24:49.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nicolas.ferre@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2019 at 17:35, Joshua Henderson wrote:
> This bit enables replication logic to expand an RGB color less than 24
> bits, to 24 bits, which is used internally for all formats.  Otherwise,
> the least significant bits are always set to zero and the color may not
> be what is expected.
>=20
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Here is patchwork entry:
https://patchwork.kernel.org/patch/11037167/

Thanks, best regards,
   Nicolas

> ---
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gp=
u/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index eb7c4cf..6f6cf61 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -389,7 +389,7 @@ atmel_hlcdc_plane_update_general_settings(struct atme=
l_hlcdc_plane *plane,
>   	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_HLCDC_LAYER_DMA_CFG,
>   				    cfg);
>  =20
> -	cfg =3D ATMEL_HLCDC_LAYER_DMA;
> +	cfg =3D ATMEL_HLCDC_LAYER_DMA | ATMEL_HLCDC_LAYER_REP;
>  =20
>   	if (plane->base.type !=3D DRM_PLANE_TYPE_PRIMARY) {
>   		cfg |=3D ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
>=20


--=20
Nicolas Ferre

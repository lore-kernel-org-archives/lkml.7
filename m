Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA836C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B084020823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mMZ+c5jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKYJfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:35:34 -0500
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:15106
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfKYJfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:35:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMp/bjpwZF/x7hueK7oiluIYWT0Zwtk9XfDBEbbcGugcvJoFOvPWnMal9K2zumz0BxAlfrkfQ0mm5iTz4vtSynQRcvzd+qeYKv/l0CU4EsNMaenOi0ptfMAih8nLIan/TvUYZWqWxzPl+swlxscxa5YWlLfGLQH/FrxPee72mF5eRwetRa+vou5Gvy9ZvzQPzjNk24mdPRg2FePaEiX1Y8Ny02FEEIcRQdk27Pq5NHDbh8UUZcO5UdD5d33WkMJ8oE3Z4gKVHnJTZdB4AhU6olhoSEaMXk9zrcJMk9tLXq7SJKV6s5bdidYXser2EiMPIekbd6I9xgp8a7RvYnRhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt9SOUBBvRYODrZaBujWY6ol90DM8+mssgncsqlAv7w=;
 b=lElSr+8ifapnhf3xbUsDsrCMDWJg7fUEQ9JbkqoC2PXpa5cYZ0p/KUGwjpINfDidBD5T9Y4qEzJuUOPT/UG6c1unkA8pht9k86nCLduk53ZMGCKlSAsq0AuFcoBMboNnKveoIXaUvqy1UGgGBd12ofRLEUDBBGJbZy+mRaLnL4RNah4npm62zRRoSg90r1GXgp/3v/JszXGDnR/BvZ35Piqle1oYxbHJZxRx1QSgarUcURgT+sGgLeSu9r4XAY4njW/FxPMLYwiSTgp2huU6UFhZloMj8i7nRjy40M662r3Rq8hIDdSfQtS8d3QJvTqKhParpuo3zb6Y5GOMwcF/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt9SOUBBvRYODrZaBujWY6ol90DM8+mssgncsqlAv7w=;
 b=mMZ+c5jbGBWIkQmHGwwhUvqVMBNuzgJEHHJcnqaJPZuYtq48evLiWTUFcBqIPFoxlGEEl3gIl6xvWV8lm2SmlvgXjDXWVHklIFilTW0PXe+cXY4t6OlHyG4hWavR7jlpzfSFwOWycW3KNi9NuVyEehgL1N7OpPKFA6Zk0pKHqCk=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6063.eurprd04.prod.outlook.com (20.179.27.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 09:35:30 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 09:35:30 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: roles: fix a potential use after free
Thread-Topic: [PATCH] usb: roles: fix a potential use after free
Thread-Index: AQHVotK+QWYpBR3K1EiRCSfQT+CjR6ebobIA
Date:   Mon, 25 Nov 2019 09:35:30 +0000
Message-ID: <20191125093528.GC20079@b29397-desktop>
References: <20191124142236.25671-1-wenyang@linux.alibaba.com>
In-Reply-To: <20191124142236.25671-1-wenyang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe38cf7e-c571-404e-b69c-08d7718ad020
x-ms-traffictypediagnostic: VI1PR04MB6063:
x-microsoft-antispam-prvs: <VI1PR04MB606373EF6AF89079717743758B4A0@VI1PR04MB6063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(43544003)(189003)(199004)(9686003)(6116002)(8676002)(186003)(76176011)(7736002)(305945005)(4326008)(33656002)(66946007)(66446008)(66556008)(64756008)(3846002)(8936002)(6512007)(26005)(81156014)(81166006)(76116006)(91956017)(71190400001)(6506007)(66066001)(71200400001)(102836004)(66476007)(6916009)(316002)(54906003)(1076003)(6486002)(6246003)(2906002)(53546011)(6436002)(229853002)(99286004)(478600001)(33716001)(14454004)(256004)(14444005)(446003)(11346002)(25786009)(86362001)(5660300002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6063;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4O7l8bhEsEB1S5W6KTtTB+sf7Ns3UJiWYKF6M0+NKp1pBJViY6DfOYMeJXZqP1Ebq512XuJV6OSrs9KdwzNGbdSY+ijBX0mbV0ymyL3uSE6QwD+oukmfPHCUyyTpEhw79h/EwTXJHrLWHekfNzOY/c/emBPZeUJvDXs7gZ92gYIQ6HlACAv8ClR0Wj1FquF5D1DzuSmKZIzbBJgLRN3bHsrVgb3XRpIUzVTeYW13j1vJ9FCprOXgv4d52u4LiaVC3vOMyGJTX85RBU/lk8Vag7rhJ877SoDaLj/SHXWmnOJ7/mN6TYZRbt1kgpJeALbykVrx8heG8cZPdYj6AqwLSwYfK9efIOSP7QY+o8mqOkVE5y1XBuFjqYrO4vkKRPOiAkzxke6A+OrqOlzvH3SKGiyKwKGUN/HkeDzhD/4e7Qh+PPJm5RLrhvUro0G8Ooi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48D55C999BDD25479D8FBB074CFBCF06@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38cf7e-c571-404e-b69c-08d7718ad020
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 09:35:30.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0NXRlrnuOqRC397xLtDm7HQsle0knmiJts0sEXS4jkV06OYtub4HQfRHqvvPq6PlQ1nXV54Mjxaa5LdGjVZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-24 22:22:36, Wen Yang wrote:
> Free the sw structure only after we are done using it.
> This patch just moves the put_device() down a bit to avoid the
> use after free.
>=20
> Fixes: 5c54fcac9a9d ("usb: roles: Take care of driver module reference co=
unting")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/usb/roles/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 8273126..63a00ff 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -169,8 +169,8 @@ struct usb_role_switch *fwnode_usb_role_switch_get(st=
ruct fwnode_handle *fwnode)
>  void usb_role_switch_put(struct usb_role_switch *sw)
>  {
>  	if (!IS_ERR_OR_NULL(sw)) {
> -		put_device(&sw->dev);
>  		module_put(sw->dev.parent->driver->owner);
> +		put_device(&sw->dev);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_put);
> --=20
> 1.8.3.1
>=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=

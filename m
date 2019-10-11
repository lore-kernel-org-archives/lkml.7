Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1455C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E0214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IT7q9GPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJKFui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:50:38 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:46643
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfJKFui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/A06X+Q3pcwA+jecgV59hkhQDlZxNW791ha2GZ4ShRAA6nqv/9HRHJp53JQ8SUT4Cz+nXuz46SP/L+pGsdW7aujJ9rLssUklso6VWm5RTcDeWVnXeULkJg/GHL2bYMmF+ugSMAMTHthDicNaEpBACFq0bulAUyFlP4BeoXolLcIDNNxhbdKB8eNJqEK7BBOzOpiNW5dAItOc1xGR1JQTBatIoUj4d0t3Zk2WXUaamroZVnqzSUNwAtwGmJ8VkapT8Vo3a4/h5Ezhce32u6eAxoa+7+DhzkQQAaTn+rCEPKz/ccHL+dq1rTpNpgaRrGOOa3bDnGEvBEsBpnfbksgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbg3QkVIOJIFlgTl0YuFgMlU/rq8TKJcHc1Awl+VPPA=;
 b=HzU8CC+iLZ6eCuUQNjgF0UYTJiEUgOSwH1tuhhD7HshJV3pzhqleQa5amkgTvD0vOee0aj/weorD3kEgImXigBKdcQHzLb66ajWnz/1AVVDAJk1+dJkbbJHiBZrC2Ci2fE2XRzNaqYbVnFGfWKHf/0Efl9/q0o3NmXR/FIjnr8F4IPsUAe2ldXbVFrvMiUd6fv75uoCQeWq0+vdAwYRruFhHdqpXRQikCLbvfAFl3tX4feV01ltJxuEt5ABPFIAjupxsC+z6q88sus9YXgPh9GKevKVc9IrbKxA1IQUqwWxW4dPz9Wds62CLARN2yXryCSvNCN1rxnASFbwC1wFY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbg3QkVIOJIFlgTl0YuFgMlU/rq8TKJcHc1Awl+VPPA=;
 b=IT7q9GPtZPmrJ4CODGL8T6duCHE901st4B3r2iqrKj3hJNNJezBZJnKaytclMiJY38ups3WbBQrYKmsAVOzGxEXSpdgehX8aCgyqCu4psruAWwmY9FzRM7x5bm0D/X2wpmgMPcW1PZbNs59MYA22sRsckirayjD3HiosvC0YL4o=
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com (20.177.41.157) by
 AM0PR04MB4754.eurprd04.prod.outlook.com (20.176.215.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Fri, 11 Oct 2019 05:50:35 +0000
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::99b0:3cb8:e409:1798]) by AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::99b0:3cb8:e409:1798%6]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 05:50:35 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jun Li <jun.li@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] usb: chipidea: set mode for usb phy driver
Thread-Topic: [PATCH v2 2/3] usb: chipidea: set mode for usb phy driver
Thread-Index: AQHVf3Kguafv1B6mvkqZ25XYUmZVPKdU8I0A
Date:   Fri, 11 Oct 2019 05:50:35 +0000
Message-ID: <20191011055002.GD4774@b29397-desktop>
References: <20191010135656.3264-1-igor.opaniuk@gmail.com>
 <20191010135656.3264-2-igor.opaniuk@gmail.com>
In-Reply-To: <20191010135656.3264-2-igor.opaniuk@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b77d2de3-4511-4b15-29bd-08d74e0eef8f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4754:|AM0PR04MB4754:|AM0PR04MB4754:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4754A8A3EB74B076023569C48B970@AM0PR04MB4754.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:218;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(76116006)(186003)(33656002)(81166006)(81156014)(7736002)(6512007)(9686003)(25786009)(26005)(44832011)(446003)(11346002)(33716001)(476003)(4326008)(66066001)(486006)(478600001)(53546011)(76176011)(8676002)(7416002)(5660300002)(6506007)(6246003)(99286004)(86362001)(14454004)(6486002)(6436002)(1076003)(71190400001)(3846002)(71200400001)(316002)(229853002)(6116002)(305945005)(54906003)(102836004)(66946007)(66446008)(6916009)(66476007)(66556008)(64756008)(2906002)(91956017)(256004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4754;H:AM0PR04MB5314.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWjGdWuyDASr1+j3LPdgZw8tNCnMXRJXS4C/S8G7CzouCynnoY4jjbsXeGq/ToHZ6qlOWpcvHIqscbzD5Ja0PnFEOSKXhXqlxRmU84DZx+DTAbNFTSyIFCisBwheR0JmJWmz+PjaFg21INuk/wWhCLPEgMi67Lcc5N4uu/UhVnmB8yV795zt8w4TrYKu/SN5ApckORak8cJKyZwwVAhRwbG37DYF1K6mwnK9ugSeXm6J8vePTvl8AMs7pNf638UZqBFu/4n3KYPhscppPGuLPXS9pAowcn3o3Ux69iAdw1nkaHHoJcXDr1adCq+zH8BjNDo8rXj7qFBkpSphY8G0WkhxeLIRW6OocZb/csfOOrviBvIHeEA/hdLz51TFNfmwD6a9SJSSJ024OtMronxSjAJBa7FkzS5Ovj3F480F/Cc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF9446BFCB88624A959B7FBB8156D189@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77d2de3-4511-4b15-29bd-08d74e0eef8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 05:50:35.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6CMRewsFhwesxC3a6gZ3MdSlKooC7mAeKcSQnCfxMSf9B5HZmlXV4HCtK8uLWuowcjiLpPThThqc6BU+jbYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-10 16:56:55, Igor Opaniuk wrote:
> From: Li Jun <jun.li@nxp.com>
>=20
> After enters one specific role, notify usb phy driver.
>=20
> Signed-off-by: Li Jun <jun.li@nxp.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
>=20
> v2:
> - restored original commit author
> - fixed build for multi_v7
>=20
>  drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 6911aef500e9..cf9cc9402826 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -275,9 +275,21 @@ static inline int ci_role_start(struct ci_hdrc *ci, =
enum ci_role role)
>  		return -ENXIO;
> =20
>  	ret =3D ci->roles[role]->start(ci);
> -	if (!ret)
> -		ci->role =3D role;
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	ci->role =3D role;
> +
> +	if (ci->usb_phy) {
> +		if (role =3D=3D CI_ROLE_HOST)
> +			usb_phy_set_mode(ci->usb_phy,
> +					USB_CURRENT_MODE_HOST);
> +		else
> +			usb_phy_set_mode(ci->usb_phy,
> +					USB_CURRENT_MODE_DEVICE);
> +	}
> +
> +	return 0;
>  }
> =20
>  static inline void ci_role_stop(struct ci_hdrc *ci)
> @@ -290,6 +302,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
>  	ci->role =3D CI_ROLE_END;
> =20
>  	ci->roles[role]->stop(ci);
> +
> +	if (ci->usb_phy)
> +		usb_phy_set_mode(ci->usb_phy, USB_CURRENT_MODE_NONE);
>  }
> =20
>  static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
> --=20

For chipidea part:

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=

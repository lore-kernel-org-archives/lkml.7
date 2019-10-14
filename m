Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA742054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FJlbAtTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfJNIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:07:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23289 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfJNIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:07:12 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: UGibkiNXvUrWCamX0QhV/TVfkCUPClDol4r975xAvpWbFkWoyeQsksUUzhASPeKXYq5h88knQH
 dIsQICU744mUQSIzy9g6WtID+A/4p8RzqoY8JC9Ozz8HMZqcGutC+g58WYYKqRP/wtZVwgtlzN
 aWH5ZyTxTeaZccJpNRc/rd4pWZMSMffCZVNrxYe8qI8dPyRjPiJouToeJ5p2GFfsEdUvT3djub
 lYjJ3sJ+GlY21iOK5jPNHZ6cODw7wQQiIX0mhL6UOnMM/UjjW23aRXmJ90sUEdss3EdqRirE6q
 n1A=
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="52825359"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2019 01:07:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Oct 2019 01:07:08 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 14 Oct 2019 01:07:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc9Ab1U3yFO4g4p/9+Y4rgeCwI8OP7B1VWOO/rcQCl8+GssOeZApWVif9BPZyqglYEA5bDI7qj5jTeLyJUm2NT59lnmtlyk4pBmlK+M3F+zMhDJNBRSIy1K5T18bKZG5W2AM+ydAYdILi6zYMJPwiNxo6/tGIPTxxKkt7Epgv6pgH9hjacKtzdAr9bcgdv0UJ3kVXLgeqH5rUTnW9W9XdXtHWPTXSJH+cFztvjE/XhIFxc33L2ux4LQpDnpab5aO85eArw4Ir8OJ+P8Nllhu7oTOqo7qDEL2I+T19RFnbnlc93fOvZ/DUSlsvWeUcVGgpZSKh+jC3MmG6EUnYGD+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69bGrsCcMw9SrK8ASlgWJrARW2eXSNnJcEUg3g8hF/A=;
 b=KA0eiC360Lify4tAcxyuvq3kRWAyqqYKNDqCUK5mSIjjbZBuzsPcDQk0SvWbRRbAtsIj2I38KsXysSVBvcYcFkgVIKCpohUcr+FsB85GGHaRyM6fVk1vGzHl32nG0lMuATwNGBNtrNJRBo45m9gQUXVd8iMVEeU3812h6StaFREHqI0VHMnE/sRQec/7yWLw7xxGgUdtxTx13h595P8U/u59+VV2Pp4Q4wbr76mEugtuBCdyAp27ATHeeGqXJhjtLUhEfFL8ihcr0Nvz1QQGljPY1tBndQKeLPDhdVyUxihZDFQpis7mIP/9O6WMl9rWx2hro0drqIQF3KC2jZ6wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69bGrsCcMw9SrK8ASlgWJrARW2eXSNnJcEUg3g8hF/A=;
 b=FJlbAtTjFOJanN1xR4pU0npzktiPZtVJJBxHzRQROXbJJXHfY7gg8ijdGQQCiVoZf8LIlLiAhU2J1yJzkSMeQw64ZLEQNrOgTomwjZTwGBovnHghCQSi6SyydqXMQOjfWF+A/ArZ5p6a1SRH0p3Ruv34YkJychn6Ii1AfoPBVaw=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1550.namprd11.prod.outlook.com (10.172.53.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 08:07:03 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5d81:aef1:f63:3735]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5d81:aef1:f63:3735%3]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 08:07:03 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <natechancellor@gmail.com>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: host: ohci-at91: Remove unused variable regs in
 at91_stop_hc
Thread-Topic: [PATCH] USB: host: ohci-at91: Remove unused variable regs in
 at91_stop_hc
Thread-Index: AQHVgmZcvPN8nyQjlE2+eKw+69w/ZQ==
Date:   Mon, 14 Oct 2019 08:07:03 +0000
Message-ID: <bff9bdd9-bc3c-e333-7b4a-df53194de06f@microchip.com>
References: <20191011185950.1470-1-natechancellor@gmail.com>
In-Reply-To: <20191011185950.1470-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a7fa174-84e5-4535-c565-08d7507d7f2f
x-ms-traffictypediagnostic: MWHPR11MB1550:
x-microsoft-antispam-prvs: <MWHPR11MB155050286C8463CD0FA023D9E0900@MWHPR11MB1550.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(31696002)(36756003)(86362001)(476003)(2616005)(4744005)(446003)(7736002)(66066001)(81166006)(11346002)(14454004)(8936002)(478600001)(6116002)(486006)(316002)(81156014)(5660300002)(8676002)(31686004)(3846002)(2906002)(54906003)(305945005)(6246003)(2171002)(26005)(229853002)(256004)(186003)(25786009)(14444005)(6506007)(386003)(99286004)(52116002)(64756008)(66556008)(66476007)(110136005)(66946007)(53546011)(4326008)(71200400001)(71190400001)(6436002)(102836004)(6486002)(76176011)(6512007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1550;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ki0uJd5ug6SdS7z95iRgu4psRiZkJa6elxaIITAF1Uh6JTIZ+lu1YOxBRUo4vHi/7RG5Qjvwqgy5t6qbJ0wMZg38eQyrz4fdMyJooN9zBTuJ/qWHkJDrt/m661Vf63PZxgoFHKCK9lwhXAQlTP12NRvBwOiawxdFBa8G6SVVblwVnvTIHwk212MPyMU3z3cuIhyi3yVRiyay686zBdi3qEBO2fA6WxZCWsZ8+QSIjPWGy0wtwXi1z7Swyc7T8zdRCPUCP9zuz3NrOK+ZC8HS9WKhzSAwk+5eMtw2vlYtYseaQsxLnqkXX0Nss0U06gvNQhwh749TGxwfMuHsxu9g7jwiiKcMqrr5EqnpgAMVMgRcSiCyJXNIl5dVJOjvQap9SqKFfrfWByxOuItQd4hQUnbSI/rvZeQ0m9BazYdkdc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F28BCB39B94F694A9D7886C008FC048D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7fa174-84e5-4535-c565-08d7507d7f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 08:07:03.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1f/SbE9mQvxlRdfVMrCYerUbycIYwD9X0MDZGdvjIHQ/1Ien4qS5PQfGaf6JeWIWAgjf1hDe/7IYCPPP3t8EUJ/+2lgzCBjIIQv28rPYK40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 at 20:59, Nathan Chancellor wrote:
> drivers/usb/host/ohci-at91.c:118:28: warning: unused variable 'regs'
> [-Wunused-variable]
>          struct ohci_regs __iomem *regs =3D hcd->regs;
>                                    ^
> 1 warning generated.
>=20
> Fixes: 9c4567fa0a44 ("USB: host: ohci-at91: completely shutdown the contr=
oller in at91_stop_hc()")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/usb/host/ohci-at91.c | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 513e48397743..b635c6a1b1a9 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -115,7 +115,6 @@ static void at91_start_hc(struct platform_device *pde=
v)
>   static void at91_stop_hc(struct platform_device *pdev)
>   {
>   	struct usb_hcd *hcd =3D platform_get_drvdata(pdev);
> -	struct ohci_regs __iomem *regs =3D hcd->regs;
>   	struct ohci_at91_priv *ohci_at91 =3D hcd_to_ohci_at91_priv(hcd);
>  =20
>   	dev_dbg(&pdev->dev, "stop\n");
>=20


--=20
Nicolas Ferre

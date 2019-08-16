Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88688C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5259B20644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mshJJOTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHPK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:27:38 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:16738 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHPK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:27:37 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Cristian.Birsan@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Cristian.Birsan@microchip.com";
  x-sender="Cristian.Birsan@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Cristian.Birsan@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Cristian.Birsan@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: zg3jTBpUON/0X8mJoI0PFYCFvPkJRvh9ilIZVCkJp6s6YVX2vi51xgbkVW9ddLDIphijMaOOYE
 y3tys29uzvxlZFGq2DTemiQgw+Ogu8cTaCbgG/rQmLuRZQnAGFZJjNZxGpfEndzpDtruD9/NUh
 4ZNZ4UkFwTN1mXO4dQ2j23aSQl/xVO1GxCaaaZ7nVVAtUQ2r9//4/kWMmA8XEUmuV795huU8DI
 n9FQ7pBL3bIURlbbWTC4+TT6HMCMd86PxTk1Al4idlXtRbWNMHkoeD4wHbaPxD2hEonBcLRb0J
 fO4=
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="45409549"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2019 03:27:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Aug 2019 03:27:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 16 Aug 2019 03:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVBW1+G5+lX5fgNK7on39qjsXUl6eCP+rvrLsKLHziqvD1NAIITzFXRNdC/Zf4TT9VuwQ28unWYgpG2eoyeKbj5Cd5D05uUYO58qWcR3ZBphkFGrgU+H0xVFwH1mp5BCAOnj0NcUEu421CUlXc19E654xaOamkeKpp6dZYjVa/UfL/1gA3Icn+goldCZT6iNI+KiKLx0vTc7kGR2GTxPcJFdV3IAqDPKk5t/X4GA4peqPw3fc9ND7tuyhj3vEFtKTWxug67TTLIezJMLTSJG1eJwLxDe5eY2kTv+Ams2kYdGgW+zie4/YvaF+EBBsAMJ3KCGoGj9+szShTFUURg4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQKqN1RotLKLgFBibrKSRIPIFYn8RPO3qMhXwUVLFAw=;
 b=DL9MsK5N+EHG1VcQt9QPWuHQcJnuVWIxGhzd/HXka2yu39LNTdMVB2/3ZvymhzkHRGWtpmz8LanLlCf/7dM3ZEqnEDmAf2zmR0Vx08GOgrDGIc7os9TXAx5tSyPljIwu/1czHWQzze84sKHLzoem82i0fpYNp3GAMLwMwbgYIsgvl2RnAIFAtaRnVs4K+pkHLBKF2QduP+pkRo/jBW+f968W+HzAkB5Mjeqz2exTX7PnnSC7zdPHDuVMkbyxL8bh7qNyhrzwSuKPRrzqrmEFIGbqRxZbhjJtDSy5Mwi48qOQzGQUiVEzw6kOygRzCBlgQFjctTMsrl2cAlAflWvJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQKqN1RotLKLgFBibrKSRIPIFYn8RPO3qMhXwUVLFAw=;
 b=mshJJOTtwEz8652R3bTSgQ3oCfwX3NsmR3Awjx1B5GneMqDPYX4pm5hMFs/g1wm6fomHDmnPpleIcfNFqxuJbxqDgPiCzQSmTu2W4pn0GV1y1dKLq7A6eK1V4jBwqv6fr3+LGtBQnzPK1HMidjw1Zs5BRUqYB88Lu8zr7WCcJHI=
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (52.135.227.33) by
 BYAPR11MB3302.namprd11.prod.outlook.com (20.177.185.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Fri, 16 Aug 2019 10:27:34 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::5da2:303:52db:b397]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::5da2:303:52db:b397%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 10:27:34 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <gustavo@embeddedor.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: atmel_usba_udc: Mark expected switch
 fall-through
Thread-Topic: [PATCH] usb: gadget: atmel_usba_udc: Mark expected switch
 fall-through
Thread-Index: AQHVS757Fmd4DRrnXkaGR2hwuzpkNqb9ocmA
Date:   Fri, 16 Aug 2019 10:27:34 +0000
Message-ID: <b0344a15-f0bb-df6a-22a9-36bf432cca3b@microchip.com>
References: <20190805184842.GA8627@embeddedor>
In-Reply-To: <20190805184842.GA8627@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [94.177.32.154]
x-clientproxiedby: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To BYAPR11MB2647.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816132325501
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51859a9a-d77e-4f28-6f35-08d7223459f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR11MB3302;
x-ms-traffictypediagnostic: BYAPR11MB3302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB330225500B0741ECD78BA00AEFAF0@BYAPR11MB3302.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(64126003)(31696002)(66556008)(99286004)(186003)(66476007)(6636002)(6116002)(66946007)(71200400001)(71190400001)(7736002)(305945005)(6486002)(26005)(86362001)(52116002)(4326008)(25786009)(6246003)(76176011)(229853002)(65806001)(36756003)(6512007)(6506007)(6436002)(102836004)(65956001)(53546011)(53936002)(446003)(386003)(4744005)(256004)(2616005)(478600001)(486006)(11346002)(66066001)(476003)(3846002)(8676002)(5660300002)(31686004)(14444005)(8936002)(81166006)(81156014)(110136005)(65826007)(58126008)(316002)(14454004)(64756008)(66446008)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3302;H:BYAPR11MB2647.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pUTHbjs9VHMknr8wmgFSwt1Mw+wOgdc4LBLwn2lRDfTACNp/VHeCQAaSwWFAnOoskbc2rofHqjz2S6Lr1LutUxODiykIcI/8dCqPNyEveeVTVMrZUBfS67BDi9MbOLe///gyEvxPkiOSl39e1uZmMbUfw6INqCx40ORoTEB1w3lmgKeZ5sO3tvzMN7qTQDrocVaxtU55ppDDTf2CIZ/epS9A5nUMtsDUFDkOm1aIGXVrqvb4iIEwy/kzoS71cBb+M2iH5rKTNkdmKCSzjw5tBRCi8NsfvJi11M8CyF/KmUposjgC4gHmcx+iDj7qn3P+TsUVzXxiPzmWt7mfYiPiSLqpYQdFHtr5RlqdCAyy7e4xonMczhe/2JxMX/MInQg9tPnZFgZ+BhUTlSk83wf+6TugkRoe68/rY7RQw6mtJTw=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4DEBB27B2F87FB42B93FE99C0696AC65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51859a9a-d77e-4f28-6f35-08d7223459f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 10:27:34.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSEWdAgGUOM79s0NTq0ejfsTKS5zX/e2WZ/15TEGsPYWpkocKXZa473IafHJxLBCBRhQ8slxNm5V7qA6Dtt0udbSODFx9XL/2VxfTTYq6kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/19 9:48 PM, Gustavo A. R. Silva wrote:
> External E-Mail
>=20
>=20
> Mark switch cases where we are expecting to fall through.
>=20
> This patch fixes the following warning (Building: at91_dt_defconfig arm):
>=20
> drivers/usb/gadget/udc/atmel_usba_udc.c:329:13: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Cristian Birsan <cristian.birsan@microchip.com>

> ---
>   drivers/usb/gadget/udc/atmel_usba_udc.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget=
/udc/atmel_usba_udc.c
> index 503d275bc4c4..86ffc8307864 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -327,6 +327,7 @@ static int usba_config_fifo_table(struct usba_udc *ud=
c)
>   	switch (fifo_mode) {
>   	default:
>   		fifo_mode =3D 0;
> +		/* fall through */
>   	case 0:
>   		udc->fifo_cfg =3D NULL;
>   		n =3D 0;
>=20

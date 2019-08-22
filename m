Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F73C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB6720656
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YudYopLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbfHVRz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:55:59 -0400
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:16290
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731231AbfHVRz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWhqdInEk6uyTla1GtvG8XjmJaAB1cAwjRwXKcY5J9Zx+QcXfxEEgkamozh6BTsSDu2bWTb3WPcArnCu4rzUe/Wux7H/+WtlyK4wJHNyaFRhYDXzBfPcTpnf6bhDiGIn40k5aDbLOKGB4AKbRkDlorQ4EcbSNVz7lpvVmQZLunbolbUAAUHLXGTO29ERBSGoWO56rEGKq1UwXuSQBz5If4Ot8NI7tTzwz57Q0w68Rr8iPLfY/AIlf9bm1JKPnmfK9xF+dfUyLVksgD/g9pxzlsc6X9bX/fuw1tZ1/mQpiu9S6UBuZwkr7iyrf5WLFxcLH2sCEE08/+GoTQCeLHd8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYzMgoAN6NM14VPhIBwd7Ai1RxoPcCeqbOgf/MFgI4E=;
 b=TQx53JHiJW3DCZ1oeaPy1VaDcHhS8xnoqaonaDrIswpuRaeKOQFrlcnPGYsCC73QkYiMTMyZiBULoheQwsfxKSKyxqTnJ0CiNjYUyvQFQUOOxuEZRAfV455dD24HJTrurv8typtNHk5m1B4hNFXJot72K6e0yshEgjORHeJqQ2Lf26PJoo/ZkqBLa6YAFRzfZuacfxn+cOHj2q6X0/gnGfQbbzyPt4kgzqnNLeqOZA8uvYcRM+6U2PTLjeZgUI+8eqll+pW6WvLaZnuOLmmx0T9tVZeLkbYnHnSAATQga5+E3PjCtJ0goyDaf5tEqoJGGcFwjYM0aPFhnq9LIvkgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYzMgoAN6NM14VPhIBwd7Ai1RxoPcCeqbOgf/MFgI4E=;
 b=YudYopLterMA57das8r08ksidURXhV4O9/LENu4xtyD4wa+CjOX3oyd2OrZaZVtdNSiE1pnOtmqpor889uJLlhjIv+JJX3MUeUGxQQDkMVbg4lnjTbF8WA7x1Wl6VHyG5mvyTXIbddnxyeyUNJ/J/rpUY35qLZHp8uQaNdFeBAo=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6984.namprd02.prod.outlook.com (20.180.11.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 17:55:54 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 17:55:54 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Derek Kiernan <dkiernan@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 4/4] misc: xilinx_sdfec: Prevent integer overflow in
 xsdfec_table_write()
Thread-Topic: [PATCH 4/4] misc: xilinx_sdfec: Prevent integer overflow in
 xsdfec_table_write()
Thread-Index: AQHVV++vOnMFcLNfRkOFJ6N+dUEQ/qcHdYPA
Date:   Thu, 22 Aug 2019 17:55:54 +0000
Message-ID: <CH2PR02MB63593CB2434AC146D841E56BCBA50@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20190821070606.GA26957@mwanda> <20190821071122.GD26957@mwanda>
In-Reply-To: <20190821071122.GD26957@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a510962-e8db-4662-7053-08d72729fa8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR02MB6984;
x-ms-traffictypediagnostic: CH2PR02MB6984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB69848E24700568880E2E42CECBA50@CH2PR02MB6984.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(13464003)(189003)(199004)(6246003)(86362001)(11346002)(486006)(446003)(8676002)(476003)(6436002)(26005)(99286004)(3846002)(6116002)(81166006)(7696005)(6636002)(71200400001)(229853002)(66556008)(66446008)(76116006)(316002)(64756008)(66946007)(55016002)(66476007)(9686003)(305945005)(14444005)(14454004)(256004)(66066001)(52536014)(4326008)(102836004)(81156014)(110136005)(54906003)(2906002)(74316002)(478600001)(53546011)(6506007)(53936002)(186003)(33656002)(5660300002)(7736002)(71190400001)(8936002)(25786009)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6984;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YUnQRQfC1vj61Fqx/TEprCeMDb/DYllytgqfn9+jmbCdKINjDSpqmo5HD6JpcS4wcFpO3Em3jComXMkylwPxc3CD23PL3cI0xOegF4FUa6sf14wZjGEOhvoI8FDDPKG0FuKyhX1ALcMDpNALe/EyA5N2HkeiKtCe8qbZTfSSG4kF7ZZSmJu/oGCGZXegwqQbZLOV83COk2r5pmY3aRzAzW/+YnKIIL+DX+4LLBfmb/jzECqhYHpvlO+lVnsEHNato1EfFNfGv70o3T9hwpK6XHkJWVysSLmbwUq07OOgY6lGH3cPiHfcyOc2RmZdhww52UV0b8DuOFC8KrSwmflTxWZZAn6P1B/p5Mz9Fzrk8gD4ejBwPaqCD+n0GWifGTe9eNoMIsA7rGESSpnkWjUBHlZtwIHQYcnNWGbR8k/SlRo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a510962-e8db-4662-7053-08d72729fa8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 17:55:54.6245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLpLINQjkgQQrDVBo/HcMlEi6QxwWlK6+I+KO+UY3Thqaq/DoS41Qs0Ql2ICG1P00kiMlF3CNTkQ94Ony8pMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,


> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday 21 August 2019 08:11
> To: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>
> Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org>; Michal Simek <michals@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kerne=
l-janitors@vger.kernel.org
> Subject: [PATCH 4/4] misc: xilinx_sdfec: Prevent integer overflow in xsdf=
ec_table_write()
>=20
> The checking here needs to handle integer overflows because "offset" and
> "len" come from the user.

Good catch, thanks.

>=20
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 3fc53d20abf3..0bf3bcc8e1ef 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -611,7 +611,9 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdf=
ec, u32 offset,
>  	 * Writes that go beyond the length of
>  	 * Shared Scale(SC) table should fail
>  	 */
> -	if ((XSDFEC_REG_WIDTH_JUMP * (offset + len)) > depth) {
> +	if (offset > depth / XSDFEC_REG_WIDTH_JUMP ||
> +	    len > depth / XSDFEC_REG_WIDTH_JUMP ||
> +	    offset + len > depth / XSDFEC_REG_WIDTH_JUMP) {
>  		dev_dbg(xsdfec->dev, "Write exceeds SC table length");
>  		return -EINVAL;
>  	}
> --
> 2.20.1

Reviewed-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Thanks=20
Dragan

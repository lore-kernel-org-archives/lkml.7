Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFBC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0689021721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sma.de header.i=@sma.de header.b="lYu6zeYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfFSUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:42:13 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com ([40.107.8.129]:30070
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfFSUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4r5QD766sOZQuGqSfvpvPbibSOcbyz0qH1MFqqa8KI=;
 b=lYu6zeYMM3tyBOr2dtem+eAbd41IaJMt0KUpPCv3GYbstS09JHIo4g5P6/5eQr6UvD+3RqVm2gCmphG2aY28Bd4ZKgrdw+JsvaCegSlOVfRawRigFPY0hR6keoCsfnqQwlCEh+HrCjjo3VF6yeH1SdQEFYmWCp+dCTOeLPoTn2M=
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com (20.178.114.156) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (52.134.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 20:42:09 +0000
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::542a:ddc6:d453:1cbf]) by AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::542a:ddc6:d453:1cbf%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 20:42:09 +0000
From:   Felix Riemann <Felix.Riemann@sma.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2] regulator: da9061/62: Adjust LDO voltage selection
 minimum value
Thread-Topic: [PATCH V2] regulator: da9061/62: Adjust LDO voltage selection
 minimum value
Thread-Index: AdUm3QeB54lUFgggQ2yizx2Lz7Rw5Q==
Date:   Wed, 19 Jun 2019 20:42:09 +0000
Message-ID: <AM0PR04MB54277574167351CD6FD2AECB88E50@AM0PR04MB5427.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Riemann@sma.de; 
x-originating-ip: [93.209.170.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 186650cf-6e7e-4ede-5f39-08d6f4f69978
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR04MB4114;
x-ms-traffictypediagnostic: AM0PR04MB4114:
x-microsoft-antispam-prvs: <AM0PR04MB4114D724C41399FBDA1D9B4788E50@AM0PR04MB4114.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(14454004)(6436002)(66476007)(66446008)(26005)(66946007)(7696005)(73956011)(76116006)(54906003)(64756008)(66066001)(99286004)(6506007)(68736007)(53936002)(316002)(6916009)(52536014)(476003)(4326008)(74482002)(25786009)(6246003)(102836004)(86362001)(72206003)(66556008)(6116002)(8936002)(256004)(71190400001)(486006)(186003)(5660300002)(8676002)(55016002)(74316002)(2906002)(7736002)(229853002)(33656002)(81166006)(81156014)(75402003)(305945005)(478600001)(71200400001)(3846002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR04MB4114;H:AM0PR04MB5427.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qmh3WPmwcttA4ZjuStgIraSmZe2B0NODRCxlyGkms0InnRYvNKErZOvaOS4cogvA0QkwCZ1Vx/IlMu4O6e//TSdN8JRD16u3Rke/aWR/pnoHTEn8wAmW3cb3VeAqc3ULy7W1lONLIoWiAK8hdLpXL+NZv91rfGXdUJvJ7VgrQoYC0NKa3zjNpTzPhGirJ11Su9NJ2yYWXTSZ6EmrTOmpQ/T0+hfJMrZAI95yLE1gtwMU+6cDCFz25jTxRKj/3QrOtdlGBvJSmkPfqs+o0zanOQ34TFu+aBdbr4CQsQ+ZCUzcjbsmZSbyBySAsb+nhjZxaV4kgZMLj8YoQJtMw8O7lhu4qgN8u0aiMdTFcXyb3gFFbOmHOYE6URxKtyIRTYVfjY3DhIIxoiBPLm6M+9+pEnf8eOYN31vTximcsdTUzwE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 186650cf-6e7e-4ede-5f39-08d6f4f69978
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 20:42:09.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riemann@SMA.DE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

>
> I have taken your previous patch, fixed the whitespace like we discussed
> and updated the commit message to add more details. Also, I have
> simplified your original patch slightly by using a single define in the
> include file instead of repeating the same value for each LDO[1-4].

Thanks for taking care of the whitespaces and the commit message.

> I've finished my testing for DA9061 and DA9062 and so I've Acked your
> patch and added a Tested-by tag. If you are happy with those changes to
> your patch, I guess you can let the Maintainers take a look.

Yes, I am. I  couldn't spot anything problematic in your changes so far.

Regards,

Felix



___________________________________________________

SMA Solar Technology AG
Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert
Handelsregister: Amtsgericht Kassel HRB 3972
Sitz der Gesellschaft: 34266 Niestetal
USt-ID-Nr. DE 113 08 59 54
WEEE-Reg.-Nr. DE 95881150
___________________________________________________

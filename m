Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B34C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F20217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brtchip.onmicrosoft.com header.i=@brtchip.onmicrosoft.com header.b="EonrR1Tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfDJI4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:56:19 -0400
Received: from mail-eopbgr1320138.outbound.protection.outlook.com ([40.107.132.138]:7344
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfDJI4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brtchip.onmicrosoft.com; s=selector1-brtchip-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN4OMzVGx1pIMq1o1OAUXIRt1R8rx8h2Q0rnmMLNosk=;
 b=EonrR1TwM6l2/Fzge8VpWKoHmVEsS9cLQdPFKGagIUZIggtuBMDURDSnxYBZSswSGuaRm0h4/40Q7lDEmArYEkFf4q90lxtFIxgVecUcIn6Sw9T5JKsKcOG+JItBoirkzYl6ygTwP+FToS3JH3aXyOwz/bm0LC5ISGebmmMyej4=
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com (20.177.171.75) by
 SG2PR03MB3340.apcprd03.prod.outlook.com (20.177.12.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.11; Wed, 10 Apr 2019 08:56:12 +0000
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::2d63:4333:ba1d:dd5c]) by SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::2d63:4333:ba1d:dd5c%2]) with mapi id 15.20.1792.007; Wed, 10 Apr 2019
 08:56:12 +0000
From:   "Ramachandran Srinivasan (BRT-SG)" <srinivasan.r@brtchip.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Deferred URB submission for timesharing the DMA channels
 of DWC_OTG host controller in Raspberry PI
Thread-Topic: [PATCH] Deferred URB submission for timesharing the DMA channels
 of DWC_OTG host controller in Raspberry PI
Thread-Index: AQHU7gHBOqV8wADqX0uU8sxQzGaCe6YyPX+AgALc9wA=
Date:   Wed, 10 Apr 2019 08:56:12 +0000
Message-ID: <20190410085608.GA13848@brtchip.com>
References: <1554724399-2972-1-git-send-email-srinivasan.r@brtchip.com>
 <20190408131245.GC24108@localhost>
In-Reply-To: <20190408131245.GC24108@localhost>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KL1P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:802:2::34) To SG2PR03MB4165.apcprd03.prod.outlook.com
 (2603:1096:4:3d::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=srinivasan.r@brtchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [118.189.144.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 481cdb4f-d0a1-4f24-ca51-08d6bd926151
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR03MB3340;
x-ms-traffictypediagnostic: SG2PR03MB3340:
x-microsoft-antispam-prvs: <SG2PR03MB33407493AA35203A018571E99B2E0@SG2PR03MB3340.apcprd03.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(8936002)(256004)(81156014)(6486002)(486006)(508600001)(14444005)(4326008)(476003)(6246003)(33656002)(68736007)(6512007)(25786009)(11346002)(2616005)(8676002)(10126004)(53936002)(36756003)(186003)(6306002)(6436002)(446003)(53376002)(229853002)(7736002)(305945005)(81166006)(105586002)(6916009)(71200400001)(71190400001)(4744005)(102836004)(6506007)(97736004)(106356001)(386003)(66066001)(86362001)(316002)(99286004)(5660300002)(2906002)(26005)(14454004)(54906003)(1076003)(6116002)(3846002)(76176011)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR03MB3340;H:SG2PR03MB4165.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: brtchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b0c2VSMycCcsLPuRd+C9hIuWvPGsixuj2YNBiO9pTU7tPahxxxh6AwJwKL/p5zypJ7YR9boBNrOAxC6VCSxxkP6uE/+n6ABVZZoIji/8n6Q5bLNjiqlOhkDZLUYSUQyO/Vcu2dRgan8GV4WCS3yyDgtoMQokiD5BazmjYDvWgVdpHA6nDLunjdz+1gVPrWl/hUDme7g3WqgYzTw3mDy6+P3/s3VXzBLuESPYdrOiTj4PKyIb6ugYeUs1EvQI8yGOhlq6oZGLXfebZhrRxBRvw60mad67sM0JzdHppdHpsxQf408knjiGjj/KxLMAS53AYSLpO/FtW10HqkJ6+Cs+gwhHInTLSxSWJRkHxnzuVs+CdrKMSZzV1K2EIomg8XY1ytCNEOH6Hzq6HZtsg4Jkg4NlFMW3KGCKs+RwP4yXfuc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <922A6263019E3146A87102D489BC0566@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: brtchip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481cdb4f-d0a1-4f24-ca51-08d6bd926151
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:56:12.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a2bb2098-6a22-417d-b196-55ac329bdd17
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Johan, I have amend the commit message of my changes as per the
patching process, and hence the git format-patch has created a new email
subject "[PATCH v2] usb: serial: defer URB submission for ftdi_sio",
Also for the whitespace problem I have run the "checkpatch.pl" script
and ensured I got 0-Error and 0-Warnings. Please help to review the
changes.

Thanks, Srini.

The 04/08/2019 15:12, Johan Hovold wrote:
> On Mon, Apr 08, 2019 at 11:54:00AM +0000, Ramachandran Srinivasan (BRT-SG=
) wrote:
>
> Make sure to always provide a proper commit message.
>
> > Signed-off-by: Srinivasan R <srinivasan.r@brtchip.com>
> > ---
> >  drivers/usb/serial/ftdi_sio.c | 153 ++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 152 insertions(+), 1 deletion(-)
>
> Your patch has been been (whitespace) corrupted and is barely readable.
> I have no idea you're trying to here.
>
> Johan

--

Please note BRT have updated their Privacy Policy.

Please click on the following link to access and review.

BRT Privacy Policy<http://brtchip.com/privacy-policy/>

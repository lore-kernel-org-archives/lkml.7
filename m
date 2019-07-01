Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36623C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D62146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=utoronto.onmicrosoft.com header.i=@utoronto.onmicrosoft.com header.b="mCqrIzVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGAVHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:07:51 -0400
Received: from mail-to1can01hn2015.outbound.protection.outlook.com ([52.100.146.15]:26666
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfGAVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utoronto.onmicrosoft.com; s=selector1-utoronto-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JyuDFUmOpzgKH6dgh5LdWzoUOc/E37EGuvvgxjAQ2g=;
 b=mCqrIzVFmcqHGcpB0dwl8e3+jSVAMdhvcB2LpRTiPyuLbMwLt7rDGLypVZXODS+c2VDXlHYqgYLwPQQrJrlE+u7HGxaI88JGl60mCMsT7lBSZ2tPHb0+plYDFO1Kb3+Evswxsu+j2ytHfDGXWzD/jV/hkLZOeSNh7xYvwTFY9Mk=
Received: from YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM (52.132.47.29) by
 YTOPR0101MB2027.CANPRD01.PROD.OUTLOOK.COM (52.132.49.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 21:07:49 +0000
Received: from YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2901:a18a:73ce:3378]) by YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2901:a18a:73ce:3378%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 21:07:49 +0000
From:   Qixin Ye <mqixin.ye@mail.utoronto.ca>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Project Analysis
Thread-Topic: Project Analysis
Thread-Index: AQHVMD8ebzaRt4gJ00uIjGf1FoVULQ==
Importance: high
X-Priority: 1
Sensitivity: company-confidential
Date:   Mon, 1 Jul 2019 18:59:33 +0000
Message-ID: <YTOPR0101MB22349C41B84FEE48620A57BCCFF90@YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM>
Reply-To: "mrfuhuangfu101@mufgbank-jp.com" <mrfuhuangfu101@mufgbank-jp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:405:39::22) To YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1e::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mqixin.ye@mail.utoronto.ca; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [102.165.49.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63cba719-9a06-4da7-5b14-08d6fe5640e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YTOPR0101MB2027;
x-ms-traffictypediagnostic: YTOPR0101MB2027:
x-microsoft-antispam-prvs: <YTOPR0101MB20279BAB8E8DB6A2EB52E30ECFF90@YTOPR0101MB2027.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(7116003)(6246003)(71190400001)(316002)(486006)(9686003)(14454004)(33656002)(71200400001)(81686011)(52116002)(7696005)(6666004)(2501003)(55016002)(476003)(256004)(786003)(99286004)(26005)(53936002)(43066004)(7736002)(186003)(68736007)(25786009)(305945005)(5660300002)(66476007)(66556008)(66446008)(2906002)(73956011)(74316002)(52536014)(66806009)(81156014)(6916009)(8676002)(81166006)(6436002)(66946007)(229853002)(6506007)(64756008)(386003)(3480700005)(5003540100004)(558084003)(221733001)(8796002)(8936002)(478600001)(74482002)(86362001)(5640700003)(66066001)(2351001)(3846002)(102836004)(6116002)(130330200001);DIR:OUT;SFP:1501;SCL:1;SRVR:YTOPR0101MB2027;H:YTOPR0101MB2234.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mail.utoronto.ca does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jGr0RqaqW46m1LDVzvvkB93KThuD9ZQgNAcHQN/nzGzX+Dg9DnM/ewbK9IXbhKqaEdRtGZN2UW03ae1tai6TJtqnFdLGOf2OhOl0hXMfNfO5BRTYH3xYnrIc7j93IGtD51OzeRmYaip8e87vuIAzSHgOmhJPyml/VKclvJdh/twVp/BjiLkvqGBuBLOmXmDUW13tHYdm9bXk9Ug6yFU9Tbmr3X+evNF7LJ+r4VbRomop0GNI92JvpCq217HkhZjKmuKc/BUg//elCF98zG7mgrv3GzE2xBuRI8CvCKaf/xHVUXYu4B2HC6oU71Biq5t2NPo7jiVDFRoyKoWD+tiYgyDCp459wSAk5qrPvMeSzjW2iHfatZRDvjICQ3PrNv6yo4Ly8XqC+mAv+X26fJaawZin7uoYq5ZaNFneymEhX/w=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <346566D773879B4DA30059C863AC0A35@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.utoronto.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cba719-9a06-4da7-5b14-08d6fe5640e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:59:33.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78aac226-2f03-4b4d-9037-b46d56c55210
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqixin.ye@mail.utoronto.ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you receive my earlier email as  regards the project with Mr Fu huang C=
EO. PLEASE REPLY immediately. Regards.

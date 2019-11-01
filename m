Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F68CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C546E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="OU99N62M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKAVmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:42:51 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:60901
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbfKAVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1pATbYbts69et0Uq6ICIiOJ3oYQy7snNJg4opbU8/QJRIbZIFPevwZo4phnuadFOuFiilpPPFx1tcoLidF9s7ozdPPwYkFsEBr21/KTrb+QxgVNE/RnPqTif5pmfsdX8KnI0Sspvg+08TM8q9wyaIiLBJPCYcS+IjQ2OWJaIA4bhr1MmCvPIsVPw4fH/NT8lWF/kTVVsEIIJ1svoXTNt5oJ496qRPy2MlPgUnXjh5662jPa67AAHkJ9Pb1/gQX8RIAkxKq4cMh9gMUmLbmEzRoUg57MDypOawDhipj5M+0cwbkn1IF+Ki/Cmykf24tWyWJneMDXLfxkqbKegLA/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Sj22Janicqv6lu1j46S7mrnz7N45ClWvsKIrJ2kNA=;
 b=Cj8cMm/WNmKxWnkUJB2MrLt4jjjTG9f1sPexV7Yf+E9AfVuIdarmVdMrOPiRQiHZjbJQzXuTErH1QMCjPYhk0fvnCb8V4+i0tfDLNd1AxmFq1i3W+q8EvojbYIlcc7waEEo2G2gi7FbNNZ5KtGcBh9u1471Dnyw1vObpFYKMnXT+a7BxQpgCpeieHp3nUamh1aPOBYjvJMglbvqE0d6/9Cxqo+5ibQ29ufp0QK6FEbk3vVebzEWActDyhCIpqpqfc7WufG5lxRFdtsHkTvYxyBD1P2UVQ+lHQGesONJFqfhSmuiGFtfhnTb9Y4lg7+vsEFyPRc5URB9AA5TvcR5O3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Sj22Janicqv6lu1j46S7mrnz7N45ClWvsKIrJ2kNA=;
 b=OU99N62MZ74iI+PB1zVI03+qUHl49+FDRctBU2+HAdRumA/ZsvkYiEjgrJgeVfQ6rf+BOkiMvL0SwfX3H3LJcqU6ETY/0YOqGphrWO+vDIsZKgQ4dXr6yh3sJ9F64wi8lSSVlJm1eNXlasMbNkCGjZ0unliE2RytgNwbU43Kpzs=
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4679.eurprd08.prod.outlook.com (20.179.47.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 21:42:46 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee%6]) with mapi id 15.20.2387.031; Fri, 1 Nov 2019
 21:42:46 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] staging: axis-fifo: probe function cleanup
Thread-Topic: [PATCH 0/3] staging: axis-fifo: probe function cleanup
Thread-Index: AQHVkP1M58++tMKSskS5FRk5OoC1Iw==
Date:   Fri, 1 Nov 2019 21:42:46 +0000
Message-ID: <20191101214232.16960-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [81.98.213.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f79699e3-a982-4f5f-9834-08d75f146ee9
x-ms-traffictypediagnostic: DBBPR08MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB46794FD3A83C781405942B81B3620@DBBPR08MB4679.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(36756003)(2351001)(86362001)(186003)(66066001)(6916009)(14444005)(66556008)(476003)(486006)(71200400001)(64756008)(5640700003)(2501003)(6512007)(66946007)(6486002)(44832011)(71190400001)(2906002)(6436002)(6116002)(3846002)(50226002)(66476007)(4326008)(305945005)(8936002)(25786009)(5660300002)(7736002)(81166006)(256004)(386003)(8676002)(6506007)(54906003)(81156014)(66446008)(2616005)(508600001)(14454004)(52116002)(99286004)(4744005)(102836004)(316002)(1076003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4679;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Dx5C1lYYcPwhYlfym7fOwhdYI30YfUf0e2ftDeW5BjvD0TekVdll83n/p9hBgK3wnUoq/Cmt90OnGqxiq6PLqsz1raHz7D0Sq89D4m8eBnVGhgN617PZSFc+4zufskq+WnKqPpSvPiIiNBDKASNlBMhBsVIJgsrcGkYIjVCpaw1eRAMi21nCfbhdLzc0BohFS7bTP5FvGScg096Id/CtSc2KJzLqGsXrUTFqOITVf1TpE16ELySlt9nHFY57fcQ57H4o3QFDW3dkqugtuZZLnyVKnEyJWidKcj+NMc0vPD1fPoOCy4JeOJs1qz544cp6ETjxuF6hZQHpwFgztup21QTqU0REnNc6DUJbzwC7nvNutgjTreYnpaC24eDf9RojHmcEPGyuzWJtI9duWYRPFQg4/KHfH6+I/aZTqdk4Zp+qhu6Zlab0ua5TvqO9D9/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: f79699e3-a982-4f5f-9834-08d75f146ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 21:42:46.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZFr5l1W0X2PUlu49bGwpsY5FEJhbiIJIqryanZYpnrcWD5WKcZ53vsCwoO/V0cJQjI5GXRCwMmwL3ZUWYGqkB62XRxpL8rha7A9dfvlUBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid parsing unused device tree properties and add a note on ignored /
unsupported properties inside the joined documentation instead.

Also use managed functions to claim the device's resources and remove unuse=
d
resource pointer from the device's internal structure.

Quentin Deslandes (3):
  staging: axis-fifo: avoid parsing ignored device tree properties
  staging: axis-fifo: request resources using managed functions
  staging: axis-fifo: remove unused pointer to memory resource

 drivers/staging/axis-fifo/axis-fifo.c   | 301 +++++++-----------------
 drivers/staging/axis-fifo/axis-fifo.txt |  18 +-
 2 files changed, 90 insertions(+), 229 deletions(-)

--=20
2.23.0


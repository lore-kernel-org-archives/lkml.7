Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B2C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F5A208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="Fa/V9q4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436559AbfHIOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:48:52 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:24036
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIOsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIq1wuUIcmTNYP3UcO5HhLBmTVU0EeBJfPnIXJCf0TBiuUhZ203cuV5h7ldcFbRxVp5IYr6bTsZMZ2QErSFEPRncQJAx8SJmyA2rFeG1XHJgzVJTh2TmKIRaYu/E17KKdA8ih183StnSKtS+G51a5GgXs8LGET0pd7XEcLuZOcwzcmM2It0haERoc689DSOC70HH8eL5V/9mwaa4NOi6Ye8B+hO+L9myhNVoIyruKK4uXQ50UliX5TRvO5Tb9YrmWGBW7rKg77WlyUTqC1i9r0GgI3n/aeUqktIcgxNxMfn37ZysiadfEc6XyrQokJPgK2sCnPRZDAgvAtciJszuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnR9Hax5guR2EDI9NmQ0N4IgqELLp4Iwszcv1pUteNs=;
 b=ND1zhdikcn+8Q6sGXgzlZf0DAXgFm5RMaWp1QWLAtShajmZ6Tnn7jPN87rLnZiQL0llu9Y8gnnxFg3HgcIbk6f8t5PNjVCCWZmEBPar04kNiRJfQWhqqhFSo7oCOIqrOT/84n6bBLgcCoI1w57gZz6Mo0oFsi7yQl++mYgdDvQxGKfAN3Y8vIn9ysoQz2EQvVzjYkH+8mAVB9phuQ2QAFcl+Cl9x2ljY79b4cnmBQbeSzG2whsHSW3yYwWu2hD0h6TBgZ7nVEUCyifeDQ7pTXSeSVUH52G4h00nNgbdA7au3WDq++WEKcKbMqT1+KpFUY3wj+ZQVwxd3yvf1j5ZYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnR9Hax5guR2EDI9NmQ0N4IgqELLp4Iwszcv1pUteNs=;
 b=Fa/V9q4WDU2qQIUG/wheFKw3HuBq27exB5moBgRORbnPTaKkmZSo6l1MPOJMMf8w7Kclzx2ATvRLy0XZRymq/7tB8yfQzf4cFIqMn0Fam+VZ/05ayZCQxRQ3QsRDw/pllktwbV7McW0RglZtMt3qKL062ES7obp8SZGVK9KQdFU=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3486.eurprd04.prod.outlook.com (52.134.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 14:48:45 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:48:45 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Lookup PCS offset, and cleanup hex formatting
Thread-Topic: [PATCH v2 0/2] Lookup PCS offset, and cleanup hex formatting
Thread-Index: AQHVTsGLOqdpCCelO0Ktz+HvyUlLyg==
Date:   Fri, 9 Aug 2019 14:48:44 +0000
Message-ID: <20190809144827.1609-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:405:3a::40) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42cea595-fccd-43da-46ec-08d71cd8ad8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3486;
x-ms-traffictypediagnostic: VI1PR0402MB3486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB34866462BF5F223A60593CCB94D60@VI1PR0402MB3486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(366004)(136003)(376002)(346002)(199004)(189003)(1076003)(102836004)(6512007)(386003)(2906002)(6506007)(53936002)(86362001)(6436002)(6486002)(558084003)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(5660300002)(50226002)(99286004)(81166006)(7736002)(476003)(81156014)(256004)(2616005)(486006)(71190400001)(71200400001)(52116002)(8676002)(478600001)(36756003)(6916009)(8936002)(25786009)(66066001)(186003)(6116002)(3846002)(26005)(54906003)(14454004)(4326008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DSXxkQ/cu7z7HUJDb2KLDQ+aPrdDKdF9KYjY/0cpVKNyzpxUF9HePEpEBsplYBvgaHa/mWIVMj4NHPUeoO0u1dtYvJ+Ypb/2ilWQXHNOZiYtRDJ79JV1ZfF3xfxPq8Hn26SHbUi+RqphwH1o+XZ4UWkDLNpzm1KxPyJW8q9KXKl2GHe1D7aq74YJDyecH/nk4eXn+0cWO4IvuTk1B+sURKfCMpXrk50o5cwz70IQ8nmWWreT7m/q8EgF5psDlowlFTvXcrFGqkqgfCkWMnEYuCDTnFnOPs/Sb885wVT3UYd3vJPRYmgqcW3cbZxB4V9+n8p+oGjk3SWFXHi79AHuw7bUUe4CG90myKE0ZN6bN/dKuUo+WwX/RksRboQFyravG46CZunvzbXi12wCy3p92a31LpRbUbNj3E0ARNBVWWM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cea595-fccd-43da-46ec-08d71cd8ad8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:48:45.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQcLFsysPKT5RZfuR74zMfve/F59VOcGWVhkDrZOkY/IwwuTblOo1XhWIYCTnDvF+is9yqNMzp4i5WaHoD6K6Sl9Ja6O9m3yIIPRQgWF3PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Fix case of hex values

Stephen Douthit (2):
  ata: ahci: Lookup PCS register offset based on PCI device ID
  ata: ahci: Cleanup hex values to use lowercase everywhere

 drivers/ata/ahci.c | 62 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 13 deletions(-)

--=20
2.21.0


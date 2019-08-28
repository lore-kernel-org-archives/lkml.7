Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033502173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JFwcGmrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfH1GIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:08:13 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:33601
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfH1GIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPDul+JXt89w52ucKynCjghIuhJu8up42R1nOMvwLd+ZJLv6Nn08aZTx+X6lOche86bcCnRgo5p8DucoLm3NRg6/c4ajcgILXlpPG1zYMsqf8PRWlNQalDRmjpxo+IgZsrXevRcThwL2Yt3of3qDIY4VOxdWrUbf/zVCtL/Ftf8iFuNCzQga4xJJ1NxuAwaB0UaMox5DMqPilqmSJLWaq93KCnsPHjvrKhm3+ixvp/EKvZPB1RojCSVV5ytZghkcb6DM1ZFOtl2Q4jGb5i7vwXBMc3HiqbeLV/K4V5mph9NHdkeM+CgEwjrRSsnMRhGJNH7eEtKhdfJiSDdXZevJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3x1Ei1hoRmrkLKmggwHyCvcPsdTYoi2Hso3r5Ta5qY=;
 b=fmG++o35cTSchb5Ggoyuem33yxx/HPR3X9rj4+1ES2drAYE2B4RfI1QYagqFbGCNfvrbtQ4/XQHWAtepw8txiIq//vsTAGkCLI65lyvzv2e3hZy9ZB22m7UHqOAm1yBLypyTFkTFI/Zh/0kmx2lrTTxOyxFSuFyVcTUKX1tHAP69j+iBEO1ZsvXZH8Za8gTONqk4qz/aAxdyPTJUi7OEtRhnZmpky0No28GjOBxscFTjcHAliiTPK9KTfZbpXD7zKjlIe/4aRjCKIPp7BGscjM+nCjbFK2tE4PIzWymfW9pUpR6nSH/Kyw0kXuBQKUfuunHpABl40MfQ1OyHwFBiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3x1Ei1hoRmrkLKmggwHyCvcPsdTYoi2Hso3r5Ta5qY=;
 b=JFwcGmrbqhmO426SQTQ92iY2aJOR71IeNncTZtszWI+1fdIDmSu3DeRH3jjn13TXFsUGP+blnzvZ1hLACtX97arPZFGwTWzL3tqMP57YRnNJtNIn6XW2d0knOCYIaK0bI6UZCd0M1Nz5XDcfVroVTm0t6dFFMrnFgwOogHZr1CA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4487.namprd03.prod.outlook.com (20.178.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 06:08:09 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:08:09 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/8] regulator: support Silergy SY8824C/SY8824E etc.
Thread-Topic: [PATCH v2 0/8] regulator: support Silergy SY8824C/SY8824E etc.
Thread-Index: AQHVXWb3eqtRm470nkSmF9fkEpNwlw==
Date:   Wed, 28 Aug 2019 06:08:09 +0000
Message-ID: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0203.jpnprd01.prod.outlook.com
 (2603:1096:404:29::23) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64460700-2b63-42a2-bc33-08d72b7e1956
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4487;
x-ms-traffictypediagnostic: BYAPR03MB4487:
x-microsoft-antispam-prvs: <BYAPR03MB44878A98D8843FDC2A578E6FEDA30@BYAPR03MB4487.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(54906003)(66066001)(50226002)(186003)(102836004)(305945005)(8936002)(7736002)(26005)(52116002)(386003)(99286004)(8676002)(3846002)(110136005)(81166006)(81156014)(6436002)(5660300002)(4744005)(66476007)(66446008)(64756008)(66556008)(476003)(6116002)(2906002)(1076003)(71190400001)(486006)(66946007)(256004)(86362001)(25786009)(4326008)(14454004)(6512007)(478600001)(6486002)(53936002)(71200400001)(6506007)(316002)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4487;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2llZFkCoxEc7pyiGl/ch4nu/UrCcX1HsvhGZ6IXZn926ktxzzKIuM2CqpZiWx0p+kZ/hXaAFTvo2rWcj0f2xydqIWKugpzXqXslcnLeymr8rFcaL7Y4OsLHQ5Ky2bldYXcHKQEOdM1c1fm9e/v9wpMzEJu6h/+WY1KftudNjDZoKPVqJL6+wLqfgZzMHP+5oXuuZqRZioLLZsxpLHw5xZfiN28c1OBoSeMsHdJRIbj8hsN01uAJA+ekHbqQNCXw98EMl7eOFfZPKfGZOfXPGT5hTSXFovfvwDMk2ud5/C1nTPwUFtcnlI0Bqkt9sXouYBqpIodY/ENCoMVhTESxfi6YR0xhHSryRk78WBkwvFR5gqGXCFNdb8pgOo+OZNU8Q7DHl2UUDGiPzviTZMPQJo/vr+fsd1+oOE5dYTXqA+u8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60EC053632AE7C439CA40447EB6F4990@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64460700-2b63-42a2-bc33-08d72b7e1956
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:08:09.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1KhphWMQxn+TTqv99WmsFGZziQHGh9XgVIdtcAVjRoNhKBCqCxOorfcWa0WVUSvsEAPxM88MAGI+JkjPYP8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Silergy SY8824C/SY8824E/SY20276/SY20278 regulator.

Changes since v1:
  - use c++ comment style for SPDX header
  - add prefix for BUCK_EN and MODE

Jisheng Zhang (8):
  regulator: add binding for the SY8824C voltage regulator
  regulator: add support for SY8824C regulator
  dt-bindings: sy8824x: Document SY8824E support
  regulator: sy8824x: add SY8824E support
  dt-bindings: sy8824x: Document SY20276 support
  regulator: sy8824x: add SY20276 support
  dt-bindings: sy8824x: Document SY20278 support
  regulator: sy8824x: add SY20278 support

 .../devicetree/bindings/regulator/sy8824x.txt |  24 ++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sy8824x.c                   | 231 ++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
 create mode 100644 drivers/regulator/sy8824x.c

--=20
2.23.0.rc1


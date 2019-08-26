Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F80C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DED217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="om5iSzub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfHZKBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:01:03 -0400
Received: from mail-eopbgr820049.outbound.protection.outlook.com ([40.107.82.49]:51332
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfHZKBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:01:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU9GfGMmeqtCNrfORXB/ZpjCK6/LoQVearsiqdMVRg0/Ir8aI+womPuiMKizi5jl7AnogECn/ZVaEcg1FqWOoa4LoJWOtMsAKz1jpx3G2Qm3ktoWSLiCCb/W5WXGcf5SIAs/dDKl03Zp53PbKLoj1RLaa18nMRq9hp2+XBMN3Q4zeaW0Q+Ju24CQwpI2rmjFEeR98tjQzCX/KPNVZQBE77ODJfSKaiRQYIlfHL75AORyPUAZIsmgtgwiHdR5HKwCLeZKFf5XYbb4PXlaLvxjPGHhRa2StZQ9WLQHPw94UfMX6cLfbzmQj6nHzJLn6/RGLt4tKvw6BaldsBC1D5QmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbJKNDnN1GQx1AXa0LroQuByxnIAZttlWjC9hZTgh7M=;
 b=JTyqm9dU1EwnFSxsHLV2oSg6hmxmI9HeD1JZaRkWgTCaAJc4vY0FdsVomFyl+4izZie6JQgOi9hyl/Os3xo/egb3SigRymIc75vuw/GpqcGXPs3qQe+QgIBxxobKf+QyPLFd6oAFcwGQ95Es5zzkl7wlfyAMY3sAWBvylVvu7EnaffY8oyYsE0N5U3wOr3e/bXk/aoQkakKgGQFiCyHFjifJWwR7IyL4CQoLnzGjHJhz4fiNS8FvkAr+sKoBmcAu2OqUd1XFIlqDkOqHgCl/sIjj3IC1AtvES7YVnmK0aqy65eq1yJf7SoEdg0PhjJ/nC/qj5N2IQTQ4db6xvgfvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbJKNDnN1GQx1AXa0LroQuByxnIAZttlWjC9hZTgh7M=;
 b=om5iSzubm9D+OKHGctmvt0Cu+Xw1w16AHlngl4iBmwF7FAuwlsnfVBXcStlLwLr7HiAuNBC1hWcjAXhd+RhGuKt0YVhCTXs6v1du4KdIuCIbeGValu0DE7vLj8oLhkOOD5WwEv+9IVUat3k7cNAE5eKMMmCJy7/a7/Vqfi9GT1s=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3589.namprd03.prod.outlook.com (52.135.213.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 10:00:59 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 10:00:59 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] hwmon: a new driver for Synaptics AS370 PVT sensor
Thread-Topic: [PATCH 0/2] hwmon: a new driver for Synaptics AS370 PVT sensor
Thread-Index: AQHVW/UpuKgnUYeviku4YwTMS3cUuw==
Date:   Mon, 26 Aug 2019 10:00:59 +0000
Message-ID: <20190826174942.2b28ff05@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ab9302-0a1a-466a-0b57-08d72a0c4b9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3589;
x-ms-traffictypediagnostic: BYAPR03MB3589:
x-microsoft-antispam-prvs: <BYAPR03MB3589B1E1AE41052A4EFB62A5EDA10@BYAPR03MB3589.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(14454004)(81166006)(71190400001)(81156014)(71200400001)(50226002)(486006)(316002)(7736002)(52116002)(25786009)(5660300002)(99286004)(476003)(2906002)(86362001)(6512007)(9686003)(66066001)(305945005)(4326008)(1076003)(6486002)(478600001)(256004)(186003)(8936002)(102836004)(6116002)(6436002)(66446008)(66556008)(64756008)(66476007)(26005)(66946007)(110136005)(8676002)(4744005)(6506007)(3846002)(53936002)(386003)(54906003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3589;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rpqoyWL4FLyNBAX+WHzf5XNe2xQjJ3yxV5hr6uf0SlSoG5Q9L6CaPSriYs2nzV5mRwaZZ2mMNgi93n/DlE57I8NHI4UT9XNvYfG5GyAPRdgvFbq3lGet5r9FHwlbeDprGKw6g089ugFUocogLyOLtV2LlVq3iAKCRN7tpXhgXqg6GNeRnCuBTDYZ3HLZu7n1kKcnHcxFpERvsHeAoCxm46pcbY/U8yW5mCFOYZGarzMh6eYQFJRzQhhHhIzXmR+KSU4k00oKqczHm3fFAQgalZGjVXZnJ3nmbaB2yd/uNGus+HfeEcVyZbkQJvWysfySOybiaRQqLbzGeOS6HYTZ6mMzE4D+ciNAdSNQDgugsXIajYTYLnyB41yuaERTSabKDSmAE3CALuX88697Y+e9EItA7LG1IVpZ8fzijvFpMIk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D0CBE1D2191CE40B68239C6DFEC1C29@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ab9302-0a1a-466a-0b57-08d72a0c4b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 10:00:59.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWQTlQ/Dvpj7clw9sqgdMwhBwy9xhK9/fnnndKdqGndjfp5NByxgsxUo+28jAtVVEonlozW50Cap3aNtgUi5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for Synaptics AS370 PVT sensor. Currently only
temperature is supported.

Jisheng Zhang (2):
  hwmon: Add Synaptics AS370 PVT sensor driver
  hwmon: (as370-hwmon) Add DT bindings for Synaptics AS370 PVT

 .../devicetree/bindings/hwmon/as370.txt       |  11 ++
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/as370-hwmon.c                   | 158 ++++++++++++++++++
 4 files changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
 create mode 100644 drivers/hwmon/as370-hwmon.c

--=20
2.23.0.rc1


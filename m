Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73963C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410C52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Oij1rxeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfH0Dnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:43:35 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:5584
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbfH0Dne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G40Lr/sl/DZiBFNuoqfVqkwiTwciomSqtETCjaUVEbe5KFUIutiEou0c0Q8GNJboXsg+xFH4HlUaN7V6Gc3lgPY73pJ/rQudZsig80WIUdzuyDs6hbltbVvVyif0u/6V/ICBl74LL9inXrUI2Mf4Ns17wgw2BjZHus5iGfj8OvDDIKRrnvJWI9wxZHUjX+TGkXZHtF00zztiaiwU2S4a4BotjLZO/T4H1wkoZNeLiy+D3yRJ3GaGh0FrX4wVudsgcmYaqqGyvQ0M3UUoj+6jv3CrDvrnO1os6SiTZDU3w2zhBjyLCI1Ht0gGs1TEpyWlqc9YYj+HErU2tsY359aNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmZ3TBP1lvj3criWo2G2ZSOtqFXaBnAcAZnult+mbEw=;
 b=YLHQtN0nwsf0TBDoXr6OpNv8jmtrHyG4dB9UCi4Et04iHz29f31X4Vvam3/sczTZXk3Ivtd0LgJjrOTLvePdHTsBIbksDUEbRMHbz8IHePEPJULwasSjxz2eHTMmfthAJg/NdQvtOZZ1b/vDYIWn2xuiJGs2bCRE9VL+TD+QYFSgP3zJAKrRqyezoyeDyKMIrF//Xc4rLHM6pAwQmyzSqmb9lyc0nH267K4ouT19pZUr1PWDUWBT5GLpKTi0k/sftr2dzDLToJAvOmgtI97BIWp5ZN03pqh1VJIYUAL9qHSTIeChNApk5Ai74T6tEz4LrULb+PKEIZVw02ta7NwE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmZ3TBP1lvj3criWo2G2ZSOtqFXaBnAcAZnult+mbEw=;
 b=Oij1rxeGkWeeU3QzUNNGC0z91ShLey1PZTUfQ2eAA5htYRZeH6vknqY/KtOm6d1YK6JRJmZRAS7UhsdtjLhrEsNczOjqTbupTlq4YelW44Bh5qHbpkxDk6HC/41GRTeFZPUIp0gU62L5lsPkMhMjklsxuASsu/cK206QeV4rdhU=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3621.namprd03.prod.outlook.com (52.135.215.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 03:43:31 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 03:43:31 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] hwmon: a new driver for Synaptics AS370 PVT sensor
Thread-Topic: [PATCH v2 0/2] hwmon: a new driver for Synaptics AS370 PVT
 sensor
Thread-Index: AQHVXImY5jamgXX6CkyUUj8wQ3HlEQ==
Date:   Tue, 27 Aug 2019 03:43:30 +0000
Message-ID: <20190827113214.13773d45@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12e499c9-6f1a-4ce8-ddac-08d72aa0ba66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3621;
x-ms-traffictypediagnostic: BYAPR03MB3621:
x-microsoft-antispam-prvs: <BYAPR03MB36215F0A190CD2EF707E4AA9EDA00@BYAPR03MB3621.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(6436002)(102836004)(476003)(26005)(186003)(1076003)(478600001)(386003)(305945005)(2906002)(8676002)(9686003)(8936002)(66066001)(6486002)(486006)(81156014)(7736002)(4744005)(256004)(71200400001)(5660300002)(81166006)(14454004)(52116002)(86362001)(53936002)(110136005)(54906003)(66946007)(3846002)(6116002)(66446008)(66476007)(64756008)(66556008)(71190400001)(99286004)(25786009)(6506007)(4326008)(316002)(6512007)(50226002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3621;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5RD/bzMQcmbLnr2zCGRcnZh1PhSEaBj9AabdAubT0bOhtFyU3BCxuuXaSH5C99bGjl3+HRtEe44Gh7CnNi4kjkU8+xRhHduQ1bzd4+KDecmyIDip8agZ9spoZYXCJEQOUraVz+pgCBH4uk29DRNoq50OBUwmPs93EyvlzXBSnKAiUC/DKBOCXU6uCBPFz90Gl/srSrTmBzfFTQ56qXwmUoBV9fJ1XLOr8hLS7XWm5z3iAEqFW9Hjo4bwNxDe/bSk+0tfWn++HY5cPSzl2roxJCgmDjQduOEgI9LoeN7bHi9Ui+GGYWcD8SEFKTzQD6SMMoYi1Ywv+Swqbzjhg24BR8AApB6tSghjWWDtqyL1r+BAL/FR/lNR3v1GEuCVCpjTtJfuKg2IW+gLPmJJpH4qjsz5LT++A4YNGv/bajlExpk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0FE8A303FA1D74489DBBEF4AAF4DEB1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e499c9-6f1a-4ce8-ddac-08d72aa0ba66
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 03:43:30.9270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NF7AVNXH2RhW1+D7104Dz15STbEpX83tjuZ4DwdI+XGCpBQZYDVfQhLZidXRS2xwLRxYL87kAPaxoHukLtmlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for Synaptics AS370 PVT sensor. Currently only
temperature is supported.

Jisheng Zhang (2):
  hwmon: Add Synaptics AS370 PVT sensor driver
  hwmon: (as370-hwmon) Add DT bindings for Synaptics AS370 PVT

Changes since v1
  - remove useless <linux/delay.h>
  - use GENMASK
  - remove useless bit operation
  - remove read_pvt()
  - use DIV_ROUND_CLOSEST()

 .../devicetree/bindings/hwmon/as370.txt       |  11 ++
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/as370-hwmon.c                   | 147 ++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
 create mode 100644 drivers/hwmon/as370-hwmon.c

--=20
2.23.0.rc1


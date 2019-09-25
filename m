Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B146CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A3D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qnpCTAYa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PfMQm9sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442250AbfIYEaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:30:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8946 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbfIYEaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569385806; x=1600921806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rA+WLdFvXnsdESLlm02oFt1X88ILTUumHhuhuG7W7bc=;
  b=qnpCTAYa4jsDKEQZ7FWjUy1vPA29RfJ+hlOOgmDEOEii+dcpAEt8X1Gz
   cEmuWBwUl01O4OsRhAw41v83se6rLyDjkpovDz63KX3Xa/pVMyu6WMNJZ
   QJqtkaOorjUsAZael5SRb5Yua1ZLdN5mOTG9loNZ9N86K4zGE16kCtRC4
   /51ULdTHbdwXt8Yy4w4IijT+YpWSg795qiQ6/7R1ejg19SqUDKmiUoAt+
   p/02RWG1mdqpsBQtByOc3UT8rx0QHLWOAAEPQeOkihuQINUVvVKFbSUU0
   p9egNY2+b6O2ovI6KyaM5IHIvSZCNd1VJemKcY+Xp+h/J6ND5Wlh34IPp
   w==;
IronPort-SDR: 5xntbbgJCKjWE1ui1l6ebVA2T/7MIfMs+2qybOEnv4SggZXZM/CHomlcVEnpuiSRbBflrawjEm
 B4A2iVTV7RmBiB2+ZBw0td/1rfbETK+4YgA66EuW5nsCY+9yKDP9aN2Lt5Dj16Mq6FWWfQQsy9
 7pRtMfe5YGlyfOH1c0QtyJUc0NGoOBV1Ecf9JZzjJebx3xTMfU9cNWXV+oaTvD0CtjdYBrNcwd
 9rVuGlBBsNHi7X7lgNYADm47JhR8ekNRmqotpWLaPYXBtEGLBdnb9mURCjnku1NPW1xnb22VHb
 vkY=
X-IronPort-AV: E=Sophos;i="5.64,546,1559491200"; 
   d="scan'208";a="119815072"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2019 12:30:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUX/zoi12rtWcwP+z+qYDBUNpkDe6DndRA5dEMPzkeQP8Ufd05yH2jPw+RVgWNZuuHLi6M7s3RAhNrZsVjSJNhKzCbnByw5NpRPNRJfMSuoZ9pIL6ChR37i/+xI+2mgs/lYto6/KfqY/uoMkXawqwkwqjXfzoHxnV6LNmuCylKnNaYpN9FMTRFTWEZ37GUxrz/odR+qoO+fSJLAvGZh6RUNRftZMSOtrkR1j/R6s37ad6EalGHH7UspjtlKTAaLKWT47/hD4HRxv1zpCMjkZhEbzGOtCXSaKi/fYlEjOMINwLRpJ4J+gFhCAGGM7gz6b057mEQKWjyQLicAwCuZFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4w1j0lZNjR9ny75m6RBVUHTJi+zufl696GsOCoqZEo=;
 b=OFlpdDujJZb4URdmst2Aiy2XhTtmn2bMG8UYaK7jjzp/5eYKAjQodN9SWxh6EpnyLl7zeYSB849aX9vu+vZhC5Kub219xCg/4tLMqnSIM3ZxyN33Psxj4gPZG1IjS2z1Khy3KZbKn/76KZA0lHb1m0Rr9fVY/6jPyaOOzH535B9l2R6jkbKXCNRKAbE/IoS9eabUkn1IUK7rfsRw/SevSosyeXovSYjG8ZvcpINMAtrmkCdprIKWiAO5L5GUtFBtsYydewJPd5p61hGlLijp7q74IXPtyyZgGiUIAACPxbmn8xgCEuA/0FMOIKhLKOVUq6YobZtNAwDzQqGLIyxQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4w1j0lZNjR9ny75m6RBVUHTJi+zufl696GsOCoqZEo=;
 b=PfMQm9sMUPngMANEPAydv6FO53lrfpLiWZvy9RX6WjMntwQyN2aB8S7kDUu4qsRuV6F1xZAZe+o7eHpcr4VS6rBE7vxD1vvdxh3vbx1o6p5tdtKK/FxWyuWm6WxoCrvTSFY+Zaio222wN+Xf1xL6QvTjlwR9ishDpYdF4Yl/vns=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5805.namprd04.prod.outlook.com (20.179.20.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 04:30:03 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 04:30:03 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roman Kiryanov <rkir@google.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
Thread-Topic: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
Thread-Index: AQHVc1nm/m92ZHaq/069iGKwBeQlyw==
Date:   Wed, 25 Sep 2019 04:30:03 +0000
Message-ID: <20190925042912.119553-2-anup.patel@wdc.com>
References: <20190925042912.119553-1-anup.patel@wdc.com>
In-Reply-To: <20190925042912.119553-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::15) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce378f4d-6ad9-4283-1cbf-08d7417108ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5805;
x-ms-traffictypediagnostic: MN2PR04MB5805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5805C102646ADD0DE487ADE38D870@MN2PR04MB5805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(25786009)(6506007)(316002)(186003)(256004)(4326008)(5660300002)(50226002)(8936002)(476003)(4744005)(26005)(14444005)(11346002)(2616005)(446003)(2906002)(486006)(44832011)(99286004)(81156014)(81166006)(6116002)(3846002)(2171002)(36756003)(102836004)(6436002)(52116002)(14454004)(6486002)(66556008)(71200400001)(8676002)(71190400001)(66446008)(66476007)(66946007)(64756008)(305945005)(110136005)(7736002)(478600001)(54906003)(6512007)(1076003)(86362001)(386003)(66066001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5805;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O2czGEvkr+0ivONdxj6QarFym1pzodLZfeNJkpZTqTk/eZqT5repF6tZBneIWcRQbiwBLuiZ3fm+tAnCJ9YPn8QUUONolTGRKF2JNl8I3gjz8bQlxaowHqQFQTcgQkNklPBWwzoelJnowCw/ecX5owtCXJ13EpbmIlrlbl5KVfL78S76qzKx7FixMAJK5axNhGsDxo5ZtGf36mcVhJik6QehpA1HKnM0NDgABBZ+F2yGbaN+eRECoxaHvQqILjTHSGrB1+CF5TH5bYS6COR+ltODZPNqtF1prVXS4AJOV2d8OPBrUDRioL3k6xVzHjSTJ8+MqavG/1krkovwf0aOa387GZm0n+iZuIYC7qszV/MdI2k34fuk67MkDEWxrAXJRXBD3Mb0aDbubYlA3/rA8ejpNWGgNIW3jy+2vngEVhI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce378f4d-6ad9-4283-1cbf-08d7417108ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 04:30:03.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdx5DDlm+PzYBlOlKs4eGspxmECDng59r8XhVzzpe9ZfULy6/z/kxLFUed9UEtmi7oRwVndgvfpJ4LvMHGe0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be using some of the Goldfish virtual platform devices (such
as RTC) on QEMU RISC-V virt machine so this patch enables goldfish
kconfig option for RISC-V architecture.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/platform/goldfish/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/=
Kconfig
index 77b35df3a801..0ba825030ffe 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig GOLDFISH
 	bool "Platform support for Goldfish virtual devices"
-	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
+	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS || RISCV
 	depends on HAS_IOMEM
 	help
 	  Say Y here to get to see options for the Goldfish virtual platform.
--=20
2.17.1


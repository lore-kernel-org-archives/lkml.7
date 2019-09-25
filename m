Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E9C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694DD21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FnAxuXaN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dZpxsLe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442309AbfIYGhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:37:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55201 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411896AbfIYGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569393467; x=1600929467;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xDAK9eD20FMwArgo6UAZsCcoUa8BKNwG9TusQsvNraE=;
  b=FnAxuXaNYk8Wj8/VlL7fOkZo4PkeEnLGIAW2pFF5E43j78lpXXiL3IaG
   z0hZeaYZODjTCukS4SrYdeXvrvx1//iEPC0cmfrVY4wXysvxazznnXQ+t
   Tj4sv/cq5HlZqp17bz6ww+0GnJnWPPj1DDU/etT1aiSWXNJvihf5IFqHc
   XlqW7eWPyhrxbdE0RcbdnkcDH05IhXvJCHTtQmrXxAdgwRdI5FC+tn9ec
   XIjS5irZvNZtUs5d1hMMgrRTvRE9Ag25NWuTOp5XBCHUJSs4jEFBgnEcF
   eEOGw76ywaQPOIrxJedUxtfwmxUNorVy0RtEdzyz39IYUylDwEsLI3E2V
   w==;
IronPort-SDR: /UE/zC2PWK+d2w4bn87hh9L3LMYrR2Fwab98IXHV7yWiLPaws6KQxHSDHsgENZt2Oq3NHMMKZP
 9TpUgmXrzB0YoZnaNwKQzie0FaS/wkaBW0s4tp+HiBqL9DuEW/Aiq3Rvnh95G+ZD+29OnAJD+O
 jo706KG9xLK0HXioUBA3E+JWtBEyNxe90W1lqzYmcZe4BvbH6GsMzn2dK0ZRZwzTXSbuF1HsqY
 ViZ5ShDMVQZ6B2rU7wuTce8nFrbaQMcdxwOmLm216eNvWiA6im9qgZdSjjMhR4Hcx8l/E7Ax2U
 nw8=
X-IronPort-AV: E=Sophos;i="5.64,546,1559491200"; 
   d="scan'208";a="120615884"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2019 14:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB3QLcZb4MYTeDDNTFxWEqfH80zuIWR8R9e0fHCRozHtSIduouQfNPTci7U5ahbJHIJWUKip0sw1p4poaF+V5eGhPdjpJOSNwkvGolOfqeAJWlwe8GUD8nkOPIucAKnpkBS107p4B+wlH0Nm+lFi7ZbdeauyYpJSyKkCBmpldcojbPklFxJr72a1f+yUkxfiXDa0uqjESVQit5x70IRDumEL/c+woEdWFfRkyM2kk3alyJN7ALgfJKK8eo/Uu0vtQF/2VbAk3gY0RPqOoiozJJ5/qTuWdRmcfLwm+w5huEne4w4ECPBOb6GM3CmsmeUrnwZcDhtK8wzzlwnXbv1CYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmEGVz7Iakijh5HTCalHIAc3WlFQ/CJbnzC6DaJIACA=;
 b=glkLiffaNBDVJ7UQxNjbFszAxAtZbP7fEM44jyEGJKroFXXLEh5ZPdMuwnyQRFYp9NkkPOusTGEEUL9z10EmjyFI1MzabfEZM4qk6+IibJDCWjSTy4MTCv8S2+q6HOvpZtm9eYd5Ts473qns/PTxaNRQ/tn8V+5p8Db4Ofo9rUmKczREB5sgBmDhKfB7s8AFzTgNZ7yxrf7ol7RFF/Kcy8ey45fRcS7uBDnqqbMa4KLwMIwPM5Kp3AZPjaApvfwi4WNGQfygpysHXUWSu8sUxPOnzCN3H33MjpkQ0vGqNzmKvlhttvF9wx/stFLT7PRzdN8I33ENeE2MGB2bVrTXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmEGVz7Iakijh5HTCalHIAc3WlFQ/CJbnzC6DaJIACA=;
 b=dZpxsLe4ftQuFr/CSY50Lnv7CUO9hApIlWDxA2qdrw1EGrQE9m5jWA7zX4sXYbeVJt4beuynmArGIQEiganqSFzItWQjypaNv2aMT92g4N+/tz5YH6IU7YTsuEY/QbL8l0J7DrDMK0/WdogFO8v489FSBYklQvYO5yjLAKOJRxs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5712.namprd04.prod.outlook.com (20.179.21.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 06:37:44 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 06:37:44 +0000
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
Subject: [PATCH v2 0/2] Enable Goldfish RTC for RISC-V
Thread-Topic: [PATCH v2 0/2] Enable Goldfish RTC for RISC-V
Thread-Index: AQHVc2u81p3C6nz8IUStE6Z4s4ZhcQ==
Date:   Wed, 25 Sep 2019 06:37:44 +0000
Message-ID: <20190925063706.56175-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c31b79df-812f-49af-c8fd-08d74182dec1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5712;
x-ms-traffictypediagnostic: MN2PR04MB5712:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB57124266E4486DF743004ED38D870@MN2PR04MB5712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(71200400001)(2171002)(4326008)(386003)(6506007)(476003)(54906003)(3846002)(6116002)(110136005)(81166006)(486006)(99286004)(102836004)(81156014)(1076003)(316002)(2616005)(8676002)(7736002)(50226002)(6512007)(26005)(6486002)(6306002)(5660300002)(4744005)(186003)(86362001)(305945005)(2906002)(44832011)(256004)(36756003)(71190400001)(966005)(66066001)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002)(14454004)(25786009)(478600001)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5712;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: An32t+t80NfzVG3g6YGYJOzkX96WSeI89+RT7EsKQ4YMkf8S6vavc36uPEUh/iPwknPIbrvPygKePBmjuImoWFZfX0JkMNbvYSxOByI1LHa19b2ZAQGxvI/2VKQxCTiykBlyVQamR0H1EvxMWwVC68vuz9LiVUMKt0JUBdQ2CGmPi4PXFIVmbK8C6PYu48LbOMrnOoubkraS3j7RtkRaypOW+WDTt5v6tSqkzTqd8MTMZowHLh7LOCnvovdFsYryhqUjS5u1a2Y9c+C5YxueQGRPjMViSUkX0ztDPE+YqLNBUoFeo1r0NK0m2ESBHzz9jVM7COoRnQUcF+qc6v0VlmK5DJ6yP6bm/BzXRxGX5PWadzZlowvIBT8LK3EhN+oqILQiyYlX+8Xulh9YfhQ6RAUAzkry7V2x4px4vUy3B/ea0L7Uf64FUHC0U+1Az425NJ15463kmAU0vZt17jnptQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b79df-812f-49af-c8fd-08d74182dec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 06:37:44.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnWSDzlqAjGuWn6uiO9zBKtsaRxXHhoykRYdVOlpcnd0oWaK0Xc9Jk6U55iYcUzhIhxN4EU1QeTZQ0nZ3kaYNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be using Goldfish RTC device real date-time on QEMU RISC-V virt
machine so this series:
1. Allows GOLDFISH kconfig option to be enabled for RISC-V
2. Enables GOLDFISH RTC driver in RISC-V defconfigs

This series can be found in goldfish_rtc_v2 branch at:
https//github.com/avpatel/linux.git

For the QEMU patches adding Goldfish RTC to virt machine refer:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg05465.html

Changes since v1:
 - Updated PATCH1 to allow goldfish drivers for all archs with IOMEM
   and DMA support

Anup Patel (2):
  platform: goldfish: Allow goldfish drivers for archs with IOMEM and
    DMA
  RISC-V: defconfig: Enable Goldfish RTC driver

 arch/riscv/configs/defconfig      | 3 +++
 arch/riscv/configs/rv32_defconfig | 3 +++
 drivers/platform/goldfish/Kconfig | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

--
2.17.1

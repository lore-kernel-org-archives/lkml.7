Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6AEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF17C207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AWidT7Rs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kdFJmD/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfKYNWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:22:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4276 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfKYNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574688162; x=1606224162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bsi8t4T7byWAp4HJVshpgEJd+swfFKATtJn46gaJqNI=;
  b=AWidT7RsdiK6GS3cLSZnCOhXbYl8umvbVGbPSfbNxqc9Pf/2khm71e27
   G+cxvb5MtfknuCGJH0YhMJmxDzK/UdiJ3ObVU1g1j/vDWYEHHjnQCJJqM
   Grab+Gk/FTMatmGjh1gZY+gqXcfCBPyPml7UlWvQ/TF7nO4Vo8oOlaoM4
   Y5YwD8lE4aD8bpXKPAfupBYncqyDOtRsz4cikePoUlHys+JnXBpoU9XUF
   tooRzn3wyxe4INGbn+BQLffcLJCtBIDMXPr5zKbrC4kyZtPiuPwjeSCWz
   qNjeOfwkUONHtWYOu7zE56WDfGFZ9Hd0yDtt2udTXbQHZwGf3Fb0GYBKV
   A==;
IronPort-SDR: nHF7XThrgpSInJtxTcJisXDxQsLU/HfF+gTrs+RALHqP4YaUVKALED6Z+MLo+n7HpFMy43GkbO
 r/TbcFFfX95Mks0OMXTprhmemXmtjTs9cpPV4e0iEdxcEnfs8XJ5dI3KjgQUNF4jYbYm5ftGfZ
 EfGyqteqv9eEDPmMdPyrw5XJjwDBmMhMWwh1NY/gtBkcGxVXU8r9nbHMv0GpfkNmDBjWyogf4V
 /kYy2VGgsEkYz8VP5+k29H3bc1cVCdBM5Spy8HNFyyZeodGIQZ3/hdP3ADTJWtrvBTyM7EvamR
 xhs=
X-IronPort-AV: E=Sophos;i="5.69,241,1571673600"; 
   d="scan'208";a="125552386"
Received: from mail-co1nam03lp2056.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 21:22:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXMz9Sdzdl7GDArTpmu4T0l7mNl4s06JRH0ZL9VCmt4VKUTGCor4B+O6chu4KrygjxaZ/EVE7NkQMltWvBYlgFw/q7EPe0UaMYOkX02GgSZJQ656difwC3A3Uf/X+JV0hOdelg0nCGRPwSD4i2zMyaHVpyBbbJGJNRZ8rCckLjYP9u4XGihtfrskqkuDsIc1ObBoW2aHmq+vp2nFngAujBiQYzhvNjoSfilzPTYRBHQQoBC+2IBBkM+ENVxI8CPZylrfKK4GAex/0GEXMSRRR3JZzREpgvnpo7eIKx6zbTfyPTUtMr7lcb7XP7UZfgSapNe73Ete4sLbEd+mM3PQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNc1vOAjhAgtS7t+/pFWWR02BxR6E4z6NQcusdM/MTc=;
 b=HRc2fbxkkdP5gDo4HI59h14krIYbcL6bBvvfiyFImYrr764vOyAZiwvebtl8UcIxqaRw42IyxDJsi/6oNJZaWr94UFOtEs04IvEqbhWOQB8NT1lOKV7QHMzQiSg/0wPGegibeTn7YFLDh0uJyt3OVTaKHEmpalCL6h4sWhGBFWBAQ8/mHjdp/a1GUuriIqL3w+/KxETYwHcdiPclyVSCiewI4mLVSkjBfP+00GOUOnnwfu5DMxwkD/rlZg2Tut39rvGCQEmbexqlMcOasq2qLK9qHCoKrCBH6YtKvuDw8CaQIxC26JHAvCoiJ/IzvgDf4tpVsvmOnt3fsD4g/vX/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNc1vOAjhAgtS7t+/pFWWR02BxR6E4z6NQcusdM/MTc=;
 b=kdFJmD/KiH6s6zhLW2NUP6CfXRjbzQ8OzCZLg96tXAIG36mpT/jz04xkVcjF07z1MDV4ZlcDz6VqXUuckhsQZT8VGjrpXuTnr/F+eoEgJEVtghUNNMxueY7swKQDxbsMmBgNPgFRZCWG/12dVXO0v+43BPnsF7TY6WXswLlgVLg=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5981.namprd04.prod.outlook.com (20.178.246.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 13:22:39 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 13:22:39 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt machine
Thread-Topic: [PATCH 4/4] RISC-V: Select Goldfish RTC driver for QEMU virt
 machine
Thread-Index: AQHVo5NoD4LpTQJcok+mKVALFiqEXg==
Date:   Mon, 25 Nov 2019 13:22:38 +0000
Message-ID: <20191125132147.97111-5-anup.patel@wdc.com>
References: <20191125132147.97111-1-anup.patel@wdc.com>
In-Reply-To: <20191125132147.97111-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.21.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b58eba5-7df1-4810-0fc9-08d771aa8b16
x-ms-traffictypediagnostic: MN2PR04MB5981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB59812FC8D0D01C4BCA4F6D438D4A0@MN2PR04MB5981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(14454004)(50226002)(66946007)(8936002)(2906002)(81166006)(81156014)(6506007)(66476007)(6486002)(305945005)(25786009)(14444005)(256004)(76176011)(9456002)(54906003)(316002)(8676002)(6436002)(66446008)(386003)(66556008)(64756008)(110136005)(99286004)(52116002)(186003)(26005)(5660300002)(102836004)(1076003)(44832011)(55236004)(478600001)(66066001)(2616005)(71190400001)(71200400001)(446003)(11346002)(6116002)(3846002)(86362001)(6512007)(36756003)(4326008)(7736002)(2171002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5981;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6dNzhOQxraAmUCJ3C07EGexvAW35L61GvOOa3vKz/QwdcBf0gcJnY0iozsS0tUrMbGHYnAFQ2JH2/CgLiSuW+BGxWSV6KI0kk3fRQyLTGnoGECXgHJgZXgQpvfN1P0gwzLJ9/pHqefnOpu4g0d9HI1rAXOcKd/oVdMKc+Zgyye8xTIvOYaNWtlRlQy7zHlcmZJptrfYLkw5BqoIaRTkj4gaKBgsKfbQtj+eJ+dtLXKR+d4KLy0ug3/xwv/it3QjhYBUcsnjQOVi7lWUAAzf7LUNdIC/YBYAOcJ2dTBB2ioPGfJAOP8/pOgONERo9DnERfjKf8yyff0MaFGtgZV+eqW+2E13616k+r10EVG4lgWH3Tl3PZw4lN8UKNNnt0k5FxIt+h3xvTjxebu1MtJwrRpqcpluNp1QqVuEgPkcTb1nMnfqwslEtjfZDIS3Pfuj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b58eba5-7df1-4810-0fc9-08d771aa8b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 13:22:38.9881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHq3FkjnXkox1a9M0C/iLOKKQDktVHmj+qrU9Im1aYhplwTj7unaPFZIKEGW3R68rWYsc30c/eU7+KbS/C6koQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We select Goldfish RTC driver using QEMU virt machine kconfig option
to access RTC device on QEMU virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs           | 2 ++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index bae4907b4880..65cf39867c60 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -28,6 +28,8 @@ config SOC_VIRT
        select VIRTIO_INPUT
        select POWER_RESET_SYSCON
        select POWER_RESET_SYSCON_POWEROFF
+       select GOLDFISH
+       select RTC_DRV_GOLDFISH
        select SIFIVE_PLIC
        help
          This enables support for QEMU Virt Machine.
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index bf33bd40ee07..c5e04384ec3d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -73,6 +73,7 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
 CONFIG_MMC=3Dy
 CONFIG_MMC_SPI=3Dy
+CONFIG_RTC_CLASS=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
index 234213b4ea74..7972b1d321c1 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -69,6 +69,7 @@ CONFIG_USB_OHCI_HCD=3Dy
 CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
 CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
+CONFIG_RTC_CLASS=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
--=20
2.17.1


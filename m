Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D9C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B468D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SsQ9MIsG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WCu8OBYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfKYNW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:22:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4276 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfKYNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574688147; x=1606224147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=horAi4KzBP/7dsI/GA0yclgax0jj3r7MFi58WYxfmIs=;
  b=SsQ9MIsGeR3oFbokK0YELAF7FWWE9ZchFGSMjNuWKxzyHsdouybxw/Az
   tI7IJrn092dC7joEvJcsiultzC0zAulZya5tfT7eNOtcnfjnDmmUK8QOJ
   kCmOz1CFqQ6eTWetO/5eETOeVFYzfx4/Tr9F7UJFa58hHATHBuhf8i66G
   PmZtfI2erIXuatp1213gOxtA9zJNVdAg8GOS/bkTK9O+sJaYVR3RjA1zv
   hfVVSZ8wv+BLLr0TMCy3Vvp3Trr19TLIbxGC7uBgTh8vxCe+8RhsVd8MT
   iEPgqig5udcwDmVIxVvChilb7LwLj4LAAHDKKmVwKPrGrQiQTW/3Kq0GK
   Q==;
IronPort-SDR: YuuuS/v0UiBD0Vg/30s2VqF+TF09Sf+sJRCH5Qx6Pl+TqcsP10s6cAlz4Nt9MD4D2VQjADo5o9
 9qc2EpZTtorB7AU8xozo0wV0CxDwTXSN2BFlGCCx74+uJMyxrV6XE0d2R3pt150GbYcaxslAKq
 jKcEgE8KjKTbpXKkVoYJ5h7YM/Tw6VeaY/c0nhfKxQFnJ3O5948oxs5Agy7LC4BHz/g32AjVai
 Osyn/w9yQ+8WjW8bdjZtYPFSahGl4bkJrf9ul5LeP+SJVqS9xOKEJRMA+35CemjXIsUao6v8dp
 PwQ=
X-IronPort-AV: E=Sophos;i="5.69,241,1571673600"; 
   d="scan'208";a="125552361"
Received: from mail-dm3nam03lp2052.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 21:22:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjwiHsn5hJt8gaH/67bfEbCsL5zODejDpyDuWTz9cbe3otjmOxpK6XU5p0/wFB4IsHTfXvV+FBahOtFfevi0HzW4wp1fWLH0Tgvca6r1+8XAvR+cMF1n64d9/EeCP+E5aRz0Gis/aTeMN4EonrfZF7NPQmbCs/HfqVgzJd1yfXysrGQmUQBn3J29hxyT4EZJ+7lKZv92GDO8ruHNUSM29S8X8AMFRXCMgGMVayb21kX/WUD9vweIPR2DhbO690kCn64RzqYHhI7+9u1tpOZTuVqvD7YWNbsE+V74VcVeiZuK6hEvpMHtbeHxXyC9syDEaxPahP0sN1QwwBFVn4ADjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMn5zXhu1i0vo6FLz6ed6vtvjkBO9LVnTk0Wj3ZwH1k=;
 b=GmesJfAGWhWTDilepkX/WOdc5yn3IMvxaU34YyszMsnvZqR5q/d/DZ7wfZoYy4kLydCxLikO5Pt1MIudSmIuCl9Wl+XqVhse0whX90HacLIZ01Us6s+xqYRMlEV25qn6HUbRHAqhLPUnVLlQ4UKz4pSC+iP5JE0yv52J1IVyTms1BI3i25SFwzg8oAMi1EmGNcP9ZUy/OLM5i6RU3VlNVhXxlLrflcsdbci+Y/2RCvNGLJGMiABkCEjsz6KIwjhE1dkgBPbOxSrs/gJK+JIq1iqh0VsqZdDM/a16//rjhUOJjxPeestagq2ESZdumKyqnRb64vN5db3XaBgASxxrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMn5zXhu1i0vo6FLz6ed6vtvjkBO9LVnTk0Wj3ZwH1k=;
 b=WCu8OBYUMK55hvL3iw3ZPfXhTkZnMqBk08ZL4msW2usZjrapJzAtc6Buu3p2ii4Nrb1Czl0nHmd3hf1zlJ7Lil7n8lBm/VLe1fd29K9jkRQutqeoKbKADTW0ebJKBqtboueZfuAZ5GZar8PZk4FqLlFiHT/P/CYT7NGdO7paIEo=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5981.namprd04.prod.outlook.com (20.178.246.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 13:22:23 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 13:22:23 +0000
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
Subject: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Topic: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Index: AQHVo5NfR7JNI4Hx2ku+Z33hWlX+RQ==
Date:   Mon, 25 Nov 2019 13:22:23 +0000
Message-ID: <20191125132147.97111-2-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 575dc44a-95a7-4dba-8adb-08d771aa8181
x-ms-traffictypediagnostic: MN2PR04MB5981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB598142769DE7855AFBCD1D178D4A0@MN2PR04MB5981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(14454004)(50226002)(66946007)(8936002)(2906002)(81166006)(81156014)(6506007)(66476007)(6486002)(305945005)(25786009)(256004)(76176011)(9456002)(54906003)(316002)(8676002)(4744005)(6436002)(66446008)(386003)(66556008)(64756008)(110136005)(99286004)(52116002)(186003)(26005)(5660300002)(102836004)(1076003)(44832011)(55236004)(478600001)(66066001)(2616005)(71190400001)(71200400001)(446003)(11346002)(6116002)(3846002)(86362001)(6512007)(36756003)(4326008)(7736002)(2171002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5981;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLj1Sn+7780JHvqSGGohnlhYmDI1X9cbVVUHczwvYdZNZI+vVf3pSLboNF2KAp41qyAq9TVCsHuIdGffuxilqK9DgawnFew+xEzYJ7hqwRFv6NryYHby5UVpdlu7n0rc9aodHe4+gTvprSIgX3AILLTTY5NS+n/JnLkdLeZq6wNLoXv00zYCldk7M2FaIJhSeZW/QDgviDqO7w1f7oWsZjHm1ywMUf4agyNS+46lJgzFf7/GIDpmWfK0O882DxcIIWrnjouAZNBhTy4auXcoO7sn8F8A0AEEHyr4WNijIDWxhQQC+zTtsjMKurO3fnTIrzvihB/Kxrdr+QrxOwEKtuHdCre9RFfbrKm6toNrG0LP/nZvWHRpt1h3Rd1TdwzIPkMVBFJK2QJpppTLXWJ4tgTdrQsqe7RPiUX26RDmKAQL/EqlQX8oRDuftaC147RC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575dc44a-95a7-4dba-8adb-08d771aa8181
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 13:22:23.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaY1ke8iHiPbY8DPfzGOpilubvvI3n6Fxr346Ts9s04sJyrmWY4Mu6GqFmSrRoro+Q/nxFcxrigtIL0D9LeTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add kconfig option for QEMU virt machine and select all
required VIRTIO drivers using this kconfig option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig.socs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 536c0ef4aee8..62383951bf2e 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -10,4 +10,24 @@ config SOC_SIFIVE
        help
          This enables support for SiFive SoC platform hardware.
=20
+config SOC_VIRT
+       bool "QEMU Virt Machine"
+       select VIRTIO_PCI
+       select VIRTIO_BALLOON
+       select VIRTIO_MMIO
+       select VIRTIO_CONSOLE
+       select VIRTIO_NET
+       select NET_9P_VIRTIO
+       select VIRTIO_BLK
+       select SCSI_VIRTIO
+       select DRM_VIRTIO_GPU
+       select HW_RANDOM_VIRTIO
+       select RPMSG_CHAR
+       select RPMSG_VIRTIO
+       select CRYPTO_DEV_VIRTIO
+       select VIRTIO_INPUT
+       select SIFIVE_PLIC
+       help
+         This enables support for QEMU Virt Machine.
+
 endmenu
--=20
2.17.1


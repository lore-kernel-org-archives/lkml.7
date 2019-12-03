Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323CD206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YtG1PovD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lvAQW7NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLCDtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:49:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65119 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLCDtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575344973; x=1606880973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5DHzY/TI+dRQJvB9HZniY1xx+KA4MPagqU+gOZy2kI=;
  b=YtG1PovDOvpwN3sqSaojeohE40rjROYC6N20jb/qND8ZbElW4JKyETGv
   pVwoZICRFboBrUufCeJNDr1IDZBDXFf0oBZp2+ECPys8tgOqxJheqFzAK
   gk/efmZF59tuLNUFmhdb6aDV6tFH0i2e9XDo8rhBcHPWA2co2PJg2seRR
   +6uCKWv3FTR00OSkL9YvaxFWcuMHIPip+pivDB07p7eTJW9jZ1WMdKhdc
   eTaySwaJ2BHgaxP2ztwvwDrY35sZ6VEHiYsYbFRtiTGvcoN6N6pjzlrQQ
   PQTzItBepRimEOEaHRjkcfAynIfQ9K7xHw21LRl4Ew3QAd82tRj6mTd6n
   g==;
IronPort-SDR: 2a/PPVX/GZlfgr52cZHBEVC2cdZfRBfk2ZBrtI72gMmmQqpME1ljdMixyV8aQOo3pf7bo5jNm7
 VenMsGzWwpmg9x2JDnsD4vt7XDjQtASdhTRCmNdB38t5duMY/kBexqNDuF+gEWQOx8cJ1NuqjV
 0x/tedb1mT1+Ao8vQYYI+iZECVG4LStCQ9Ao5nG0wNH8lzswV0xPtQLFlLay11Qb/4NqyDJfpf
 pSc6608beqpzFVc0ifTXTw3Zoo3axF9wYK7Ok4D3c3PiV6GGOG03o9U+fgUAwVfsIgRlekO1Iq
 XT0=
X-IronPort-AV: E=Sophos;i="5.69,271,1571673600"; 
   d="scan'208";a="231947960"
Received: from mail-sn1nam01lp2055.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.55])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 11:49:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRK/6AcxMwNbTmbWbKBf4ft4eS3cIWI5j6klS4/uMRU7soia/qC7CSgV1P2APDuXZHBpei6br/X4K5bHbiXc12qQmp/8LKlL/E1SzP7z2lTUXGWTrEyZcrJ6+o7qzdZK6RszsIAdyL6qU1vedzGI3zYowT3du7aGhnmOgS5bYiQ1oehdc9yHAxqF0F3fIPLaNmA1gkuVloQO214QOnvnlD2+88TriUhS2r6UW6NlAQqUhLrUWQhXNm1TcLgQZ4wbT47WaqW/0Yl181qjuxQbZY56L5yzip5sHDhgoPxgiw/EeVJ/cYg3ZdqQuArzZyJK6UNA5RIm8Sufbh2xKJRxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEJIr+QiXaaflHlZ4EYGuf8WZ7voD9MljXBWnsexI2k=;
 b=jnR3RjNY9Ggp+xAgSannZuBJ4KUk+IlXXXHM/OCTib0W5aKXzz2OG6uZ47T5GjEV+y0LC/OHm6THZyzGRzDDvYPiXh7H58Kp1Yjx+FZII4bBIJuINEFshOw8/NzTX6E2mLiQxFHkIFtBdskgrv2CcTFjyipnC+fapqeJmeKOgCx5+vzqlmtA4AMkwpoEm/7n45BpxnooCg2hi2CckHd8uT/BBVztqBmQ25kKGBQYyvuGe2URZ6NEYFXJOOE9fQOo9jVEiVRzjSY8q6kZVmnw09c1TZSSaTClDSpEe/Xx3/EC99TP0xAa3izZRPvCKpNazlZ9eRccJTgp62RmfA3ZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEJIr+QiXaaflHlZ4EYGuf8WZ7voD9MljXBWnsexI2k=;
 b=lvAQW7NAMIg9QmrGvXUobFjXIy4746KHHbfC3SZfeCoeRVMkVLyE1hHKi6/ib0+9S3gD9bOEVMMvKRunvDQ7R55kCk+LDTuYsUDoJzUAv10zpOrLHt3C0WHULYZON2z+ZWpa8fxEorquS9VLD2OhazmH9gTuQ7dCQ5TpukbF2Co=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5807.namprd04.prod.outlook.com (20.179.22.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 03:49:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 03:49:31 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Topic: [PATCH v2 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Index: AQHVqYyr4UjTWKXKREGsKPB7m3aMbQ==
Date:   Tue, 3 Dec 2019 03:49:31 +0000
Message-ID: <20191203034909.37385-2-anup.patel@wdc.com>
References: <20191203034909.37385-1-anup.patel@wdc.com>
In-Reply-To: <20191203034909.37385-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [12.169.102.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc16592a-a8ca-4cbe-6da5-08d777a3cd86
x-ms-traffictypediagnostic: MN2PR04MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58079C46EE0F8B0262F5B9938D420@MN2PR04MB5807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(66556008)(6116002)(3846002)(66446008)(66476007)(64756008)(66946007)(25786009)(52116002)(76176011)(6506007)(386003)(186003)(305945005)(7736002)(26005)(102836004)(478600001)(316002)(71190400001)(71200400001)(14454004)(44832011)(446003)(256004)(11346002)(2616005)(2906002)(66066001)(81166006)(8676002)(50226002)(81156014)(8936002)(110136005)(54906003)(4744005)(4326008)(5660300002)(99286004)(2171002)(6436002)(36756003)(6486002)(6512007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5807;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Pzxunqc4lFKnXLgGdTIwAWlfxND/0sYxyNGSk/HEwUAn9vl66dFCTSHUiV9Kq0kDrzz3nNQPCRE7tp8+tl8kBFu9gIEWGG3FvkDJ9zEgASoH+A8gMjFZi6dUbLjIFoLctmLyVi/xYDO47AFeZjWiUVaEkok6WFOCm2QqNjhXTytoYGULHraXu/ye0jNPAVgQT/ygJajRXBWMvq0VIE3WsRfXMfzhfF3kfcqwQgMj0zHotQGX70yKUieZ5KcwJr68VhXs650Q6VtzScYv1VWh9VWWrPdjrKirgzjkjbJhhPK/1ycm9Q7X2XvVQ4l6MQFs3V2+sRvMecGtxU49KLbeNRfn88Dpqc1Jz5DRu5hqmYvVxayKOCk9IJrJ3gN8sZ75ivQGG8rXRt24jZRacW8j/3s3JDQBg+Hg2uB6uoGuMAxWRI2XcPjKO7zUAcKJkmP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc16592a-a8ca-4cbe-6da5-08d777a3cd86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 03:49:31.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCax64wdC3mlYbRPFu+QSSdSyReCfPmW1Da8U49htUXOdkqb3/WepqlnkIiEN8b9i46MoDIQ2qnK1gtJZvSE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add kconfig option for QEMU virt machine and select all
required VIRTIO drivers using this kconfig option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
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


Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26136C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA3D222CB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dmj0Y53/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tE5zba5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKKNfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:35:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11746 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573479300; x=1605015300;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=B20lMD2o+jlF279OvcESadwAl9e0f7y8w1QEbTC5/IU=;
  b=dmj0Y53/28Vu/MSuIPf+hWbMcg9yIE3uRmqQa3dU1jEKKJ6PpIR+ODDL
   Jb+AWTjF0Ki0ufCoXt3Krp/pQIAYLeMkXfYe7Jqk1qn88b6zurcy1MW0J
   FVeUNfjHxE3wuguRtUZOxCoVHfK6pse69I9ir5GWK2AwiMVFz6F/5rEMe
   u37dd5A0PVFt6Woh/o51PrFJlAQ56lOTMCNvjPUMyDLfuldIXt5K302gF
   nEqv1WjFCeJtrzYY+5Po/Ji26eiUiKU6S1IxJ+OPar/4xjSmDbxOVEti6
   FdmA7TR1cnTzbWDn4dcPu1Py64FHBMZX2UVvJlPZB/FegBEb3tQ85q9yu
   Q==;
IronPort-SDR: rXxMjmdt2UDx5XpY1TA45lbR8wesCHiIyhIYRoWupt2xzaagT9QGP68uHdAKmuUqfLyBMFG1G2
 iPt8n5UWxVQi9htveL0kGjdDHsZxQY7LB6nlXUvOxvch95GQFxC/weRaRKRTOkLOONa6cMaPZE
 cTRRg27qUGoZ1C82CKmIhemY7k2aXicEqF3zMfFb+ZtXdWqCmOq1S/vSzDlcqdmvw7ViqYgiSV
 1RsRbcXMekdX4vo0Lz/a00d7YsMFG+Qd/etXuewvELWnF2IzQQmeBYYpqhplLsINc+7ka6qCbW
 zlc=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="229957749"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2019 21:34:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEddivtSsoq+UBEfnFugdz1HXk8ul8GXhXce1jvwggvHJYiu9jAcIHGcqg2F8tH0AFQRTrdNjY3eb0Iqy08KxmbHAHITOMLYg+8p/zquCYQ4MbsB1jlTwMlG6sFVwg/3t74pdS1TMdjJNRMnjvCUynpP3Hhb+DkynVJK+3Y3y10SRjl1KK3bmVIOA8OYNMSvjyN/ZXgEizaBFWT2qgp6n4QbtHHUiTyLTRIakI4lBu1EZpCh17algjNhtGR0H1AGXM+h81xvWU1myHKyK5TboOIIMa+A2f9Ny3y/qendh0MYp2yHs5aaZSPOA6H97YjTGr4Igd5WTXuSC/YugD5UiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDYnW7Ql0H324ZrDr3qLgI7BZ5qSkz9zfLBqA8DL/ZM=;
 b=Kf4r/DA29qUZNy3HuL1LSW8ZJLcFxix8RRjiz8iniYfLT8EYL034kUxfyrKPFfn/kyIqWyeUFTfZnhAocqewPtD5fD72NlF1iwKbm74Y8ZY069TUy7kMrZo65/0SfDMJSZN9wWwpsv6/4ITWhFeBy1QyiIxaZjPoxqWG2jU6iaU9FafRfSW/Vlclzu1wvuKM2daLu5B7yiSD1TvWUpdc9J4fb4yXWCnAtnf5zrj5gw5L74K3FK4vMN8uSTcmVmHJ1SLVxzAVkM4QHrDG9v7ny7ABYa1hPdnrbpJnekEHs+p417pEV0w9Aa7C40UBwCivDtj3Pqn7WZcxAB/2ZFdv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDYnW7Ql0H324ZrDr3qLgI7BZ5qSkz9zfLBqA8DL/ZM=;
 b=tE5zba5/5pSVkE/OJ59NNI4//onoVU7nj1l8XHNLWxefeE2ZJumMndMnAv/ISPvr7V2gSajwZK+s2yxncrGwANrMhWWISuNwJJQJOslimd60Ht5LAHdZwBFhFakfRBhZGos6P9+d0tz7L0t3s89SQyg2YivBSH5lR/FqKv5yYhM=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5838.namprd04.prod.outlook.com (20.179.21.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 13:34:58 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ac5b:8360:b7a7:f8fd%6]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 13:34:58 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Topic: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
Thread-Index: AQHVmJTPyH8iXg4fS0aBJhwN0J4ATQ==
Date:   Mon, 11 Nov 2019 13:34:58 +0000
Message-ID: <20191111133421.14390-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::31)
 To MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ca2a562-c83e-4f9b-afab-08d766abf1de
x-ms-traffictypediagnostic: MN2PR04MB5838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5838462CEBA5162EF3E5CC9C8D740@MN2PR04MB5838.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(486006)(6486002)(305945005)(2906002)(186003)(6436002)(26005)(1076003)(476003)(2616005)(54906003)(66446008)(64756008)(66556008)(66476007)(110136005)(25786009)(44832011)(99286004)(86362001)(36756003)(6116002)(3846002)(66946007)(316002)(8676002)(50226002)(256004)(8936002)(81166006)(81156014)(14454004)(5660300002)(4326008)(52116002)(6512007)(386003)(478600001)(7736002)(55236004)(6506007)(102836004)(66066001)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5838;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlUIT4gyVDUIw9QGror7PZuK6DvC4hjUseg0rVQ7ur/2V7bbqzHuqWpD8OQ/IFQdFN+aa6TXwcwQ+m+mtNVtpgQKkBWpQQhsN+FCPqkEt8RhuQRNXHakEXGODjyn2hmnSkSs7wj2HVqHm0f0Dts57fG06e5HEZgqz/gtzHk+OGfmNS+yFUw4WO0k35g5AZ3hXEecRtKwmGnCOMe341NWL0YYt1wPCS7CB2XjQ+v2+XYaPrM7/YODJx5iVkmLKi7UEDrO/RnKH/seq1TXuyOK5vnfKYt4BIKIM5gFSH/XGBAE6H9JF3BXzxTJ2WrHC0RLIU0lQRQpUcOftDeayVULN2FtGEr+DAhUKTWtFcD3wG71M495+FvadBmV0ZpFs7s9ymX6ZhRBBwxAhWtjV8+lq1jBgN4r0p6q0ixxIaE8lf1XlCJgYRlLCZKgoojqyA3H
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca2a562-c83e-4f9b-afab-08d766abf1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 13:34:58.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBUuYJe0vupLLsLiz4ISngf8uYhDrG0Pig8G70diR5yV3/0aNgXQACbh7Bu0oMvNGOahfZMaGiKcd3wNmxCZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use SYSCON reboot and poweroff drivers for the
SiFive test device found on QEMU virt machine and SiFive
SOCs.

This patch enables SYSCON reboot and poweroff drivers
in RV64 and RV32 defconfigs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/configs/defconfig      | 4 ++++
 arch/riscv/configs/rv32_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 420a0dbef386..73a6ee31a7d2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -63,6 +63,10 @@ CONFIG_HW_RANDOM_VIRTIO=3Dy
 CONFIG_SPI=3Dy
 CONFIG_SPI_SIFIVE=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_POWER_RESET=3Dy
+CONFIG_POWER_RESET_SYSCON=3Dy
+CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
+CONFIG_SYSCON_REBOOT_MODE=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
index 87ee6e62b64b..1429e1254295 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -61,6 +61,10 @@ CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
 CONFIG_HW_RANDOM_VIRTIO=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_POWER_RESET=3Dy
+CONFIG_POWER_RESET_SYSCON=3Dy
+CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
+CONFIG_SYSCON_REBOOT_MODE=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
--=20
2.17.1


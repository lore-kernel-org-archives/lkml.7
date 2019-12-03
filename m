Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14841C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687D206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AbfWNlRp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IGyWSat+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLCDtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:49:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54160 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLCDtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575344979; x=1606880979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VaTOvvd+MkDxiGg/xGJmIeH7GRWGvCfSfcnZCcK+JyY=;
  b=AbfWNlRpycrKNK50i8rNIa1ao1qyib/n7QZeSCu8m66LswCrhziTLvO1
   G0ivzKqEXUuFB33h3eS5STJkrRXY0LOcEJNpr+shBjm0qIrsJqyQKFCrt
   ndkg9XVk4nV3B0cEMQEJ9RnJvICFCaCV0fGFLBsLOGOb8z8lhuE7y4qON
   v2ci+lhkQQD0QekDPhaVrxdKzNTRpFe0H8A8lwjJCaQ6tzv48vvfNrOo2
   jMiVCfrDknMjXqAPixuXDTAPL5MAaMeMz6N/QFof/ytaz7icQw6J/dUWZ
   2j/Ei1wgMhSTFLZWD5gIOsYbnSR2WiGCZx2jt7t4ig+qy7gL0L1tr50F2
   A==;
IronPort-SDR: ft4UWYN7k+ZE2NOsdoqTyFTfZxIx0T3UdtUmskc69k+5n5pd0yP1PhULrwj1IP8YaO1WrfS+/u
 pHL3IDgCT3t6w+/oebKRIwo/5m2YEqLSIK4j/DZLxPPleJt8fNO+LjZz/jrRYQpiwfm5jfQD9T
 GuqFQf5o2ZdlgrxFM6oqUu4GdZV5v+nxiYCLIVFv9F8y9tMHycqy0RHZxAruG8o6MyUnQmnjgt
 XMQGy/9j0bh0w5xGjQPKaumFPdz1RwnSI5TB+WEj2u1lixnRcqvc6Lg2WXMDOY2hbXruPvjqmc
 tVw=
X-IronPort-AV: E=Sophos;i="5.69,271,1571673600"; 
   d="scan'208";a="126069218"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 11:49:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly+QPZ7rq9ba4GEAfR3qlAGajDhvNg8fQ3y0KB/CT5gMkFSsbwcgN6gkSyjU7Zx+0Vlx2BsBsicwA8rzkIyGfmUo6oCrUACbsNURfAyklzt5S4436LcfhU4cXetYpNZ3A5M76OSdnIYRrO4ELOMp0maify9IrWW/IDga1pf5WV560kvuIhtU+odsF1LBjg1yiORfFaV1JDA7lnW7qh/emiq93IFl8kKNwAE6fCKW38AI8cTygCphW29nZ5KygtS350rnhTvBf2ImJlfO+XOUHHjUzRNsUDEzJT8G56epq+5PXtt6WRVJn1jzRr1Wff0+8+KRtWielQ2p32LjhGYaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1yvc+oa92sYt185PPEJQrXvsBPIMg3LEUTwTyGsZs=;
 b=AAKPg254hRvtA1drufb+d8KJ+9I3lP1YMHnTVGtyttLJES6BBY32Hcz7W83gMwe5kwp2RwMUIR1Tvi0SQcgt8WE0o4oqHt/1RCHsnPTKB45etsXGe5k4+6rKTOlEQJGUfLwrVbdqxsczsciPPma7EntMo/KtC8WJO5brGrnwbz9Sq2Sx1HxLKMdpJs480JDRu95bfdLvLO1nAZ4BCjzxMBM85Dyg2QgSbZOjRaCSfPgXQfIUY8rdZGUVoThSr93vHRxvNUBkaZ+adl3pNqT1ODOT0jfUUhF+9fZHBiAicm/aOlXkEgg01VjEolNGQfXdtPsNUW9twURD8He0UsnxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1yvc+oa92sYt185PPEJQrXvsBPIMg3LEUTwTyGsZs=;
 b=IGyWSat+HWuXXuA4YsI9Z57vm5MWwr96sRLofcMqfg1mhaEj+5YMXHJlbszYZVLwpSUN28zt6ga9d+8lhPwrtYm4k/+e/WuN42DDfTKGk9BpgZxrp+NE+Ej6GQ/SF1iUh1Ht2PMIfwiZUdrko9/8vXYhc0VcSWq1oTJ6yrbBWyA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5807.namprd04.prod.outlook.com (20.179.22.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 03:49:37 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 03:49:37 +0000
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
Subject: [PATCH v2 3/4] RISC-V: Select SYSCON Reboot and Poweroff for QEMU
 virt machine
Thread-Topic: [PATCH v2 3/4] RISC-V: Select SYSCON Reboot and Poweroff for
 QEMU virt machine
Thread-Index: AQHVqYyuT1WruYC6ZkKNWgYy1d4XCg==
Date:   Tue, 3 Dec 2019 03:49:37 +0000
Message-ID: <20191203034909.37385-4-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: b7fd9b06-0fd9-48ea-9a81-08d777a3d139
x-ms-traffictypediagnostic: MN2PR04MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58070E7E58A42D754E3ADF4F8D420@MN2PR04MB5807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(66556008)(6116002)(3846002)(66446008)(66476007)(64756008)(66946007)(25786009)(52116002)(76176011)(6506007)(386003)(186003)(305945005)(7736002)(26005)(102836004)(478600001)(316002)(71190400001)(71200400001)(14454004)(44832011)(446003)(256004)(11346002)(2616005)(2906002)(66066001)(81166006)(8676002)(50226002)(81156014)(8936002)(110136005)(54906003)(4326008)(5660300002)(99286004)(2171002)(6436002)(36756003)(6486002)(6512007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5807;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM9El4b1NrQD5rY2FVzthRHKz8gXOkBrFTARba0S70cgJ/XUm9xDScbeRkYrva5c1B+W3XOpkdp+QATiK3oSkIFHkwfmxnK2Lm8IMPGi1JLU56v8sn9YDWgEVkDZFqtDHcDJPJTOwUaORwhU+qz8f4BLUrwqBbUUwLHoOYUJxd8LJrrTxqVN2TG3H6N6i8iWwOhMFaMn7PXdp+KmLp4nLwyHse8nHOZ3BtMTRnRYw5HlOuxD1S1AjgvY/eMvnvvfVq7G4mo/9cgJIxX1tGq4tbiL1yyM77WEvVECKSGYOvHYJrNoVfqqsqKAr0rST8wccwLgOvTgRNtm9FQ8NEyhMkH5q+T7K3RLrdWK+ily7mRGyixMlvjXVFI6BmQhqqf7vLXPGgfxTp+Xi+VQ2vjwPF4/lV6HGjrxwKJB8EbK9KaBeVu7puKLnMprYhkcZ+CB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fd9b06-0fd9-48ea-9a81-08d777a3d139
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 03:49:37.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k097//RpsTyFWWRVwHQ3DfJbH6NjtmtSA1hEqEe9ePUUITHGL4GGVU+Klq9VUoYW+M7ljS6CSk16XmXWlcT35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SYSCON Reboot and Poweroff drivers can be used on QEMU virt machine
to reboot or poweroff the system hence we select these drivers using
QEMU virt machine kconfig option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig.socs           | 2 ++
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 62383951bf2e..bae4907b4880 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -26,6 +26,8 @@ config SOC_VIRT
        select RPMSG_VIRTIO
        select CRYPTO_DEV_VIRTIO
        select VIRTIO_INPUT
+       select POWER_RESET_SYSCON
+       select POWER_RESET_SYSCON_POWEROFF
        select SIFIVE_PLIC
        help
          This enables support for QEMU Virt Machine.
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2515fe6417e1..bf33bd40ee07 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -58,6 +58,7 @@ CONFIG_HW_RANDOM=3Dy
 CONFIG_SPI=3Dy
 CONFIG_SPI_SIFIVE=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_POWER_RESET=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
index bbcf14fd6f40..234213b4ea74 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -56,6 +56,7 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
 CONFIG_HVC_RISCV_SBI=3Dy
 CONFIG_HW_RANDOM=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_POWER_RESET=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
--=20
2.17.1


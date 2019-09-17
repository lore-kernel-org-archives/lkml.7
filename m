Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80DC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28972171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BG0beOxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfIQPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:54:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23498 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbfIQPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:54:44 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pZCi0jmdrXYjgEqghDGxOZTQJyfzVL31/58V73sq8Eqz4vO/6AX82/xanp2l+zAbnJjBBn7v1d
 4e3nvyYdx7VAIHbhxv4VbZVVDlP5QnvFkh/PWVoSyhg0z37+W4DAlLPXa9fwYJU6pnc+Ex0FOZ
 /tV09v61gJ8pCk2d7QlYQoGeKvivXcge6G2QqTjGlofq2FxJ1ERXoYHluQkePEe8I+9lT2EojD
 NxT1iHXtf0ZH6N1djxnZ5+WcT2WHBSKSLwRVMbBYzJMcfm3O+KHBUZA4DPnuwVWtrsSqI7Yuc3
 h28=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="50797775"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:54:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:54:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSMNC2qrBsHnmLzZdzwfNh8mjDXMZ2Txoq6N7S0nmWNKg5gVZqlna4BDjKTgVvyOnZ6G3Vk9RsSUHeBS6RmaH2x+851exkl4+fl17cfj7A7b8lRUnoHscHz1mmSidw5AWyS2qNndix2HtCrolTA8FaG+sG+cFqcB0LhnX+DSCsvHaeGD3gaZD86VTkCg0mIzB2c+pZFi9shidEdFYYOdVLCeKxUgv82EBJDNlpt4fJkCy/ZN/2k09Lus1MiGNATXXoi1OGYK2L7wSkVO1LdFg4ntOKpK3YYtXjGI97yO747vrDVZmCR+MyxlprXsrYWb8J8HrhQzYeHbO/mKCkyp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7q28f+MGVhV+Xcu8L8xNgCaNx8+supQj2vwUAIR7ow=;
 b=DNAgDvUBLIO1K+SwP5EHJnekAX4UZ+Ad0/jAOleiLyFf9xsYliLhB66itX5CNc5vlnhIOSJoffAs198p8gIvYt1i/Du0Gx1U10uYUT7fgykwJQKrYoz8Dj5vuyZjQkmp9qeuP/mTnHg6cHW/nyF6YhxPZ2tfWvs74wJAoi1QHnPL5Dha6EWW7IxxhvgOiJVQ+vOW4Iq2k56ixb5M+qCgyk7rEepG9e6AgYjNhU6r8oAtlQuG71WCT/XbqElcwcvc1CN3t2NkEsAmsBfpn0lPAbf9YqYNa2fcHd2NEEoie6hkz7PsNtqKKUd5iJvbF2iM5Oyb0AFX/DIk6Ty+cydH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7q28f+MGVhV+Xcu8L8xNgCaNx8+supQj2vwUAIR7ow=;
 b=BG0beOxBnHKPalJ4WqCYehmR+CYr5NefHYVm9WkaTrd71CT7CmtvBtqGd7rsXqKTBNN1Pbj6uOvwSHxCADXLRVIhcTe7oDrEU3JCMkx/+PwrOB8eTWE3R7k6B/kKc2hYx3WSNblRFUKDdYfvo+EMSfLwIs7uR5/Pt3Qg/vvwhxU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:54:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:54:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH 00/23] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVbXA3ZsB/BVyqVUKkLPfzQhFGCw==
Date:   Tue, 17 Sep 2019 15:54:40 +0000
Message-ID: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88283e5b-b36d-4061-758c-08d73b875983
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB398467CA42B049471025FD39F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(2906002)(52116002)(2201001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ofh6pe1v6FA/3NbOqQvSvo31cnWpwEKQTwRlOl1Py6WLd01OpltUENpUuE7ZiM3AYdcAdwbEnpxLVyKv3Je64uyvzCnhlET3Tz/fwSSfpTVAIxZo57YRc8ZvmxsmTmnuiSX4lgXyUhNmzEsgiMR1h0QFbf8c0Ngz4WrNpiNweGeix1L2ZicV1O+XA61beR3bXIFuw8saMm3Cc+wLClHkWJLQIx2XcQTx1YBmFv5x7wo7uwGCuzaOCln4FDxnDBYhTGePwcRAsINI5fE33uuJMNlIKN7NsTvulgu8YRoe8Wr+Bxc+HxncPV+jIfxLsXLtTxVMQ6sIQ2pbErXxoIKk/S0R1VQ6i9+R20sWKUHDnPW+xcNe9ABoqCKFnCX5GITy2tG35/AsViSe/+7AwldexDgk/+wCFoNSHlGXNz/MXUM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88283e5b-b36d-4061-758c-08d73b875983
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:54:40.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIb127DlvcsxmJa8rtpr+Dlokbm/a5zYluVfjB0+ANLbP5pD2XbD8OvMhc99cHuyVBKDg0mhiwMqVj7PpcsyVcgz4lw1LrNFjpkyfA7FP0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches 1 - 14 are just clean up patches for the Flash Register
Operations.

Patches 15 - 21 deal with the Quad Enable and the (un)lock methods.
Fixed the clearing of QE bit on (un)lock() operations. Reworked the
Quad Enable methods and the disabling of the block write protection
at power-up.

Patch 22 adds Global Block Unlock support as an optimization for
unlocking the entire memory array. Patch 23 uses it in sst26vf064b.

This is just compile tested, I don't have a relevant spansion-like
flash memory to test the (un)lock() methods.

The patch set can be tested using mtd-utils:
1/ do a read-erase-write-read-back test immediately after boot, to check
the spi_nor_unlock_all() method
	mtd_debug read /dev/mtd-yours offset size read-file
	hexdump read-file
	mtd_debug erase /dev/mtd-yours offset size
	dd if=3D/dev/urandom of=3Dwrite-file bs=3Dplease-choose count=3Dplease-cho=
ose
	mtd_debug write /dev/mtd-yours offset write-file-size write-file
	mtd_debug read /dev/mtd-yours offset write-file-size read-file
	sha1sum read-file write-file
2/ lock flash then try to erase/write it, to see if the lock works
	flash_lock /dev/mtd-yours offset block-count
	read-erase/write-read-back test
3/ unlock flash and do a read-erase-write-read-back to check if the QE
bit was not cleared.

Thanks,
ta

Tudor Ambarus (23):
  mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
  mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
  mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read() definition
  mtd: spi-nor: Rename nor->params to nor->flash
  mtd: spi-nor: Rework read_sr()
  mtd: spi-nor: Rework read_fsr()
  mtd: spi-nor: Rework read_cr()
  mtd: spi-nor: Rework write_enable/disable()
  mtd: spi-nor: Fix retlen handling in sst_write()
  mtd: spi-nor: Rework write_sr()
  mtd: spi-nor: Rework spi_nor_read/write_sr2()
  mtd: spi-nor: Report error in spi_nor_xread_sr()
  mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
  mtd: spi-nor: Drop duplicated new line
  mtd: spi-nor: Drop spansion_quad_enable()
  mtd: spi-nor: Fix errno on quad_enable methods
  mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
  mtd: spi-nor: Rework macronix_quad_enable()
  mtd: spi-nor: Rework spansion(_no)_read_cr_quad_enable()
  mtd: spi-nor: Update sr2_bit7_quad_enable()
  mtd: spi-nor: Rework the disabling of block write protection
  mtd: spi-nor: Add Global Block Unlock support
  mtd: spi-nor: Unlock global block protection on sst26vf064b

 drivers/mtd/spi-nor/aspeed-smc.c      |   23 +-
 drivers/mtd/spi-nor/cadence-quadspi.c |   54 +-
 drivers/mtd/spi-nor/hisi-sfc.c        |   23 +-
 drivers/mtd/spi-nor/intel-spi.c       |   24 +-
 drivers/mtd/spi-nor/mtk-quadspi.c     |   25 +-
 drivers/mtd/spi-nor/nxp-spifi.c       |   23 +-
 drivers/mtd/spi-nor/spi-nor.c         | 1697 ++++++++++++++++++-----------=
----
 include/linux/mtd/spi-nor.h           |   75 +-
 8 files changed, 1050 insertions(+), 894 deletions(-)

--=20
2.9.5


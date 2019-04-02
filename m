Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A57EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KoIpFKea";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KM4UwECm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfDBJSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:18:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63071 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfDBJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554196684; x=1585732684;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=er82yyelYx5INU3biE0ev4LdDRvdqMtPW+ooZPUYTbs=;
  b=KoIpFKeaveu3CojWtjqPlPgzoaAj06iifYoj1h21XoWGI9zmkiMpOFzG
   5XLfYn54QJp6y9e6tRfJ32Dmmodv2qlgQv7iUC9Oc60Q5vKWhnbzeJCmz
   s/ipFMYOY4g7A6FRcABP5VDXNziVfEaSTFOZznDHcMHhp+HOAQYDk9x5I
   oeK61cc5ODlx2Jj4P/YY2OEf52pKcBW8cR1Z2Ab4x0wTFFcgSMun/WmMb
   GkQwMj3RA70gd4NJ6aJqbLv7zJnwiVxCsIAIJEQIUkV2oL9Wejnj1k266
   yi+SyZw9o5Z0vt8CMppdsK+nJufscMiLLtHwDRpOPWY+oFWzdlj+h2YZ/
   A==;
X-IronPort-AV: E=Sophos;i="5.60,300,1549900800"; 
   d="scan'208";a="109852023"
Received: from mail-sn1nam01lp2052.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.52])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2019 17:18:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKvSGmdeV/OzV0Wo/Ed2Jb8cfQfXuUxoDRNBRVlVtR8=;
 b=KM4UwECmszZiMSQcEfJJbpHtXZNhzJ670RFQhkNuhijZaXB7LgyYLqke1lR3AiCMHaAnagJVFlDIsjID/QgutM5IHPMVcAKTDUA1LW9KxZeeZaTujeT0CWkROtpGnMLrCck/8bU1FMyrYGFK3JoyjmlMk8BD9+d3NzvOf1oNb6E=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5487.namprd04.prod.outlook.com (20.178.245.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 09:18:02 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 09:18:02 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2] RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit
 systems
Thread-Topic: [PATCH v2] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
Thread-Index: AQHU6TT4TjtgcLh+40eL12JN1QVv8Q==
Date:   Tue, 2 Apr 2019 09:18:02 +0000
Message-ID: <20190402091741.11298-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae0f543-1060-4a41-c0c4-08d6b74c1afa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5487;
x-ms-traffictypediagnostic: MN2PR04MB5487:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB548772187CE6B5546A92D8498D560@MN2PR04MB5487.namprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(476003)(14454004)(44832011)(36756003)(305945005)(81166006)(256004)(5660300002)(186003)(99286004)(486006)(66066001)(2616005)(71190400001)(6436002)(102836004)(8936002)(81156014)(2906002)(386003)(52116002)(8676002)(2171002)(1076003)(26005)(25786009)(97736004)(54906003)(50226002)(6486002)(6506007)(86362001)(71200400001)(7736002)(106356001)(3846002)(316002)(6116002)(105586002)(6512007)(110136005)(53936002)(68736007)(478600001)(72206003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5487;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x35QSxNy4cd3FkdzKagBqBUCRHLSbwkOmNS6BoK0D2WMPDv0O4mI8E1YkmGAiQNYc8mgV0HbfNXbylP5jZtI73ZEJRlzyBO6GfyjA5VM0kW+4MO9qJsZj8FAORArAoQ7AalhKbR6CWBoLpF3uwjgDcAK2bbGMj6b0mi7DkcrIyMydlrRJUXqjsywHeXN2DiiI73nwD1KHNMB1mOlwam02UTTbjTRUcR/oE0AlgANsYQwcYoaVbv2WGLGwM0WC6AEluitCgjOuiLPuN5RUwDKO7KDfWS4I+4k1MKYYcyf+Uqv0NnkWC09Vl3xZmn0UkppfxnLDJTNZZZQUGZVL0mrthlT22f9yrdz8Xn0mAJgLJHcBAbLi7mjjaG2FSX0VxOe1VJvlMZ6toduzRO+CRLJ8jVmssV6ArfhkpX215iGeMs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae0f543-1060-4a41-c0c4-08d6b74c1afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 09:18:02.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Maximum Physical Memory 2GiB option for 64bit systems is currently
broken because kernel hangs at boot-time when this option is enabled
and the underlying system has more than 2GiB memory.

This issue can be easily reproduced on SiFive Unleashed board where
we have 8GiB of memory.

This patch fixes above issue by removing unusable memory region in
setup_bootmem().

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v1:
- Use memblock_remove() instead of memblock_reserve()
---
 arch/riscv/mm/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5fd8c922e1c2..b5038a121005 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -121,6 +121,14 @@ void __init setup_bootmem(void)
 			 */
 			memblock_reserve(reg->base, vmlinux_end - reg->base);
 			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
+
+			/*
+			 * Remove memblock from the end of usable area to the
+			 * end of region
+			 */
+			if ((reg->base + mem_size) < end)
+				memblock_remove(reg->base + mem_size,
+						end - reg->base - mem_size);
 		}
 	}
 	BUG_ON(mem_size =3D=3D 0);
--
2.17.1

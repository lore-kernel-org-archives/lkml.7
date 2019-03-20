Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A00521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CHBVzLxH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I+0/X32n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCTWj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:39:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8015 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553121595; x=1584657595;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nuA8SeyKMQet73IFvNXvb60+KYi1NHCzY0ONJWJOOYY=;
  b=CHBVzLxHdqkt8QXkMwysgVxmyMxWUMr6l7MQIBlgpLgTkS83ysLGNQGk
   jjXKWt8/8daGe4SCn0Z5XeM/gahCnk+Hup1ChRHkOfXPs4KkGjhQkOfhc
   0kreD7T6bGxcNgvoXD+PYBaJObLLJD6KA9vifc1su6QbwzFEBNGJ2YXy8
   i2BjbDVxU9nGgYA6vrdbauPkSQ2q9VE3V1dgoDs9Aja2zgxACZl+vp7Ub
   wJ3OPuuP+58TRnZxM1wUgEnpiqbb7zjisi1z9y5ZAj+ws8A7CYCFZV5+Y
   Abw4ArBnFVojZZ4t5ycClXtWxcPENNocXcK0peYTPHYLasK2Pqj6Zo1iN
   w==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544457600"; 
   d="scan'208";a="209428723"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 06:39:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc/BdpAuukXR56MwHnoEgXj+B35UQG3jyjvokOJhXq0=;
 b=I+0/X32n6TJRIc+Gnamb3U3rGt53zxsn7LkK+UtiwhWRbjzabkhgmfDbysCOJG14zUgEgFAc9nvOkmh4MZUuGW/LAK37qU3TT/EJsJYqtQLBNuRHCej8EWGsjVO0gaCBrr36B/7RyUbeKFCdICXWazTCDgpD7byJ16TJoH6fC1g=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4822.namprd04.prod.outlook.com (52.135.240.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 22:39:53 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 22:39:53 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] irqchip: plic: Fix priority base offset
Thread-Topic: [PATCH] irqchip: plic: Fix priority base offset
Thread-Index: AQHU323V8Xb/o1cDwEi/9uvtYKARwg==
Date:   Wed, 20 Mar 2019 22:39:52 +0000
Message-ID: <20190320223853.1209-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To BYAPR04MB4901.namprd04.prod.outlook.com
 (2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fce0eb38-563d-49b6-3cb6-08d6ad84f7ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4822;
x-ms-traffictypediagnostic: BYAPR04MB4822:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB48225B75ECCF1F491729C04290410@BYAPR04MB4822.namprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(97736004)(5640700003)(106356001)(26005)(6436002)(25786009)(81156014)(6486002)(66066001)(1730700003)(6916009)(68736007)(5660300002)(105586002)(4326008)(54906003)(2351001)(305945005)(81166006)(2906002)(316002)(36756003)(256004)(52116002)(476003)(7736002)(6512007)(72206003)(2616005)(3846002)(186003)(8676002)(86362001)(102836004)(53936002)(2501003)(386003)(1076003)(50226002)(44832011)(14444005)(8936002)(486006)(6116002)(6506007)(478600001)(71190400001)(71200400001)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4822;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPWrUxfNRXaVKcUnmL7n1EU94aViyPxr/LH+sAmnsG5gVRPMGwnzlvp4O7UtoLeqRuMpEhAKEBfP8H1i0oBTGj8wJZ4ajzYNHlhkHFuWkgnVhhJaq/Py5iL7eNlUl/MOB4lEAxv5HfzRkz5Accrod5S2XeA37TMyWdbBqzKjOyupeX46qDXsfL7mRm+fIUSfW8DvS7AY17n+K9zqHeJZ/2QXvMRl3vTLMMOXGv/kqahLuvNN7daK3+wEb/udtgZ9woqP0qq0AZbuWDA0ML7Cmiyo6a1rVKQLSgctskJbyFX3P5x9idZEyBf2Zqu5VubXHy8VGB5w7B5QHHwzUiCU6hahoGxDv3xdJQcWQP2ekXYwrJGfGmK6bqAJldTgOSBon1PQnxb/LSUd9JlVlT4jaLTrIQZ5poebfwBAai2LV4s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce0eb38-563d-49b6-3cb6-08d6ad84f7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 22:39:52.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the FU540 and E31 manuals the PLIC source priority
address starts at an offset of 0x04 and not 0x00. To aviod confusion
update the address and source offset to match the documentation. This
causes no difference in functionality.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive=
-plic.c
index cf755964f2f8..826e7293d608 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -35,7 +35,7 @@
  * Each interrupt source has a priority register associated with it.
  * We always hardwire it to one in Linux.
  */
-#define PRIORITY_BASE			0
+#define PRIORITY_BASE			0x04
 #define     PRIORITY_PER_ID		4
=20
 /*
@@ -88,7 +88,7 @@ static inline void plic_irq_toggle(const struct cpumask *=
mask,
 {
 	int cpu;
=20
-	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	writel(enable, plic_regs + PRIORITY_BASE + (hwirq - 1) * PRIORITY_PER_ID)=
;
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
--=20
2.21.0


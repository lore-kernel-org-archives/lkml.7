Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E454420726
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 05:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="qMSaI+2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRF6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 00:58:41 -0500
Received: from mail-eopbgr790081.outbound.protection.outlook.com ([40.107.79.81]:31584
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfKRF6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 00:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXensFFs2GnwhPb5SQY5HYfeUqfUsfEAK8w8qDBuUJjtn3+WY7OGlDC5k3DG/smT0AOOaQvfHTyjKwYFap8BuBOXz0fmdxNCnwECy7gr5I3vQFSp4JchOGd97oDgDe1JycnGLUOkFaTj9lh16IKUOGROvkRH/YCarYmVAoYECFzqL5a9fj2Pj+0KT8e9CcOJFHYzmIQLXC9+APEhDVX554mgXP4V9dBP0sWnqrfgwQJh6Ws6JtQ0NDipFHl+dQZ/Ixk9tDvT6/cgvhkxgN4peGNEOfRuJjkk/rSsDXtgFRZq1WclS2F6dznKC5/SRW6vc15ZYCTrwZDLPevo1Ydrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51zqmSFm+2+y50UokU2mS7wqdMURW8mFABYJHOVjryQ=;
 b=aT9gFkBFMPdf3LclzRuHWHlxAoMyyVtz2AfPPafN5FSFcw+DHw9spR8eo/F9j/JEKxCZEmMtAyp9brDkubnDkFA1wec2jh3x81zMzWCaicU7OnTMLMDC+cNsSdMHD83PA6jk30kWRHFoHvmwcQrRpaJCkE38YLn+gOuKLfDlNU0CpmYLp18wH15/mNts3WGNPl7Kw9Izpmp766INpCSX6QxdnDk75YA9WjCKXloyJPmYwfETsAB0ScZQzVrmeUiY56jo64UGeQ5mArK/5aq7gmCry6oB9pclOCVfhQr8ezwDfINOg/p+3hRQjmGOt7A/rndEJh1lQ4v0HMynyhkHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51zqmSFm+2+y50UokU2mS7wqdMURW8mFABYJHOVjryQ=;
 b=qMSaI+2MtNQATuBS5yKKGZ73SWaQAnpeutQes23IFJJUPzVDAlJigejzO21VIgzWZylzf60fpDmghcaBtvJrqbLYdJQtshoiy9EMfN9X2ELpvGORUilbDQu+B1httYX6FLNu+9kA96A/3SnJ3F5ieZ2WYKghBkUzUUy+ZdhAFog=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3656.namprd13.prod.outlook.com (20.180.4.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.11; Mon, 18 Nov 2019 05:58:34 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::853e:1256:311e:d29%7]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 05:58:34 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] RISC-V: Add address map dumper
Thread-Topic: [PATCH v2] RISC-V: Add address map dumper
Thread-Index: AQHVndU2VgMppCRLNkW/sB+PFFFlEg==
Date:   Mon, 18 Nov 2019 05:58:34 +0000
Message-ID: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::18) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e9863ac-1009-4025-030f-08d76bec58d1
x-ms-traffictypediagnostic: CH2PR13MB3656:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB3656880E3D54A846F9CEB6568C4D0@CH2PR13MB3656.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39840400004)(366004)(376002)(346002)(199004)(189003)(81166006)(486006)(2616005)(81156014)(476003)(7416002)(2501003)(478600001)(8936002)(8676002)(52116002)(44832011)(50226002)(7736002)(36756003)(305945005)(2906002)(25786009)(64756008)(66946007)(66476007)(66556008)(66446008)(316002)(71190400001)(71200400001)(6486002)(5660300002)(107886003)(102836004)(4326008)(186003)(99286004)(6512007)(86362001)(14454004)(2201001)(6436002)(26005)(66066001)(14444005)(3846002)(256004)(6116002)(54906003)(110136005)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3656;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNqWz/BxC7x57h+sr7l97rPW6rPNrAX7kLcoRkaW2lbP7O008JTGpqnWqk3p9P9d4Bhth1FCaZW7jdo/tbGp+u5/wmONm9/q1Iu50v0J65mpMj6F66XBO8fwXqI6XA65jV9aSQbWejTAYQlvZlC8pxTuxpPJ5mp8ePSV+zJhVXu50Cip1V2ov3kuG26PfD3XnRI1wZlNdvzrHgPZBKBdO7cHd9Do9ygbzdNJ6YiovEvnTf5zRYWIibMJIv/V3/Yhjeb8nFIfLaj1ch0XDDky7qNLTygC+MxaJ5bRexfXeX3eFh7+qJl3MHDhS2CZ+7Ac+e5kAWVY0OOtplyu0B0O7ojS1AUl1M4NgjH1a1WG9gg8U/8TDctAiiA+f4Yf+gljWxx6yNQA/rLGscwcYCXq9VA0WGmRmrIFEXoF8AeQaA8skTxSvHqyFVDRqZVFWIsS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9863ac-1009-4025-030f-08d76bec58d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 05:58:34.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPZ8xeibrwhCeH1KAbT+4bCSq3KChdkR36kFu/R/oOeMS1rwXy60hadQY7BQPg1CsDzI1icnbCsndTac/S/VhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for dumping the kernel address space layout to the console.
User can enable CONFIG_DEBUG_VM to dump the virtual memory region into
dmesg buffer during boot-up.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive
Unleashed board.

Changes in v2:
- Avoid #ifdefs inside functions
- Helper functions instead of macros
- Drop newly added CONFIG_DEBUG_VM_LAYOUT, instead use CONFIG_DEBUG_VM
---
 arch/riscv/mm/init.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 573463d..7828136 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -45,6 +45,41 @@ void setup_zero_page(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
=20
+#ifdef CONFIG_DEBUG_VM
+static inline void print_mlk(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
+		  (((t) - (b)) >> 10));
+}
+
+static inline void print_mlm(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
+		  (((t) - (b)) >> 20));
+}
+
+static void print_vm_layout(void)
+{
+	pr_notice("Virtual kernel memory layout:\n");
+	print_mlk("fixmap", (unsigned long)FIXADDR_START,
+		  (unsigned long)FIXADDR_TOP);
+	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
+		  (unsigned long)VMEMMAP_END);
+	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
+		  (unsigned long)VMALLOC_END);
+	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
+		  (unsigned long)high_memory);
+	print_mlk(".init", (unsigned long)__init_begin,
+		  (unsigned long)__init_end);
+	print_mlk(".text", (unsigned long)_text, (unsigned long)_etext);
+	print_mlk(".data", (unsigned long)_sdata, (unsigned long)_edata);
+	print_mlk(".bss", (unsigned long)__bss_start,
+		  (unsigned long)__bss_stop);
+}
+#else
+static void print_vm_layout(void) { }
+#endif /* CONFIG_DEBUG_VM */
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_FLATMEM
@@ -55,6 +90,7 @@ void __init mem_init(void)
 	memblock_free_all();
=20
 	mem_init_print_info(NULL);
+	print_vm_layout();
 }
=20
 #ifdef CONFIG_BLK_DEV_INITRD
--=20
2.7.4


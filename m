Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4468C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB8E21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfHVDsW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:48:22 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:38460 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbfHVDsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:48:21 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Thu, 22 Aug 2019 03:46:29 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 03:45:42 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 22 Aug 2019 03:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egOGdapcvLGtbmmJwfVvVKFjTXW1ghNu5TFDeK1FFvU2tdYMOXQqrdTVNgCbWcZjhdkLgol/J9vhq3m9JI2GOv6DBeDJP9siZmdIBDt0ZqTEQ6DuRaGHmVTUBaNq8qpBZcfmtM/51MWeYqwjVxbunWaqEXYIrRk8n0Y4gSe6cz1dcqMeNe7wU9PzBv9jsSYVJFwneeG55ebWHl9xv4CvtY7BP4+whYp2uwW/sSrPJMRoNjcKCJ5YgPFVDsXEAyOXIHX4Gas1C9DYvmXTccrPSFD2CWo4DjgVBeiIg5LWBNBX4Pvt1/79j3Rzv4ET9+DpIFjG2UKNXg4HyYy3TXasgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGMIc39pnzcFZYWZqFhH1a57rYVN+bPE0GSOjhqW0tQ=;
 b=Q2rCly0dJcTCYDAcCq29xap7JpSdp8H0jeiToVtPfgVIr/A2UfGT2ZonO2iV42EHvaqCQ86eeatgrxWi/uZqavkaEbmJxYx/QlqZ7nOm8ZTMxsx9QMDpGJuhfbfEmhPJJIVaacOcWQy7n3rm/eiNQ+fNGlmXSNKgmV5IPzIuPH2acXdSSgPExkc4v03o3NJZSqYMj9FKA2CzNtzQ6O9PRy3r0lp5m7u856KbHN0HuXCAFfq8AN9QAjQVnxFOEEtJKSXtTKa9tBXsrcp2CEdwd3rd9Z6oFC3pc8WIZTLIdziN7HztXGkgS9USBfYEolKCX/wAhmc+JJrevHBwqySKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3105.namprd18.prod.outlook.com (10.255.136.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 03:45:34 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::847e:511a:8cc2:8fca%6]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 03:45:34 +0000
From:   Chester Lin <clin@suse.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Chester Lin <clin@suse.com>, Gary Lin <GLin@suse.com>,
        Joey Lee <JLee@suse.com>
Subject: [PATCH] arm: skip nomap memblocks while finding the lowmem/highmem
 boundary
Thread-Topic: [PATCH] arm: skip nomap memblocks while finding the
 lowmem/highmem boundary
Thread-Index: AQHVWJwNXyBr+dQszki0v7NBI7XKFQ==
Date:   Thu, 22 Aug 2019 03:45:34 +0000
Message-ID: <20190822034425.25899-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:4:91::24) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff7514a2-3c84-48a9-d5b0-08d726b32fd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BY5PR18MB3105;
x-ms-traffictypediagnostic: BY5PR18MB3105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3105EDE35D4DD795F5B5F9C8ADA50@BY5PR18MB3105.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(81166006)(81156014)(8676002)(71200400001)(6486002)(99286004)(110136005)(50226002)(6436002)(54906003)(4744005)(486006)(2616005)(6512007)(14454004)(7416002)(476003)(66556008)(4326008)(2501003)(25786009)(316002)(386003)(186003)(26005)(6506007)(102836004)(8936002)(2906002)(2201001)(64756008)(66446008)(52116002)(66946007)(66476007)(107886003)(6116002)(7736002)(5660300002)(256004)(66066001)(53936002)(14444005)(305945005)(3846002)(478600001)(1076003)(36756003)(71190400001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3105;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lk14lhMcIg02p+5vmoQGt+I5SKfceTn43Vs6peULttmj7IF8LO788esS4d6btjhPYWsTgYzcXC+10fbnTcTRV8usm1ujgkFF9i5i/NDgqoaOBcnNCEC3qA3aOTD/7x40+gE11uNyGIJAh9NafTfi1RZ/FWNoGjAHLCOWBicUqRwY/lUaQE1F2Mwu1Hd3MEv6u8DunzPWAeiUiUWP2sxNnTPMOzOxjV4yAvClAkWCYROiCiUVl6RYJlhWolrPPOyMngeUjLzs+XtCbUed+U/kDoqLfVwOZWKZF9GFvQwuX2Ox1SLn0cdM9QHsUo7igmvGoFECKXIuLXM5tFyxhsyRUYPJ0jw+KktfbBqror0QPgrf1+HWdAbJLKCDAaeqA1dgphZlJLXAgmG8EkObUzyhRiZKdIpLuC6pXRxN/u5cN/4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7514a2-3c84-48a9-d5b0-08d726b32fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 03:45:34.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XypkSIJ0UID5ThjZNKVMod9/5xARgxWqNBaTHojUfmY2mdug2pGg+/TDUkp5gg4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3105
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust_lowmem_bounds() checks every memblocks in order to find the boundary
between lowmem and highmem. However some memblocks could be marked as NOMAP
so they are not used by kernel, which should be skipped while calculating
the boundary.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm/mm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 426d9085396b..b86dba44d828 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1181,6 +1181,9 @@ void __init adjust_lowmem_bounds(void)
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
 
+		if (memblock_is_nomap(reg))
+			continue;
+
 		if (reg->base < vmalloc_limit) {
 			if (block_end > lowmem_limit)
 				/*
-- 
2.22.0


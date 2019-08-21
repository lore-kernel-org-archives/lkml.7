Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301DDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D43233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="TdnpAHVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfHUJ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:56:42 -0400
Received: from mail-eopbgr700045.outbound.protection.outlook.com ([40.107.70.45]:51808
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfHUJ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id4ASevEIGgIogNEvUycxs4ZQnSgIsKxVYlNxWtpkNcrIvoxMj9UGNY4KBiTlPwsV7d4I8841F8Bm0uejbWTWgNHJyXLmp7j9nt1ib0fV+mpKpn/xU+igi0yJsWI+NNpiBAcQhpiGJw5fcliiCS3XE/vcwQd1jURkq6V0xF5jCqbs6AqwWhy0uG7+RWbkLf+1jxhlcVFUOLIsBdMpig8ExFgxcC8jrHviEYIIaerbeZ1i3eTm/8dBf9jfLc9K3QUVjhoQynthEofGsVT6njmxYgpzi0y2DB61MlyDblJcOSvQOIC5HcWMaMEKBvreADIZGpczzvXAgcYVByY817YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga9HpClYwxw/cm6sUhur+fKgs5ikbOaHmZU6B1GonhM=;
 b=WvhBdvyVt/vV/pIwWh6PLrHUPg1xIHm8gzPIYLQH0ZSUwnolQO1cDNQbmsGDmW+3sQrAuMTxSkfAE4UvlJglgeUdQD8HLoGWkbVi222IdBSHSD0BZ8s45C61C0Jydov9vl46OmLvZvoT0qJ4pMveqtz+iq3mLe3ukjWtsfZYn5jOz8PMuxUe233ouj9t1LIHObBUxud5Rox+K9JzcsODJ6ToI43bM9Vg5xJpZACjU0CsjYYJ25EPsQBtAquX/zr5OLCjVosz6iRPP+ohcTg1QrSte+F5+j7dCLaKU+q8Z6WNw5QSg8w88MobH2P3HLip6TUBqecIt3yJvpVCrLze3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga9HpClYwxw/cm6sUhur+fKgs5ikbOaHmZU6B1GonhM=;
 b=TdnpAHVA8iMnekqWh2toaUxA8wd6YQyIQfccRK/k5sGZlJ6FcZYf0rWPOWmPmZOzXkiN+KprdqEatoAAvKXcuiMPOZBLJPDIn9fU03br1vJ1wuGnlipWjZKMGqOL0paOcC4rR7f1jpgavBfRoQi6NX0We2U4CqxMMbz+3abwiCA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3639.namprd03.prod.outlook.com (52.135.213.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 09:56:40 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 09:56:40 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] kprobes/parisc: remove arch_kprobe_on_func_entry()
Thread-Topic: [PATCH] kprobes/parisc: remove arch_kprobe_on_func_entry()
Thread-Index: AQHVWAa6TjC5SDDjQUqnxzYIwX9R7g==
Date:   Wed, 21 Aug 2019 09:56:40 +0000
Message-ID: <20190821174533.5736ca90@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0046.apcprd06.prod.outlook.com
 (2603:1096:404:2e::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f79cb2a-0b06-4a3d-233e-08d7261ddcd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3639;
x-ms-traffictypediagnostic: BYAPR03MB3639:
x-microsoft-antispam-prvs: <BYAPR03MB3639808F53A797398138AEFBEDAA0@BYAPR03MB3639.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(71190400001)(71200400001)(110136005)(316002)(4326008)(54906003)(486006)(26005)(5660300002)(102836004)(6506007)(4744005)(66066001)(3846002)(6116002)(2906002)(386003)(186003)(7736002)(99286004)(305945005)(1076003)(53936002)(66946007)(66476007)(66556008)(64756008)(66446008)(256004)(86362001)(476003)(6436002)(50226002)(52116002)(478600001)(81156014)(8676002)(81166006)(6512007)(9686003)(8936002)(25786009)(6486002)(14454004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3639;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +X5eGJ7vCJ2XkVJtTSWOxpO9ZbPM99Qdmj/v++nkL9T3d56JWTXZmxYpk+/Ppwa8yGQ0QqWHeKPPd/hShkKAZd3t7D6gQkUHWNenJ6foz5vS9m01Y1KG8P31za2SGr4Y++oF0NpkUXL6XTeTIN1fLjMbmNWw4MYDB7LqA+ybGFxu6FKcUDcKgwyEBHHlixRDONF71vziFdI8o1voQ/HM7zyIUsnLG51l/MeT/+PrrAtDWE919sokhoRSwWiErZHbjFOKTKJztUpxYIjjqKzZwIucH6grIW42f5V5nOcs3FHAZBbRzx6gCzKT73hB74EwHwxg1zvMZ1Jg098ERXyN3ABjwXacCkcLDUKBG6ITM9woH1aVd3PmUNYLb3gpusPrTBhzKy+YSmLTWLXxWn1C05YhS0V3ACPbny8NPnIA7jg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94073DB57D47F04D96301B354B3E9B97@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f79cb2a-0b06-4a3d-233e-08d7261ddcd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 09:56:40.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4qZkoZHm09q1Re2eWEn5vf0wyGzHoA2BEBSNc7Dzn0FrfbePEEzKIp73O8mrzQEeWpBxFH8JnsoSkuRwyv1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common kprobes provides a weak implementation of
arch_kprobe_on_func_entry(). The parisc version is the same as the
common version, so remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/parisc/kernel/kprobes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 5d7f2692ac5a..77ec51818916 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -281,10 +281,6 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return p->addr =3D=3D trampoline_p.addr;
 }
-bool arch_kprobe_on_func_entry(unsigned long offset)
-{
-	return !offset;
-}
=20
 int __init arch_init_kprobes(void)
 {
--=20
2.23.0.rc1


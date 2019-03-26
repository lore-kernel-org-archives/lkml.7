Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE607C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I2MnBK81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfCZQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:59:10 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:31652
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbfCZQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QBj3A+Z4xBoWBX2Q1QR7FkJxhs3GGD1frGLNfhtpiA=;
 b=I2MnBK81nw+0HPWUWKEiEBKRV8InYKQShSKJvuVb48XQkrhAeSasKvB5FvS1Mzu3s6kMOVb1e6BL80lpl5SYyqNQdWwtJUxqAbTrRDMrSHlgDw71VNkCm017cq2QY/n4zrJeX6OI1o2hF4/q6m+X4WUD6339LxO9iJ4Rs5r44Wg=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2189.eurprd08.prod.outlook.com (10.172.12.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 16:59:04 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::24ef:2725:26cc:ae35]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::24ef:2725:26cc:ae35%8]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 16:59:04 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, "terrelln@fb.com" <terrelln@fb.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH] lib/lzo: fix bugs for very short or empty input
Thread-Topic: [PATCH] lib/lzo: fix bugs for very short or empty input
Thread-Index: AQHU4/U36rVDi5JFrE6P9rVvVRS9dw==
Date:   Tue, 26 Mar 2019 16:59:03 +0000
Message-ID: <20190326165857.34613-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f54bb013-72d9-499f-21da-08d6b20c59ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2189;
x-ms-traffictypediagnostic: VI1PR0802MB2189:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2189C2D806378726449FDF168F5F0@VI1PR0802MB2189.eurprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(8676002)(478600001)(305945005)(6916009)(2616005)(6512007)(7736002)(476003)(3846002)(6116002)(66066001)(54906003)(2906002)(4326008)(186003)(6436002)(53936002)(36756003)(71200400001)(52116002)(5640700003)(99286004)(71190400001)(97736004)(68736007)(6486002)(8936002)(2501003)(2351001)(25786009)(5660300002)(14444005)(102836004)(486006)(14454004)(26005)(81166006)(316002)(50226002)(106356001)(1076003)(81156014)(44832011)(105586002)(86362001)(7416002)(6506007)(386003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2189;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ptsNc3XKXLnLqv92rd6++oMBN2SbbgTh3l2bAoY+DvAZ75yDAJyJDQzBmDyueY7yfTUdllffa+JZWvPxh/CVkW/QPpXLAwbdDFFLQG8qBAHpgc2i5q+y8wmTEk6iFSQ7uiDqmIVT9+14kx/+gYQU7ECqglyJwEOmE/4W1zmo8V2vxoocDfJfHb6x1V39cl6r5PPq0+9/0HpCUE/h217DQZEsNuR/zQdQV/Fh08VJVsfbBu/7zjydr9u4LuoPILEgrROvU3j1hYFDtpQUe5NrGQoa0C/YfkSOosawkrtvB7h3MOsRI7MRJdagIuwbo3zP0tU61pN05vcvGGyTrBU7JyapHcBY8cfWtTqQMjHxtx1g8UTiq/gn0PBd7WXtnpkT5PWIR9HFzGrAkQcoI8FXGq9PlwYl8YlNYvylXzjRSp8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54bb013-72d9-499f-21da-08d6b20c59ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 16:59:03.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For very short input data (0 - 1 bytes), lzo-rle was not behaving
correctly. Fix this behaviour and update documentation accordingly.

For zero-length input, lzo v0 outputs an end-of-stream marker only,
which was misinterpreted by lzo-rle as a bitstream version number.
Ensure bitstream versions > 0 require a minimum stream length of 5.

Also fixes a bug in handling the tail for very short inputs when a
bitstream version is present.

Change-Id: Ifcf7a1b9acc46a25cb3ef746eccfe26937209560
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 Documentation/lzo.txt           | 8 +++++---
 lib/lzo/lzo1x_compress.c        | 9 ++++++---
 lib/lzo/lzo1x_decompress_safe.c | 4 +---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index f79934225d8d..ca983328976b 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -102,9 +102,11 @@ Byte sequences
                 dictionary which is empty, and that it will always be
                 invalid at this place.
=20
-      17      : bitstream version. If the first byte is 17, the next byte
-                gives the bitstream version (version 1 only). If the first=
 byte
-                is not 17, the bitstream version is 0.
+      17      : bitstream version. If the first byte is 17, and compressed
+                stream length is at least 5 bytes (length of shortest poss=
ible
+                versioned bitstream), the next byte gives the bitstream ve=
rsion
+                (version 1 only).
+                Otherwise, the bitstream version is 0.
=20
       18..21  : copy 0..3 literals
                 state =3D (byte - 17) =3D 0..3  [ copy <state> literals ]
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 4525fb094844..a8ede77afe0d 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -291,13 +291,14 @@ int lzogeneric1x_1_compress(const unsigned char *in, =
size_t in_len,
 {
 	const unsigned char *ip =3D in;
 	unsigned char *op =3D out;
+	unsigned char *data_start;
 	size_t l =3D in_len;
 	size_t t =3D 0;
 	signed char state_offset =3D -2;
 	unsigned int m4_max_offset;
=20
-	// LZO v0 will never write 17 as first byte,
-	// so this is used to version the bitstream
+	// LZO v0 will never write 17 as first byte (except for zero-length
+	// input), so this is used to version the bitstream
 	if (bitstream_version > 0) {
 		*op++ =3D 17;
 		*op++ =3D bitstream_version;
@@ -306,6 +307,8 @@ int lzogeneric1x_1_compress(const unsigned char *in, si=
ze_t in_len,
 		m4_max_offset =3D M4_MAX_OFFSET_V0;
 	}
=20
+	data_start =3D op;
+
 	while (l > 20) {
 		size_t ll =3D l <=3D (m4_max_offset + 1) ? l : (m4_max_offset + 1);
 		uintptr_t ll_end =3D (uintptr_t) ip + ll;
@@ -324,7 +327,7 @@ int lzogeneric1x_1_compress(const unsigned char *in, si=
ze_t in_len,
 	if (t > 0) {
 		const unsigned char *ii =3D in + in_len - t;
=20
-		if (op =3D=3D out && t <=3D 238) {
+		if (op =3D=3D data_start && t <=3D 238) {
 			*op++ =3D (17 + t);
 		} else if (t <=3D 3) {
 			op[state_offset] |=3D t;
diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_saf=
e.c
index 6d2600ea3b55..9e07e9ef1aad 100644
--- a/lib/lzo/lzo1x_decompress_safe.c
+++ b/lib/lzo/lzo1x_decompress_safe.c
@@ -54,11 +54,9 @@ int lzo1x_decompress_safe(const unsigned char *in, size_=
t in_len,
 	if (unlikely(in_len < 3))
 		goto input_overrun;
=20
-	if (likely(*ip =3D=3D 17)) {
+	if (likely(in_len >=3D 5) && likely(*ip =3D=3D 17)) {
 		bitstream_version =3D ip[1];
 		ip +=3D 2;
-		if (unlikely(in_len < 5))
-			goto input_overrun;
 	} else {
 		bitstream_version =3D 0;
 	}
--=20
2.17.1


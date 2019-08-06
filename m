Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC801C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F3720B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bluewireless.onmicrosoft.com header.i=@bluewireless.onmicrosoft.com header.b="r6Mw6XKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfHFG7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:59:35 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:1028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731557AbfHFG7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngZkJISTELCGg6keYJARjf92hBmJu1HyTDNesQMtXGVQR57fqQkO5+Kly8qbGk43fxxXmjghWjdEyHy/crfK1o/0LFX/Nguy271U9epj82GVA1Dk8STUeSH6XiIx6Qe056408llgO0k6myJFeqjItQoK09gfnDldKihdEaY7wrDOjk6iGsSrLZk4dofYxXTGd52G80uOrTdkLkh/R7DdIMq3Kwreun6CGnz8N5bQSX493ZxuUCSKDasn9tkWpnNHhNW8qM4tnFetU/Im3EHRpB8lF0VzHed9tFiMZuE7erlEPWJzu7ePOeNoYxujWxiKBtHQ44i+iY7+SkBIPAroKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeUMABZ0VJQpS0JuvZFgKYD/wwNlI2nUI/jhmSiPFsc=;
 b=Q/WcdlWSEMliSLu3t0GahYoC1iwFLyhseQs1OLXIKt2hKeBG6khTZ3EbMBgi4JC6qdjjNOVaISAz8RoaJGvJPslqGL0Vw7OgJTvQ/viXOaS78MZUEEAMe3D8aDCcOt8KaZfhV8uRQ+cxfC0sihJw3kYqRvYJUmsfrREr6/xg/sU+BdoW7gIfCeDH56Md2YqfEyvo6+VRY1FYCRwE4lPWn53vf8GiEzcVt5IVIjeKw0xGU33GNlntox/32U88fySS9HVUXrk+5W+GVZZq2KV2f3rys4+tUxf6ALAuS2ViENZN6Y33fjLa21AsbdaGKmYx6PaS9C2lIiuxGnJbjipzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bluwireless.com;dmarc=pass action=none
 header.from=bluwireless.co.uk;dkim=pass header.d=bluwireless.co.uk;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bluewireless.onmicrosoft.com; s=selector2-bluewireless-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeUMABZ0VJQpS0JuvZFgKYD/wwNlI2nUI/jhmSiPFsc=;
 b=r6Mw6XKYSDcVEM1HntHt9ssCL7q2oljbq5kC5Ck4qQk3GbJggGJUUigq0gYuXQNaeiZ8chabnDEflBkoO6RjHV7FyT/rblFu2ACUe+t5Vb4w5Zx+42UF+BNTgBeh6UG3V9UNFpI5CO/PT3PumRWXJ4JAwuktbIYhgsVqyu7UI4M=
Received: from AM0PR09MB2915.eurprd09.prod.outlook.com (20.178.203.75) by
 AM0PR09MB3732.eurprd09.prod.outlook.com (52.132.214.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 06:59:31 +0000
Received: from AM0PR09MB2915.eurprd09.prod.outlook.com
 ([fe80::e40d:6de3:4bd9:59c2]) by AM0PR09MB2915.eurprd09.prod.outlook.com
 ([fe80::e40d:6de3:4bd9:59c2%5]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 06:59:31 +0000
From:   Brendan Jackman <brendan.jackman@bluwireless.co.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
Thread-Topic: [PATCH] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
Thread-Index: AQHVTCR/NBmmzfpiF0utKzm/3hux0g==
Date:   Tue, 6 Aug 2019 06:59:31 +0000
Message-ID: <20190806065910.22600-1-brendan.jackman@bluwireless.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To AM0PR09MB2915.eurprd09.prod.outlook.com
 (2603:10a6:208:134::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brendan.jackman@bluwireless.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [222.252.15.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45efa46e-d8a3-4ef8-435f-08d71a3ba145
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR09MB3732;
x-ms-traffictypediagnostic: AM0PR09MB3732:
x-microsoft-antispam-prvs: <AM0PR09MB3732521715768664304FFB14F1D50@AM0PR09MB3732.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:234;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39850400004)(346002)(366004)(396003)(376002)(189003)(199004)(66066001)(5640700003)(14444005)(71190400001)(71200400001)(256004)(53936002)(36756003)(386003)(6506007)(5660300002)(99286004)(2351001)(7736002)(52116002)(1076003)(305945005)(6116002)(3846002)(68736007)(25786009)(6512007)(6436002)(14454004)(316002)(478600001)(4744005)(2501003)(50226002)(6486002)(81166006)(81156014)(8936002)(8676002)(2906002)(186003)(102836004)(66556008)(42882007)(476003)(26005)(64756008)(66446008)(486006)(44832011)(66476007)(6916009)(66946007)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR09MB3732;H:AM0PR09MB2915.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bluwireless.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j9mr/XNNTziOIhMnRKPPobnDTl0xo4DA+IpWeirg0nlEgvgPgi1ksbJ1avYkb0lXG1xFltZoUWntgPHYzp4xZQA7yuRpYgB2g4EJWkRWI8MQBESj6N/Nwzglu2WwRP9PDDKHObfG3WhT0SC8SVMkByE0j4wdsE4JJWaZ3w0F/h9lwOmnUWNcmY0OCESCLiu3rArPtwX1IS1MxWcPWkMhg4lXsaw4zBsEv3Y2ri5q1pv5wpvXcnPS9ZkARpg/4YjMNyGzLsmbeDJF/VXf0tB9W6JjvjfFpv7BZWKPMZr8UwHHwPiPeCLude9QiyRN/T753ougR8Wi+5dg/bZoW/bQn2TJFl5rNC5640faAOSAU1Hv2AfjSLoo4p79sii9pgXHot94pLqfN2cs/wSO3V0pCC+A460oWEAoq3fydhZhKlw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bluwireless.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 45efa46e-d8a3-4ef8-435f-08d71a3ba145
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 06:59:31.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e906b266-f5ff-4368-b47b-0f526edbc2b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brendan.jackman@bluwireless.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arguments of sizeof are not evaluated so arguments are safe to
re-use in that context. Excludeing sizeof sub-expressions means
macros like ARRAY_SIZE can pass checkpatch.

Signed-off-by: Brendan Jackman <brendan.jackman@bluwireless.co.uk>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..907a8e8d80ae 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5191,7 +5191,7 @@ sub process {
 			        next if ($arg =3D~ /\.\.\./);
 			        next if ($arg =3D~ /^type$/i);
 				my $tmp_stmt =3D $define_stmt;
-				$tmp_stmt =3D~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$T=
ype\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
+				$tmp_stmt =3D~ s/\b(sizeof|typeof|__typeof__|__builtin\w+|typecheck\s*=
\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
 				$tmp_stmt =3D~ s/\#+\s*$arg\b//g;
 				$tmp_stmt =3D~ s/\b$arg\s*\#\#//g;
 				my $use_cnt =3D () =3D $tmp_stmt =3D~ /\b$arg\b/g;
--=20
2.17.1


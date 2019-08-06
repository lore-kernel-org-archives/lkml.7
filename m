Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9005BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572272070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bluewireless.onmicrosoft.com header.i=@bluewireless.onmicrosoft.com header.b="m7egIrpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfHFHJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:09:11 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:14720
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731576AbfHFHJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:09:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD5uuYSn76XHFAF0TFkCj+Pckj7sYIWT0bc+alkZh5Vo+b4lytW3HHElDMwnNFhCd3J3USNsz+/ORvtOMPOvYkbHYPTjGbsjZFyd68wDXv+k6RyyJdw/TTUhK1nvnQZcnOh+gMhRGV2cLqqws4sVgZQ1ZBhkP5fTHvqjLqAkqQkuWAEk1/+x+BMHgZxFYlP5ihCj0TCB+fUQR6K1Brfzs80HD0B4rp0ybYn5l9RKLHXKPcYyp/d2lJWc5Hph7xo+n1MsGOxuPEa/Ijxq/vKlRkyfji2H+FBQ0P8mgGlRiC+YQO85TpOdpexn65Vt/zCUJSXfO2+4I1eeZqVcRegsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOWNYJae7pA1i14CTzZKo+BUgBN0/xS5AyTnGZSw+sw=;
 b=UH2XiU3FNLAXEKRx0rScAMf50jwvZxA4vlD/WtJceamncygTjWqxsGCprY7Pb+hh4gi8k5IKigotEPzvUQHMk6ES3QWb4XhcU0kx1E8gP2lO1NKyolBG/3Yj63tjvCIDZrQXfE0fCgyc6+sfRNDqLu4kdj8oftSlVE2X0M/wiIbM2QkjPJWlggrcOUXecVyla3YVICw19VA6NQD/ZIKz9YUbBf9Ri/3yBudO/d0EcS9+5aduLJF0yOyXnsDXOMrxDKx10E/JJOvwQL1AxScSQdRxlAxF/ertE7pYkzipa2tut8hhEIkKLBkLrj1HmYwoiQwgastANHcMjnMvEI3gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bluwireless.com;dmarc=pass action=none
 header.from=bluwireless.co.uk;dkim=pass header.d=bluwireless.co.uk;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bluewireless.onmicrosoft.com; s=selector2-bluewireless-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOWNYJae7pA1i14CTzZKo+BUgBN0/xS5AyTnGZSw+sw=;
 b=m7egIrpiKDSqFqjai+rNBvcuwexkiAr0szi+WfcE0h8cxMBC0Vw19c3qR6+8niLT4jCchUdPGGQgjMH23hxna4vNERt9M2YeRrQpy+u3HjqvLc2WuVogADSbMMc7KXQ76lhzGUu1T8FucQKimRO5jaqiU9ovxqGVHv64rFMx2EU=
Received: from AM0PR09MB2915.eurprd09.prod.outlook.com (20.178.203.75) by
 AM0PR09MB3715.eurprd09.prod.outlook.com (52.132.214.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 07:09:07 +0000
Received: from AM0PR09MB2915.eurprd09.prod.outlook.com
 ([fe80::e40d:6de3:4bd9:59c2]) by AM0PR09MB2915.eurprd09.prod.outlook.com
 ([fe80::e40d:6de3:4bd9:59c2%5]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 07:09:07 +0000
From:   Brendan Jackman <brendan.jackman@bluwireless.co.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v2] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
Thread-Topic: [PATCH v2] checkpatch: exclude sizeof sub-expressions from
 MACRO_ARG_REUSE
Thread-Index: AQHVTCXWhhSbxTJ6ZUOv8jMwPNds8Q==
Date:   Tue, 6 Aug 2019 07:09:06 +0000
Message-ID: <20190806070833.24423-1-brendan.jackman@bluwireless.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To AM0PR09MB2915.eurprd09.prod.outlook.com
 (2603:10a6:208:134::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brendan.jackman@bluwireless.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [222.252.15.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5757074-f86c-4a82-5e28-08d71a3cf873
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR09MB3715;
x-ms-traffictypediagnostic: AM0PR09MB3715:
x-microsoft-antispam-prvs: <AM0PR09MB37155314F22FC4E017358DF7F1D50@AM0PR09MB3715.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39850400004)(189003)(199004)(386003)(14454004)(6436002)(54906003)(476003)(6916009)(2616005)(6486002)(5640700003)(53936002)(6512007)(107886003)(2351001)(2906002)(4326008)(71200400001)(71190400001)(478600001)(2501003)(6116002)(68736007)(81166006)(26005)(81156014)(186003)(3846002)(66476007)(66556008)(64756008)(66446008)(25786009)(36756003)(7736002)(305945005)(8936002)(52116002)(14444005)(6506007)(256004)(8676002)(99286004)(66946007)(1076003)(44832011)(50226002)(66066001)(316002)(5660300002)(486006)(102836004)(42882007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR09MB3715;H:AM0PR09MB2915.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bluwireless.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6WWAocffAY0p1mmUGePnBbpVAFXozo7dL8O6bfhJ2axY0Xn1EMoLYWaY3oIYLTXcMfL5OFZ1DBLC8Jcu2KZK8ywn9jfoOmU7v2nF6oMcFkXa5TZCy6b8x3demloK4IQLx6L0MQMhK2bxWbmU2QN6bXkWlCePnqRqihV6vs3ZHeImcS6Z7nsBSWq6OOdxR+KMi9/IwanvPj+Fpf7hEKcI7SPTUFjDdFG/ioWT6MPPKGEZhp/mrJyh9FuEK1qPKbLFfyPV7vr4L36r1RzLwsFJmmgT+O3TEZfT3kf0oCR8qED9/gHUBbUse3tVJcEPqw0lxu/+25U2pvPRhuRUYWMrvkWLin2erTL5RNb4L4ZW2ts+R3aCzmrNx5RGeI5rdRpjY4tgm53neUf9tfJeDSBnjDDIMzJUka9rqsTnigronms=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bluwireless.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: d5757074-f86c-4a82-5e28-08d71a3cf873
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 07:09:06.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e906b266-f5ff-4368-b47b-0f526edbc2b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brendan.jackman@bluwireless.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arguments of sizeof are not evaluated so arguments are safe to
re-use in that context. Excluding sizeof sub-expressions means
macros like ARRAY_SIZE can pass checkpatch.


Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Brendan Jackman <brendan.jackman@bluwireless.co.uk>
---
v2 is the same patch, I just forgot to add CCs to the original.
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
--
2.17.1


Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138DC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="JTkCQjAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfB1Kct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:32:49 -0500
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:56544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbfB1Kcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPdjFYnXNKNZPU9s2wzh7Lui3EqTd3GclCAwZkI5a8g=;
 b=JTkCQjAnTfqPmgfNrwh3oCcX0nIcWq70XIaDdVvDZNLxP1Wz7IkvuWTDTPYvOSMS6LS+OJmCx14LFA+wSJxvmJhSNiM7XDPa5MdJnjA7XEW+rQk1NENpmsp8PMnoIsqJ/Ymx0JNlYw75vodgjYTrv9/R6Xh2qA0r1nFQGWapbh4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM (10.167.201.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 10:30:43 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 10:30:43 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Topic: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Index: AQHUz1Co/Wp6EPz520CpARAl4seE1w==
Date:   Thu, 28 Feb 2019 10:30:43 +0000
Message-ID: <20190228103026.9566-5-rasmus.villemoes@prevas.dk>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28ea4180-8b38-45c2-d582-08d69d67cae5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0509;
x-ms-traffictypediagnostic: VI1PR10MB0509:
x-microsoft-antispam-prvs: <VI1PR10MB0509C0233B750CB786D1C1A88A750@VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(40224003)(189003)(199004)(476003)(446003)(11346002)(2616005)(8936002)(44832011)(8976002)(106356001)(42882007)(486006)(68736007)(186003)(50226002)(107886003)(105586002)(54906003)(74482002)(110136005)(316002)(5660300002)(97736004)(1076003)(72206003)(2906002)(52116002)(71190400001)(6486002)(305945005)(478600001)(256004)(71200400001)(53936002)(99286004)(6436002)(66066001)(6512007)(6116002)(81156014)(81166006)(102836004)(4326008)(25786009)(6506007)(386003)(26005)(76176011)(7736002)(36756003)(8676002)(14454004)(3846002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0509;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0509;23:vNE+vdX0WsYEX6ZxvQuORsswyZQN724rBuL0jd2?=
 =?iso-8859-1?Q?SUJfoTSKn0iw3jBkdN1rcIV2J7gSF692aI6hcsicluegwVCLEf46j6w2/m?=
 =?iso-8859-1?Q?h05ZYe8dE8hRpyIxZTTTdMgdqgkoq8z71C/PympQGooDYD9Q52WdRoGkXO?=
 =?iso-8859-1?Q?66TAJ0DmyVk3XQD3OlVuy1oFuvIDs1UD3n+DIuoytofCpfwd41UNpAqC7h?=
 =?iso-8859-1?Q?TpETClx/WUyGwzblhmnYtOTyY22Q8TWTbFmSySfJfXXlShWAeZjSrPdBla?=
 =?iso-8859-1?Q?ByGbwM/sibLedbRZE1bhC5LN3o+g/vo/meEj2fRzjoyXdHgUcMEvzR2/fy?=
 =?iso-8859-1?Q?WU0Pq2KSEwfcoTaLObDgBQYxZSCuN8hmj+uWE0Isjpz5f9jbPlfzxaUHC1?=
 =?iso-8859-1?Q?rCGj7x2AB3pdxbhDOtb3zasbkjCUM/EVdzHdcpb9dQsV3aLCLMvwyPVhJm?=
 =?iso-8859-1?Q?5K6OZGeilKpAbNalNtq/7neqnfqVsm5Br0AHiFq76Z5GYVmLKzFeIx5rM8?=
 =?iso-8859-1?Q?fQqJrDFqMEVe0x0AMYh8GfaXDQmES0agUzYb/1TwSNEXTd1D7Fr9VC5bUo?=
 =?iso-8859-1?Q?9lVB6Me+QNtCp9kUp+dirKP2DA/6Lo+YT8awByLLwTRWRJ+Yq+ZkFugQ2I?=
 =?iso-8859-1?Q?dmFEYr5gtzTEtSzkI44TLb07NTtJDcg1k+R0EUSpiXF20YRb/iyQTBqWpA?=
 =?iso-8859-1?Q?JOWpRizI/pU9l90L1hcK6CAdgktxQ2c2iP4A6lSIGW66qKn852jDbVKc8Y?=
 =?iso-8859-1?Q?O7B5kiJ2lP/B/5mi2ToTYBcBte4sXKotls92PDFXfJS7xOVLBa8+QanWH8?=
 =?iso-8859-1?Q?hkcda8+vBPKVmx3qs6i+E2rl+B3OrT1um3fvLSATDgVbIvRrCczKnM8drK?=
 =?iso-8859-1?Q?odhqBVYfocLTJY6XWZCM7ER+SV8FhGO/0EVJ/dUSqpiWtYt0LYoeZMEQ+9?=
 =?iso-8859-1?Q?j1C9ToXPhbmzhPv8IAoZndly80FORQNLZtHaO+BJPu1zESr3+dsl52CjQa?=
 =?iso-8859-1?Q?Q+2BxW73q5duP/2xtUvdwiRCxWM3RnCKqjENvIy5Re3kyOIt08rvEhYUxs?=
 =?iso-8859-1?Q?JcEes+hdjwjgotFh4lW9Lfr3uQx6e84bnseY+Ty4DbrZ7NJPGPTJAvwuD5?=
 =?iso-8859-1?Q?dLeaLFYS+k3in1wB61Gj0anLKFeNRD8YaNQm2wcgwFO9nZhR4JlZ8S3T98?=
 =?iso-8859-1?Q?5osdzAc5SuXz2n7/Apys0XPUfzu8ciNPEE7J2jll8yBWvL2RU9p3i3jBv4?=
 =?iso-8859-1?Q?HtpSCZ9B5xYClihSQcWyOuIDbiUfKrxZ1kHqtCM3ikbzd1QhbSfzA5vHRm?=
 =?iso-8859-1?Q?Xrl7ExxoSPF290MIN2EvwYQqDGliFItFWoY6ylJqcGMsUewBbhVmauojdI?=
 =?iso-8859-1?Q?K5ecgIXk7X6mlUEk7gqfcIB55DOWf3bEVpc88kEGX0pn7mT5RLQ=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OZ0+45zcsiItEtoXgD3stRbsEFKzXY4nGgoAptjDwtVGM6Hbu3333IgA/KXa2ntCyeGqV8b7cBGSOrO6Ve+2hB0UGBZx7QbxkQwSv6Bt/P6SO33SL+jyM1M5L40ev2WTXrv7DmIbxYQiI7RYEFmxJpn7fIJfaTUmw+Wb6UhCRk9RhrdtHSiSV8X8MqSJDZZCIpXXcKH4g4csLbl8aOG8KcBa2nE0bTnTOySHqMdAjG98itjb/qIRROEcOumuX0TRsf4NBECw+YbKM3kUqts4QS+VSmvUmsfGo+85/TQspPisjRvhZ6WA4/cnZpdUHOI/Xh/p1EeEVNkdmhn3seXTXYZMOv2z2lEIATw5t1LGwmSGROc3R/xkHB17icS7beUNJzKt1cFXaHzfMChk/YEac28AF5BPEV71IzAdC1T92aA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea4180-8b38-45c2-d582-08d69d67cae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 10:30:42.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that the set of snum _values_ to populate the
snums[] array with is a function of the _number_ of snums
alone. However, reading table 4-30, and its footnotes, of the QUICC
Engine Block Reference Manual shows that that is a bit too naive.

As an alternative, this introduces a new binding fsl,qe-snums, which
automatically encodes both the number of snums and the actual values to
use. Conveniently, of_property_read_variable_u8_array does exactly
what we need.

For example, for the MPC8309, one would specify the property as

               fsl,qe-snums =3D /bits/ 8 <
                       0x88 0x89 0x98 0x99 0xa8 0xa9 0xb8 0xb9
                       0xc8 0xc9 0xd8 0xd9 0xe8 0xe9>;

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt      |  8 +++++++-
 drivers/soc/fsl/qe/qe.c                            | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt b/Docu=
mentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
index d7afaff5faff..05f5f485562a 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
@@ -18,7 +18,8 @@ Required properties:
 - reg : offset and length of the device registers.
 - bus-frequency : the clock frequency for QUICC Engine.
 - fsl,qe-num-riscs: define how many RISC engines the QE has.
-- fsl,qe-num-snums: define how many serial number(SNUM) the QE can use for=
 the
+- fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
+  defining the array of serial number (SNUM) values for the virtual
   threads.
=20
 Optional properties:
@@ -34,6 +35,11 @@ Recommended properties
 - brg-frequency : the internal clock source frequency for baud-rate
   generators in Hz.
=20
+Deprecated properties
+- fsl,qe-num-snums: define how many serial number(SNUM) the QE can use
+  for the threads. Use fsl,qe-snums instead to not only specify the
+  number of snums, but also their values.
+
 Example:
      qe@e0100000 {
 	#address-cells =3D <1>;
diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 71beeb72eee4..049b36d6aeee 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -283,7 +283,6 @@ EXPORT_SYMBOL(qe_clock_source);
  */
 static void qe_snums_init(void)
 {
-	int i;
 	static const u8 snum_init_76[] =3D {
 		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
 		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
@@ -304,9 +303,22 @@ static void qe_snums_init(void)
 		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
 		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
+	struct device_node *qe;
 	const u8 *snum_init;
+	int i;
=20
 	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
+	qe =3D qe_get_device_node();
+	if (qe) {
+		i =3D of_property_read_variable_u8_array(qe, "fsl,qe-snums",
+						       snums, 14, QE_NUM_OF_SNUM);
+		of_node_put(qe);
+		if (i > 0) {
+			qe_num_of_snum =3D i;
+			return;
+		}
+	}
+
 	qe_num_of_snum =3D qe_get_num_of_snums();
=20
 	if (qe_num_of_snum =3D=3D 76)
--=20
2.20.1


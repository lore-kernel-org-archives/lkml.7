Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FCA2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="i3gmoHXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfB1Kar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:30:47 -0500
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:56544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbfB1Kar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74/CR0tb2JiWnIqLZxhxnHEIPP+FbTZaeS+da5fT4us=;
 b=i3gmoHXoxMYTz9JyZ0WPFqJ31AvlZzTNnOxL3FqVmSUFXPulsWODMop502Qgp/4YG8D7/M6BiUDz6gp6E3+UIyyBkh5+FgKIDOeC8wCcxnNCIyfi3nmGszs/a593dR0KTJHRjN7nPOS20B/CKBvGHqWqNZIk5jDjNEPqjswpxdw=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM (10.167.201.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 10:30:39 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 10:30:39 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 0/4] soc/fsl/qe: qe.c: cleanups and support for MPC8309
Thread-Topic: [PATCH 0/4] soc/fsl/qe: qe.c: cleanups and support for MPC8309
Thread-Index: AQHUz1Cmj5RviE8mh02LQND/tLqu7A==
Date:   Thu, 28 Feb 2019 10:30:39 +0000
Message-ID: <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
In-Reply-To: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
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
x-ms-office365-filtering-correlation-id: f93de89d-cd92-4c4b-31f5-08d69d67c897
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0509;
x-ms-traffictypediagnostic: VI1PR10MB0509:
x-microsoft-antispam-prvs: <VI1PR10MB0509DC9DBDA88CF07CE096228A750@VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(189003)(199004)(476003)(446003)(11346002)(2616005)(8936002)(44832011)(8976002)(106356001)(42882007)(486006)(68736007)(186003)(50226002)(107886003)(105586002)(54906003)(74482002)(4744005)(110136005)(316002)(5660300002)(97736004)(1076003)(72206003)(2906002)(52116002)(71190400001)(6486002)(305945005)(478600001)(256004)(71200400001)(53936002)(99286004)(6436002)(66066001)(6512007)(6116002)(81156014)(81166006)(102836004)(4326008)(25786009)(6506007)(386003)(26005)(76176011)(7736002)(36756003)(8676002)(14454004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0509;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0509;23:YZO/54zoJDg6W2HMN293XVZ+stFmgI912Vz+x+m?=
 =?iso-8859-1?Q?tLdd2Z61Erjkpwjs8SPE9tgRZ+RhDWHioKLWm1hPD8Dstm9XEOo0Nz5mWl?=
 =?iso-8859-1?Q?qNqJgA+pO6qigLcFR4DzPioXTL4ycdOy9bfvYB8ldMRVA24vx+NKmq+YzY?=
 =?iso-8859-1?Q?pAq4P7m1dCTIvU4fjk/cKzwF1KucH/sYb/VWhe8bo1JTiEqNvStC7hssrn?=
 =?iso-8859-1?Q?g84Cm48zXCpEjg9RvxpE4yUgP3IZyuO3cACkL2EH931BthyyUbtPqUq4/w?=
 =?iso-8859-1?Q?g+tRgK1haRi1wmuN0V1Z21V0WsWyotgJHcz1llAteWhmECUkb9fBvtwLIa?=
 =?iso-8859-1?Q?c7kR6L5jto5rt+cytEDYBQ7S92Lz+8rTv0wzSAV5PexgAonKSlAIlwFVR0?=
 =?iso-8859-1?Q?KBuhs24b5s9S98qQ59ujZ6eWuhiugeLa/iLm8wmrlVmo17+kvMjTVci7eB?=
 =?iso-8859-1?Q?bq3zSuoEGvSY+vEsI1bx7ZBc37af/p56IPfk2uRINQEnwKVsXnwG6WrvJs?=
 =?iso-8859-1?Q?i8V/SoeMqp+SUsOLIEhagsF7x3TP4Km7lTFa1mHsDyh4MFYv3WI2nTEO0q?=
 =?iso-8859-1?Q?Uq8n+wu+PTmB3k312MMJAo6SaD+IJdIB1yOn8vDwwl8WOMGO9CW7wE/By+?=
 =?iso-8859-1?Q?tvbdFVaxYvL32CTkaTEG0rCt75UNHlb6pipHZmlqVmljYN5yFJhgHRf/Z9?=
 =?iso-8859-1?Q?uCXdd74irY3D/Oimah+UX/o/Z8AYu/CSCmdgps5MYs81wyhSfSysIMAIfD?=
 =?iso-8859-1?Q?XV4J4SSMUP+Hmw2mhOKKIKS5A7RCwTvustVKNqIM3X69uQft9DOKTaK4PD?=
 =?iso-8859-1?Q?mCZGub1fEdUWOGcuVw7Aiu4NsUxtJZAn57FGFyqejOr51F0Zieh7z5tkPV?=
 =?iso-8859-1?Q?y6KKS2wHzZEu03ir9aa4Mk+CTBb3zegtfPgJCvTlYw8pxffU22TDKL5UMT?=
 =?iso-8859-1?Q?vAgpL/Zv9ScGnRCsq+UnHN9B1OeDVtsYC90xbRj3RWqJVlg4uu9I3JQ3xW?=
 =?iso-8859-1?Q?Oe29tH79tZIS90Kj8MM5cBLLJDvvpX8tlPkirDfCBSiBIOvl5vTycX5FjC?=
 =?iso-8859-1?Q?0LC52P02o+bbr3n7kJAVMsxPy04x+ax+ZnkUqOWF9BBLF5W0DO3368bSky?=
 =?iso-8859-1?Q?KZWVs0bcRWi25W3NTbX1KMif6VIb1IaHMHZzPsSYgSFugpwW7nmMReeLHq?=
 =?iso-8859-1?Q?lt+Omjfpy40t5KXOXghLabtY3/UnWrpmPvAWuvpsnSChUACptjQ3O/GV7/?=
 =?iso-8859-1?Q?TuARFr4VCv0YsiG14P4u/nKTpj0Tjlp6JoEGSXmGjS+x4lpCr6ay0hJyoY?=
 =?iso-8859-1?Q?lqrJZbUzF+LMYQQ9jZymYHjr79KolrOq7bOtb/4oW0Scicl1qD0LvYw1cm?=
 =?iso-8859-1?Q?wJkfF72gSNr72Qx7g0K85reJdj4Z3?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g+0H4TWVit9mZkSCNVpOvoRgozreryYGXzxmBmN9vJwJERqVAPF7sDVNCtyKtIFt431RG+eTRyVZATiReP0nErJeXy5K7bYs8+27YLBDYxJrsVB+SpYWRBuRA5PPIwM+1gALQgIG2XGakDtEVNr1ih2YfNbwm7K69bVBhuLWsM5vF2O1+fhSpj6pLdH/pwUWGiv5IHFrV6n9Abl1ukHoUw4uuC01MsjZbsx7bTP3fNo8P4JshksjvP4vr6I749ju7+4WoIbmgIzUKET5uqgk1PY6mAR/tBdyF7j5owCMDykeZUZJiNCcr2q7b5C/tzKUw32Y+LdVTbM0If+VIuXclGwKAswYhi2hVoxW3FaU3z30hJ9pWO/vLPUvDjVauPLWiZkrWsSy4AHw7uAQic5NydsvKWGy3bVPIqytcBRtcIU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f93de89d-cd92-4c4b-31f5-08d69d67c897
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 10:30:38.6614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I have in mind for a fsl,qe-snums property. The second
patch in the series has the side effect of making it very easy to
introduce that, since the of_property_read_variable_u8_array helper
does exactly what we need in terms of verifying the array length and
copying out the values to the snums array.

This should make it easier to support all of the QE variants out
there, instead of teaching the qe driver some magic mapping from
qe-num-snums to actual snum values.

Rasmus Villemoes (4):
  soc/fsl/qe: qe.c: drop useless static qualifier
  soc/fsl/qe: qe.c: reduce static memory footprint by 1.7K
  soc/fsl/qe: qe.c: introduce qe_get_device_node helper
  soc/fsl/qe: qe.c: support fsl,qe-snums property

 .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt |   8 +-
 drivers/soc/fsl/qe/qe.c                       | 124 ++++++++----------
 2 files changed, 62 insertions(+), 70 deletions(-)

--=20
2.20.1


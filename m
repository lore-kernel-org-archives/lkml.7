Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCBC22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="IKZ9Igu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHUJtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:49:05 -0400
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:29981
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfHUJtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh/dV0iePQ+4k5/tUS/5aZaz+t2EEtdDYNWjZaEHIZ03qQi9zd9PbqglOctBnrNLbfYb6NbI+AEH0/IeNDQZqIuecnOdByV1DHeN7S6fEUppt+Qli1C9Op082xlpmObgKDnYEMj+us/NNK0koL/X++Uc/8FWPV3JXPUzYwxhcy5fIPEmwvfpXpvynXZQCy/O/VCzy0jNE4cwQ66moemAudOlfvJjJvRHTDAM6BN9PxFyPpRWS7kbKS8IsW63e+fpAmJK1U0OGUVCVSi7k3SvxrcZrL8sN7HepeXIJVcmkRKKxfKSbq7mNtNrJHT1Ze4jOznbcqid9DluErjPKZE76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gtHIjLItw7G5pBGRFD5QEmfvn5Iv+YxcTnHtjRBUkg=;
 b=WUQcj2PTomgtx6ygSOGdGBD5e3F1EGgoZef3YC/WWvkgna28Xdtqx14BQct1s/sGOmyGP5EAZLjOGxgS4lbUHGbpq6XHQzo+g/G5eec6QFfVpTe5c3TkegBKfEex1LN1fI8W9ltqALa6dNDP6uzhGkMqZMdmGJo1DwsuMr7hj/num+6Yo7lOJqNEg30nxuEre2YX+EP+KdpPI11lkrCd6U+ZBL7IFEPdtfV2upnPSxA3boBM8vgxQFfHYLs9vdSSxeS3x5G4Bmc0kNm7HBHBfodiMdzggO8RZMXl/KNz+n6yUlSu1OFr88kbPQs6Ia1RCl8LEOex4If/biAb31JikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gtHIjLItw7G5pBGRFD5QEmfvn5Iv+YxcTnHtjRBUkg=;
 b=IKZ9Igu8DDLhmYjEPz0uLT7eq4LiS+yC1yfzgZNTbxTop2W3hpXmz88c8t76Q5RcTOhfOQcz4H5m2Y5BrQ98+jEUTAlYnK/TScCDGltTOAkS9X2shx3DxMUsAKx0n0uQ8wbMyEIzF8xpAQYEpknwE4SjvkkhbQcS49xxGMVi7a4=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4216.namprd03.prod.outlook.com (20.177.185.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 09:49:01 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 09:49:01 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: ftrace: remove ftrace_caller_old() and ftrace_call_old()
Thread-Topic: [PATCH] ARM: ftrace: remove ftrace_caller_old() and
 ftrace_call_old()
Thread-Index: AQHVWAWpTPa2leot7U6qZ7id2aGviw==
Date:   Wed, 21 Aug 2019 09:49:01 +0000
Message-ID: <20190821173753.7b404335@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0172.jpnprd01.prod.outlook.com (2603:1096:402::24)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54eb0223-d198-4e86-7967-08d7261ccb8a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4216;
x-ms-traffictypediagnostic: BYAPR03MB4216:
x-microsoft-antispam-prvs: <BYAPR03MB421687E670A034524E7EC7DAEDAA0@BYAPR03MB4216.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(476003)(86362001)(71190400001)(99286004)(71200400001)(26005)(66946007)(64756008)(66556008)(52116002)(486006)(256004)(186003)(4326008)(102836004)(8676002)(66446008)(81166006)(8936002)(81156014)(50226002)(386003)(6506007)(66476007)(25786009)(54906003)(110136005)(316002)(3846002)(6116002)(4744005)(2906002)(6436002)(5660300002)(305945005)(1076003)(53936002)(66066001)(14454004)(6512007)(9686003)(7736002)(6486002)(478600001)(39210200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4216;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IVaJ++UcfauEfpZo+Vci1daT1PbmRMVEt8zmDRQGT9nmq3GXdq1R7o+/RcsRCzgMchYgG0ppLmoz82twiS8MOoJF3Ah6auFRhR7AKTSJmYgyB0/g/I8EvnkDxQQkQIq6UQUrwWUUpxLdxAJErPv7jENXppeNaddgMqmV/LPx7+iF2NfiaFgODSBSZ2EcmURv4vzxVYNDUDEFHL2rRfbhN/ye9/Tg22J1SGv6KYXW2jeImaAImiFF82g/eGbQII9/pBBGlvSXkc5nd6/LX6aveZCGoGY+LEFyCzYJ6zWwS0BeoQOIn2B4oz27Hdo9zJ3oFyzHho90jjYNRGG1bS4KkgrcbIt5TuhRmj6e/EhY1x7rpasdjNjDGtAoT6XXmVV3/QPya4ypVGNjr1MYs+lTcNsMJTObwckMcpE7iJxqvv8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E319A5BA08B47438458B421F446FBD3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eb0223-d198-4e86-7967-08d7261ccb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 09:49:01.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/dTjsvvD07jeTu4OKdEAVyszBLJDaehc7wTJk8e7K+iV84xiY6EgCFs9Fi4u1Bgp7oAAa0LeM2GpzomIOwQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
removed the old mcount support, but forget to remove these two
declarations. Remove them to clean up.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/include/asm/ftrace.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 18b0197f2384..f67596427971 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -23,9 +23,6 @@ static inline unsigned long ftrace_call_adjust(unsigned l=
ong addr)
 	/* With Thumb-2, the recorded addresses have the lsb set */
 	return addr & ~1;
 }
-
-extern void ftrace_caller_old(void);
-extern void ftrace_call_old(void);
 #endif
=20
 #endif
--=20
2.23.0.rc1


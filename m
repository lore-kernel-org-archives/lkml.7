Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE035C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588D2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="FYEok7fW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfHWKdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:33:31 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com ([40.107.71.55]:43568
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730818AbfHWKdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq0qdLGvTl0M69MZPYunidnEBDd7KoTYizAnVwBJ56Vgh9IxF4z89Eun6SmpdrRB6/OkbU5kJRG39vYJxenlbR7fgZW71aEvOk1N0GuNIBNNAzE4VxKkIH4+fqDoWPdGwJ7jLAu3JwCAZs/UjMdtWFSGwos3Yt87d8NBpxI+KCgXxeA2OjYTYjxNUXQGasNzifVy6VCmaR8yvZNNYm2XGQZbYjJUHE8qkxE3JlGvZtCgLgV2ASwaErc1vgLPpEN4cK8XV7PcS1v3Dxe319N+y/29Pz6kvBWu3uuS8Gqv1A2/EvhqJv+xXsb1knfFQmWv0eP7hped9UYga/odNU0XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw5miTTGcDyaWU3bGKdl/sgBX3EJjhV1YyoYn+RC6jM=;
 b=lTUoj7PPCDti4C3gVHKvLVVgjAwHyVf7JQK/gBccYT52fpfR+JVOuhATK0Pk2gsRWVoF6g27Oo4btcHCQvZNamd3lf+cXVGPqOUIPWwAa0R3S7JmtWTrc+lS5N0MJwdy+GHqQhu3TS1DO131hHMtOjelLkllZoqpW4qVQVU0JjrYSdaG2xgM8Uv/KJ3AW4jbUCJXx5bd080zDLMLqAhgZewxBi2u7FLSQtw5ABCW49wZJHb6bQxn5m2eG8b2gcHDRWW9hsvGZTqpx1pZY6ASiglXvspNd6pEgRtjDKc9oddVoODopCraUGz9ob62EPNqaJz+BKKEG5a8kTCH26MAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw5miTTGcDyaWU3bGKdl/sgBX3EJjhV1YyoYn+RC6jM=;
 b=FYEok7fWqn/0A58L6cIvbnqRSABjQlN5RX5VeLO35XKnXz8I7A2327+ohVfjLf+T1G999RwpDSRPZxqt+CtWHG+sGSACe1qzCY1cgv6acrlpxAhLi+35cD6F3g+3RHlUh5XMZn0JL/dZYYYPyN1jDBoY1kjAZIyXNM+/qKe1D2g=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3640.namprd03.prod.outlook.com (52.135.213.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 10:30:02 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 10:30:02 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Topic: [PATCH v2] ARM: ftrace: remove mcount(),ftrace_caller_old() and
 ftrace_call_old()
Thread-Index: AQHVWZ247bHc8lRHzEW3X45ZRp5UUQ==
Date:   Fri, 23 Aug 2019 10:30:02 +0000
Message-ID: <20190823181842.108e6e73@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:404:56::36) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ddce9d6-de1f-4d9a-2025-08d727b4daf3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3640;
x-ms-traffictypediagnostic: BYAPR03MB3640:
x-microsoft-antispam-prvs: <BYAPR03MB3640C6CBDA087370AAE28EDDEDA40@BYAPR03MB3640.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39850400004)(346002)(366004)(199004)(189003)(102836004)(8676002)(305945005)(81156014)(81166006)(7736002)(478600001)(86362001)(53936002)(8936002)(14454004)(256004)(486006)(9686003)(6512007)(6116002)(25786009)(6436002)(71200400001)(71190400001)(3846002)(6486002)(2906002)(50226002)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(476003)(186003)(54906003)(110136005)(5660300002)(1076003)(316002)(66066001)(4744005)(99286004)(6506007)(386003)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3640;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 44TFjnAd+z5VsBNJiYJ0DHuLteLk4dfPFywCc1rrm8vXZ7lmnG8U5o4At5TofGzmplAZvbuvUMJC5LDcDpORo3218fl5fnZUnCoviX+fU1EO8zmLKV/YxHN2oUYVzN7WbJN5/x9TDtm90ZH+M36bFoo1TEPIlaWPlaNCT9HFdsKyu4I8FRCjhL9HM4Sj52/9MNJ2ddNE6PKBUvKEWMTMKv4+w/MRxhMAJUdIPuEAYCKXLCr457QeI1C7ZSB6cia53i85m/6s4iKdjXB6GAfpk2zvL9eW8EgE0lL+tS2Dmtbu9SOSQAHOvQe2Hl0978lU4qTg1ogNBo94Gt7MU0XgYD6hS2YC0Ig0/fnK/GCn5rNio9nekk1R2ZIBiu5tZuIopzi9+Q4/qzNvYQXgiWn70hnX3dk/Qa6kRSTE+3CZveU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00A50105E477CE489D558106E4749D61@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddce9d6-de1f-4d9a-2025-08d727b4daf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 10:30:02.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4cddftsdfNwyZMxhd6sgfZqvaQ//YKu6ceICF88ebomk4kMBqYnm7k8HXPfrx1mrSNB0I8estRfB4gnIm4zBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3c61619568c ("ARM: 8788/1: ftrace: remove old mcount support")
removed the old mcount support, but forget to remove these three
declarations. This patch removes them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Changes since v1:
  - remove mcount() declaration too

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


Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8106C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9D220872
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="drZ6SwUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfI1BxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:53:12 -0400
Received: from mail-eopbgr800097.outbound.protection.outlook.com ([40.107.80.97]:53109
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfI1BxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:53:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfcQoURwlavDpF7hG63R1XSQJTa3DjgopWtfKG2jLlFwQfox+8BrdM8FKyZ6jRPpHZlygRkJT9f87hlFXVxka3CiL0nyENjzQ4QJSFDBwPy+dt7NI2cNp9ZH08apUWsBbyBW1F7Bvab0yf2x7DiTVJPUXlhb6gTdg8yKpLMYTzeUK9R61BwJkrW28mF8Qz60e4Kbrav6DHsNQ5X8OPSEcb24oHl3WUvbaxgyOIf+iUdaTwzHm420NJGytTk04h29tp84m7nyDV3H+crH7Q2A7TKpE93txUjJNrwHl+Ty0KG8axZOG8ZctZwPLR3eeeqGqYyb5t6kFY6KSKMDJ/lR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEu+JfK6OjcJd/yqimyilUKMx+RSmmC9U53rvj+jJUk=;
 b=IIbl/WKStKOPeuOfZhC81LCrmFMB3QmmjwVPu3A897V2cg0g1YOMNvVzU7g7UglhSgloBs6r+WcxyWG2S3HFGvMhAv9hKyzKsFjGLNpuExGKpy3IUHkN8kWYuHaxD9kgPRdq5KxXoDH0v9sTzs5ArAM42MLseWFQ50vrbxTfjEqu+en4Fb3D+h/2zvssD1a2slLQHVPZFERLNtoVazc7KlNflsJRDRRlAtx5jjc+OPlz6D5tEJ/H1kpPIjrUlzJPA114f7+2HQIGSFjwbDC9abdIg9T+Vly/q08lpCteeoaLBfQHNFj9unIaGaST3Wr6W1qHlxaNwE2hz7MsC17SOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEu+JfK6OjcJd/yqimyilUKMx+RSmmC9U53rvj+jJUk=;
 b=drZ6SwUZOZUfe+5olI3tKYWUcS1iHjtJuJncerzA9X5eZh6hv1JVg2jJK6BZXHYoB7NswFpTJpO51SRICyn0Uh4BYfkagv8KPH5H5ZZexCMRN9PblfKHjpP8K5yv2oPOGf1TmjakPe4U/7+EkTXG7Ha9G/g9/E8zUNEaniEKFyg=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1268.namprd21.prod.outlook.com (20.179.74.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Sat, 28 Sep 2019 01:53:09 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Sat, 28 Sep 2019
 01:53:09 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/4] perf docs: Correct and clarify jitdump spec
Thread-Topic: [PATCH 4/4] perf docs: Correct and clarify jitdump spec
Thread-Index: AdV1n2Bs8TQvHlYdQvSyxDQl3R86lg==
Date:   Sat, 28 Sep 2019 01:53:08 +0000
Message-ID: <BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-28T01:38:59.2288447Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab65d156-f883-4db3-993c-08be3d8ea58e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff749a14-8082-4b77-8741-08d743b69cd6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1268:|BN8PR21MB1268:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB126874149F6F8F8CA95BC7F7F7800@BN8PR21MB1268.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(10290500003)(9686003)(66066001)(54906003)(22452003)(6116002)(110136005)(25786009)(6436002)(4326008)(186003)(14454004)(478600001)(86362001)(8936002)(71200400001)(2906002)(81156014)(81166006)(55016002)(71190400001)(316002)(8676002)(305945005)(76116006)(486006)(476003)(7696005)(256004)(14444005)(99286004)(26005)(74316002)(102836004)(6506007)(5660300002)(3846002)(7416002)(66946007)(66556008)(52536014)(10090500001)(33656002)(7736002)(66476007)(8990500004)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1268;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrt6bWou6M2uxYDKJ5qDEvUzhBop4vQlq8q1EKweqqZsrpn/6VrfBfmu55SNOBYc6d0yOR+GSzAWwClu/Os4Pwnh1UyPWFbUGbFNr17lQKWClfJgNltonkYtjqf+jm8VOAlY4Kmb8+ktNQg2q8I3+IveV7nn0Yqo0x7pYrASZcnEBrE+O4Tqk6NUIITtuMvSwdC5+p1LSMGQA4aYKC1vTKmzqRDKxNvHE24PR1DYR6vD0ewT/1PPyyJwI8GEQfDqWDZxER97+mjWjaAYruyOHL9UfeS+Eu+KmsKwM5RTrEuiaptXWfS4ejK6+9D7b3I/h809p6l8aeVUGOZHJzi14+mfBJm6pJYyaHbvm2DJvXuZwI3n0JlkdQfI9BHwz9VDeJkx1BDPuIjkidG3huIsYCXiax2k6MZclFawb3fk6kw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff749a14-8082-4b77-8741-08d743b69cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 01:53:08.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNhX6iw4IzmJGyGQQ0kotMt5qqF93eAqA1g1AKp2KgQWrDXgRVWihxTCGRvF/c9VW9NLsjW6cWwiXhlBRljmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specification claims latest version of jitdump file format is 2. Current
jit dump reading code treats 1 as the latest version.

Correct spec to match code.

The original language made it unclear the value to be written in the magic
field.

Revise language that the writer always writes the same value. Specify that
the reader uses the value to detect endian mismatches.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/Documentation/jitdump-specification.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/per=
f/Documentation/jitdump-specification.txt
index 4c62b07..52152d1 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -36,8 +36,8 @@ III/ Jitdump file header format
 Each jitdump file starts with a fixed size header containing the following=
 fields in order:
=20
=20
-* uint32_t magic     : a magic number tagging the file type. The value is =
4-byte long and represents the string "JiTD" in ASCII form. It is 0x4A69544=
4 or 0x4454694a depending on the endianness. The field can be used to detec=
t the endianness of the file
-* uint32_t version   : a 4-byte value representing the format version. It =
is currently set to 2
+* uint32_t magic     : a magic number tagging the file type. The value is =
4-byte long and represents the string "JiTD" in ASCII form. It written is a=
s 0x4A695444. The reader will detect an endian mismatch when it reads 0x445=
4694a.
+* uint32_t version   : a 4-byte value representing the format version. It =
is currently set to 1
 * uint32_t total_size: size in bytes of file header
 * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as s=
pecified in /usr/include/elf.h)
 * uint32_t pad1      : padding. Reserved for future use
--=20
2.7.4


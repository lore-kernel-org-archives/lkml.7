Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710BAC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332AE20869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EYOP3HCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfI1BjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:39:04 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:39689
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfI1BjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+2hJ1NeTV4PoSvl7/DwpFmJ57urHcsyG/LP9B+5VqvQ6G7XppR1eTEuRORIj5BmmcapD0R62RIkB2sdJCVsehtgGulpElEE85xwvPN4HyKEHKlYP54XD94OVx+fVC48M7wMMbtFVuRwutj7HCpVu5G6J8vsmPZwb8qsgpMRyl+RXIPLSdg/Hcl7fnUTjSXQe1NgH0HCGlSVaKXHYcwltgIU5TGaAG2px2LML8aQlIj+Dh2t5bFcdABKdw7YqZ5fNj0cC254UbbdIgK8UBAtmiHYMZjEaXkHxeKtMiEsgVmr+U0SZApIdUy0X4ZjC5AMXbHQUEF5CXDrXFMPja5Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jGCMCBrUgq/6hw6L80clSR7szmROcDTg60EnlrnwjM=;
 b=Svh9gSVzit2SwYz09mI8TqU5huwTKqwOE7wDj9qEG+tTVBftop4aasTurAU2FUcpbcn44GEfYAxbbhhEoDrJV2aDOCSnQ0qFf+JFAhjIkdudBe+3ucRjdRBi/zXN1OeBqOMQr60sEkIkYoMC2he2LOl5PK1KULuMvwyabyJyMjeG9jQO92Be5gpjPYbpinNa+92BCmW8R8zYleuGNPXPvGnANe1ckY9W+8lCEjHzCw78JD/VEqN8LLQdfwhZ6DKcpzzom/3E7U+lMUJ9p5S9wNGgrYP31+MkVMEOERbpmRj43tVettJ0LZ+HgwXwAR1papwdfEKfR9eHqA15Ns77kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jGCMCBrUgq/6hw6L80clSR7szmROcDTg60EnlrnwjM=;
 b=EYOP3HCTSoWo81Qv8yoCrG/tFUNSnDim6t2KPeR2iSqO4zSt4Nilm/muKzRVBVRpAp4N0hUrlzXskuTMs+dpYIPXr0PaRS8b81i/bKEbYehDD2L1z3qg8O8yLgt2FU/dcjpjjpbynQHErrkXEGya4J1QOqozfX9PQvTiXu8G0H8=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Sat, 28 Sep 2019 01:39:00 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Sat, 28 Sep 2019
 01:39:00 +0000
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
Subject: [PATCH 1/4] perf map: fix overlapped map handling
Thread-Topic: [PATCH 1/4] perf map: fix overlapped map handling
Thread-Index: AdV1nTZ8lfM9Cf56S6GO5+sKq8wUvw==
Date:   Sat, 28 Sep 2019 01:39:00 +0000
Message-ID: <BN8PR21MB136270949F22A6A02335C238F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 7ae6c3c4-9012-45a4-dde8-08d743b4a2ef
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1137:|BN8PR21MB1137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB1137A19C8445480D6DF410E3F7800@BN8PR21MB1137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(74316002)(8990500004)(66066001)(478600001)(8936002)(52536014)(2906002)(25786009)(8676002)(7736002)(99286004)(4326008)(81156014)(19627235002)(110136005)(7696005)(71190400001)(81166006)(71200400001)(10290500003)(5660300002)(102836004)(316002)(64756008)(7416002)(66446008)(256004)(76116006)(476003)(14454004)(305945005)(486006)(26005)(6506007)(66574012)(14444005)(55016002)(9686003)(66946007)(33656002)(66556008)(186003)(10090500001)(86362001)(6116002)(22452003)(3846002)(6436002)(66476007)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1137;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNwkRJWlfLUsWOXrUidSwgJHjXDuf6jX0b0zJs20Mit9GiG+2JkwmnHDWjZ5enE5pPZQg2RbJTIeJC/akMtbC1CEgaI+kWO/LfnaA/B9oLWMLauJY6KlLEcS/8R0tcq4h+TuwTLkXaNA2b6sXiLxHn/0wstmXbH5Ln5WUFHwKJWaKqWyrZsUB2/KIKrJS1NE9l9thggBnWa+OFxLuBzw1+VWO0CSP52tkTn3/xb62F9MhJZcXnbt8g4l6y8ie5spJEhlTwk45kVsbDfSFNTsGI9h5MWQTEyLdG0oRnlRAFRX21AC0/ID1/s8We4zyY2of6EE0L2E+dsHCGu8NCLjvu5zN6OUYKwpe13d4Xz74qTM6VsQ2ZxPJPwGV5U7hxVNmLw/yKVqwJ8+0uUgKx3ZtapD3YQr5z/aBd2uZLB8XKs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae6c3c4-9012-45a4-dde8-08d743b4a2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 01:39:00.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0fJIWwBHQWih2gRRlHvu/QsOoiIUtUy9TCckRAFGGDAjUlzymCXR3dyP2wBUVca6XVEw4RIjadvl2SGu6ninw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever an mmap/mmap2 event occurs, the map tree must be updated to add a =
new
entry. If a new map overlaps a previous map, the overlapped section of the
previous map is effectively unmapped, but the non-overlapping sections are
still valid.

maps__fixup_overlappings() is responsible for creating any new map entries =
from
the previously overlapped map. It optionally creates a before and an after =
map.

When creating the after map the existing code failed to adjust the map.pgof=
f.
This meant the new after map would incorrectly calculate the file offset
for the ip. This results in incorrect symbol name resolution for any ip in =
the
after region.

Make maps__fixup_overlappings() correctly populate map.pgoff.

Add an assert that new mapping matches old mapping at the beginning of
the after map.

Committer-testing:

Validated correct parsing of libcoreclr.so symbols from .NET Core 3.0 previ=
ew9
(which didn't strip symbols).

Preparation:

~/dotnet3.0-preview9/dotnet new webapi -o perfSymbol
cd perfSymbol
~/dotnet3.0-preview9/dotnet publish
perf record ~/dotnet3.0-preview9/dotnet \
    bin/Debug/netcoreapp3.0/publish/perfSymbol.dll
^C

Before:

perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
   grep libcoreclr.so | head -n 4
      dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
          r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
      dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
          rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
      dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
          rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
      dotnet  1907 373352.705249:     250000 cpu-clock: \
           7fe6159a1f99 [unknown] \
           (.../3.0.0-preview9-19423-09/libcoreclr.so)

After:

perf script --show-mmap-events 2>&1 | grep -e MMAP -e unknown |\
   grep libcoreclr.so | head -n 4
      dotnet  1907 373352.698780: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615726000(0x768000) @ 0 08:02 5510620 765057155]: \
          r-xp .../3.0.0-preview9-19423-09/libcoreclr.so
      dotnet  1907 373352.701091: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615974000(0x1000) @ 0x24e000 08:02 5510620 765057155]: \
          rwxp .../3.0.0-preview9-19423-09/libcoreclr.so
      dotnet  1907 373352.701241: PERF_RECORD_MMAP2 1907/1907: \
          [0x7fe615c42000(0x1000) @ 0x51c000 08:02 5510620 765057155]: \
          rwxp .../3.0.0-preview9-19423-09/libcoreclr.so

All the [unknown] symbols were resolved.

Tested-by: Brian Robbins <brianrob@microsoft.com>
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
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5b83ed1..eec9b28 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "symbol.h"
+#include <assert.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
@@ -850,6 +851,8 @@ static int maps__fixup_overlappings(struct maps *maps, =
struct map *map, FILE *fp
 			}
=20
 			after->start =3D map->end;
+			after->pgoff +=3D map->end - pos->start;
+			assert(pos->map_ip(pos, map->end) =3D=3D after->map_ip(after, map->end)=
);
 			__map_groups__insert(pos->groups, after);
 			if (verbose >=3D 2 && !use_browser)
 				map__fprintf(after, fp);
--=20
2.7.4

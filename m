Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16327205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cm+40xSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfITTUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:20:22 -0400
Received: from mail-eopbgr750115.outbound.protection.outlook.com ([40.107.75.115]:43800
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfITTUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PntwezEus3IQhcol8M5Edb79tTG73VjaKSArPHBIlwV5Pz3iXcV+9KypR93QzV+OtStLVXy5hit6YJPxqEnzuLMfkNt/GbFXM/gKmV5bOgAAa/nE1gOa7ebPzbyiVCx8QJrBHdrtYrr3aeYB9qXDi+2qZJvobeM0TZIOcfgYEEu9FsQ+lfh3tWyZCVfbVSsUxbs8q21PpYc0QrqmbPvja3vlcaOn02U6YWEb3pfppZedGHct9yPotWRpPMjJM5ZHuhrqo88bpAY7nf5qR7s5iJc4SNxegVR5BoDq21qhYqZDhGoulvweSHrJ6mCFm0dzEJ1a/9n2AVR7RULYh1FJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL0Qfy7YaUhhdLtqJrDq+kFso747FyI74iE57dXvZDg=;
 b=UGhwrR0x7zkrQvMbrBAkMKnHgvCQkpBZsSBCcdErYse7+5gQcrTdBOxnrUDirK8uUl9aeJ4UiWVQVEeZeBMObeDSuiZN5TYgzm/g1mCFNzN3b7am0iTJTrASpBtgXHCVDdK6PoWocEicqIuJMBh9hSfJE9LuCecLP6KK1HcTh2WV2ad69KLLWEiY+fY1aQ1vrpzbh+NK6eCRwRF2tt82rC3CBas6Z28VfLHdPtyT1whvVYSchF1tICSAPXDYizutrYC/JXuidDYxMO8tIAprI5NEitB11J3E/I7AYk85913py3w1Je7T/BDpwcU8SoMaM52nygMBpPemb6Sur9rMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL0Qfy7YaUhhdLtqJrDq+kFso747FyI74iE57dXvZDg=;
 b=Cm+40xSZ0F+aIhs6WdqWV7AwbJSLOCsPKP2QLYsmQhH4oyi77gorUpiFDZi0ZGGFNyIeM5eFNxOqxtB09bgRGEZb33v8Q2pcFKsiGnqr4QTeXE+veYG7V4IkYfofPMZAWf1dzoWvgYUpKcudHt/brgbMfgWqMrHZJ8m/x5sW+cI=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1250.namprd21.prod.outlook.com (20.179.74.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.11; Fri, 20 Sep 2019 19:20:19 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::4506:fd59:ba74:46d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::4506:fd59:ba74:46d%7]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 19:20:19 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: [PATCH] perf map: fix overlapped map handling
Thread-Topic: [PATCH] perf map: fix overlapped map handling
Thread-Index: AdVv5y6SzPv23L21QnSQJe3E6wWQgA==
Date:   Fri, 20 Sep 2019 19:20:18 +0000
Message-ID: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-20T19:20:17.8175398Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4481e280-18db-41f0-b60b-edd25023ba1e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48baf6d2-034b-4cd7-144f-08d73dff9321
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1250;
x-ms-traffictypediagnostic: BN8PR21MB1250:|BN8PR21MB1250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB12501946576AF9C588E56D11F7880@BN8PR21MB1250.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(6506007)(186003)(7696005)(52536014)(5660300002)(74316002)(25786009)(8990500004)(66446008)(10090500001)(305945005)(3846002)(7736002)(486006)(8676002)(4326008)(64756008)(66946007)(66556008)(102836004)(476003)(76116006)(14454004)(6436002)(86362001)(256004)(6116002)(33656002)(8936002)(66066001)(55016002)(81156014)(107886003)(99286004)(26005)(66476007)(66574012)(71200400001)(81166006)(478600001)(71190400001)(110136005)(22452003)(2906002)(2501003)(10290500003)(7416002)(54906003)(9686003)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1250;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6JbZPMSQL/DdTJiYAjF32XKhCUaFr12oxmUT/DbJhN7hvaYBevN2LrQGI6w6KCafavNbg360Ybtf6prluUAktjWGJ5KCEjtnEXfqm1+8sRYhNxVacp8t78jU56C1kk9ixCq2uWlL+2Xr/2Znwv6x4pG7c1SIRio+Y1Mbg1zyGshmPH6FfrAL3xzKCFB0y4v+d8pYL3yEen3y771o2YKP4l4R8H9CWjVkANuU3LahXYkdlN1cZ3oc9HliKVjZEi6cDeQqo5tAIrp9wsBERqQZrOX0TiH/DOPfHwus7SLcjkVUOVSj3Ju3+h4ydsFezzrsvumzHLCI7X8YP4RKNfjffr5LYtCQvN7hKi6CJADcPTxaJurIL/Jtg/f/7ZDlViGX8y9KN6fm10NW9ow+kTZ4ug2bmDXDXxjyhaM6dPFz2rs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48baf6d2-034b-4cd7-144f-08d73dff9321
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 19:20:18.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzGcI/W0Nj8VYdCTrGfuP1PDMo6eSdjGyzYvBW4/qQFJVMJKM7aIC6ttEISiQXWrxEtqLsj6eNMyGV4jtc0oQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1250
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

Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5b83ed1..73870d7 100644
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
+			after->pgoff =3D pos->map_ip(pos, map->end);
+			assert(pos->map_ip(pos, map->end) =3D=3D after->map_ip(after, map->end)=
);
 			__map_groups__insert(pos->groups, after);
 			if (verbose >=3D 2 && !use_browser)
 				map__fprintf(after, fp);
--=20
2.7.4


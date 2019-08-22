Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F358C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F418821726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gMe7tnvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfHVJKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:10:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732985AbfHVJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:10:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M97stv015986;
        Thu, 22 Aug 2019 11:09:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=pe8srJJW5dECkgXrPF2LkQb+H+Tg6+y671jwy3FXLxU=;
 b=gMe7tnvn/WZ7bt7vlEe/EbC/jnhFHIEqSXg5PKMu2z1frfTaIwY+jYT16vvnzvdAtFsF
 VIz6YbwH+v1RXZeR3KSU/cFFtW7wi2M3bZ2WB8CEMg/g5FBUIMUxySAKWvbjT/bGYKP5
 cLLvpjBtlmKvaQUZW3nRcYzLJBq/DmSMZIOjBwcB8g1FOGorFiMbWbIYEPKZEUKtTY4M
 9VYvsFHu6HCTaR/RTPEKyZpk+mzdfxbgx6oid8I24MPEwdHM54rSf+NyrRklxHJFonRe
 QTF545pgPGD39s6feJPj3yLMyUopgdCTDijMKBlyOhIqrXjG50q6UB5ACyBF7pSdJ8YY NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ue721bvdr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 22 Aug 2019 11:09:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E10F512C;
        Thu, 22 Aug 2019 09:07:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D04292BC43D;
        Thu, 22 Aug 2019 11:07:01 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 11:07:01 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Thu, 22 Aug 2019 11:07:01 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gerald BAEZA <gerald.baeza@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: [PATCH] libperf: fix alignment trap in perf stat
Thread-Topic: [PATCH] libperf: fix alignment trap in perf stat
Thread-Index: AQHVWMj1j+C7y+L4oEKEBHLzYFO6WA==
Date:   Thu, 22 Aug 2019 09:07:01 +0000
Message-ID: <1566464769-16374-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the patch 'perf stat: Fix --no-scale', an
alignment trap happens in process_counter_values()
on ARMv7 platforms due to the attempt to copy non
64 bits aligned double words (pointed by 'count')
via a NEON vectored instruction ('vld1' with 64
bits alignment constraint).

This patch sets a 64 bits alignment constraint on
'contents[]' field in 'struct xyarray' since the
'count' pointer used above points to such a
structure.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 tools/perf/lib/include/internal/xyarray.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/inc=
lude/internal/xyarray.h
index 3bf70e4..51e35d6 100644
--- a/tools/perf/lib/include/internal/xyarray.h
+++ b/tools/perf/lib/include/internal/xyarray.h
@@ -2,6 +2,7 @@
 #ifndef __LIBPERF_INTERNAL_XYARRAY_H
 #define __LIBPERF_INTERNAL_XYARRAY_H
=20
+#include <linux/compiler.h>
 #include <sys/types.h>
=20
 struct xyarray {
@@ -10,7 +11,7 @@ struct xyarray {
 	size_t entries;
 	size_t max_x;
 	size_t max_y;
-	char contents[];
+	char contents[] __aligned(8);
 };
=20
 struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
--=20
2.7.4

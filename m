Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84948C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407422DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nuRxovpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfHUO7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:59:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34995 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfHUO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:59:07 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LEfjSi009445;
        Wed, 21 Aug 2019 16:58:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=hvsyhvBbKbAJCgOiIKrRFL9GHm7h8/kewDO4a8D7m+M=;
 b=nuRxovpd/+qFW1wlNN/bYzzek0YmXSQOJu8hRnCXaGbQPZFkqH25FNLxrpE1QvV0e6hH
 E4chC4jVsTfi6reBe642JZ4MoQj+vitpIXW4X7pq1gdfcEGRFFE1O0MOCmJkeo4ZCIny
 TFSrfDO+1CKknh6b7kAd475QqR+SIdDUzhRYQoNcDInf8m/Y87UuV5pMl5HBHWeCvfFm
 ToZE62UY3wbDEGu01MJAdI+LPEcdrstg0i6P1ZtvAP9HqRHugOGSYO2UQ6o63B5aVt5P
 w4KaUGg4hKgjKu0je4+LuGKnixsLzSI/3qJnRCS+EnrN69T8x+RbLgmoveN0bRSLIdAv Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ue7buye6t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 21 Aug 2019 16:58:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6142838;
        Wed, 21 Aug 2019 14:58:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 466B42D6F86;
        Wed, 21 Aug 2019 16:58:47 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 16:58:47 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Wed, 21 Aug 2019 16:58:46 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>
Subject: perf tool issue following 'perf stat: Fix --no-scale' patch
 integration
Thread-Topic: perf tool issue following 'perf stat: Fix --no-scale' patch
 integration
Thread-Index: AdVYMNa4esDp3njlR1KZ0bzgLh2tpg==
Date:   Wed, 21 Aug 2019 14:58:46 +0000
Message-ID: <2680dc183a9e45b999be4939cbe67b44@SFHDAG5NODE1.st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andi and all perf tool / arm debug =A0experts

This is about the following patch=A0:
       perf stat: Fix --no-scale
       SHA-1=A0: 75998bb263bf48c1c85d78cd2d2f3a97d3747cab

Since it is applied in the kernel, I noticed that perf tool fails on my ARM=
v7 platform (STM32MP1 with Cortex-A7 and NEON) with the following error :=20
       root@stm32mp1:~# perf stat --no-scale sleep 1
       [10827.350202] Alignment trap: perf (631) PC=3D0x001139e8 Instr=3D0x=
f4640adf Address=3D0x0021a804 1
       [10827.357704] Alignment trap: not handling instruction f4640adf at =
[<001139e8>]
       [10827.364867] 8<--- cut here ---
       [10827.367875] Unhandled fault: alignment exception (0x001) at 0x002=
1a804
       [10827.374427] pgd =3D 8abc1568
       [10827.377090] [0021a804] *pgd=3Dff2e8835
       Bus error

The same error happens with or without the --no-scale option.
This is to give the context. I do not blame your patch, Andi :)

I analyzed the root cause of this issue, summarized below, but then I need =
your lights to imagine the best correction.

One of the changes in the patch concerns tools/perf/util/stat.c :
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 case AGGR_GLOBAL:
       =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 aggr->val +=3D count->val;
       -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if (config->scale) {
       -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aggr-=
>ena +=3D count->ena;
       -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aggr-=
>run +=3D count->run;
       -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 }
       +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 aggr->ena +=3D count->ena;
       +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 aggr->run +=3D count->run;

The consequence of this new writing is that GCC generates a NEON vectored i=
nstruction to load count->val and count->ena values in 64 bits registers, s=
ince they are sequential in memory and systematically initialized now:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f4640adf =A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 vld1.64=A0 {d16-d17}, [r4 :64]

The problem comes from the ':64' specifying that the parameter has to be 8 =
bytes aligned.
The 'count' pointer points inside the 'contents[]' array from the 'struct x=
yarray'.
If I force this field to be 64 bits aligned, then perf works again:
struct xyarray {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t row_size;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t entry_size;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t entries;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t max_x;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t max_y;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char contents[]=A0;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char contents[] __attribute__((aligne=
d(64)));
};

But the xyarray structure is generic so I think this patch cannot be the fi=
nal one.
Some GCC versions have a -mgeneral-regs-only option to forbid the generatio=
n of NEON instructions while compiling one file, but this does not seem to =
be mainlined (?).

Well, I am hesitating and don't know what kind of correction I should apply=
.
I also don't know very well perf tool source code, so this sets some border=
s to my imagination=A0 :)

Can you help me please ?

Best regards

G=E9rald


Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB18C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221D0219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="T48ll+Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfHGO5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:11 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:43520 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729278AbfHGO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:11 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x77ErAVF027634;
        Wed, 7 Aug 2019 15:56:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=WxrDZfrPFE+RvJaiBPECJUVgzxPWUEvRSCLWbbN/jLk=;
 b=T48ll+CdytcVMYVJht4s5V/Qo58ccg6Saf61fFUqb7kioyMPCy7QTcrFwn2J51JV5HKM
 b21otkH0kD9m18HPCv/AtH8Qo04YnRUNj5FJ1Ep9iSFnB4t3xSaq66pPSpmvJ34O2dLI
 3by81euhHtYjvYhqe4TOQ/JIysuCRHSnxtGK5WF53eTwtVEkGVwA+zvtU7HMi6FKV2iI
 CUAK8DobFVgnrFyxdBUnNY1SlBFeczgjMeBmiUsmcs7oI8eI6xhDi3z18o9SdiGA4qB7
 754UjvgtIDgU4TU0ZmlzOlLBoX9YWD2zjyT85Vlr4jLEQB3znHoGPFrrZiwx4XvRg88U jg== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2u51wv18qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 15:56:50 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x77ElwIP032212;
        Wed, 7 Aug 2019 10:56:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint6.akamai.com with ESMTP id 2u55kw7b2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 10:56:50 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb3.msg.corp.akamai.com (172.27.123.103) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 7 Aug 2019 10:56:49 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Wed, 7 Aug 2019 10:56:49 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH v2 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Topic: [PATCH v2 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Index: AQHVTNFKCXp+3LpVfE2FoOm2P/P8Y6bv1MsA///vEXA=
Date:   Wed, 7 Aug 2019 14:56:49 +0000
Message-ID: <dac01704fb6847ebbc08bea4115d52df@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <cover.1565146171.git.ilubashe@akamai.com>
 <70ce92d9c252bbafa883a6b5b3c96cf10d1a5b31.1565146171.git.ilubashe@akamai.com>
 <20190807114602.GB9605@krava>
In-Reply-To: <20190807114602.GB9605@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.34.37]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070158
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-07_03:2019-08-07,2019-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908070159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, August 7 at 2019 7:46 AM Jiri Olsa wrote:
> On Tue, Aug 06, 2019 at 11:35:55PM -0400, Igor Lubashev wrote:
> > The kernel is using CAP_SYS_ADMIN instead of euid=3D=3D0 to override
> > perf_event_paranoid check. Make perf do the same.
> >
> > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c    | 3 ++-
> >  tools/perf/arch/arm64/util/arm-spe.c | 4 ++--
> > tools/perf/arch/x86/util/intel-bts.c | 3 ++-
> > tools/perf/arch/x86/util/intel-pt.c  | 2 +-
> >  tools/perf/util/evsel.c              | 2 +-
> >  5 files changed, 8 insertions(+), 6 deletions(-)
> >
SNIP
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -12,6 +12,7 @@
> >  #include <time.h>
> >
> >  #include "../../util/cpumap.h"
> > +#include "../../util/event.h"
> >  #include "../../util/evsel.h"
> >  #include "../../util/evlist.h"
> >  #include "../../util/session.h"
> > @@ -65,8 +66,7 @@ static int arm_spe_recording_options(struct
> auxtrace_record *itr,
> >  	struct arm_spe_recording *sper =3D
> >  			container_of(itr, struct arm_spe_recording, itr);
> >  	struct perf_pmu *arm_spe_pmu =3D sper->arm_spe_pmu;
> > -	struct evsel *evsel, *arm_spe_evsel =3D NULL;
>=20
> wouldn't this removal break the compilation on arm?
>=20
> jirka
>=20
> > -	bool privileged =3D geteuid() =3D=3D 0 || perf_event_paranoid() < 0;
> > +	bool privileged =3D perf_event_paranoid_check(-1);
> >  	struct evsel *tracking_evsel;
> >  	int err;
>=20
> SNIP

Mea culpa!  (An artifact of a bad rebase.)  Just learned to cross-compile. =
 Thanks, Alexey and Jirka!

The v3 with the fix has been posted (https://lkml.kernel.org/lkml/cover.156=
5188228.git.ilubashe@akamai.com).

- Igor

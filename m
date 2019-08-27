Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8118C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF98206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="euls1GAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfH0B66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:58:58 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:14244 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbfH0B66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:58:58 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7R1v64g026922;
        Tue, 27 Aug 2019 02:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=z+bPajNU3NgiGWlepe3Am9VgKE88jtNrKSsMqBenzlo=;
 b=euls1GAhGHFur2O3wBy2nvhiEfpfUW/qshrBY7lBEdRJbI7YKfxbVDVSc38PrPBzISEO
 hBQUU3EEPhQil4etzLoUQtx4AFZtFzx6qLpd6J1d01/lyuixU4lqPtw+1T4fY/TEYdX2
 EsPfa53jx2LCsVYUc4EmhLL34MzuKHNyCSMNSLvmjaOwKzo3Jnd1KAtMKZuuRb2iGhpX
 +bFpvAzBHDurWfUwdYNMEXOwID/fdRD9kzUVjulCDu0d++GQmk7CluQHkRpUDmCAENeH
 oXNBNDB4RrwBB8hwnJABOmxQeyTThk8lzv/4Ycy8ldFUC2FWk6IPxzAL0qt1b65yzwvm zg== 
Received: from prod-mail-ppoint4 (prod-mail-ppoint4.akamai.com [96.6.114.87] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2ujwd5j3mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 02:58:37 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7R1lcSj001158;
        Mon, 26 Aug 2019 21:58:36 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.57])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2uk0k0bgba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:58:36 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 26 Aug 2019 21:58:35 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Mon, 26 Aug 2019 21:58:35 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Leo Yan <leo.yan@linaro.org>
Subject: RE: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Topic: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Index: AQHVTS6ohXVeHma7aEyJ5mLyFs0geab7PiSAgAAMNACAAAEdgP//yqiwgAHfTwCAABf5AIAF9+gAgAASvOCAAYXjAIAJuzjg
Date:   Tue, 27 Aug 2019 01:58:35 +0000
Message-ID: <c647400a6c164bdab2cadfb7c0f1b519@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
 <20190815214236.GA3929@kernel.org>
 <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
 <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
 <20190820171342.GD3929@kernel.org>
In-Reply-To: <20190820171342.GD3929@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.33.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908270019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, August 20, 2019 at 1:14 PM Arnaldo Carvalho de Melo <arnaldo.melo@g=
mail.com> wrote:
> > Arnaldo, once we decide what the right fix is, I am happy to post the
> update (options 1, 1+2) as a patch series.
>=20
> I think you should get the checks for ref_reloc_sym in place so as to mak=
e the
> code overall more robust, and also go on continuing to make the checks in
> tools/perf/ to match what is checked on the other side of the mirror, i.e=
. by
> the kernel, so from a quick read, please put first the robustness patches
> (check ref_reloc_sym) do your other suggestions and update the warnings,
> then refresh the two patches that still are not in my perf/core branch:
>=20
> [acme@quaco perf]$ git rebase perf/core
> First, rewinding head to replay your work on top of it...
> Applying: perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
> Applying: perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> [acme@quaco perf]$
>=20
> I've pushed out perf/cap, so you can go from there as it is rebased on my
> current perf/core.
>=20
> Then test all these cases: with/without libcap, with euid=3D=3D0 and diff=
erent
> than zero, with capabilities, etc, patch by patch so that we don't break
> bisection nor regress,

All done.  I've posted the update as a new follow-up series: https://lkml.k=
ernel.org/lkml/1566869956-7154-1-git-send-email-ilubashe@akamai.com/ rebase=
d on your perf/core.

I've tested 336 permutations (see the new cover).  In particular, I was abl=
e to reproduce the crash on perf/cap and confirm that no permutation can ca=
use such crashes for any of the patches in the series.

> Thanks and keep up the good work!
>=20
> - Arnaldo

- Igor

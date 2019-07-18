Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476AC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5DD2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="EewxxdlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbfGRVBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:01:04 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:24606 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727939AbfGRVBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:01:03 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x6IKv4VE021447;
        Thu, 18 Jul 2019 22:00:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=+ssnnKo+Ny4lHnJ+V/hmqcMG7PzlxwxGyfupOGxa7us=;
 b=EewxxdlHBeCSDA0B0D5Gbk15s6frmPcSPKDE4QlgAikU5wYCdqTRVbYIN8WB49kNOqXb
 07uQW/fIcIBdlj16olLbLu4DGKGqY+Aa++hcY1bndJIdj+uf/jv09BqmSrqBgffmtKF5
 /WTQJ14aSjRDx7UQDzcvCQNsgLCoSjtDm1RjGL5Ka+3iQYbYPr1FruwgrLh2AVRkYDcQ
 xf2ru40YtZk0gfvicTR+rmglM6vR5X8ONGVN6mC+rZJ0FWFB7eSdqZ9h961ZJjnqhq3s
 j6+ffDBCH/VZ02p0stNjkEOc6fe/K21yViFhAL5mp6R4Vt4ID2chzdJ0Tdt5t/+8Lqf6 iA== 
Received: from prod-mail-ppoint7 (prod-mail-ppoint7.akamai.com [96.6.114.121] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2ttadjvje7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 22:00:31 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6IKlF9R011038;
        Thu, 18 Jul 2019 17:00:30 -0400
Received: from email.msg.corp.akamai.com ([172.27.27.25])
        by prod-mail-ppoint7.akamai.com with ESMTP id 2tqamxcxb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 17:00:30 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.27.105) by
 ustx2ex-dag1mb1.msg.corp.akamai.com (172.27.27.101) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Thu, 18 Jul 2019 16:00:29 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.27.105]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.27.105]) with mapi id
 15.00.1473.004; Thu, 18 Jul 2019 16:00:29 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH 1/3] perf: Add capability-related utilities
Thread-Topic: [PATCH 1/3] perf: Add capability-related utilities
Thread-Index: AQHVMTPGnf3CWkvPCkGRtIeitk962abNV2aAgAJg2ICAACz8AIABDlOg
Date:   Thu, 18 Jul 2019 21:00:29 +0000
Message-ID: <61675e9064e14ee9ab8d3d25912a917a@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
 <20190716084643.GA22317@krava> <20190717210551.GI3624@kernel.org>
 <20190717234652.GJ3624@kernel.org>
In-Reply-To: <20190717234652.GJ3624@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.37.145]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion!  I'll try to add a test for libcap to the patch =
series as v2 of the series.  Probably not next week, though (IETF week).

- Igor

> On Wed, July 17, 2019 7:47 PM Arnaldo Carvalho de Melo wrote:
>=20
> Em Wed, Jul 17, 2019 at 06:05:51PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Jul 16, 2019 at 10:46:43AM +0200, Jiri Olsa escreveu:
> > > On Tue, Jul 02, 2019 at 08:10:03PM -0400, Igor Lubashev wrote:
> > > > Add utilities to help checking capabilities of the running process.
> > > > Make perf link with libcap.
> > > >
> > > > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > > > ---
> > > >  tools/perf/Makefile.config         |  2 +-
> > > >  tools/perf/util/Build              |  1 +
> > > >  tools/perf/util/cap.c              | 24 ++++++++++++++++++++++++
> > > >  tools/perf/util/cap.h              | 10 ++++++++++
> > > >  tools/perf/util/event.h            |  1 +
> > > >  tools/perf/util/python-ext-sources |  1 +
> > > >  tools/perf/util/util.c             |  9 +++++++++
> > > >  7 files changed, 47 insertions(+), 1 deletion(-)
> > > >  create mode 100644 tools/perf/util/cap.c
> > > >  create mode 100644 tools/perf/util/cap.h
> > > >
> > > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.confi=
g
> > > > index 85fbcd265351..21470a50ed39 100644
> > > > --- a/tools/perf/Makefile.config
> > > > +++ b/tools/perf/Makefile.config
> > > > @@ -259,7 +259,7 @@ CXXFLAGS +=3D -Wno-strict-aliasing
> > > >  # adding assembler files missing the .GNU-stack linker note.
> > > >  LDFLAGS +=3D -Wl,-z,noexecstack
> > > >
> > > > -EXTLIBS =3D -lpthread -lrt -lm -ldl
> > > > +EXTLIBS =3D -lpthread -lrt -lm -ldl -lcap
> > >
> > > I wonder we should detect libcap or it's everywhere.. Arnaldo's compi=
le test
> suite might tell
> >
> > I'll add this tentatively and try to build it in my test suite.
>=20
> So, not even in my notebook this worked straight away:
>=20
>   CC       /tmp/build/perf/util/cap.o
>   CC       /tmp/build/perf/util/config.o
> In file included from util/cap.c:5:
> util/cap.h:6:10: fatal error: sys/capability.h: No such file or directory
>     6 | #include <sys/capability.h>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> mv: cannot stat '/tmp/build/perf/util/.cap.o.tmp': No such file or direct=
ory
>=20
>=20
> I had to first do:
>=20
> dnf install libcap-devel
>=20
> So we need to have a feature test and fail if that is not installed,
> i.e. libcap becomes a hard req for building perf, which I think is
> reasonable, one more shouldn't hurt, right?
>=20
> With all the features enabled:
>=20
> [acme@quaco perf]$ ldd ~/bin/perf
> 	linux-vdso.so.1 (0x00007ffe7278a000)
> 	libunwind-x86_64.so.8 =3D> /lib64/libunwind-x86_64.so.8
> (0x00007f7be52f1000)
> 	libunwind.so.8 =3D> /lib64/libunwind.so.8 (0x00007f7be52d7000)
> 	liblzma.so.5 =3D> /lib64/liblzma.so.5 (0x00007f7be52ae000)
> 	libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007f7be528d000)
> 	librt.so.1 =3D> /lib64/librt.so.1 (0x00007f7be5283000)
> 	libm.so.6 =3D> /lib64/libm.so.6 (0x00007f7be513d000)
> 	libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007f7be5135000)
> 	libcap.so.2 =3D> /lib64/libcap.so.2 (0x00007f7be512e000)
> 	libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007f7be5113000)
> 	libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007f7be50c0000)
> 	libslang.so.2 =3D> /lib64/libslang.so.2 (0x00007f7be4de8000)
> 	libperl.so.5.28 =3D> /lib64/libperl.so.5.28 (0x00007f7be4ac2000)
> 	libc.so.6 =3D> /lib64/libc.so.6 (0x00007f7be48fa000)
> 	libpython2.7.so.1.0 =3D> /lib64/libpython2.7.so.1.0 (0x00007f7be4690000)
> 	libz.so.1 =3D> /lib64/libz.so.1 (0x00007f7be4676000)
> 	libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f7be45d1000)
> 	libnuma.so.1 =3D> /lib64/libnuma.so.1 (0x00007f7be45c3000)
> 	libbabeltrace-ctf.so.1 =3D> /lib64/libbabeltrace-ctf.so.1
> (0x00007f7be456d000)
> 	libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007f7be4551000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007f7be5331000)
> 	libbz2.so.1 =3D> /lib64/libbz2.so.1 (0x00007f7be453d000)
> 	libcrypt.so.2 =3D> /lib64/libcrypt.so.2 (0x00007f7be4502000)
> 	libutil.so.1 =3D> /lib64/libutil.so.1 (0x00007f7be44fd000)
> 	libbabeltrace.so.1 =3D> /lib64/libbabeltrace.so.1 (0x00007f7be44ed000)
> 	libpopt.so.0 =3D> /lib64/libpopt.so.0 (0x00007f7be44dd000)
> 	libuuid.so.1 =3D> /lib64/libuuid.so.1 (0x00007f7be44d3000)
> 	libgmodule-2.0.so.0 =3D> /lib64/libgmodule-2.0.so.0 (0x00007f7be44cd000)
> 	libglib-2.0.so.0 =3D> /lib64/libglib-2.0.so.0 (0x00007f7be43a9000)
> 	libpcre.so.1 =3D> /lib64/libpcre.so.1 (0x00007f7be4335000)
> [acme@quaco perf]$
>=20
> ;-)
>=20
> So, please check tools/build/feature/ and check how this is done and add
> a test and the warning in tools/perf/Makefile.config so that we get an
> error message stating that libcap-dev or libcap-devel should be
> installed.
>=20
> I'll do it if there is any difficulty, just not right now as I'm busy
> and want to get a pull req out of the door.
>=20
> - Arnaldo

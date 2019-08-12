Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4DD2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="H3CVYj30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfHLWdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:33:35 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:14690 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfHLWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:33:35 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7CMVrin004996;
        Mon, 12 Aug 2019 23:33:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=h0LVmZptY3RxOpHXUCSrEDRNcipSZb2uNc3syHLZIKc=;
 b=H3CVYj300Dv/RnDQWiUCDs/mdwJLLmB6+gfPLJrALW9pKJ2ghQrlwE5vT94UsdzH2yxs
 fKnWbL752L/I3x+LM4xNZwQMr+pmV8gTd9n9/xOqccB76+se1uOF1RlXgGGg0G2kr9tt
 PsKzTu0iL65cpEBfSVoIem4Q0+3AV1BuXV1O+2OFwZ/6e25Xk+sMYs4iL1XQlh52vgqK
 bpu4YphEBMVamkdP+wYI7FOtCibBWLBM0i4NeJLc+qDQSyzl2PsRa24ihtjRB33MoGuO
 KI7zN4jh49krBWjKLFwDQpkHFRq45B+0yrHj9AY9inSE+jsFBd/me7qkGqGXb0tSLnH0 pw== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2ubf8hgavk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 23:33:10 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7CMVxmL023325;
        Mon, 12 Aug 2019 18:33:09 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.32])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2u9s8vs7qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 18:33:08 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb3.msg.corp.akamai.com (172.27.123.103) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 12 Aug 2019 18:33:07 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Mon, 12 Aug 2019 18:33:07 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH v3 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Topic: [PATCH v3 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Index: AQHVTS6omT1rjBdROkC0v0885SRG3Kb4OiwAgAAEBYD//9oaUA==
Date:   Mon, 12 Aug 2019 22:33:07 +0000
Message-ID: <735aabdfa76f4435bdaff2c63d566044@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <ad56df5452eeafb99dda9fc3d30f0f487aace503.1565188228.git.ilubashe@akamai.com>
 <20190812200134.GE9280@kernel.org> <20190812201557.GF9280@kernel.org>
In-Reply-To: <20190812201557.GF9280@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.36.134]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908120219
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-12_09:2019-08-09,2019-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908120219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, August 12, 2019 at 4:16 PM Arnaldo Carvalho de Melo <arnaldo.melo@g=
mail.com> wrote:
> Em Mon, Aug 12, 2019 at 05:01:34PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > Em Wed, Aug 07, 2019 at 10:44:15AM -0400, Igor Lubashev escreveu:
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct
> > > perf_event_attr *attr, int idx)
> >
> > >  static bool perf_event_can_profile_kernel(void)
> > >  {
> > > -	return geteuid() =3D=3D 0 || perf_event_paranoid() =3D=3D -1;
> > > +	return perf_event_paranoid_check(-1);
> > >  }
> >
> > While looking at your changes I think the pre-existing code is wrong,
> > i.e. the check in sys_perf_event_open(), in the kernel is:
> >
> >         if (!attr.exclude_kernel) {
> >                 if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> >                         return -EACCES;
> >         }
> >
> > And:
> >
> > static inline bool perf_paranoid_kernel(void) {
> >         return sysctl_perf_event_paranoid > 1; }
> >
> > So we have to change that perf_event_paranoit_check(-1) to pass 1
> > instead?

Indeed.  This seems right.  It was a pre-existing problem.


> > bool perf_event_paranoid_check(int max_level) {
> >         return perf_cap__capable(CAP_SYS_ADMIN) ||
> >                         perf_event_paranoid() <=3D max_level; }
> >
> > Also you defined perf_cap__capable(anything) as:
> >
> > #ifdef HAVE_LIBCAP_SUPPORT
> >
> > #include <sys/capability.h>
> >
> > bool perf_cap__capable(cap_value_t cap);
> >
> > #else
> >
> > static inline bool perf_cap__capable(int cap __maybe_unused)
> > {
> >         return false;
> > }
> >
> > #endif /* HAVE_LIBCAP_SUPPORT */
> >
> >
> > I think we should have:
> >
> > #else
> >
> > static inline bool perf_cap__capable(int cap __maybe_unused) {
> >         return geteuid() =3D=3D 0;
> > }
> >
> > #endif /* HAVE_LIBCAP_SUPPORT */
> >
> > Right?

You can have EUID=3D=3D0 and not have CAP_SYS_ADMIN, though this would be r=
are in practice.  I did not to use EUID in leu of libcap, since kernel does=
 not do so, and therefore it seemed a bit misleading.  But this is a slight=
 matter of taste, and I do not see a problem with choosing to fall back to =
EUID -- the kernel will do the right thing anyway.

Now, if I were pedantic, I'd say that to use geteuid(), you need to #includ=
e <unistd.h> .


> > So I am removing the introduction of perf_cap__capable() from the
> > first patch you sent, leaving it with _only_ the feature detection
> > part, using that feature detection to do anything is then moved to a
> > separate patch, after we finish this discussion about what we should
> > fallback to when libcap-devel isn't available, i.e. we should use the
> > previous checks, etc.
>=20
> So, please take a look at the tmp.perf/cap branch in my git repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3Dt=
mp.p
> erf/cap
>=20
> I split the patch and made perf_cap__capable() fallback to 'return
> geteuid() =3D=3D 0;' when libcap-devel isn't available, i.e. keep the che=
cks made
> prior to your patchset.

Thank you.  And thanks for updating "make_minimal".=20


>=20
> Jiri, can I keep your Acked-by?
>=20
> - Arnaldo

Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569CCCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6BE20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="aWc5pVTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407026AbfJWQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:07:15 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:10248 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407003AbfJWQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:07:14 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9NFlAil019771;
        Wed, 23 Oct 2019 17:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=LQfy3ZX+sOtzy7F6giHvI1YYxcQkXeleR2LTYGJeqoo=;
 b=aWc5pVTcWaKEnqZmyBaCBJqV+tUVIgVdhJ0V/CoJJgxGg0nT9fI7EP56WI08owglbfPV
 UDBkJoUlpQ9MR23yWXp4WWnyi2qxXTKemlCz06Hd3LP5zY9A0WPfon/5uYlMzxl7Zn2/
 j36PBGjO+YnXtacs5myph6tRMxAM+Mcrs9USixCJqyDf5FuECR6pCUHFKoHkbjwPOmm+
 Fqx9j0/BYw1UONfr0cUUfLm25/7f3XLdaN8bypBDLhlJgqfFWUZJA1xWGpeMAZeolZr9
 NL/ntXZAeLYVu1ze6gyKTG4gF2g18ALqJtMqTPr2fzBkbMkFktg2OWPwGVF/lUlDUzmb 7g== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2vqthjn7r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 17:06:56 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9NFl7n6008199;
        Wed, 23 Oct 2019 12:06:55 -0400
Received: from email.msg.corp.akamai.com ([172.27.165.115])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2vqwtx2bc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 12:06:55 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.165.123) by
 ustx2ex-dag1mb1.msg.corp.akamai.com (172.27.165.119) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 23 Oct 2019 11:06:54 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.165.123]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.165.123]) with mapi id
 15.00.1473.005; Wed, 23 Oct 2019 11:06:54 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] perf kvm: Allow running without stdin
Thread-Topic: [PATCH 2/3] perf kvm: Allow running without stdin
Thread-Index: AQHViUT4jEXDkFlf70GojsikrAjFJadoXn2AgAAE7ZA=
Date:   Wed, 23 Oct 2019 16:06:53 +0000
Message-ID: <9be5f3fb3cf3493abf50e7acbab48d47@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
 <1571795693-23558-3-git-send-email-ilubashe@akamai.com>
 <20191023104245.GL22919@krava>
In-Reply-To: <20191023104245.GL22919@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.33.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230155
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_04:2019-10-23,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 23, 2019 at 6:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Oct 22, 2019 at 09:54:52PM -0400, Igor Lubashev wrote:
> > Allow perf kvm --stdio to run without access to stdin.
> > This lets perf kvm to run in a batch mode until interrupted.
> >
> > The following now works as expected:
> >
> >   $ perf kvm top --stdio < /dev/null
> >
> > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > ---
> >  tools/perf/builtin-kvm.c | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c index
> > 858da896b518..5217aa3596c7 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -930,18 +930,20 @@ static int fd_set_nonblock(int fd)
> >
> >  static int perf_kvm__handle_stdin(void)  {
> > -	int c;
> > -
> > -	c =3D getc(stdin);
> > -	if (c =3D=3D 'q')
> > +	switch (getc(stdin)) {
> > +	case 'q':
> > +		done =3D 1;
> >  		return 1;
> > -
> > -	return 0;
> > +	case EOF:
> > +		return 0;
> > +	default:
> > +		return 1;
> > +	}
> >  }
> >
> >  static int kvm_events_live_report(struct perf_kvm_stat *kvm)  {
> > -	int nr_stdin, ret, err =3D -EINVAL;
> > +	int nr_stdin =3D -1, ret, err =3D -EINVAL;
> >  	struct termios save;
> >
> >  	/* live flag must be set first */
> > @@ -972,13 +974,16 @@ static int kvm_events_live_report(struct
> perf_kvm_stat *kvm)
> >  	if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
> >  		goto out;
> >
> > -	nr_stdin =3D evlist__add_pollfd(kvm->evlist, fileno(stdin));
> > -	if (nr_stdin < 0)
> > -		goto out;
> > -
> >  	if (fd_set_nonblock(fileno(stdin)) !=3D 0)
> >  		goto out;
> >
> > +	/* add stdin, if it is connected */
> > +	if (getc(stdin) !=3D EOF) {
> > +		nr_stdin =3D evlist__add_pollfd(kvm->evlist, fileno(stdin));
> > +		if (nr_stdin < 0)
> > +			goto out;
> > +	}
> > +
> >  	/* everything is good - enable the events and process */
> >  	evlist__enable(kvm->evlist);
> >
> > @@ -994,8 +999,10 @@ static int kvm_events_live_report(struct
> perf_kvm_stat *kvm)
> >  		if (err)
> >  			goto out;
> >
> > -		if (fda->entries[nr_stdin].revents & POLLIN)
> > -			done =3D perf_kvm__handle_stdin();
> > +		if (nr_stdin >=3D 0 && fda->entries[nr_stdin].revents & POLLIN)
> {
> > +			if (!perf_kvm__handle_stdin())
>=20
> can this return 0 ? if stdin is EOF then nr_stdin stays -1
>=20
> > +				fda->entries[nr_stdin].events =3D 0;
>=20
> why do you need to set events to 0 in here?

Otherwise poll() would wakeup continually, since an EOF stdin is already re=
ady for POLLIN.

- Igor

> thanks,
> jirka

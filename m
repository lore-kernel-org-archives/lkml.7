Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB202FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397C2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="i/e7gDaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfKHT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:56:38 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:3950 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387487AbfKHT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:56:38 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8JlL7S002767;
        Fri, 8 Nov 2019 19:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=a4L7v4SXG9vAmTn7DbzVCdQNrIZnAZKSnnudNXDiGcc=;
 b=i/e7gDaRA4CI4jolhPJ26aaf0Wr6lurJKCkyF7DbF+b2JWWJShtMBgWB2T0L2wy+qDh4
 5qhMllcPu1ZSxJAxkZ7tEqO1QOZR1qY4Mp5bIs4Wj75+JkWTAfW5aPe8ApWZuxxc3cj0
 66l3eynKx55bb3WlwZ1qfduo6E+4W8Z+XA2p+W9FCvT0Mfy1Cjpijgup3HUxDc/QPjly
 1PydcgYGOsLb8oOXNSb2JgNhkEGI8qH7k1NsKDR5DzB+tQpEiB6B9pr3Nd0NEBVEszyi
 A71bE1kUMc3a35dWfT0mjLNTO8KGMRD36jsGqB6xLp7L7Ix6LI/YsfWRjhRMEPusx9B3 mg== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2w41v53rfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 19:55:17 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id xA8Jm6Kc008078;
        Fri, 8 Nov 2019 14:55:16 -0500
Received: from email.msg.corp.akamai.com ([172.27.165.112])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2w420xa1qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 14:55:16 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.165.123) by
 ustx2ex-dag1mb2.msg.corp.akamai.com (172.27.165.120) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Fri, 8 Nov 2019 13:55:15 -0600
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.165.123]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.165.123]) with mapi id
 15.00.1473.005; Fri, 8 Nov 2019 13:55:15 -0600
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] perf kvm: Allow running without stdin
Thread-Topic: [PATCH 2/3] perf kvm: Allow running without stdin
Thread-Index: AQHViUT4jEXDkFlf70GojsikrAjFJadoXn2AgBlmKCA=
Date:   Fri, 8 Nov 2019 19:55:14 +0000
Message-ID: <1cf0b4cbb0d04ef2a323faa0dfca0668@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
 <1571795693-23558-3-git-send-email-ilubashe@akamai.com>
 <20191023104245.GL22919@krava>
In-Reply-To: <20191023104245.GL22919@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.38.21]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080192
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_07:2019-11-08,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911080192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Jiri!  I replied previously to one comment and totally missed anothe=
r comment above.  Mea culpa.  Not intentional.  Comments inline.

Arnaldo, were you waiting for this comment to take this and the previous pa=
tch in the series?  (I only see that PATCH 3/3 made it to your tree.)


> On Wed, Oct 23, 2019 at 6:43 AM, Jiri Olsa <jolsa@redhat.com> wrote:
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
> > +		if (nr_stdin >=3D 0 && fda->entries[nr_stdin].revents & POLLIN) {
> > +			if (!perf_kvm__handle_stdin())
>=20
> can this return 0 ? if stdin is EOF then nr_stdin stays -1

The purpose of this check is to catch a case when stdin does not start out =
closed but gets closed later.
Something like:

	sleep 5 | perf kvm ......

Arguably I could had handled both cases in a single uniform way (just this =
code without the initial check).  The effect of this would be one unexpecte=
d cycle of output at the very beginning in the common case (stdin is closed=
 from the start).  So I wanted to make the common case behave well.


> > +				fda->entries[nr_stdin].events =3D 0;
>=20
> why do you need to set events to 0 in here?

As I mentioned before, this is to ensure that no more wakeups are going to =
happen due to stdin getting closed during the perf run.  W/o this, stdin fd=
 would always stay "ready for POLLIN", and perf would never sleep.  (The cl=
eanest way would be to remove stdin fd from the kvm->evlist, but there is n=
o such interface for evlist.  Writing that interface just for this case see=
med imprudent, when events=3D0 would do, and we already access revents abov=
e.)

> thanks,
> jirka

Best,

- Igor

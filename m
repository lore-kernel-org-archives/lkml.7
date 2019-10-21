Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C876C20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcX+FDH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfJULz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:55:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfJULz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571658955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urMnxqD4zk6ykuuKvZgu4quBATLxrW70HSow1LjWqjY=;
        b=GcX+FDH2DD3eNTDvSdJlw4jGYkFPoGTFbvFeclB/siOSXtPYpX7y5bxDg+yOsPV5dVJT7i
        ByTrDRNtYa+qZjaCwIauSmTXKNMWZh/7A8NP2Cr8kGwQip3vBBs/xm1Yltj1FySMFJuYlv
        YF1DflZtpwm6OdG7TP8wjSssWX4YQIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Uf-7-x3yPVypCfDITFJVEQ-1; Mon, 21 Oct 2019 07:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACFC980183E;
        Mon, 21 Oct 2019 11:55:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5DD5826362;
        Mon, 21 Oct 2019 11:55:47 +0000 (UTC)
Date:   Mon, 21 Oct 2019 13:55:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiwei Sun <Jiwei.Sun@windriver.com>
Cc:     acme@redhat.com, arnaldo.melo@gmail.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mpetlan@redhat.com, namhyung@kernel.org, a.p.zijlstra@chello.nl,
        adrian.hunter@intel.com, Richard.Danter@windriver.com
Subject: Re: [PATCH v4] perf record: Add support for limit perf output file
 size
Message-ID: <20191021115546.GA5845@krava>
References: <20190925070637.13164-1-jiwei.sun@windriver.com>
 <5d6e3bba-fb53-14a6-c3c8-3e5aba930f04@windriver.com>
MIME-Version: 1.0
In-Reply-To: <5d6e3bba-fb53-14a6-c3c8-3e5aba930f04@windriver.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Uf-7-x3yPVypCfDITFJVEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:51:17PM +0800, Jiwei Sun wrote:
> Hello Arnaldo & Jirka,
>=20
> Do you have any other suggestions regarding the patch?=20
> Any suggestions are welcome. Thank you very much.

oops, overlooked this one, sry..  I'll check on it today

jirka

>=20
> Regards,
> Jiwei
>=20
> On 2019e9409f=1C=0825f=17% 15:06, Jiwei Sun wrote:
> > The patch adds a new option to limit the output file size, then based
> > on it, we can create a wrapper of the perf command that uses the option
> > to avoid exhausting the disk space by the unconscious user.
> >=20
> > In order to make the perf.data parsable, we just limit the sample data
> > size, since the perf.data consists of many headers and sample data and
> > other data, the actual size of the recorded file will bigger than the
> > setting value.
> >=20
> > Testing it:
> >=20
> >  # ./perf record -a -g --max-size=3D10M
> > Couldn't synthesize bpf events.
> > WARNING: The perf data has already reached the limit, stop recording!
> > [ perf record: Woken up 30 times to write data ]
> > [ perf record: Captured and wrote 10.233 MB perf.data (175650 samples) =
]
> > Terminated
> >=20
> >  # ls -lh perf.data
> > -rw------- 1 root root 11M Jul 17 14:01 perf.data
> >=20
> >  # ./perf record -a -g --max-size=3D10K
> > WARNING: The perf data has already reached the limit, stop recording!
> > Couldn't synthesize bpf events.
> > [ perf record: Woken up 0 times to write data ]
> > [ perf record: Captured and wrote 1.824 MB perf.data (67 samples) ]
> > Terminated
> >=20
> >  # ls -lh perf.data
> > -rw------- 1 root root 1.9M Jul 17 14:05 perf.data
> >=20
> > Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> > ---
> > v4 changes:
> >   - Just show one WARNING message after reached the limit.
> >=20
> > v3 changes:
> >   - add a test result
> >   - add the new option to tools/perf/Documentation/perf-record.txt
> >=20
> > v2 changes:
> >   - make patch based on latest Arnaldo's perf/core,
> >   - display warning message when reached the limit.
> > ---
> >  tools/perf/Documentation/perf-record.txt |  4 +++
> >  tools/perf/builtin-record.c              | 42 ++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >=20
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docu=
mentation/perf-record.txt
> > index c6f9f31b6039..f1c6113fbc82 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -571,6 +571,10 @@ config terms. For example: 'cycles/overwrite/' and=
 'instructions/no-overwrite/'.
> > =20
> >  Implies --tail-synthesize.
> > =20
> > +--max-size=3D<size>::
> > +Limit the sample data max size, <size> is expected to be a number with
> > +appended unit character - B/K/M/G
> > +
> >  SEE ALSO
> >  --------
> >  linkperf:perf-stat[1], linkperf:perf-list[1]
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 48600c90cc7e..30904d2a3407 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -91,6 +91,7 @@ struct record {
> >  =09struct switch_output=09switch_output;
> >  =09unsigned long long=09samples;
> >  =09cpu_set_t=09=09affinity_mask;
> > +=09unsigned long=09=09output_max_size;=09/* =3D 0: unlimited */
> >  };
> > =20
> >  static volatile int auxtrace_record__snapshot_started;
> > @@ -120,6 +121,12 @@ static bool switch_output_time(struct record *rec)
> >  =09       trigger_is_ready(&switch_output_trigger);
> >  }
> > =20
> > +static bool record__output_max_size_exceeded(struct record *rec)
> > +{
> > +=09return rec->output_max_size &&
> > +=09       (rec->bytes_written >=3D rec->output_max_size);
> > +}
> > +
> >  static int record__write(struct record *rec, struct mmap *map __maybe_=
unused,
> >  =09=09=09 void *bf, size_t size)
> >  {
> > @@ -132,6 +139,12 @@ static int record__write(struct record *rec, struc=
t mmap *map __maybe_unused,
> > =20
> >  =09rec->bytes_written +=3D size;
> > =20
> > +=09if (record__output_max_size_exceeded(rec)) {
> > +=09=09WARN_ONCE(1, "WARNING: The perf data has already reached "
> > +=09=09=09     "the limit, stop recording!\n");
> > +=09=09raise(SIGTERM);
> > +=09}
> > +
> >  =09if (switch_output_size(rec))
> >  =09=09trigger_hit(&switch_output_trigger);
> > =20
> > @@ -1936,6 +1949,33 @@ static int record__parse_affinity(const struct o=
ption *opt, const char *str, int
> >  =09return 0;
> >  }
> > =20
> > +static int parse_output_max_size(const struct option *opt,
> > +=09=09=09=09 const char *str, int unset)
> > +{
> > +=09unsigned long *s =3D (unsigned long *)opt->value;
> > +=09static struct parse_tag tags_size[] =3D {
> > +=09=09{ .tag  =3D 'B', .mult =3D 1       },
> > +=09=09{ .tag  =3D 'K', .mult =3D 1 << 10 },
> > +=09=09{ .tag  =3D 'M', .mult =3D 1 << 20 },
> > +=09=09{ .tag  =3D 'G', .mult =3D 1 << 30 },
> > +=09=09{ .tag  =3D 0 },
> > +=09};
> > +=09unsigned long val;
> > +
> > +=09if (unset) {
> > +=09=09*s =3D 0;
> > +=09=09return 0;
> > +=09}
> > +
> > +=09val =3D parse_tag_value(str, tags_size);
> > +=09if (val !=3D (unsigned long) -1) {
> > +=09=09*s =3D val;
> > +=09=09return 0;
> > +=09}
> > +
> > +=09return -1;
> > +}
> > +
> >  static int record__parse_mmap_pages(const struct option *opt,
> >  =09=09=09=09    const char *str,
> >  =09=09=09=09    int unset __maybe_unused)
> > @@ -2262,6 +2302,8 @@ static struct option __record_options[] =3D {
> >  =09=09=09    "n", "Compressed records using specified level (default: =
1 - fastest compression, 22 - greatest compression)",
> >  =09=09=09    record__parse_comp_level),
> >  #endif
> > +=09OPT_CALLBACK(0, "max-size", &record.output_max_size,
> > +=09=09     "size", "Limit the maximum size of the output file", parse_=
output_max_size),
> >  =09OPT_END()
> >  };
> > =20
> >=20


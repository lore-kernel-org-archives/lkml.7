Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E1C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053AA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb/sKvBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfKGJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:26:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbfKGJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573118800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mC1Pv6icrr2ctyAgbD+rdnRUWubvdWCUcd8FncINe4=;
        b=Wb/sKvBmCE0C6WA8ZaFQSrYe7iVE5p2v2IWBSfQwXiV94oorIVOm2TQCHu+ILHgDAOiTHj
        Kf+p5cp1aSOlfFhIGj/ePL83SrrtKjPfWkN91KHi6Hlt2c8NEyAn4ly8qKApB2St6d4HZr
        7PtDf6kGbQxzIPZx2/uxfMZj9jQfpig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104--ByG3N9YNXC4dqQcGtIVww-1; Thu, 07 Nov 2019 04:26:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A38107ACC3;
        Thu,  7 Nov 2019 09:26:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F1FD10013A1;
        Thu,  7 Nov 2019 09:26:33 +0000 (UTC)
Date:   Thu, 7 Nov 2019 10:26:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191107092633.GA14657@krava>
References: <20191105033611.25493-1-yao.jin@linux.intel.com>
 <20191105033611.25493-8-yao.jin@linux.intel.com>
 <20191106210106.GA12156@krava>
 <cddb7e55-ae98-62c7-db9f-70e6fc734579@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cddb7e55-ae98-62c7-db9f-70e6fc734579@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -ByG3N9YNXC4dqQcGtIVww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:19:10PM +0800, Jin, Yao wrote:
>=20
>=20
> On 11/7/2019 5:01 AM, Jiri Olsa wrote:
> > On Tue, Nov 05, 2019 at 11:36:11AM +0800, Jin Yao wrote:
> >=20
> > SNIP
> >=20
> > >=20
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/builtin-report.c    | 27 ++++++++++++---
> > >   tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++=
++-
> > >   tools/perf/ui/browsers/hists.h |  2 ++
> > >   tools/perf/util/block-info.c   | 12 +++++++
> > >   tools/perf/util/block-info.h   |  3 ++
> > >   tools/perf/util/hist.h         | 12 +++++++
> > >   6 files changed, 112 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.=
c
> > > index 7a8b0be8f09a..af5a57d06f12 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -485,6 +485,22 @@ static size_t hists__fprintf_nr_sample_events(st=
ruct hists *hists, struct report
> > >   =09return ret + fprintf(fp, "\n#\n");
> > >   }
> > > +static int perf_evlist__tui_block_hists_browse(struct evlist *evlist=
,
> > > +=09=09=09=09=09       struct report *rep)
> > > +{
> > > +=09struct evsel *pos;
> > > +=09int i =3D 0, ret;
> > > +
> > > +=09evlist__for_each_entry(evlist, pos) {
> > > +=09=09ret =3D report__tui_browse_block_hists(&rep->block_reports[i++=
].hist,
> > > +=09=09=09=09=09=09     rep->min_percent, pos);
> > > +=09=09if (ret !=3D 0)
> > > +=09=09=09return ret;
> > > +=09}
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > >   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
> > >   =09=09=09=09=09 struct report *rep,
> > >   =09=09=09=09=09 const char *help)
> > > @@ -595,6 +611,11 @@ static int report__browse_hists(struct report *r=
ep)
> > >   =09switch (use_browser) {
> > >   =09case 1:
> > > +=09=09if (rep->total_cycles_mode) {
> > > +=09=09=09ret =3D perf_evlist__tui_block_hists_browse(evlist, rep);
> > > +=09=09=09break;
> > > +=09=09}
> >=20
> > it's good that most of it is in the block-info.c,
> > however what I mean was to have a single report
> > function for rep->total_cycles_mode, like:
> >=20
> > =09report__browse_block_hists()
> > =09{
> > =09=09switch (use_browser) {
> > =09=09case 1:
> > =09=09=09ret =3D perf_evlist__tui_block_hists_browse(evlist, rep);
> > =09=09=09break;
> > =09=09case 0:
> > =09=09=09ret =3D perf_evlist__tty_block_hists_browse(evlist, rep);
> > =09=09=09break;
> > =09=09...
> > =09}
> >=20
> > preferable in block-info.c as well
> >=20
> > which would be hooked in report__browse_hists:
> >=20
> > =09report__browse_hists()
> > =09{
> > =09=09if (rep->total_cycles_mode)
> > =09=09=09return report__browse_block_hists();
> > =09=09...
> > =09}
> >=20
>=20
> If we move all block implementations from builtin-report.c to block-info.=
c,
> one difficulty is that we can't reuse some codes in builtin-report.c. For
> example, reuse the function which prints the event stats
> (hists__fprintf_nr_sample_events)

aah so that's why it's deep in perf_evlist__tty_browse_hists, I see
ok it's close enough then ;-)

thanks,
jirka


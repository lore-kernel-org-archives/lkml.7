Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32242C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F532067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+YDfiei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKRKrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:47:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726461AbfKRKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574074064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLtGVM6PipP628quEPkr2NHsPu2QXaRDRD5O4yScMCs=;
        b=g+YDfieiNZ92DtcX4BGeNCqjIdPay9j8Pg2j5s+xLhASJIAC5v7LPvZoxAyPzioQ8x6VBP
        hnhAV2dekx3M/nJeDzMTrsoQqWULaXEY8XbKIb9YL+Y5NY5m0PjpoMVgSsRRcaROKJX9yd
        4CfLNyVBvjVnTm6C5P/84wFmTqbwS6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-D3E0VnpeNLi8Fjd26oZQ_g-1; Mon, 18 Nov 2019 05:47:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2CE107ACC4;
        Mon, 18 Nov 2019 10:47:39 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0704260557;
        Mon, 18 Nov 2019 10:47:37 +0000 (UTC)
Date:   Mon, 18 Nov 2019 11:47:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf report: Jump to symbol source view from
 total cycles view
Message-ID: <20191118104737.GF28372@krava>
References: <20191113004852.21265-1-yao.jin@linux.intel.com>
 <20191113004852.21265-2-yao.jin@linux.intel.com>
 <20191115133438.GA25491@krava>
 <cbf51f14-dc76-9030-2dce-6d83122a15c4@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cbf51f14-dc76-9030-2dce-6d83122a15c4@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D3E0VnpeNLi8Fjd26oZQ_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 08:12:02PM +0800, Jin, Yao wrote:
>=20
>=20
> On 11/15/2019 9:34 PM, Jiri Olsa wrote:
> > On Wed, Nov 13, 2019 at 08:48:52AM +0800, Jin Yao wrote:
> > > This patch supports jumping from tui total cycles view to symbol
> > > source view.
> > >=20
> > > For example,
> > >=20
> > > perf record -b ./div
> > > perf report --total-cycles
> > >=20
> > > In total cycles view, we can select one entry and press 'a' or
> > > press ENTER key to jump to symbol source view.
> > >=20
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/builtin-report.c    |  9 ++++++---
> > >   tools/perf/ui/browsers/hists.c | 25 +++++++++++++++++++++++--
> > >   tools/perf/util/block-info.c   |  6 ++++--
> > >   tools/perf/util/block-info.h   |  3 ++-
> > >   tools/perf/util/hist.h         |  7 +++++--
> > >   5 files changed, 40 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.=
c
> > > index 1e81985b7d56..ceebea4013ca 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -493,7 +493,9 @@ static int perf_evlist__tui_block_hists_browse(st=
ruct evlist *evlist,
> > >   =09evlist__for_each_entry(evlist, pos) {
> > >   =09=09ret =3D report__browse_block_hists(&rep->block_reports[i++].h=
ist,
> > > -=09=09=09=09=09=09 rep->min_percent, pos);
> > > +=09=09=09=09=09=09 rep->min_percent, pos,
> > > +=09=09=09=09=09=09 &rep->session->header.env,
> > > +=09=09=09=09=09=09 &rep->annotation_opts);
> > >   =09=09if (ret !=3D 0)
> > >   =09=09=09return ret;
> > >   =09}
> > > @@ -525,7 +527,8 @@ static int perf_evlist__tty_browse_hists(struct e=
vlist *evlist,
> > >   =09=09if (rep->total_cycles_mode) {
> > >   =09=09=09report__browse_block_hists(&rep->block_reports[i++].hist,
> > > -=09=09=09=09=09=09   rep->min_percent, pos);
> > > +=09=09=09=09=09=09   rep->min_percent, pos,
> > > +=09=09=09=09=09=09   NULL, NULL);
> > >   =09=09=09continue;
> > >   =09=09}
> > > @@ -1418,7 +1421,7 @@ int cmd_report(int argc, const char **argv)
> > >   =09=09if (sort__mode !=3D SORT_MODE__BRANCH)
> > >   =09=09=09report.total_cycles_mode =3D false;
> > >   =09=09else
> > > -=09=09=09sort_order =3D "sym";
> > > +=09=09=09sort_order =3D NULL;
> >=20
> > hum, how is this related to this change?
> >=20
> > jirka
> >=20
>=20
> Hi Jiri,
>=20
> If we set the sort_order to NULL, it will use the default branch sort ord=
er.
> The percent value in new annotate view will be consistent with the percen=
t
> in annotate view which is switched from perf report.
>=20
> I observed the original percent gap with previous patches and then I deci=
de
> to use the default sort order. Now the test result looks good.

ok, plz make note of it in changelog or comment

thanks,
jirka


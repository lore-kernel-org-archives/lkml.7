Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E408C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF9217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYXexiOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfKFVBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:01:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727587AbfKFVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573074073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zT8QsoAqQnGs1T3NPJ/bBHUSyXYwOrFJ23z56/WkNsQ=;
        b=CYXexiOgzSLsAwdQQna39Kw6Zqsl5RdRmjO/xYWibPOQKdF1MYFTELZt6rJjVg4fiLDZnl
        EbK5YXP91/6wxWSaO7VhO582KThAyj55F7Qh4WSL1ju01rDaJeRqadxRJSahCFOG1L8YOk
        KLnkSYi85cTn9HbdU62tYka0GyPva2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-WpNLrZsaOTS6JiJeUXHOGw-1; Wed, 06 Nov 2019 16:01:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA278017DD;
        Wed,  6 Nov 2019 21:01:09 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62BFB1A7E2;
        Wed,  6 Nov 2019 21:01:07 +0000 (UTC)
Date:   Wed, 6 Nov 2019 22:01:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191106210106.GA12156@krava>
References: <20191105033611.25493-1-yao.jin@linux.intel.com>
 <20191105033611.25493-8-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191105033611.25493-8-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WpNLrZsaOTS6JiJeUXHOGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:36:11AM +0800, Jin Yao wrote:

SNIP

>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    | 27 ++++++++++++---
>  tools/perf/ui/browsers/hists.c | 62 +++++++++++++++++++++++++++++++++-
>  tools/perf/ui/browsers/hists.h |  2 ++
>  tools/perf/util/block-info.c   | 12 +++++++
>  tools/perf/util/block-info.h   |  3 ++
>  tools/perf/util/hist.h         | 12 +++++++
>  6 files changed, 112 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 7a8b0be8f09a..af5a57d06f12 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -485,6 +485,22 @@ static size_t hists__fprintf_nr_sample_events(struct=
 hists *hists, struct report
>  =09return ret + fprintf(fp, "\n#\n");
>  }
> =20
> +static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
> +=09=09=09=09=09       struct report *rep)
> +{
> +=09struct evsel *pos;
> +=09int i =3D 0, ret;
> +
> +=09evlist__for_each_entry(evlist, pos) {
> +=09=09ret =3D report__tui_browse_block_hists(&rep->block_reports[i++].hi=
st,
> +=09=09=09=09=09=09     rep->min_percent, pos);
> +=09=09if (ret !=3D 0)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
>  static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  =09=09=09=09=09 struct report *rep,
>  =09=09=09=09=09 const char *help)
> @@ -595,6 +611,11 @@ static int report__browse_hists(struct report *rep)
> =20
>  =09switch (use_browser) {
>  =09case 1:
> +=09=09if (rep->total_cycles_mode) {
> +=09=09=09ret =3D perf_evlist__tui_block_hists_browse(evlist, rep);
> +=09=09=09break;
> +=09=09}

it's good that most of it is in the block-info.c,
however what I mean was to have a single report
function for rep->total_cycles_mode, like:

=09report__browse_block_hists()
=09{
=09=09switch (use_browser) {
=09=09case 1:
=09=09=09ret =3D perf_evlist__tui_block_hists_browse(evlist, rep);
=09=09=09break;
=09=09case 0:
=09=09=09ret =3D perf_evlist__tty_block_hists_browse(evlist, rep);
=09=09=09break;
=09=09...
=09}

preferable in block-info.c as well

which would be hooked in report__browse_hists:

=09report__browse_hists()
=09{
=09=09if (rep->total_cycles_mode)
=09=09=09return report__browse_block_hists();
=09=09...
=09}

plus below

SNIP

> +
> +static int block_hists_browser__title(struct hist_browser *browser, char=
 *bf,
> +=09=09=09=09      size_t size)
> +{
> +=09struct hists *hists =3D evsel__hists(browser->block_evsel);
> +=09const char *evname =3D perf_evsel__name(browser->block_evsel);
> +=09unsigned long nr_samples =3D hists->stats.nr_events[PERF_RECORD_SAMPL=
E];
> +=09int ret;
> +
> +=09ret =3D scnprintf(bf, size, "# Samples: %lu", nr_samples);
> +=09if (evname)
> +=09=09scnprintf(bf + ret, size -  ret, " of event '%s'", evname);
> +
> +=09return 0;
> +}
> +
> +int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
> +=09=09=09   float min_percent)
> +{
> +=09struct hists *hists =3D &bh->block_hists;
> +=09struct hist_browser *browser;
> +=09int key =3D -1;
> +=09static const char help[] =3D
> +=09" q             Quit \n";
> +
> +=09browser =3D hist_browser__new(hists);
> +=09if (!browser)
> +=09=09return -1;
> +
> +=09browser->block_evsel =3D evsel;
> +=09browser->title =3D block_hists_browser__title;
> +=09browser->min_pcnt =3D min_percent;
> +
> +=09/* reset abort key so that it can get Ctrl-C as a key */
> +=09SLang_reset_tty();
> +=09SLang_init_tty(0, 0, 0);
> +
> +=09while (1) {
> +=09=09key =3D hist_browser__run(browser, "? - help", true);
> +
> +=09=09switch (key) {
> +=09=09case 'q':
> +=09=09=09goto out;
> +=09=09case '?':
> +=09=09=09ui_browser__help_window(&browser->b, help);
> +=09=09=09break;
> +=09=09default:
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +out:
> +=09hist_browser__delete(browser);
> +=09return 0;
> +}

also could this go to block-info.c as well?

thanks,
jirka


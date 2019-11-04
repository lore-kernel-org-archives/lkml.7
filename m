Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36724CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0920F21D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSSw/e3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfKDNxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:53:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32926 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728613AbfKDNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572875620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QadV5tG6EB2e2xWmrLW6Mggt4QHFFL3zdZUu1G5fCIE=;
        b=fSSw/e3bmqxlDJyaJ3znvLhIRQ9k0+MOyCQftqleu5B7XZ4iydXV9dgQx5gMdnJTVPFOsn
        zEZhGhN/Ev2SJAmgCpoWbuuiLn32nrGoZAyYcD+y0S6+vf5YCieNpraEq3TWog6nVfp3Fb
        Q1PX8lQHBHX/D7lj6K71sZan41AQUtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-SNzsJspRNzW08-To_lsAkA-1; Mon, 04 Nov 2019 08:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD382800686;
        Mon,  4 Nov 2019 13:53:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id D09705D9E5;
        Mon,  4 Nov 2019 13:53:33 +0000 (UTC)
Date:   Mon, 4 Nov 2019 14:53:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191104135333.GH8251@krava>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-8-yao.jin@linux.intel.com>
 <20191101083434.GD2172@krava>
 <2bbc0a0d-639b-7a88-71d5-6c022f46134c@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2bbc0a0d-639b-7a88-71d5-6c022f46134c@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: SNzsJspRNzW08-To_lsAkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:07:33PM +0800, Jin, Yao wrote:
>=20
>=20
> On 11/1/2019 4:34 PM, Jiri Olsa wrote:
> > On Wed, Oct 30, 2019 at 02:04:30PM +0800, Jin Yao wrote:
> >=20
> > SNIP
> >=20
> > > diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/=
hists.h
> > > index 91d3e18b50aa..078f2f2c7abd 100644
> > > --- a/tools/perf/ui/browsers/hists.h
> > > +++ b/tools/perf/ui/browsers/hists.h
> > > @@ -5,6 +5,7 @@
> > >   #include "ui/browser.h"
> > >   struct annotation_options;
> > > +struct evsel;
> > >   struct hist_browser {
> > >   =09struct ui_browser   b;
> > > @@ -15,6 +16,7 @@ struct hist_browser {
> > >   =09struct pstack=09    *pstack;
> > >   =09struct perf_env=09    *env;
> > >   =09struct annotation_options *annotation_opts;
> > > +=09struct evsel=09    *block_evsel;
> >=20
> > you should be able to get the evsel from hists_to_evsel function
> >=20
> > jirka
> >=20
>=20
> Maybe we can't. The hists in hist_browser is set to block_hists (not the
> hists for evsel).
>=20
> See block_hists_tui_browse,
>=20
> int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>                           float min_percent)
> {
>        struct hists *hists =3D &bh->block_hists;
>        struct hist_browser *browser;
>        ......
>        browser =3D hist_browser__new(hists);
>        ......
> }
>=20
> So I have to pass the evsel in.

I see, ok

jirka


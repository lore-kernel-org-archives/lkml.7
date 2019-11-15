Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686CB207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXuU2lqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKONeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:34:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727314AbfKONep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Kmf9p24G+e2nuURDCB0V07M/DkvoNVwYc9ExgJ2ml0=;
        b=EXuU2lqc4mWCqPjnH+VFvhChdoihagIjNjL0gwFirNIJkwq/kiA4xVSfyBcUQ3WijVnbjy
        364nOuHbfYAodCcGZKqXxghXOB9EDTgGe1KiQhaDLpBZW1jWG5sn9zjv40RsImPdTBn7gz
        dwj2E+dAwmW0hCayiAIuE7MVkKJk41w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-SC2msJGjPwevHWfciSARpQ-1; Fri, 15 Nov 2019 08:34:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A9D0102C8BE;
        Fri, 15 Nov 2019 13:34:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 254206364A;
        Fri, 15 Nov 2019 13:34:38 +0000 (UTC)
Date:   Fri, 15 Nov 2019 14:34:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf report: Jump to symbol source view from
 total cycles view
Message-ID: <20191115133438.GA25491@krava>
References: <20191113004852.21265-1-yao.jin@linux.intel.com>
 <20191113004852.21265-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191113004852.21265-2-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SC2msJGjPwevHWfciSARpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 08:48:52AM +0800, Jin Yao wrote:
> This patch supports jumping from tui total cycles view to symbol
> source view.
>=20
> For example,
>=20
> perf record -b ./div
> perf report --total-cycles
>=20
> In total cycles view, we can select one entry and press 'a' or
> press ENTER key to jump to symbol source view.
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    |  9 ++++++---
>  tools/perf/ui/browsers/hists.c | 25 +++++++++++++++++++++++--
>  tools/perf/util/block-info.c   |  6 ++++--
>  tools/perf/util/block-info.h   |  3 ++-
>  tools/perf/util/hist.h         |  7 +++++--
>  5 files changed, 40 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1e81985b7d56..ceebea4013ca 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -493,7 +493,9 @@ static int perf_evlist__tui_block_hists_browse(struct=
 evlist *evlist,
> =20
>  =09evlist__for_each_entry(evlist, pos) {
>  =09=09ret =3D report__browse_block_hists(&rep->block_reports[i++].hist,
> -=09=09=09=09=09=09 rep->min_percent, pos);
> +=09=09=09=09=09=09 rep->min_percent, pos,
> +=09=09=09=09=09=09 &rep->session->header.env,
> +=09=09=09=09=09=09 &rep->annotation_opts);
>  =09=09if (ret !=3D 0)
>  =09=09=09return ret;
>  =09}
> @@ -525,7 +527,8 @@ static int perf_evlist__tty_browse_hists(struct evlis=
t *evlist,
> =20
>  =09=09if (rep->total_cycles_mode) {
>  =09=09=09report__browse_block_hists(&rep->block_reports[i++].hist,
> -=09=09=09=09=09=09   rep->min_percent, pos);
> +=09=09=09=09=09=09   rep->min_percent, pos,
> +=09=09=09=09=09=09   NULL, NULL);
>  =09=09=09continue;
>  =09=09}
> =20
> @@ -1418,7 +1421,7 @@ int cmd_report(int argc, const char **argv)
>  =09=09if (sort__mode !=3D SORT_MODE__BRANCH)
>  =09=09=09report.total_cycles_mode =3D false;
>  =09=09else
> -=09=09=09sort_order =3D "sym";
> +=09=09=09sort_order =3D NULL;

hum, how is this related to this change?

jirka


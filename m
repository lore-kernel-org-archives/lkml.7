Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D79520678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ac4MIf2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfK0ISy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:18:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59693 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbfK0ISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574842732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljhewKbxHJezSx+rS3E3FDX8oxHHWYHSlYwJHWJi7eA=;
        b=Ac4MIf2xJASTiC0/XBL7c9nGCnseBqe/3tyDdfdMIzyu92pvS8Md0xjKjqaO7kCjGPZJLG
        ad208g5CcmwLAeIRrHfbxt8hQ21OO7PXOaIPnjE0KdtFigyXklPZViGVbAuNHh9nPq1HDx
        fpufYo1n9PF7oKnVmhr+LVJUWlx+SSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-1jFMoWh8MuW10INoaOHqMA-1; Wed, 27 Nov 2019 03:18:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADAC0100A14C;
        Wed, 27 Nov 2019 08:18:47 +0000 (UTC)
Received: from krava (ovpn-204-226.brq.redhat.com [10.40.204.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E1E5600C8;
        Wed, 27 Nov 2019 08:18:45 +0000 (UTC)
Date:   Wed, 27 Nov 2019 09:18:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf c2c: fix '-e list'
Message-ID: <20191127081844.GH32367@krava>
References: <20191127073442.174202-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191127073442.174202-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1jFMoWh8MuW10INoaOHqMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:34:42PM -0800, Ian Rogers wrote:
> When the event is passed as list, the default events should be listed as
> per 'perf mem record -e list'. Previous behavior is:
>=20
> $ perf c2c record -e list
> failed: event 'list' not found, use '-e list' to get list of available ev=
ents
>=20
>  Usage: perf c2c record [<options>] [<command>]
>     or: perf c2c record [<options>] -- <command> [<options>]
>=20
>     -e, --event <event>   event selector. Use 'perf mem record -e list' t=
o list available events

man c2c page do say you should use 'perf mem' not 'perf c2c'
could you please change the man page as well?

>=20
> New behavior:
>=20
> $ perf c2c record -e list
> ldlat-loads  : available
> ldlat-stores : available
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-c2c.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e69f44941aad..dd69cd218e4c 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2872,10 +2872,26 @@ static int perf_c2c__report(int argc, const char =
**argv)
>  static int parse_record_events(const struct option *opt,
>  =09=09=09       const char *str, int unset __maybe_unused)
>  {
> +=09int j;
>  =09bool *event_set =3D (bool *) opt->value;
> =20
> -=09*event_set =3D true;
> -=09return perf_mem_events__parse(str);
> +=09if (strcmp(str, "list")) {
> +=09=09*event_set =3D true;
> +=09=09if (!perf_mem_events__parse(str))
> +=09=09=09return 0;
> +
> +=09=09exit(-1);
> +=09}
> +=09for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +=09=09struct perf_mem_event *e =3D &perf_mem_events[j];
> +
> +=09=09fprintf(stderr, "%-13s%-*s%s\n",
> +=09=09=09e->tag,
> +=09=09=09verbose > 0 ? 25 : 0,
> +=09=09=09verbose > 0 ? perf_mem_events__name(j) : "",
> +=09=09=09e->supported ? ": available" : "");
> +=09}

there's same loop in builtin-mem.c, could you please put it
to function in mem-events.c?

thanks,
jirka


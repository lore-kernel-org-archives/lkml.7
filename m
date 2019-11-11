Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED714C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6030206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBx0shAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKKO4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:56:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726889AbfKKO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573484211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60Q7vS2CmK4AK0J+x4ZvzH3U+jveBIMJrpq1nfCbPwQ=;
        b=ZBx0shAXRbN6UNyfZwLIphjceKvNoxxqDv4l9TWII5Vf9sBbaUuEmkjRObn6oTRMHlssKr
        lRu93hzh+NcvSISF2Pwt99homsVliFY4roCVLI5nx7N6qHoDuuuKqupZJY4MMgLxYPUkqZ
        /ttJtMgGFoFSAFn/xvrVwRFUQUL4nWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Ov9PzoJrP_udTUFq1cP-gQ-1; Mon, 11 Nov 2019 09:56:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8736D18B9FDA;
        Mon, 11 Nov 2019 14:56:44 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED0EE60904;
        Mon, 11 Nov 2019 14:56:40 +0000 (UTC)
Date:   Mon, 11 Nov 2019 15:56:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] perf session: Fix compression processing
Message-ID: <20191111145640.GB26980@krava>
References: <20191103222441.GE8251@krava>
 <d57725e6-e62f-b37e-6cb4-28bf521faaea@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <d57725e6-e62f-b37e-6cb4-28bf521faaea@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Ov9PzoJrP_udTUFq1cP-gQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:38:49PM +0300, Alexey Budankov wrote:
>=20
> On 04.11.2019 1:24, Jiri Olsa wrote:
> > hi,
> <SNIP>
> > ---
> > The compressed data processing occasionally fails with:
> >   $ perf report --stdio -vv
> >   decomp (B): 44519 to 163000
> >   decomp (B): 48119 to 174800
> >   decomp (B): 65527 to 131072
> >   fetch_mmaped_event: head=3D0x1ffe0 event->header_size=3D0x28, mmap_si=
ze=3D0x20000: fuzzed perf.data?
> >   Error:
> >   failed to process sample
> >   ...
> >=20
> > It's caused by recent fuzzer fix that does not take into account
> > that compressed data do not need to by fully present in the buffer,
> > so it's ok to just return NULL and not to fail.
> >=20
> > Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing inv=
alid header.size")
> > Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.kernel.=
org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/session.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index f07b8ecb91bc..3589ed14a629 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1959,7 +1959,7 @@ static int __perf_session__process_pipe_events(st=
ruct perf_session *session)
> > =20
> >  static union perf_event *
> >  fetch_mmaped_event(struct perf_session *session,
> > -=09=09   u64 head, size_t mmap_size, char *buf)
> > +=09=09   u64 head, size_t mmap_size, char *buf, bool decomp)
>=20
> bools in interface make code less transparent.
>=20
> >  {
> >  =09union perf_event *event;
> > =20
> > @@ -1979,6 +1979,8 @@ fetch_mmaped_event(struct perf_session *session,
> >  =09=09/* We're not fetching the event so swap back again */
> >  =09=09if (session->header.needs_swap)
> >  =09=09=09perf_event_header__bswap(&event->header);
> > +=09=09if (decomp)
> > +=09=09=09return NULL;
> >  =09=09pr_debug("%s: head=3D%#" PRIx64 " event->header_size=3D%#x, mmap=
_size=3D%#zx: fuzzed perf.data?\n",
> >  =09=09=09 __func__, head, event->header.size, mmap_size);
> >  =09=09return ERR_PTR(-EINVAL);
> > @@ -1997,7 +1999,7 @@ static int __perf_session__process_decomp_events(=
struct perf_session *session)
> >  =09=09return 0;
> > =20
> >  =09while (decomp->head < decomp->size && !session_done()) {
> > -=09=09union perf_event *event =3D fetch_mmaped_event(session, decomp->=
head, decomp->size, decomp->data);
> > +=09=09union perf_event *event =3D fetch_mmaped_event(session, decomp->=
head, decomp->size, decomp->data, true);
>=20
> It looks like this call can be skipped, at all, in this case.

not sure what you mean, we are in decomp code no?

jirka


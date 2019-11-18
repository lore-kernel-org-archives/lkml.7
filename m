Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8233C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96BD2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENmpaSVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRKrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:47:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbfKRKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574074018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEYcx5JOdSU5kuiBB8VLRdEb9UL42F7wAgggAIuvnKc=;
        b=ENmpaSVgiTCHdzm8/MqXyNKvJlTebXGsICnjAuf9KM4QSEptz4upG+KAiNDIHI4FhHQABT
        gfT/wLe5atgGSz5SUwU0KWAQfkjeLpru34AnIIgz6Scx4d8MjKZs25y0GhwkZQ4aYmQV2g
        ghULDGviuGgYr9botKWs25JM0zg3l98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-y9bPbW_NPyO0YGR5ftI4Eg-1; Mon, 18 Nov 2019 05:46:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB9CA801FCB;
        Mon, 18 Nov 2019 10:46:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4A5F61009976;
        Mon, 18 Nov 2019 10:46:52 +0000 (UTC)
Date:   Mon, 18 Nov 2019 11:46:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
Message-ID: <20191118104651.GE28372@krava>
References: <237222f1-9765-dce1-601c-60530a7fc844@linux.intel.com>
 <20191115151124.GA25246@krava>
 <2f2b2421-6865-4669-7e30-918d12ae5e01@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2f2b2421-6865-4669-7e30-918d12ae5e01@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: y9bPbW_NPyO0YGR5ftI4Eg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:09:19PM +0300, Alexey Budankov wrote:
>=20
> On 15.11.2019 18:11, Jiri Olsa wrote:
> > On Fri, Nov 15, 2019 at 12:05:14PM +0300, Alexey Budankov wrote:
> <SNIP>
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index f07b8ecb91bc..3f6f812ec4ed 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -1957,9 +1957,31 @@ static int __perf_session__process_pipe_events(=
struct perf_session *session)
> >>  =09return err;
> >>  }
> >> =20
> >> +static union perf_event *
> >> +prefetch_event(char *buf, u64 head, size_t mmap_size,
> >> +=09       bool needs_swap, union perf_event *ret);
> >=20
> > why not move prefetch_event definition in here?
> > I don't see any need for the static declaration..
>=20
> It is just for the sake of more readable patch formatting=20
> and, yes, could be avoided and replaced by the definition.

I think we're trying to avoid static declarations

>=20
> >=20
> >> +
> >>  static union perf_event *
> >>  fetch_mmaped_event(struct perf_session *session,
> >>  =09=09   u64 head, size_t mmap_size, char *buf)
> >> +{
> >> +=09return prefetch_event(buf, head, mmap_size,
> >> +=09=09=09      session->header.needs_swap,
> >> +=09=09=09      ERR_PTR(-EINVAL));
> >> +}
> >> +
> >> +static union perf_event *
> >> +fetch_decomp_event(struct perf_session *session,
> >> +=09=09   u64 head, size_t mmap_size, char *buf)
> >> +{
> >=20
> > if this is decomp specific, it could take 'struct decomp*' as argument
>=20
> Well, it makes sense. whole session object is not required here.
> Just session->header.needs_swap could be passed as a param.
> Shall we make it like this?
>=20
> static union perf_event *=20
> fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap=
)

ok, I just saw the call passing all the stuff from 'struct decomp'
so I thought it'd save some arguments if we pass the  struct itself
instead

jirka


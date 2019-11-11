Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF697C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BFA222CF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu/WJSWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKQHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:07:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22961 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbfKKQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573488465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8ErC4PVdVGwBCyt7dEhWq/0IJ1CoVRGTxaHLB8Usq8=;
        b=Wu/WJSWib3Csf3EFxK36wJidLLasgG9eSg3mKt6EYDQSUkKFGwoDrFd+v/VPC6kaJG2MX4
        iLm73jfSyKfIX4z/jAxBHL8RY6i0rA/fIS2KVeY77pYX55jN+rmt8GjWAroo1FLudBsBbT
        8ovkpWLLJDJtataYNQnSZVOvS+xrasE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-yzbKBR5MO1a2Nt2c4kU-hQ-1; Mon, 11 Nov 2019 11:07:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700A0100551C;
        Mon, 11 Nov 2019 16:07:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id D399210027A5;
        Mon, 11 Nov 2019 16:07:38 +0000 (UTC)
Date:   Mon, 11 Nov 2019 17:07:38 +0100
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
Message-ID: <20191111160738.GD26980@krava>
References: <20191103222441.GE8251@krava>
 <d57725e6-e62f-b37e-6cb4-28bf521faaea@linux.intel.com>
 <20191111145640.GB26980@krava>
 <69782f54-f5f5-f89f-9c8d-172d4de331d0@linux.intel.com>
 <20191111154612.GC26980@krava>
 <84f6c330-95bc-b615-4366-8a243d1f5c20@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <84f6c330-95bc-b615-4366-8a243d1f5c20@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yzbKBR5MO1a2Nt2c4kU-hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:53:35PM +0300, Alexey Budankov wrote:
> On 11.11.2019 18:46, Jiri Olsa wrote:
> > On Mon, Nov 11, 2019 at 06:41:47PM +0300, Alexey Budankov wrote:
> >> On 11.11.2019 17:56, Jiri Olsa wrote:
> >>> On Mon, Nov 11, 2019 at 05:38:49PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> On 04.11.2019 1:24, Jiri Olsa wrote:
> >>>>> hi,
> >>>> <SNIP>
> >>>>> ---
> >>>>> The compressed data processing occasionally fails with:
> >>>>>   $ perf report --stdio -vv
> >>>>>   decomp (B): 44519 to 163000
> >>>>>   decomp (B): 48119 to 174800
> >>>>>   decomp (B): 65527 to 131072
> >>>>>   fetch_mmaped_event: head=3D0x1ffe0 event->header_size=3D0x28, mma=
p_size=3D0x20000: fuzzed perf.data?
> >>>>>   Error:
> >>>>>   failed to process sample
> >>>>>   ...
> >>>>>
> >>>>> It's caused by recent fuzzer fix that does not take into account
> >>>>> that compressed data do not need to by fully present in the buffer,
> >>>>> so it's ok to just return NULL and not to fail.
> >>>>>
> >>>>> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing=
 invalid header.size")
> >>>>> Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.ker=
nel.org
> >>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>>>> ---
> >>>>>  tools/perf/util/session.c | 8 +++++---
> >>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >>>>> index f07b8ecb91bc..3589ed14a629 100644
> >>>>> --- a/tools/perf/util/session.c
> >>>>> +++ b/tools/perf/util/session.c
> >>>>> @@ -1959,7 +1959,7 @@ static int __perf_session__process_pipe_event=
s(struct perf_session *session)
> >>>>> =20
> >>>>>  static union perf_event *
> >>>>>  fetch_mmaped_event(struct perf_session *session,
> >>>>> -=09=09   u64 head, size_t mmap_size, char *buf)
> >>>>> +=09=09   u64 head, size_t mmap_size, char *buf, bool decomp)
> >>>>
> >>>> bools in interface make code less transparent.
> >>>>
> >>>>>  {
> >>>>>  =09union perf_event *event;
> >>>>> =20
> >>>>> @@ -1979,6 +1979,8 @@ fetch_mmaped_event(struct perf_session *sessi=
on,
> >>>>>  =09=09/* We're not fetching the event so swap back again */
> >>>>>  =09=09if (session->header.needs_swap)
> >>>>>  =09=09=09perf_event_header__bswap(&event->header);
> >>>>> +=09=09if (decomp)
> >>>>> +=09=09=09return NULL;
> >>>>>  =09=09pr_debug("%s: head=3D%#" PRIx64 " event->header_size=3D%#x, =
mmap_size=3D%#zx: fuzzed perf.data?\n",
> >>>>>  =09=09=09 __func__, head, event->header.size, mmap_size);
> >>>>>  =09=09return ERR_PTR(-EINVAL);
> >>>>> @@ -1997,7 +1999,7 @@ static int __perf_session__process_decomp_eve=
nts(struct perf_session *session)
> >>>>>  =09=09return 0;
> >>>>> =20
> >>>>>  =09while (decomp->head < decomp->size && !session_done()) {
> >>>>> -=09=09union perf_event *event =3D fetch_mmaped_event(session, deco=
mp->head, decomp->size, decomp->data);
> >>>>> +=09=09union perf_event *event =3D fetch_mmaped_event(session, deco=
mp->head, decomp->size, decomp->data, true);
> >>>>
> >>>> It looks like this call can be skipped, at all, in this case.
> >>>
> >>> not sure what you mean, we are in decomp code no?
> >>
> >> Ok, it is inside "not fetching" branch.=20
> >> NULL return value means to proceed getting further over the trace.
> >> Checking record type =3D=3D COMPRESSED at the higher level could=20
> >> probably be cleaner fix and also work faster.
> >=20
> > any chance you could post the fix? the patch I did was a
> > quick fix to get the feature working for presentation ;-)
> > you're probably thinking of the proper approach
>=20
> Please share the exact reproducing steps=20
> so I could come up with something.

'perf record -z' for longer workloads

jirka


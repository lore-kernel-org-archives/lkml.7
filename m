Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3616CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D692190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA/FML9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfKCWYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:24:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbfKCWYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572819889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R8uxxoIgt0pDImRWxsOSsk8Zak5f+7K0iwQd4EDqnUs=;
        b=BA/FML9xBLo2sXHMlrZEREL3mjDz1L/pPuHWmji2SzKmFajY8C6OeMQ3F2FPsSa4k9iPkE
        Gam0vAnhmgmfMAmIeuLhWebglRo3Xi+zrluk3MVjbaBW6rCTj6kW11ldrZkM7tGwkrRu/b
        HnN3seSFklGYT3x24NINyuBW2SIVSOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-MM-1I0IzM9iA6Geo2B1xkQ-1; Sun, 03 Nov 2019 17:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5571E800EBA;
        Sun,  3 Nov 2019 22:24:44 +0000 (UTC)
Received: from krava (ovpn-204-70.brq.redhat.com [10.40.204.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77B3F1001B23;
        Sun,  3 Nov 2019 22:24:42 +0000 (UTC)
Date:   Sun, 3 Nov 2019 23:24:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] perf session: Fix compression processing
Message-ID: <20191103222441.GE8251@krava>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MM-1I0IzM9iA6Geo2B1xkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I'm not sure I follow everything on compression,
so I might have missed something, but patch below
fixes the issue for me.

jirka


---
The compressed data processing occasionally fails with:
  $ perf report --stdio -vv
  decomp (B): 44519 to 163000
  decomp (B): 48119 to 174800
  decomp (B): 65527 to 131072
  fetch_mmaped_event: head=3D0x1ffe0 event->header_size=3D0x28, mmap_size=
=3D0x20000: fuzzed perf.data?
  Error:
  failed to process sample
  ...

It's caused by recent fuzzer fix that does not take into account
that compressed data do not need to by fully present in the buffer,
so it's ok to just return NULL and not to fail.

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid=
 header.size")
Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..3589ed14a629 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1959,7 +1959,7 @@ static int __perf_session__process_pipe_events(struct=
 perf_session *session)
=20
 static union perf_event *
 fetch_mmaped_event(struct perf_session *session,
-=09=09   u64 head, size_t mmap_size, char *buf)
+=09=09   u64 head, size_t mmap_size, char *buf, bool decomp)
 {
 =09union perf_event *event;
=20
@@ -1979,6 +1979,8 @@ fetch_mmaped_event(struct perf_session *session,
 =09=09/* We're not fetching the event so swap back again */
 =09=09if (session->header.needs_swap)
 =09=09=09perf_event_header__bswap(&event->header);
+=09=09if (decomp)
+=09=09=09return NULL;
 =09=09pr_debug("%s: head=3D%#" PRIx64 " event->header_size=3D%#x, mmap_siz=
e=3D%#zx: fuzzed perf.data?\n",
 =09=09=09 __func__, head, event->header.size, mmap_size);
 =09=09return ERR_PTR(-EINVAL);
@@ -1997,7 +1999,7 @@ static int __perf_session__process_decomp_events(stru=
ct perf_session *session)
 =09=09return 0;
=20
 =09while (decomp->head < decomp->size && !session_done()) {
-=09=09union perf_event *event =3D fetch_mmaped_event(session, decomp->head=
, decomp->size, decomp->data);
+=09=09union perf_event *event =3D fetch_mmaped_event(session, decomp->head=
, decomp->size, decomp->data, true);
=20
 =09=09if (IS_ERR(event))
 =09=09=09return PTR_ERR(event);
@@ -2100,7 +2102,7 @@ reader__process_events(struct reader *rd, struct perf=
_session *session,
 =09}
=20
 more:
-=09event =3D fetch_mmaped_event(session, head, mmap_size, buf);
+=09event =3D fetch_mmaped_event(session, head, mmap_size, buf, false);
 =09if (IS_ERR(event))
 =09=09return PTR_ERR(event);
=20
--=20
2.21.0


Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE0920730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5V9I6dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfKRMWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:22:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbfKRMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574079741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0NoYJqekTI3Qnjh2uoxpfc3n3uRw7aVsaWansrk0nM=;
        b=G5V9I6dtdu/aPo4sYY0TydiuiQ8tTJeYtR/7jAjLJ93AiKxYjYAJljePDEYDLxzN5vqH4W
        0kX45AHIY6vwlUNzi5UxOLw6tSd/A/WtbZ748H2WIZH5LcwGbBUiRBprwX1oZjCwx+Bp5H
        HPCdvrQsXMxhnuAK9k5W4sAN79nH7VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-I0ynNsuQOn6w1bTaEdDk5Q-1; Mon, 18 Nov 2019 07:22:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F861883521;
        Mon, 18 Nov 2019 12:22:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1442219C6A;
        Mon, 18 Nov 2019 12:22:14 +0000 (UTC)
Date:   Mon, 18 Nov 2019 13:22:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
Message-ID: <20191118122214.GB14046@krava>
References: <ed01646b-3b28-0ce7-04da-4665b8ed8a04@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <ed01646b-3b28-0ce7-04da-4665b8ed8a04@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: I0ynNsuQOn6w1bTaEdDk5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 02:30:04PM +0300, Alexey Budankov wrote:
>=20
> Avoid termination of trace loading in case the last record in
> the decompressed buffer partly resides in the following
> mmaped PERF_RECORD_COMPRESSED record. In this case NULL value
> returned by fetch_mmaped_event() means to proceed to the next
> mmaped record then decompress it and load compressed events.
>=20
> The issue can be reproduced like this:
>=20
>   $ perf record -z -- some_long_running_workload
>   $ perf report --stdio -vv
>   decomp (B): 44519 to 163000
>   decomp (B): 48119 to 174800
>   decomp (B): 65527 to 131072
>   fetch_mmaped_event: head=3D0x1ffe0 event->header_size=3D0x28, mmap_size=
=3D0x20000: fuzzed perf.data?
>   Error:
>   failed to process sample
>   ...
>=20
> Testing:
> 71: Zstd perf.data compression/decompression              : Ok
>=20
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing inval=
id header.size")
> Link: https://marc.info/?l=3Dlinux-kernel&m=3D156580812427554&w=3D2
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - avoided static declaration of prefetch_event();
> - renamed 'ret' to 'error' for returning in case of split compressed=20
>   or overlapping records;
> - passed only needs_swap quality into fetch_*_event() instead of=20
>   the whole session object;
> ---
>  tools/perf/util/session.c | 44 ++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
>=20
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f07b8ecb91bc..c2b0703d6587 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1958,8 +1958,8 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>  }
> =20
>  static union perf_event *
> -fetch_mmaped_event(struct perf_session *session,
> -=09=09   u64 head, size_t mmap_size, char *buf)
> +prefetch_event(char *buf, u64 head, size_t mmap_size,
> +=09       bool needs_swap, union perf_event *error)
>  {
>  =09union perf_event *event;
> =20
> @@ -1971,20 +1971,32 @@ fetch_mmaped_event(struct perf_session *session,
>  =09=09return NULL;
> =20
>  =09event =3D (union perf_event *)(buf + head);
> +=09if (needs_swap)
> +=09=09perf_event_header__bswap(&event->header);
> =20
> -=09if (session->header.needs_swap)
> +=09if (head + event->header.size <=3D mmap_size)
> +=09=09return event;
> +
> +=09/* We're not fetching the event so swap back again */
> +=09if (needs_swap)
>  =09=09perf_event_header__bswap(&event->header);
> =20
> -=09if (head + event->header.size > mmap_size) {
> -=09=09/* We're not fetching the event so swap back again */
> -=09=09if (session->header.needs_swap)
> -=09=09=09perf_event_header__bswap(&event->header);
> -=09=09pr_debug("%s: head=3D%#" PRIx64 " event->header_size=3D%#x, mmap_s=
ize=3D%#zx: fuzzed perf.data?\n",
> -=09=09=09 __func__, head, event->header.size, mmap_size);
> -=09=09return ERR_PTR(-EINVAL);
> -=09}
> +=09pr_debug("%s: head=3D%#" PRIx64 " event->header_size=3D%#x, mmap_size=
=3D%#zx\n",
> +=09=09__func__, head, event->header.size, mmap_size);

you're missign the 'fuzzed perf.data?' in here

I think we should keep it just change to: 'fuzzed or compressed perf.data?'

thanks,
jirka


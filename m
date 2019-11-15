Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C53C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A401220733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKr2vO4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKOPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:11:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727380AbfKOPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPXP6F+mV8JIBN1eHnEpmeTZOZyHrGdWMdr7mXYpyO8=;
        b=VKr2vO4mQVXU7bOFHrzwTguxnmw7XH9r4pMva8bm8PWDmEuaA4jYnLyHdA0oeYkETtBBpo
        sb0l1XQNt2NdLTsAwK/sQMSQfqqEwPZDswHMlbJL7IKMpAVenY3UV47pl2Ch9+/TWd4Ay5
        YwnU9tOH9pxL0hmloqqE3hgkMFHehCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-9wMylUw0MIi5PyyvYa4yQQ-1; Fri, 15 Nov 2019 10:11:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EED31005500;
        Fri, 15 Nov 2019 15:11:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B9455C1B0;
        Fri, 15 Nov 2019 15:11:25 +0000 (UTC)
Date:   Fri, 15 Nov 2019 16:11:24 +0100
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
Message-ID: <20191115151124.GA25246@krava>
References: <237222f1-9765-dce1-601c-60530a7fc844@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <237222f1-9765-dce1-601c-60530a7fc844@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9wMylUw0MIi5PyyvYa4yQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:05:14PM +0300, Alexey Budankov wrote:
>=20
> Avoid termination of trace loading in case the last record in=20
> the decompressed buffer partly resides in the following=20
> mmaped PERF_RECORD_COMPRESSED record. In this case NULL value
> returned by fetch_mmaped_event() means to proceed to the next=20
> mmaped record then decompress it and load compressed events.=20
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
>  tools/perf/util/session.c | 47 +++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f07b8ecb91bc..3f6f812ec4ed 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1957,9 +1957,31 @@ static int __perf_session__process_pipe_events(str=
uct perf_session *session)
>  =09return err;
>  }
> =20
> +static union perf_event *
> +prefetch_event(char *buf, u64 head, size_t mmap_size,
> +=09       bool needs_swap, union perf_event *ret);

why not move prefetch_event definition in here?
I don't see any need for the static declaration..

> +
>  static union perf_event *
>  fetch_mmaped_event(struct perf_session *session,
>  =09=09   u64 head, size_t mmap_size, char *buf)
> +{
> +=09return prefetch_event(buf, head, mmap_size,
> +=09=09=09      session->header.needs_swap,
> +=09=09=09      ERR_PTR(-EINVAL));
> +}
> +
> +static union perf_event *
> +fetch_decomp_event(struct perf_session *session,
> +=09=09   u64 head, size_t mmap_size, char *buf)
> +{

if this is decomp specific, it could take 'struct decomp*' as argument

> +=09return prefetch_event(buf, head, mmap_size,
> +=09=09=09      session->header.needs_swap,
> +=09=09=09      NULL);
> +}
> +
> +static union perf_event *
> +prefetch_event(char *buf, u64 head, size_t mmap_size,
> +=09       bool needs_swap, union perf_event *ret)
>  {

'error' might be more suitable then ret in here

thanks,
jirka


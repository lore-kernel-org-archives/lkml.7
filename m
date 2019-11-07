Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A616C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3622084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+W5vLX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfKGJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbfKGJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573119755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKoCIjcW28Hko0qMcEIiY97Qrw+BX0MIbxPtgok3aZA=;
        b=a+W5vLX9lz2qF0YHTaTlGSSatxGFntipjgzq5d2l4TxXhe7oUOTqkG/E1XimWyMms9aj1R
        7uVZ9Nu8XFwICHA26fGGLda2MgusH9xk4FWlzNwcDlAZeBeHq+5q0IXk+a03Fmi0wV++Fb
        8KimzDCyVkqFk1HnP9+aTu3n00w9qS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384--ng_66w-Ptuq0G0jHTRgeg-1; Thu, 07 Nov 2019 04:42:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B4AC800C61;
        Thu,  7 Nov 2019 09:42:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9348D60BFB;
        Thu,  7 Nov 2019 09:42:27 +0000 (UTC)
Date:   Thu, 7 Nov 2019 10:42:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] perf tests: Fix out of bounds memory access
Message-ID: <20191107094226.GC14657@krava>
References: <20191107020244.2427-1-leo.yan@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191107020244.2427-1-leo.yan@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -ng_66w-Ptuq0G0jHTRgeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:02:44AM +0800, Leo Yan wrote:
> The test case 'Read backward ring buffer' failed on 32-bit architectures
> which were found by LKFT perf testing.  The test failed on arm32 x15
> device, qemu_arm32, qemu_i386, and found intermittent failure on i386;
> the failure log is as below:
>=20
>   50: Read backward ring buffer                  :
>   --- start ---
>   test child forked, pid 510
>   Using CPUID GenuineIntel-6-9E-9
>   mmap size 1052672B
>   mmap size 8192B
>   Finished reading overwrite ring buffer: rewind
>   free(): invalid next size (fast)
>   test child interrupted
>   ---- end ----
>   Read backward ring buffer: FAILED!
>=20
> The log hints there have issue for memory usage, thus free() reports
> error 'invalid next size' and directly exit for the case.  Finally, this
> issue is root caused as out of bounds memory access for the data array
> 'evsel->id'.
>=20
> The backward ring buffer test invokes do_test() twice.  'evsel->id' is
> allocated at the first call with the flow:
>=20
>   test__backward_ring_buffer()
>     `-> do_test()
> =09  `-> evlist__mmap()
> =09        `-> evlist__mmap_ex()
> =09              `-> perf_evsel__alloc_id()
>=20
> So 'evsel->id' is allocated with one item, and it will be used in
> function perf_evlist__id_add():
>=20
>    evsel->id[0] =3D id
>    evsel->ids   =3D 1
>=20
> At the second call for do_test(), it skips to initialize 'evsel->id'
> and reuses the array which is allocated in the first call.  But
> 'evsel->ids' contains the stale value.  Thus:
>=20
>    evsel->id[1] =3D id    -> out of bound access
>    evsel->ids   =3D 2
>=20
> To fix this issue, we will use evlist__open() and evlist__close() pair
> functions to prepare and cleanup context for evlist; so 'evsel->id' and
> 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> the out of bounds memory access.

right, we need to solve this on libperf level, so it's possible
to call mmap/munmap multiple time without close/open.. I'll try
to send something, but meanwhile this is good workaround

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>=20
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/backward-ring-buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/b=
ackward-ring-buffer.c
> index 338cd9faa835..5128f727c0ef 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -147,6 +147,15 @@ int test__backward_ring_buffer(struct test *test __m=
aybe_unused, int subtest __m
>  =09=09goto out_delete_evlist;
>  =09}
> =20
> +=09evlist__close(evlist);
> +
> +=09err =3D evlist__open(evlist);
> +=09if (err < 0) {
> +=09=09pr_debug("perf_evlist__open: %s\n",
> +=09=09=09 str_error_r(errno, sbuf, sizeof(sbuf)));
> +=09=09goto out_delete_evlist;
> +=09}
> +
>  =09err =3D do_test(evlist, 1, &sample_count, &comm_count);
>  =09if (err !=3D TEST_OK)
>  =09=09goto out_delete_evlist;
> --=20
> 2.17.1
>=20


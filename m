Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8F8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC5022440
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwbuac6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfKSUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:05:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23046 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbfKSUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574193918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZZsstpmsCTzgR0yQoMLhDAaOXbPXGn+7vwXrsmf6cg=;
        b=fwbuac6WMRZFnmTzlRO1cKseAJFdpry9nQBeVDL27SdJxqTqttRA688KLpkJdFpMCp0QLI
        sNIkI/ryjUMJ+LJ/JNzWRIgQK2HvrUcbV9CxeEhdUpjpGt/aNv82lpXWsJGYAydtIVWgoR
        58Q8/iNgeNqkdY9gB8VlBtcti8DZIaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Mp-Bzmh4MLGvC4QPuL-Cgg-1; Tue, 19 Nov 2019 15:05:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1764B107ACC4;
        Tue, 19 Nov 2019 20:05:13 +0000 (UTC)
Received: from krava (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with SMTP id 251E162926;
        Tue, 19 Nov 2019 20:05:10 +0000 (UTC)
Date:   Tue, 19 Nov 2019 21:05:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
Message-ID: <20191119200510.GA7364@krava>
References: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Mp-Bzmh4MLGvC4QPuL-Cgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 05:21:03PM +0300, Alexey Budankov wrote:
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
>=20
>   71: Zstd perf.data compression/decompression              : Ok
>=20
>   $ tools/perf/perf report -vv --stdio
>   decomp (B): 59593 to 262160
>   decomp (B): 4438 to 16512
>   decomp (B): 285 to 880
>   Looking at the vmlinux_path (8 entries long)
>   Using vmlinux for symbols
>   decomp (B): 57474 to 261248
>   prefetch_event: head=3D0x3fc78 event->header_size=3D0x28, mmap_size=3D0=
x3fc80: fuzzed or compressed perf.data?
>   decomp (B): 25 to 32
>   decomp (B): 52 to 120
>   ...
>=20
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing inval=
id header.size")
> Link: https://marc.info/?l=3Dlinux-kernel&m=3D156580812427554&w=3D2
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


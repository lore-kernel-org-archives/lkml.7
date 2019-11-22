Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4009D20706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSIM/tmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKVN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:27:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKVN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574429227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FORd8QVkACqNeHehzcNsWfKhWlEWu1ok2yqXPn+6C0=;
        b=jSIM/tmY2fqw2M47eoRrZUODygp+yEnG01bIaj/q0HvyzzwaY99qvRiOgZ3wU148ELhQmf
        FwXiQE0rl31pY98MSWZKgVpsgs7DWsaU7k2+xlRap9yA14SgSwWlDBluu74ihPXpBcuSpW
        jSxQhYnCtmem7Sr+WQS3x03NTUFeapE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-NA8oCq0fPFqnnSdvYZhKsw-1; Fri, 22 Nov 2019 08:27:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63C3B18557C4;
        Fri, 22 Nov 2019 13:27:02 +0000 (UTC)
Received: from krava (unknown [10.40.205.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C4F35F93C;
        Fri, 22 Nov 2019 13:27:00 +0000 (UTC)
Date:   Fri, 22 Nov 2019 14:26:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] perf record: adapt NUMA awareness to machines
 with #CPUs > 1K
Message-ID: <20191122132659.GG17308@krava>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NA8oCq0fPFqnnSdvYZhKsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:33:10PM +0300, Alexey Budankov wrote:
>=20
> Current implementation of cpu_set_t type by glibc has internal cpu
> mask size limitation of no more than 1024 CPUs. This limitation confines
> NUMA awareness of Perf tool in record mode, thru --affinity option,
> to the first 1024 CPUs on machines with larger amount of CPUs.
>=20
> This patch set enables Perf tool to overcome 1024 CPUs limitation by
> using a dedicated struct mmap_cpu_mask type and applying tool's bitmap
> API operations to manipulate affinity masks of the tool's thread and
> the mmaped data buffers.
>=20
> tools bitmap API has been extended with bitmap_equal() operation
> and its implementation is derived from the kernel one.
>=20
> ---
> Alexey Budankov (3):
>   tools bitmap: extend bitmap API with bitmap_equal()
>   perf mmap: declare type for cpu mask of arbitrary length
>   perf record: adapt affinity to machines with #CPUs > 1K

looks good to me, I sent some minor comments

>=20
>  tools/include/linux/bitmap.h | 21 +++++++++++++++++++++
>  tools/lib/bitmap.c           | 15 +++++++++++++++
>  tools/perf/builtin-record.c  | 28 ++++++++++++++++++++++------
>  tools/perf/util/mmap.c       | 28 ++++++++++++++++++++++------
>  tools/perf/util/mmap.h       | 11 ++++++++++-
>  5 files changed, 90 insertions(+), 13 deletions(-)
>=20
> ---
> Testing:
>=20
>   $ tools/perf/perf record -v --affinity=3Dcpu -- ls
>   thread mask[8]: empty
>   Using CPUID GenuineIntel-6-5E-3
>   ...
>   mmap size 528384B
>   0x7f95f8f85010: mmap mask[8]: 0
>   0x7f95f8f950d8: mmap mask[8]: 1
>   0x7f95f8fa51a0: mmap mask[8]: 2
>   0x7f95f8fb5268: mmap mask[8]: 3
>   0x7f95f8fc5330: mmap mask[8]: 4
>   0x7f95f8fd53f8: mmap mask[8]: 5
>   0x7f95f8fe54c0: mmap mask[8]: 6
>   0x7f95f8ff5588: mmap mask[8]: 7

could we add this to -vv? -v is poluted already

perhaps we should make some effort and try to consolidate -v output
for some really basic verbose, the rest would be under -vv or specialized
--debug variable .. not in scope of this patchset of course ;-)

thanks,
jirka


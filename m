Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60DACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB00620717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFjpYMXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfJ2J1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:27:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbfJ2J1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572341255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wjGRim8EVcTFVFfERIyjpzNLXg0j/Q7juE9zrWJ0Ewk=;
        b=LFjpYMXwoOFhCsjetcHDxV/MGECrcCdwcQV9tMUPrYbrN7pkApjSuGvF7EZatS3oxW18mO
        oRbWSHNuzAI1bylXOCoX0a2xZVIvxoTJe+dr7YHRl2Gr4EGYx3AZVvdNDbPn51Zcof6nk2
        l8oQ8x4kO4YGQ+QT6kpNhhe1Jz50Cec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-2S2HhW_cMfq3qJSeA44-5w-1; Tue, 29 Oct 2019 05:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA88E801E64;
        Tue, 29 Oct 2019 09:27:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04FE119C4F;
        Tue, 29 Oct 2019 09:27:27 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:27:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191029092727.GG28772@krava>
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
 <20191028013330.18319-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028013330.18319-6-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2S2HhW_cMfq3qJSeA44-5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:33:28AM +0800, Jin Yao wrote:
> It would be useful to support sorting for all blocks by the
> sampled cycles percent per block. This is useful to concentrate
> on the globally hottest blocks.
>=20
> This patch implements a new option "--total-cycles" which sorts
> all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is the
> percent:
>=20
>  percent =3D block sampled cycles aggregation / total sampled cycles
>=20
> Note that, this patch only supports "--stdio" mode.
>=20
> For example,
>=20
> perf record -b ./div
> perf report --total-cycles --stdio
>=20
>  # To display the perf.data header info, please use --header/--header-onl=
y options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 2M of event 'cycles'
>  # Event count (approx.): 2753248
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles              =
                                [Program Block Range]         Shared Object
>  # ...............  ..............  ...........  ..........  ............=
.....................................................  ....................
>  #
>             26.04%            2.8M        0.40%          18              =
                               [div.c:42 -> div.c:39]                   div
>             15.17%            1.2M        0.16%           7              =
                   [random_r.c:357 -> random_r.c:380]          libc-2.27.so
>              5.11%          402.0K        0.04%           2              =
                               [div.c:27 -> div.c:28]                   div
>              4.87%          381.6K        0.04%           2              =
                       [random.c:288 -> random.c:291]          libc-2.27.so
>              4.53%          381.0K        0.04%           2              =
                               [div.c:40 -> div.c:40]                   div
>              3.85%          300.9K        0.02%           1              =
                               [div.c:22 -> div.c:25]                   div
>              3.08%          241.1K        0.02%           1              =
                             [rand.c:26 -> rand.c:27]          libc-2.27.so
>              3.06%          240.0K        0.02%           1              =
                       [random.c:291 -> random.c:291]          libc-2.27.so
>              2.78%          215.7K        0.02%           1              =
                       [random.c:298 -> random.c:298]          libc-2.27.so
>              2.52%          198.3K        0.02%           1              =
                       [random.c:293 -> random.c:293]          libc-2.27.so
>              2.36%          184.8K        0.02%           1              =
                             [rand.c:28 -> rand.c:28]          libc-2.27.so
>              2.33%          180.5K        0.02%           1              =
                       [random.c:295 -> random.c:295]          libc-2.27.so
>              2.28%          176.7K        0.02%           1              =
                       [random.c:295 -> random.c:295]          libc-2.27.so
>              2.20%          168.8K        0.02%           1              =
                           [rand@plt+0 -> rand@plt+0]                   div
>              1.98%          158.2K        0.02%           1              =
                   [random_r.c:388 -> random_r.c:388]          libc-2.27.so
>              1.57%          123.3K        0.02%           1              =
                               [div.c:42 -> div.c:44]                   div
>              1.44%          116.0K        0.42%          19              =
                   [random_r.c:357 -> random_r.c:394]          libc-2.27.so
>              0.25%          182.5K        0.02%           1              =
                   [random_r.c:388 -> random_r.c:391]          libc-2.27.so
>              0.00%              48        1.07%          48              =
           [x86_pmu_enable+284 -> x86_pmu_enable+298]     [kernel.kallsyms]
>              0.00%              74        1.64%          74              =
                [vm_mmap_pgoff+0 -> vm_mmap_pgoff+92]     [kernel.kallsyms]
>              0.00%              73        1.62%          73              =
                            [vm_mmap+0 -> vm_mmap+48]     [kernel.kallsyms]
>              0.00%              63        0.69%          31              =
                          [up_write+0 -> up_write+34]     [kernel.kallsyms]
>              0.00%              13        0.29%          13              =
         [setup_arg_pages+396 -> setup_arg_pages+413]     [kernel.kallsyms]
>              0.00%               3        0.07%           3              =
         [setup_arg_pages+418 -> setup_arg_pages+450]     [kernel.kallsyms]
>              0.00%             616        6.84%         308              =
      [security_mmap_file+0 -> security_mmap_file+72]     [kernel.kallsyms]
>              0.00%              23        0.51%          23              =
     [security_mmap_file+77 -> security_mmap_file+87]     [kernel.kallsyms]
>              0.00%               4        0.02%           1              =
                     [sched_clock+0 -> sched_clock+4]     [kernel.kallsyms]
>              0.00%               4        0.02%           1              =
                    [sched_clock+9 -> sched_clock+12]     [kernel.kallsyms]
>              0.00%               1        0.02%           1              =
                   [rcu_nmi_exit+0 -> rcu_nmi_exit+9]     [kernel.kallsyms]
>=20
>  v4:
>  ---
>  1. Use new option '--total-cycles' to replace
>     '-s total_cycles' in v3.
>=20
>  2. Move block info collection out of block info
>     printing.
>=20
>  v3:
>  ---
>  1. Use common function block_info__process_sym to
>     process the blocks per symbol.
>=20
>  2. Remove the nasty hack for skipping calculation
>     of column length
>=20
>  3. Some minor cleanup
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  11 ++
>  tools/perf/builtin-report.c              | 125 ++++++++++++++++++++++-
>  tools/perf/ui/stdio/hist.c               |  22 ++++
>  tools/perf/util/hist.c                   |   4 +
>  tools/perf/util/symbol_conf.h            |   1 +
>  5 files changed, 160 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docume=
ntation/perf-report.txt
> index 7315f155803f..8dbe2119686a 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -525,6 +525,17 @@ include::itrace.txt[]
>  =09Configure time quantum for time sort key. Default 100ms.
>  =09Accepts s, us, ms, ns units.
> =20
> +--total-cycles::
> +=09When --total-cycles is specified, it supports sorting for all blocks =
by
> +=09'Sampled Cycles%'. This is useful to concentrate on the globally hott=
est
> +=09blocks. In output, there are some new columns:
> +
> +=09'Sampled Cycles%' - block sampled cycles aggregation / total sampled =
cycles
> +=09'Sampled Cycles'  - block sampled cycles aggregation
> +=09'Avg Cycles%'     - block average sampled cycles / sum of total block=
 average
> +=09=09=09    sampled cycles
> +=09'Avg Cycles'      - block average sampled cycles
> +
>  include::callchain-overhead-calculation.txt[]
> =20
>  SEE ALSO
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index cdb436d6e11f..a687d9e4aeca 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -51,6 +51,7 @@
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
> +#include "util/block-info.h"
> =20
>  #include <dlfcn.h>
>  #include <errno.h>
> @@ -67,6 +68,12 @@
>  #include <unistd.h>
>  #include <linux/mman.h>
> =20
> +struct block_report {
> +=09struct block_hist=09block_hist;
> +=09u64=09=09=09block_cycles;
> +=09struct block_fmt=09block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];

no need for the 'block_' prefix for the members

also please put this and all the new functions under block_info.c

thanks,
jirka


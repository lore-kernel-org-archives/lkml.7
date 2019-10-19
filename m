Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AECA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE3121D80
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea4Qn9qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfJSRmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 13:42:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfJSRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 13:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571506970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUAbi9gtDB4keSixIsPuiPWGKniK/ln01xBgx44eiIk=;
        b=ea4Qn9qqhg/9wQ3f1gG2qPzikGKpc/tX1bifHzSTHY5APK2DJov+X/Q8/CxEiAdRSMAAw+
        Z7t4vsJvtLlwtRnFocU0xFXvrSMqpIXMYEM+M4NLTdkkgN02n+NPMJtaJVbNkkkf1HWrjW
        6wJXbsgTOI1sq4BcZ3ZG6/hTuh4QDZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-qtmdEK9XN_KGZg_BcM5sJw-1; Sat, 19 Oct 2019 13:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3390D1800DC7;
        Sat, 19 Oct 2019 17:42:45 +0000 (UTC)
Received: from krava (ovpn-204-36.brq.redhat.com [10.40.204.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 322EA100194E;
        Sat, 19 Oct 2019 17:42:41 +0000 (UTC)
Date:   Sat, 19 Oct 2019 19:42:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 07/10] libperf: Add tests_mmap_cpus test
Message-ID: <20191019174241.GB12782@krava>
References: <20191017105918.20873-1-jolsa@kernel.org>
 <20191017105918.20873-8-jolsa@kernel.org>
 <20191018181429.GE1797@kernel.org>
 <20191018181631.GF1797@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191018181631.GF1797@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qtmdEK9XN_KGZg_BcM5sJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:16:31PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 18, 2019 at 03:14:29PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Oct 17, 2019 at 12:59:15PM +0200, Jiri Olsa escreveu:
> > > Adding mmaping tests that generates prctl call on
> > > every cpu validates it gets all the related events
> > > in ring buffer.
> >=20
> > So _here_ we need _GNU_SOURCE, for this specific test:
>=20
> Added, to this test:
>=20
> [acme@quaco perf]$ git diff
> diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/te=
st-evlist.c
> index d8c52ebfa53a..741bc1bb4524 100644
> --- a/tools/perf/lib/tests/test-evlist.c
> +++ b/tools/perf/lib/tests/test-evlist.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> +#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity an=
d CPU_(ZERO,SET)
>  #include <sched.h>
> +#include <stdio.h>
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> [acme@quaco perf]$
>=20
> We can go the big hammer way if this is more generally needed, but first
> lets try to use it only when needed, ok?

ok, thanks

FYI so it's quite easy now to separate the lib and move it under
tools/lib/perf..  I'll post it together with docs/tutorial update

jirka


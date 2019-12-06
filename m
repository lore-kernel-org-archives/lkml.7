Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE06C2D0D3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4228D2467D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575640526;
	bh=0P29waJL+BbTeCRUqFb+aqfd0yR1lRP2OknsfwG6byA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QShgVIg7jfEwAGzN8g0E1xo8AlkyLo3G3u0d5JmeHCohJkiu1ftfg0GAoT3TBFwLk
	 o+617Kk8t5IjHK7he3QZ7dSMr82qyY30OIxPphsYZZPA+ZNsB0xEu5ISftyCXOa6rb
	 PAj2uMhsN9JJUwa1vx5D4deBKWqeuctCxX+LIVIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLFNzZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:55:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbfLFNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:55:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-LgbSfS4yOGqGjNEkcFgoxg-1; Fri, 06 Dec 2019 08:55:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A659800D5A;
        Fri,  6 Dec 2019 13:55:16 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C15D67154;
        Fri,  6 Dec 2019 13:55:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/3] perf/libperf move
Date:   Fri,  6 Dec 2019 14:55:10 +0100
Message-Id: <20191206135513.31586-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LgbSfS4yOGqGjNEkcFgoxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset moves libperf under tools/lib.
It's now possible to build and install it with:

  $ cd tools/lib/perf
  $ make prefix=/tmp/libperf install
    INSTALL  libperf.a
    INSTALL  libperf.so
    INSTALL  libperf.so.0
    INSTALL  libperf.so.0.0.1
    INSTALL  headers
    INSTALL  libperf.pc
    INSTALL  man
    INSTALL  html
    INSTALL  examples
  $ find /tmp/libperf/ -not -type d
  /tmp/libperf/share/doc/libperf/examples/sampling.c
  /tmp/libperf/share/doc/libperf/examples/counting.c
  /tmp/libperf/share/doc/libperf/html/libperf-sampling.html
  /tmp/libperf/share/doc/libperf/html/libperf-counting.html
  /tmp/libperf/share/doc/libperf/html/libperf.html
  /tmp/libperf/share/man/man7/libperf-sampling.7
  /tmp/libperf/share/man/man7/libperf-counting.7
  /tmp/libperf/share/man/man3/libperf.3
  /tmp/libperf/include/perf/mmap.h
  /tmp/libperf/include/perf/event.h
  /tmp/libperf/include/perf/evsel.h
  /tmp/libperf/include/perf/evlist.h
  /tmp/libperf/include/perf/threadmap.h
  /tmp/libperf/include/perf/cpumap.h
  /tmp/libperf/include/perf/core.h
  /tmp/libperf/lib64/pkgconfig/libperf.pc
  /tmp/libperf/lib64/libperf.so.0.0.1
  /tmp/libperf/lib64/libperf.so.0
  /tmp/libperf/lib64/libperf.so
  /tmp/libperf/lib64/libperf.a

There are few obvious fixes added like include path changes,
that I put in separate patch, because they would get lost in
the big move changes.

Plus adding Documentation changes to have the man page base
for more additions. I switched man pages to asciidoc and
added 3 man pages:

  libperf.3          - overall description
  libperf-counting.7 - counting basics explained on simple example
  libperf-sampling.7 - sampling basics explained on simple example

The plan is to add more man pages to cover the basic API.

I put the html pages in here for you to check:
  http://people.redhat.com/~jolsa/libperf/libperf.html
  http://people.redhat.com/~jolsa/libperf/libperf-counting.html
  http://people.redhat.com/~jolsa/libperf/libperf-sampling.html

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/lib

NOTE we are still able to change any libperf ABI,
nothing is committed by this move ;-)

NOTE 'make perf-targz-src-pkg' works nicely with this change,
but is currently failing because of recent bpf changes, I have
a fix for that and will send it shortly

thanks,
jirka


---
Jiri Olsa (3):
      libperf: Move libperf under tools/lib/perf
      libperf: Additional fixes
      libperf: Add man pages

 tools/{perf/lib => lib/perf}/Build                        |   0
 tools/lib/perf/Documentation/Makefile                     | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/asciidoc.conf                | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/examples/sampling.c          | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/libperf-counting.txt         | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/libperf-sampling.txt         | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt                  | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/perf/Documentation/manpage-1.72.xsl             |  14 +++++++++
 tools/lib/perf/Documentation/manpage-base.xsl             |  35 +++++++++++++++++++++
 tools/lib/perf/Documentation/manpage-bold-literal.xsl     |  17 +++++++++++
 tools/lib/perf/Documentation/manpage-normal.xsl           |  13 ++++++++
 tools/lib/perf/Documentation/manpage-suppress-sp.xsl      |  21 +++++++++++++
 tools/{perf/lib => lib/perf}/Makefile                     |   7 +++--
 tools/{perf/lib => lib/perf}/core.c                       |   0
 tools/{perf/lib => lib/perf}/cpumap.c                     |   0
 tools/{perf/lib => lib/perf}/evlist.c                     |   0
 tools/{perf/lib => lib/perf}/evsel.c                      |   0
 tools/{perf/lib => lib/perf}/include/internal/cpumap.h    |   0
 tools/{perf/lib => lib/perf}/include/internal/evlist.h    |   0
 tools/{perf/lib => lib/perf}/include/internal/evsel.h     |   0
 tools/{perf/lib => lib/perf}/include/internal/lib.h       |   0
 tools/{perf/lib => lib/perf}/include/internal/mmap.h      |   0
 tools/{perf/lib => lib/perf}/include/internal/tests.h     |   0
 tools/{perf/lib => lib/perf}/include/internal/threadmap.h |   0
 tools/{perf/lib => lib/perf}/include/internal/xyarray.h   |   0
 tools/{perf/lib => lib/perf}/include/perf/core.h          |   0
 tools/{perf/lib => lib/perf}/include/perf/cpumap.h        |   0
 tools/{perf/lib => lib/perf}/include/perf/event.h         |   0
 tools/{perf/lib => lib/perf}/include/perf/evlist.h        |   0
 tools/{perf/lib => lib/perf}/include/perf/evsel.h         |   0
 tools/{perf/lib => lib/perf}/include/perf/mmap.h          |   0
 tools/{perf/lib => lib/perf}/include/perf/threadmap.h     |   0
 tools/{perf/lib => lib/perf}/internal.h                   |   0
 tools/{perf/lib => lib/perf}/lib.c                        |   0
 tools/{perf/lib => lib/perf}/libperf.map                  |   0
 tools/{perf/lib => lib/perf}/libperf.pc.template          |   0
 tools/{perf/lib => lib/perf}/mmap.c                       |   0
 tools/{perf/lib => lib/perf}/tests/Makefile               |   2 +-
 tools/{perf/lib => lib/perf}/tests/test-cpumap.c          |   0
 tools/{perf/lib => lib/perf}/tests/test-evlist.c          |   0
 tools/{perf/lib => lib/perf}/tests/test-evsel.c           |   0
 tools/{perf/lib => lib/perf}/tests/test-threadmap.c       |   0
 tools/{perf/lib => lib/perf}/threadmap.c                  |   0
 tools/{perf/lib => lib/perf}/xyarray.c                    |   0
 tools/perf/MANIFEST                                       |   1 +
 tools/perf/Makefile.config                                |   2 +-
 tools/perf/Makefile.perf                                  |   2 +-
 tools/perf/lib/Documentation/Makefile                     |   7 -----
 tools/perf/lib/Documentation/man/libperf.rst              | 100 -----------------------------------------------------------
 tools/perf/lib/Documentation/tutorial/tutorial.rst        | 123 -------------------------------------------------------------------------
 50 files changed, 1204 insertions(+), 235 deletions(-)
 rename tools/{perf/lib => lib/perf}/Build (100%)
 create mode 100644 tools/lib/perf/Documentation/Makefile
 create mode 100644 tools/lib/perf/Documentation/asciidoc.conf
 create mode 100644 tools/lib/perf/Documentation/examples/sampling.c
 create mode 100644 tools/lib/perf/Documentation/libperf-counting.txt
 create mode 100644 tools/lib/perf/Documentation/libperf-sampling.txt
 create mode 100644 tools/lib/perf/Documentation/libperf.txt
 create mode 100644 tools/lib/perf/Documentation/manpage-1.72.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-base.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-bold-literal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-normal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-suppress-sp.xsl
 rename tools/{perf/lib => lib/perf}/Makefile (96%)
 rename tools/{perf/lib => lib/perf}/core.c (100%)
 rename tools/{perf/lib => lib/perf}/cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/lib.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/tests.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/xyarray.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/core.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/event.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/internal.h (100%)
 rename tools/{perf/lib => lib/perf}/lib.c (100%)
 rename tools/{perf/lib => lib/perf}/libperf.map (100%)
 rename tools/{perf/lib => lib/perf}/libperf.pc.template (100%)
 rename tools/{perf/lib => lib/perf}/mmap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/Makefile (93%)
 rename tools/{perf/lib => lib/perf}/tests/test-cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/xyarray.c (100%)
 delete mode 100644 tools/perf/lib/Documentation/Makefile
 delete mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 delete mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst


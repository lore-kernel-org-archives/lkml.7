Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318DFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56B9206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575666384;
	bh=uQaO+5Ka+j+K8RkHbfkDS7NpmYXdVOJATn0bdt3WiXs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hiazD9GpNJ4cKT0xqFWsU7T8OpeLC5DgMBqUyKafbgAafIYUBY+/dpv1B52ocnXk/
	 Ry/Dr6DCYamB9TS90JWYhkMSf2EXMGMbVdyXpTcPVeNcAcDpMWFhniW2jf/cKtgBwX
	 vb0vVDz/3/Suo+MVhXzbItz8GyKqz2GvsQqGz4aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFVGW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:06:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbfLFVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:06:22 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-vu14INaPMZq1fJITPI9wwA-1; Fri, 06 Dec 2019 16:06:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26B63107ACC7;
        Fri,  6 Dec 2019 21:06:16 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A34A6600C6;
        Fri,  6 Dec 2019 21:06:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCHv2 0/2] perf/libperf move
Date:   Fri,  6 Dec 2019 22:06:10 +0100
Message-Id: <20191206210612.8676-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vu14INaPMZq1fJITPI9wwA-1
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

There are few obvious fixes added like include path changes.

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

v2 changes:
  - squash 'fixes' patch with the move, so we don't break bisect

thanks,
jirka


---
Jiri Olsa (2):
      libperf: Move libperf under tools/lib/perf
      libperf: Add man pages

 tools/{perf/lib => lib/perf}/Build                 |   0
 tools/lib/perf/Documentation/Makefile              | 156 +++++++++++++
 tools/lib/perf/Documentation/asciidoc.conf         | 120 ++++++++++
 tools/lib/perf/Documentation/examples/sampling.c   | 119 ++++++++++
 tools/lib/perf/Documentation/libperf-counting.txt  | 211 ++++++++++++++++++
 tools/lib/perf/Documentation/libperf-sampling.txt  | 243 ++++++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt           | 246 +++++++++++++++++++++
 tools/lib/perf/Documentation/manpage-1.72.xsl      |  14 ++
 tools/lib/perf/Documentation/manpage-base.xsl      |  35 +++
 .../perf/Documentation/manpage-bold-literal.xsl    |  17 ++
 tools/lib/perf/Documentation/manpage-normal.xsl    |  13 ++
 .../lib/perf/Documentation/manpage-suppress-sp.xsl |  21 ++
 tools/{perf/lib => lib/perf}/Makefile              |   7 +-
 tools/{perf/lib => lib/perf}/core.c                |   0
 tools/{perf/lib => lib/perf}/cpumap.c              |   0
 tools/{perf/lib => lib/perf}/evlist.c              |   0
 tools/{perf/lib => lib/perf}/evsel.c               |   0
 .../lib => lib/perf}/include/internal/cpumap.h     |   0
 .../lib => lib/perf}/include/internal/evlist.h     |   0
 .../lib => lib/perf}/include/internal/evsel.h      |   0
 .../{perf/lib => lib/perf}/include/internal/lib.h  |   0
 .../{perf/lib => lib/perf}/include/internal/mmap.h |   0
 .../lib => lib/perf}/include/internal/tests.h      |   0
 .../lib => lib/perf}/include/internal/threadmap.h  |   0
 .../lib => lib/perf}/include/internal/xyarray.h    |   0
 tools/{perf/lib => lib/perf}/include/perf/core.h   |   0
 tools/{perf/lib => lib/perf}/include/perf/cpumap.h |   0
 tools/{perf/lib => lib/perf}/include/perf/event.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/evlist.h |   0
 tools/{perf/lib => lib/perf}/include/perf/evsel.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/mmap.h   |   0
 .../lib => lib/perf}/include/perf/threadmap.h      |   0
 tools/{perf/lib => lib/perf}/internal.h            |   0
 tools/{perf/lib => lib/perf}/lib.c                 |   0
 tools/{perf/lib => lib/perf}/libperf.map           |   0
 tools/{perf/lib => lib/perf}/libperf.pc.template   |   0
 tools/{perf/lib => lib/perf}/mmap.c                |   0
 tools/{perf/lib => lib/perf}/tests/Makefile        |   2 +-
 tools/{perf/lib => lib/perf}/tests/test-cpumap.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evlist.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evsel.c    |   0
 .../{perf/lib => lib/perf}/tests/test-threadmap.c  |   0
 tools/{perf/lib => lib/perf}/threadmap.c           |   0
 tools/{perf/lib => lib/perf}/xyarray.c             |   0
 tools/perf/MANIFEST                                |   1 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/lib/Documentation/Makefile              |   7 -
 tools/perf/lib/Documentation/man/libperf.rst       | 100 ---------
 tools/perf/lib/Documentation/tutorial/tutorial.rst | 123 -----------
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


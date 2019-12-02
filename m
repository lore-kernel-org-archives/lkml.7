Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04234C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFD02084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575292743;
	bh=rvdi5pxL57SsWDL1S/PEJB67hsKGSgTkza74+iDfasM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=H/jyY6aZUhrG1X6G5K6pxHitMy6mAcllBXfwwGTHIo9vaobvGFR5VHEKrCXwL9f7J
	 t24SL4HnZ8X+GsIL7bYb3jKuTvBcR5/NnWPRsEFHvWWaIHm0mfP0tBYDnMp1BN24OS
	 Vy/zWmWqyOiRiE9zWwICd1UC3pLUzlDFVbQB12Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLBNTD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:19:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31171 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbfLBNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:19:02 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-EV2vrjPkOf2HJGQRGcFDgA-1; Mon, 02 Dec 2019 08:18:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48868017DF;
        Mon,  2 Dec 2019 13:18:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3DB5600C8;
        Mon,  2 Dec 2019 13:18:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCHv4 0/6] perf/bpftool: Allow to link libbpf dynamically
Date:   Mon,  2 Dec 2019 14:18:40 +0100
Message-Id: <20191202131847.30837-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EV2vrjPkOf2HJGQRGcFDgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
adding support to link bpftool with libbpf dynamically,
and config change for perf.

It's now possible to use:
  $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=1

which will detect libbpf devel package and if found, link it with bpftool.

It's possible to use arbitrary installed libbpf:
  $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=1 LIBBPF_DIR=/tmp/libbpf/

I based this change on top of Arnaldo's perf/core, because
it contains libbpf feature detection code as dependency.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  libbpf/dyn

v4 changes:
  - based on Toke's v3 post, there's no need for additional API exports:

    Since bpftool uses bits of libbpf that are not exported as public API in
    the .so version, we also pass in libbpf.a to the linker, which allows it to
    pick up the private functions from the static library without having to
    expose them as ABI.

  - changing some Makefile variable names
  - documenting LIBBPF_DYNAMIC and LIBBPF_DIR in the Makefile comment
  - extending test_bpftool_build.sh with libbpf dynamic link

thanks,
jirka


---
Jiri Olsa (6):
      perf tools: Allow to specify libbpf install directory
      bpftool: Allow to link libbpf dynamically
      bpftool: Rename BPF_DIR Makefile variable to LIBBPF_SRC_DIR
      bpftool: Rename LIBBPF_OUTPUT Makefile variable to LIBBPF_BUILD_OUTPUT
      bpftool: Rename LIBBPF_PATH Makefile variable to LIBBPF_BUILD_PATH
      selftests, bpftool: Add build test for libbpf dynamic linking

 tools/bpf/bpftool/Makefile                        | 54 ++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/perf/Makefile.config                        | 27 ++++++++++++++++++++-------
 tools/testing/selftests/bpf/test_bpftool_build.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 15 deletions(-)


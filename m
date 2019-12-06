Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A67C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE924659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izPzP3ZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:07:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726234AbfLFPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575644835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3m3SHv2J4Zilk/1OUYpn2VGPvh2BxUXtaeBSsyI5vu8=;
        b=izPzP3ZMmhqwRvmAxwD2SFBEbVQal5f3ct8m3IloBIPZQhCHUNvCDHJYupJKOShbX1V8tJ
        KUsXAum1ECIACQonbj5GMjvy6bCGpR39ED5FyUT7puFE2NHVN1QvSVtnKRcDbP53CiqAJU
        pxQrmT/ux6U9JIKP4FI4Dlk/cFkD3YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-7PvPO1H2NleMoEb44JwA2w-1; Fri, 06 Dec 2019 10:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF151005512;
        Fri,  6 Dec 2019 15:07:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F54D10016E8;
        Fri,  6 Dec 2019 15:07:08 +0000 (UTC)
Date:   Fri, 6 Dec 2019 16:07:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] libperf: Move libperf under tools/lib/perf
Message-ID: <20191206150706.GD31721@krava>
References: <20191206135513.31586-1-jolsa@kernel.org>
 <20191206135513.31586-2-jolsa@kernel.org>
 <20191206142754.GC30698@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191206142754.GC30698@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7PvPO1H2NleMoEb44JwA2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:27:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 06, 2019 at 02:55:11PM +0100, Jiri Olsa escreveu:
> > Moving libperf from its current location under perf
> > to separate directory under tools/lib.
>=20
> Breaks the build/bisection:

yes, I noted that in the cover email, the 2nd patch repairs paths,
but those changes would get lost in the move.. I can squash it
if you want, but I thought this is more transparent despite the
one-commit-long broken bisect ;-)

jirka

>=20
> [acme@quaco perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; ma=
ke O=3D/tmp/build/perf  -C tools/perf install-bin
> make: Entering directory '/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j8' parallel build
>   HOSTCC   /tmp/build/perf/fixdep.o
>   HOSTLD   /tmp/build/perf/fixdep-in.o
>   LINK     /tmp/build/perf/fixdep
>=20
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ on  ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
>=20
>   GEN      /tmp/build/perf/common-cmds.h
> make[3]: *** /home/acme/git/perf/tools/perf/lib/: No such file or directo=
ry.  Stop.
> make[2]: *** [Makefile.perf:785: /tmp/build/perf/libperf.a] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   MKDIR    /tmp/build/perf/fd/
>   MKDIR    /tmp/build/perf/fs/
>   CC       /tmp/build/perf/exec-cmd.o
>   CC       /tmp/build/perf/fd/array.o
>   CC       /tmp/build/perf/fs/fs.o
>   CC       /tmp/build/perf/cpu.o
>   CC       /tmp/build/perf/help.o
>   LD       /tmp/build/perf/fd/libapi-in.o
>   CC       /tmp/build/perf/event-parse.o
>   CC       /tmp/build/perf/event-plugin.o
>   CC       /tmp/build/perf/pager.o
>   CC       /tmp/build/perf/debug.o
>   CC       /tmp/build/perf/str_error_r.o
>   CC       /tmp/build/perf/trace-seq.o
>   MKDIR    /tmp/build/perf/fs/
>   CC       /tmp/build/perf/parse-filter.o
>   CC       /tmp/build/perf/parse-options.o
>   MKDIR    /tmp/build/perf/staticobjs/
>   CC       /tmp/build/perf/fs/tracing_path.o
>   CC       /tmp/build/perf/run-command.o
>   CC       /tmp/build/perf/staticobjs/libbpf.o
>   CC       /tmp/build/perf/parse-utils.o
>   CC       /tmp/build/perf/kbuffer-parse.o
>   MKDIR    /tmp/build/perf/staticobjs/
>   CC       /tmp/build/perf/sigchain.o
>   LD       /tmp/build/perf/fs/libapi-in.o
>   CC       /tmp/build/perf/staticobjs/bpf.o
>   CC       /tmp/build/perf/subcmd-config.o
>   CC       /tmp/build/perf/staticobjs/nlattr.o
>   CC       /tmp/build/perf/tep_strerror.o
>   CC       /tmp/build/perf/event-parse-api.o
>   CC       /tmp/build/perf/staticobjs/btf.o
>   LD       /tmp/build/perf/libapi-in.o
>   LD       /tmp/build/perf/libsubcmd-in.o
>   CC       /tmp/build/perf/staticobjs/libbpf_errno.o
>   CC       /tmp/build/perf/staticobjs/str_error.o
>   CC       /tmp/build/perf/staticobjs/netlink.o
>   CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
>   AR       /tmp/build/perf/libapi.a
>   LD       /tmp/build/perf/libtraceevent-in.o
>   CC       /tmp/build/perf/staticobjs/libbpf_probes.o
>   CC       /tmp/build/perf/staticobjs/xsk.o
>   AR       /tmp/build/perf/libsubcmd.a
>   CC       /tmp/build/perf/staticobjs/btf_dump.o
>   CC       /tmp/build/perf/staticobjs/hashmap.o
>   LINK     /tmp/build/perf/libtraceevent.a
>   LD       /tmp/build/perf/staticobjs/libbpf-in.o
>   LINK     /tmp/build/perf/libbpf.a
>   PERF_VERSION =3D 5.4.ge59599b355da
> make[1]: *** [Makefile.perf:225: sub-make] Error 2
> make: *** [Makefile:110: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'
> [acme@quaco perf]$
>=20


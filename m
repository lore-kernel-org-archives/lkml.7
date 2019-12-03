Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35938C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91BE2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5dzMAgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLCMRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:17:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbfLCMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575375472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kn4/7iv8iMtDT1ZNS2oMkaCEOLzUTqHdhs8GKxPdnA8=;
        b=L5dzMAgHmzRMagIH36+AyPLt67YnayBgsCaGp+oL01enp4cBGtHZVcy6jp9hGjpgfem2uy
        8kSHNPuAsRHF+cfRYIHTZWg+PBxbFdnzW2nQMRP00n+tDD5XXAPC0YtCEdXGG0uX8CaUTb
        xRDAFOLW+1/LlDeOuo397HVmN8VEGeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-FvSsac8iOuyGEpSuQdTfBw-1; Tue, 03 Dec 2019 07:17:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 075DB911AC;
        Tue,  3 Dec 2019 12:17:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A3CB5C240;
        Tue,  3 Dec 2019 12:17:48 +0000 (UTC)
Date:   Tue, 3 Dec 2019 13:17:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] perf record: adapt NUMA awareness to machines
 with #CPUs > 1K
Message-ID: <20191203121745.GA14125@krava>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FvSsac8iOuyGEpSuQdTfBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:41:29PM +0300, Alexey Budankov wrote:
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
> tools bitmap API has been extended with bitmap_free() function and
> bitmap_equal() operation whose implementation is derived from the
> kernel one.
>=20
> ---
> Changes in v5:
> - avoided allocation of mmap affinity masks in case of=20
>   rec->opts.affinity =3D=3D PERF_AFFINITY_SYS

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> Changes in v4:
> - renamed perf_mmap__print_cpu_mask() to mmap_cpu_mask__scnprintf()
> - avoided checking mask bits for NULL prior calling bitmask_free()
> - avoided thread affinity mask allocation for case of=20
>   rec->opts.affinity =3D=3D PERF_AFFINITY_SYS
> Changes in v3:
> - implemented perf_mmap__print_cpu_mask() function
> - use perf_mmap__print_cpu_mask() to log thread and mmap cpus masks
>   when verbose level is equal to 2
> Changes in v2:
> - implemented bitmap_free() for symmetry with bitmap_alloc()
> - capitalized MMAP_CPU_MASK_BYTES() macro
> - returned -1 from perf_mmap__setup_affinity_mask()
> - implemented releasing of masks using bitmap_free()
> - moved debug printing under -vv option
>=20
> ---
> Alexey Budankov (3):
>   tools bitmap: implement bitmap_equal() operation at bitmap API
>   perf mmap: declare type for cpu mask of arbitrary length
>   perf record: adapt affinity to machines with #CPUs > 1K
>=20
>  tools/include/linux/bitmap.h | 30 +++++++++++++++++++++++++++
>  tools/lib/bitmap.c           | 15 ++++++++++++++
>  tools/perf/builtin-record.c  | 28 +++++++++++++++++++------
>  tools/perf/util/mmap.c       | 40 ++++++++++++++++++++++++++++++------
>  tools/perf/util/mmap.h       | 13 +++++++++++-
>  5 files changed, 113 insertions(+), 13 deletions(-)
>=20
> ---
> Validation:
>=20
> # tools/perf/perf record -vv -- ls
> Using CPUID GenuineIntel-6-5E-3
> intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> ------------------------------------------------------------
> perf_event_attr:
>   size                             120
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|PERIOD
>   read_format                      ID
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   enable_on_exec                   1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid 23718  cpu 0  group_fd -1  flags 0x8 =3D 4
> sys_perf_event_open: pid 23718  cpu 1  group_fd -1  flags 0x8 =3D 5
> sys_perf_event_open: pid 23718  cpu 2  group_fd -1  flags 0x8 =3D 6
> sys_perf_event_open: pid 23718  cpu 3  group_fd -1  flags 0x8 =3D 9
> sys_perf_event_open: pid 23718  cpu 4  group_fd -1  flags 0x8 =3D 10
> sys_perf_event_open: pid 23718  cpu 5  group_fd -1  flags 0x8 =3D 11
> sys_perf_event_open: pid 23718  cpu 6  group_fd -1  flags 0x8 =3D 12
> sys_perf_event_open: pid 23718  cpu 7  group_fd -1  flags 0x8 =3D 13
> mmap size 528384B
> 0x7f3e06e060b8: mmap mask[8]:=20
> 0x7f3e06e16180: mmap mask[8]:=20
> 0x7f3e06e26248: mmap mask[8]:=20
> 0x7f3e06e36310: mmap mask[8]:=20
> 0x7f3e06e463d8: mmap mask[8]:=20
> 0x7f3e06e564a0: mmap mask[8]:=20
> 0x7f3e06e66568: mmap mask[8]:=20
> 0x7f3e06e76630: mmap mask[8]:=20
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1
>   size                             120
>   config                           0x9
>   watermark                        1
>   sample_id_all                    1
>   bpf_event                        1
>   { wakeup_events, wakeup_watermark } 1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 14
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 15
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 16
> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 =3D 17
> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 =3D 18
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 =3D 19
> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 =3D 20
> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 =3D 21
> mmap size 528384B
> 0x7f3e0697d0b8: mmap mask[8]:=20
> 0x7f3e0698d180: mmap mask[8]:=20
> 0x7f3e0699d248: mmap mask[8]:=20
> 0x7f3e069ad310: mmap mask[8]:=20
> 0x7f3e069bd3d8: mmap mask[8]:=20
> 0x7f3e069cd4a0: mmap mask[8]:=20
> 0x7f3e069dd568: mmap mask[8]:=20
> 0x7f3e069ed630: mmap mask[8]:=20
> Synthesizing TSC conversion information
> arch=09=09=09      copy     Documentation  init     kernel=09 MAINTAINERS=
=09  modules.builtin.modinfo  perf.data=09  scripts   System.map=09vmlinux
> block=09=09=09      COPYING  drivers=09      ipc      lbuild=09 Makefile=
=09  modules.order=09=09   perf.data.old  security  tools=09vmlinux.o
> certs=09=09=09      CREDITS  fs=09      Kbuild   lib=09 mm=09=09  Module.=
symvers=09   README=09  sound     usr
> config-5.2.7-100.fc29.x86_64  crypto   include=09      Kconfig  LICENSES =
 modules.builtin  net=09=09=09   samples=09  stdio     virt
> [ perf record: Woken up 1 times to write data ]
> Looking at the vmlinux_path (8 entries long)
> Using vmlinux for symbols
> [ perf record: Captured and wrote 0.013 MB perf.data (8 samples) ]
>=20
> tools/perf/perf record -vv --affinity=3Dcpu -- ls
> thread mask[8]: empty
> Using CPUID GenuineIntel-6-5E-3
> intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
> nr_cblocks: 0
> affinity: CPU
> mmap flush: 1
> comp level: 0
> ------------------------------------------------------------
> perf_event_attr:
>   size                             120
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|PERIOD
>   read_format                      ID
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   enable_on_exec                   1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid 23713  cpu 0  group_fd -1  flags 0x8 =3D 4
> sys_perf_event_open: pid 23713  cpu 1  group_fd -1  flags 0x8 =3D 5
> sys_perf_event_open: pid 23713  cpu 2  group_fd -1  flags 0x8 =3D 6
> sys_perf_event_open: pid 23713  cpu 3  group_fd -1  flags 0x8 =3D 9
> sys_perf_event_open: pid 23713  cpu 4  group_fd -1  flags 0x8 =3D 10
> sys_perf_event_open: pid 23713  cpu 5  group_fd -1  flags 0x8 =3D 11
> sys_perf_event_open: pid 23713  cpu 6  group_fd -1  flags 0x8 =3D 12
> sys_perf_event_open: pid 23713  cpu 7  group_fd -1  flags 0x8 =3D 13
> mmap size 528384B
> 0x7f3e005bc0b8: mmap mask[8]: 0
> 0x7f3e005cc180: mmap mask[8]: 1
> 0x7f3e005dc248: mmap mask[8]: 2
> 0x7f3e005ec310: mmap mask[8]: 3
> 0x7f3e005fc3d8: mmap mask[8]: 4
> 0x7f3e0060c4a0: mmap mask[8]: 5
> 0x7f3e0061c568: mmap mask[8]: 6
> 0x7f3e0062c630: mmap mask[8]: 7
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1
>   size                             120
>   config                           0x9
>   watermark                        1
>   sample_id_all                    1
>   bpf_event                        1
>   { wakeup_events, wakeup_watermark } 1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 14
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 15
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 16
> sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 =3D 17
> sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 =3D 18
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 =3D 19
> sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 =3D 20
> sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 =3D 21
> mmap size 528384B
> 0x7f3e001330b8: mmap mask[8]:=20
> 0x7f3e00143180: mmap mask[8]:=20
> 0x7f3e00153248: mmap mask[8]:=20
> 0x7f3e00163310: mmap mask[8]:=20
> 0x7f3e001733d8: mmap mask[8]:=20
> 0x7f3e001834a0: mmap mask[8]:=20
> 0x7f3e00193568: mmap mask[8]:=20
> 0x7f3e001a3630: mmap mask[8]:=20
> Synthesizing TSC conversion information
> 0x9c9ff0: thread mask[8]: 0
> 0x9c9ff0: thread mask[8]: 1
> 0x9c9ff0: thread mask[8]: 2
> 0x9c9ff0: thread mask[8]: 3
> 0x9c9ff0: thread mask[8]: 4
> arch=09=09=09      copy     Documentation  init     kernel=09 MAINTAINERS=
=09  modules.builtin.modinfo  perf.data=09  scripts   System.map=09vmlinux
> block=09=09=09      COPYING  drivers=09      ipc      lbuild=09 Makefile=
=09  modules.order=09=09   perf.data.old  security  tools=09vmlinux.o
> certs=09=09=09      CREDITS  fs=09      Kbuild   lib=09 mm=09=09  Module.=
symvers=09   README=09  sound     usr
> config-5.2.7-100.fc29.x86_64  crypto   include=09      Kconfig  LICENSES =
 modules.builtin  net=09=09=09   samples=09  stdio     virt
> 0x9c9ff0: thread mask[8]: 5
> 0x9c9ff0: thread mask[8]: 6
> 0x9c9ff0: thread mask[8]: 7
> 0x9c9ff0: thread mask[8]: 0
> 0x9c9ff0: thread mask[8]: 1
> 0x9c9ff0: thread mask[8]: 2
> 0x9c9ff0: thread mask[8]: 3
> 0x9c9ff0: thread mask[8]: 4
> 0x9c9ff0: thread mask[8]: 5
> 0x9c9ff0: thread mask[8]: 6
> 0x9c9ff0: thread mask[8]: 7
> [ perf record: Woken up 0 times to write data ]
> 0x9c9ff0: thread mask[8]: 0
> 0x9c9ff0: thread mask[8]: 1
> 0x9c9ff0: thread mask[8]: 2
> 0x9c9ff0: thread mask[8]: 3
> 0x9c9ff0: thread mask[8]: 4
> 0x9c9ff0: thread mask[8]: 5
> 0x9c9ff0: thread mask[8]: 6
> 0x9c9ff0: thread mask[8]: 7
> Looking at the vmlinux_path (8 entries long)
> Using vmlinux for symbols
> ...
> [ perf record: Captured and wrote 0.013 MB perf.data (10 samples) ]
>=20


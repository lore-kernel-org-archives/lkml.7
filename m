Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D7920700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfC1J2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:28:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:53400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1J2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:28:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 02:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126578804"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 02:28:35 -0700
Received: from [10.125.252.146] (abudanko-mobl.ccr.corp.intel.com [10.125.252.146])
        by linux.intel.com (Postfix) with ESMTP id 866965804B4;
        Thu, 28 Mar 2019 02:28:33 -0700 (PDT)
Subject: Re: [PATCH v10 00/12] perf: enable compression of record mode trace
 to save storage space
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8e9cb3b8-d949-4904-d7e8-614176e62636@linux.intel.com>
Date:   Thu, 28 Mar 2019 12:28:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a gentle reminder regarding the patch set below.

Thanks,
Alexey

On 18.03.2019 20:36, Alexey Budankov wrote:
> 
> The patch set implements runtime trace compression (-z option) in 
> record mode and trace auto decompression in report and inject modes. 
> Streaming Zstd API [1] is used for compression and decompression of
> data that come from kernel mmaped data buffers.
> 
> Usage of implemented -z,--compression_level=n option provides ~3-5x 
> avg. trace file size reduction on variety of tested workloads what 
> saves storage space on larger server systems where trace file size 
> can easily reach several tens or even hundreds of GiBs, especially 
> when profiling with dwarf-based stacks and tracing of context switches.
> Default option value is 1 (fastest compression).
> 
> Implemented --mmap-flush option can be used to specify minimal size 
> of data chunk that is extracted from mmaped kernel buffer to store
> into a trace. The option is independent from -z setting and doesn't 
> vary with compression level. The default option value is 1 byte what 
> means every time trace writing thread finds some new data in the 
> mmaped buffer the data is extracted, possibly compressed and written 
> to a trace. The option serves two purposes the first one is to increase 
> the compression ratio of trace data and the second one is to avoid 
> live-lock self tool process monitoring in system wide (-a) profiling
> mode. Profiling in system wide mode with compression (-a -z) can 
> additionally induce data into the kernel buffers along with the data 
> from monitored processes. If performance data rate and volume from 
> the monitored processes is high then trace streaming and compression 
> activity in the tool is also high. It can lead to subtle live-lock 
> effect of endless activity when compression of single new byte from 
> some of mmaped kernel buffer induces the next single byte at some 
> mmaped buffer. So perf tool thread never stops on polling event file 
> descriptors. Varying data chunk size to be extracted from mmap buffers 
> allows avoiding live-locking self monitoring in system wide mode and
> makes mmap buffers polling loop manageable. Possible usage examples:
> 
>   $ tools/perf/perf record -z -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -z -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z --mmap-flush 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -z --mmap-flush 1K -e cycles -- matrix.gcc
> 
> Runtime compression overhead has been measured for serial and AIO 
> trace writing modes when profiling matrix multiplication workload:
> 
>       -------------------------------------------------------------
>       | SERIAL                      | AIO-1                       |
>   ----|-----------------------------|-----------------------------|
>   |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
>   |---|--------|--------------------|--------|--------------------|
>   | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
>   | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
>   | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
>   | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
>   | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
>   | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
>   -----------------------------------------------------------------
> 
>   OVH = (Execution time with -z N) / (Execution time with -z 0)
> 
>   ratio - compression ratio
>   size  - number of bytes that was compressed
> 
>   size ~= trace file x ratio
> 
> See complete description of measurement conditions with details below.
> 
> Introduced compression functionality can be disabled or configured from 
> the command line using NO_LIBZSTD and LIBZSTD_DIR defines:
> 
>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd/sources/ clean all
> 
> If your system has some version of the zstd package preinstalled then 
> the build system finds and uses it during the build. Auto detection 
> feature status is reported just before compilation starts, as usual.
> If you still prefer to compile with some other version of zstd you have 
> capability to refer the compilation to that version using LIBZSTD_DIR 
> define.
> 
> See 'perf test' results below for enabled and disabled (NO_LIBZSTD=1)
> feature configurations.
> 
> ---
> Alexey Budankov (12):
>   feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>   perf record: implement --mmap-flush=<number> option
>   perf session: define bytes_transferred and bytes_compressed metrics
>   perf record: implement COMPRESSED event record and its attributes
>   perf mmap: implement dedicated memory buffer for data compression
>   perf util: introduce Zstd streaming based compression API
>   perf record: implement compression for serial trace streaming
>   perf record: implement compression for AIO trace streaming
>   perf record: implement -z,--compression_level[=<n>] option
>   perf report: implement record trace decompression
>   perf inject: enable COMPRESSED records decompression
>   perf tests: implement Zstd comp/decomp integration test
> 
>  tools/build/Makefile.feature                  |   6 +-
>  tools/build/feature/Makefile                  |   6 +-
>  tools/build/feature/test-all.c                |   5 +
>  tools/build/feature/test-libzstd.c            |  12 +
>  tools/perf/Documentation/perf-record.txt      |  17 ++
>  .../Documentation/perf.data-file-format.txt   |  24 ++
>  tools/perf/Makefile.config                    |  20 ++
>  tools/perf/Makefile.perf                      |   3 +
>  tools/perf/builtin-inject.c                   |   4 +
>  tools/perf/builtin-record.c                   | 285 +++++++++++++++---
>  tools/perf/builtin-report.c                   |   5 +-
>  tools/perf/builtin-version.c                  |   2 +
>  tools/perf/perf.h                             |   2 +
>  .../tests/shell/record+zstd_comp_decomp.sh    |  35 +++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/compress.h                    |  54 ++++
>  tools/perf/util/env.h                         |  11 +
>  tools/perf/util/event.c                       |   1 +
>  tools/perf/util/event.h                       |   7 +
>  tools/perf/util/evlist.c                      |   8 +-
>  tools/perf/util/evlist.h                      |   3 +-
>  tools/perf/util/header.c                      |  55 +++-
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/mmap.c                        | 106 ++-----
>  tools/perf/util/mmap.h                        |  17 +-
>  tools/perf/util/session.c                     | 129 +++++++-
>  tools/perf/util/session.h                     |  14 +
>  tools/perf/util/tool.h                        |   2 +
>  tools/perf/util/zstd.c                        | 111 +++++++
>  29 files changed, 813 insertions(+), 134 deletions(-)
>  create mode 100644 tools/build/feature/test-libzstd.c
>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
>  create mode 100644 tools/perf/util/zstd.c
> 
> ---
> Changes in v10:
> - separated decomp list deallocation into perf_session__release_decomp_events
> - extended the test with suggested decompression validation
> 
> Changes in v9:
> - fixed issue with improper max COMPRESSED record size calculation
> - moved up calculation of ratio variable in 03/12
> - made minor corrections in changelogs
> - corrected several checkpatch.pl warnings and errors
> 
> Changes in v8:
> - avoid using -f for --mmap-flush option
> - move stubs to compress.h and avoid unconditional compiling of zstd.c
> - fixed silent interruption for perf record collection
> - implemented -z 1 as default
> 
> Changes in v7:
> - rebased to Arnaldo's perf/core tip
> - implemented B/K/M/G suffixes for -f option
> - reworked record__mmap_read_evlist() to replace perf_mmap__aio_push()
>   by perf_mmap__push() in AIO case
> - extended "[ perf record: Captured ... ]" message with compression statistics
> - extended changelog for v5 06/10
> - used PERF_SAMPLE_MAX_SIZE for compressed record size calculations
> - renamed record__zstd_compress to zstd_compress and
>   record__process_comp_header to process_comp_header
> - separated nr_cblocks_max applying
> 
> Changes in v6:
> - extended docs with description of PERF_RECORD_COMPRESSED record and 
>   HEADER_COMPRESSED feature layouts
> 
> Changes in v5:
> - implemented perf version --build-options extension for aio and zstd - see TESTING below
> - adjusted commit message and perf-record.txt content for -f option
> - fixed build errors in case of NO_AIO=1 and NO_LIBZSTD=1
> 
> Changes in v4:
> - implemented integration tests
> - adjusted zstd_ stub functions
> - rebased on tip of Arnaldo's perf/core
> 
> Changes in v3:
> - moved -f,--mmap-flush option implementation into a separate patch
> - moved definition and printing of bytes_transferred and bytes_compressed into a separate patch
> - moved COMPRESSED feature into a separate patch
> - added versioning and stored COMPRESSED feature attributes as u32
> - implemented dedicated memory buffer for compression in case of serial streaming
> - moved low level Zstd based compression functions into util/{compress.h,zstd.c}
> - made compress function to be a param of __push(), __aio_push() functions
> - enabled perf inject to decompress COMPRESSED records
> - measured compression overhead for serial and AIO streaming using 
>   basic matrix multiplication workload on 8 core skylake
> 
> Changes in v2:
> - moved compression/decompression code to session layer
> - enabled allocation aio data buffers for compression
> - enabled trace compression for serial trace streaming
> 
> ---
> [1] https://github.com/facebook/zstd
> 
> ---
> OVERHEAD MEASUREMENTS:
> 
> uname -a
> Linux localhost 4.20.7-200.fc29.x86_64 #1 SMP Wed Feb 6 19:16:42 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> cat /proc/cpuinfo
> processor       : 7
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 94
> model name      : Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
> stepping        : 3
> microcode       : 0xc6
> cpu MHz         : 4021.884
> cache size      : 8192 KB
> physical id     : 0
> siblings        : 8
> core id         : 3
> cpu cores       : 4
> apicid          : 7
> initial apicid  : 7
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
> bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
> bogomips        : 8016.00
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
> 
> -----------------------------------------------------------------
> #!/bin/bash -xv
> 
> echo 0 > /proc/sys/kernel/perf_event_paranoid
> + echo 0
> cat /proc/sys/kernel/perf_event_paranoid
> + cat /proc/sys/kernel/perf_event_paranoid
> 0
> 
> echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> + echo performance
> + tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
> performance
> 
> for i in 0 1 2 3 5 8
> do
>     /usr/bin/time tools/perf/perf record -z $i -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> done
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 0 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7fe36de5c010
> Offs of buf1 = 0x7fe36de5c180
> Addr of buf2 = 0x7fe36be5b010
> Offs of buf2 = 0x7fe36be5b1c0
> Addr of buf3 = 0x7fe369e5a010
> Offs of buf3 = 0x7fe369e5a100
> Addr of buf4 = 0x7fe367e59010
> Offs of buf4 = 0x7fe367e59140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 16.949 seconds
> [ perf record: Woken up 309 times to write data ]
> [ perf record: Captured and wrote 179.424 MB perf.data ]
> 133.67user 0.35system 0:17.08elapsed 784%CPU (0avgtext+0avgdata 100580maxresident)k
> 0inputs+367480outputs (0major+34737minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 1 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7fcaec334010
> Offs of buf1 = 0x7fcaec334180
> Addr of buf2 = 0x7fcaea333010
> Offs of buf2 = 0x7fcaea3331c0
> Addr of buf3 = 0x7fcae8332010
> Offs of buf3 = 0x7fcae8332100
> Addr of buf4 = 0x7fcae6331010
> Offs of buf4 = 0x7fcae6331140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 17.608 seconds
> [ perf record: Woken up 595 times to write data ]
> [ perf record: Compressed 181.148 MB to 21.497 MB, ratio is 8.427 ]
> [ perf record: Captured and wrote 21.527 MB perf.data ]
> 135.69user 0.24system 0:17.73elapsed 766%CPU (0avgtext+0avgdata 100500maxresident)k
> 0inputs+44112outputs (0major+35033minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 2 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f1336f8d010
> Offs of buf1 = 0x7f1336f8d180
> Addr of buf2 = 0x7f1334f8c010
> Offs of buf2 = 0x7f1334f8c1c0
> Addr of buf3 = 0x7f1332f8b010
> Offs of buf3 = 0x7f1332f8b100
> Addr of buf4 = 0x7f1330f8a010
> Offs of buf4 = 0x7f1330f8a140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.175 seconds
> [ perf record: Woken up 521 times to write data ]
> [ perf record: Compressed 186.953 MB to 23.210 MB, ratio is 8.055 ]
> [ perf record: Captured and wrote 23.239 MB perf.data ]
> 140.21user 0.25system 0:18.32elapsed 766%CPU (0avgtext+0avgdata 100560maxresident)k
> 0inputs+47608outputs (0major+35263minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 3 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f97060e3010
> Offs of buf1 = 0x7f97060e3180
> Addr of buf2 = 0x7f97040e2010
> Offs of buf2 = 0x7f97040e21c0
> Addr of buf3 = 0x7f97020e1010
> Offs of buf3 = 0x7f97020e1100
> Addr of buf4 = 0x7f97000e0010
> Offs of buf4 = 0x7f97000e0140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 17.688 seconds
> [ perf record: Woken up 485 times to write data ]
> [ perf record: Compressed 181.908 MB to 21.962 MB, ratio is 8.283 ]
> [ perf record: Captured and wrote 21.991 MB perf.data ]
> 136.87user 0.23system 0:17.81elapsed 769%CPU (0avgtext+0avgdata 100616maxresident)k
> 0inputs+45064outputs (0major+35773minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 5 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f477b444010
> Offs of buf1 = 0x7f477b444180
> Addr of buf2 = 0x7f4779443010
> Offs of buf2 = 0x7f47794431c0
> Addr of buf3 = 0x7f4777442010
> Offs of buf3 = 0x7f4777442100
> Addr of buf4 = 0x7f4775441010
> Offs of buf4 = 0x7f4775441140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.406 seconds
> [ perf record: Woken up 416 times to write data ]
> [ perf record: Compressed 187.705 MB to 23.170 MB, ratio is 8.101 ]
> [ perf record: Captured and wrote 23.200 MB perf.data ]
> 142.72user 0.26system 0:18.53elapsed 771%CPU (0avgtext+0avgdata 100520maxresident)k
> 0inputs+47528outputs (0major+36928minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record -z 8 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7fb5bf032010
> Offs of buf1 = 0x7fb5bf032180
> Addr of buf2 = 0x7fb5bd031010
> Offs of buf2 = 0x7fb5bd0311c0
> Addr of buf3 = 0x7fb5bb030010
> Offs of buf3 = 0x7fb5bb030100
> Addr of buf4 = 0x7fb5b902f010
> Offs of buf4 = 0x7fb5b902f140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 17.751 seconds
> [ perf record: Woken up 391 times to write data ]
> [ perf record: Compressed 179.191 MB to 19.441 MB, ratio is 9.217 ]
> [ perf record: Captured and wrote 19.502 MB perf.data ]
> 138.90user 0.29system 0:17.88elapsed 778%CPU (0avgtext+0avgdata 100612maxresident)k
> 0inputs+39968outputs (0major+37436minor)pagefaults 0swaps
> 
> for i in 0 1 2 3 5 8
> do
>     /usr/bin/time tools/perf/perf record --aio=1 -z $i -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> done
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 0 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7feee4519010
> Offs of buf1 = 0x7feee4519180
> Addr of buf2 = 0x7feee2518010
> Offs of buf2 = 0x7feee25181c0
> Addr of buf3 = 0x7feee0517010
> Offs of buf3 = 0x7feee0517100
> Addr of buf4 = 0x7feede516010
> Offs of buf4 = 0x7feede516140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 17.912 seconds
> [ perf record: Woken up 390 times to write data ]
> [ perf record: Captured and wrote 187.527 MB perf.data ]
> 139.70user 0.39system 0:18.04elapsed 776%CPU (0avgtext+0avgdata 100624maxresident)k
> 0inputs+384072outputs (0major+35257minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 1 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f72b93ac010
> Offs of buf1 = 0x7f72b93ac180
> Addr of buf2 = 0x7f72b73ab010
> Offs of buf2 = 0x7f72b73ab1c0
> Addr of buf3 = 0x7f72b53aa010
> Offs of buf3 = 0x7f72b53aa100
> Addr of buf4 = 0x7f72b33a9010
> Offs of buf4 = 0x7f72b33a9140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.198 seconds
> [ perf record: Woken up 416 times to write data ]
> [ perf record: Compressed 188.562 MB to 22.252 MB, ratio is 8.474 ]
> [ perf record: Captured and wrote 22.284 MB perf.data ]
> 141.12user 0.32system 0:18.32elapsed 771%CPU (0avgtext+0avgdata 100576maxresident)k
> 0inputs+45664outputs (0major+35040minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 2 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7ffb9caf3010
> Offs of buf1 = 0x7ffb9caf3180
> Addr of buf2 = 0x7ffb9aaf2010
> Offs of buf2 = 0x7ffb9aaf21c0
> Addr of buf3 = 0x7ffb98af1010
> Offs of buf3 = 0x7ffb98af1100
> Addr of buf4 = 0x7ffb96af0010
> Offs of buf4 = 0x7ffb96af0140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.360 seconds
> [ perf record: Woken up 442 times to write data ]
> [ perf record: Compressed 191.773 MB to 24.238 MB, ratio is 7.912 ]
> [ perf record: Captured and wrote 24.290 MB perf.data ]
> 143.76user 0.49system 0:18.50elapsed 779%CPU (0avgtext+0avgdata 100596maxresident)k
> 0inputs+49760outputs (0major+35276minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 3 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f13f2df2010
> Offs of buf1 = 0x7f13f2df2180
> Addr of buf2 = 0x7f13f0df1010
> Offs of buf2 = 0x7f13f0df11c0
> Addr of buf3 = 0x7f13eedf0010
> Offs of buf3 = 0x7f13eedf0100
> Addr of buf4 = 0x7f13ecdef010
> Offs of buf4 = 0x7f13ecdef140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.383 seconds
> [ perf record: Woken up 499 times to write data ]
> [ perf record: Compressed 191.078 MB to 23.246 MB, ratio is 8.220 ]
> [ perf record: Captured and wrote 23.282 MB perf.data ]
> 143.72user 0.34system 0:18.51elapsed 778%CPU (0avgtext+0avgdata 100616maxresident)k
> 0inputs+47704outputs (0major+35783minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 5 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7fca0d091010
> Offs of buf1 = 0x7fca0d091180
> Addr of buf2 = 0x7fca0b090010
> Offs of buf2 = 0x7fca0b0901c0
> Addr of buf3 = 0x7fca0908f010
> Offs of buf3 = 0x7fca0908f100
> Addr of buf4 = 0x7fca0708e010
> Offs of buf4 = 0x7fca0708e140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 18.758 seconds
> [ perf record: Woken up 535 times to write data ]
> [ perf record: Compressed 190.065 MB to 24.430 MB, ratio is 7.780 ]
> [ perf record: Captured and wrote 24.519 MB perf.data ]
> 144.62user 0.66system 0:18.88elapsed 769%CPU (0avgtext+0avgdata 100528maxresident)k
> 0inputs+50232outputs (0major+36942minor)pagefaults 0swaps
> + for i in 0 1 2 3 5 8
> + /usr/bin/time tools/perf/perf record --aio=1 -z 8 -F 25000 -N -B -T -R -e cycles -- ../../matrix/linux/matrix.gcc
> Addr of buf1 = 0x7f7e1f449010
> Offs of buf1 = 0x7f7e1f449180
> Addr of buf2 = 0x7f7e1d448010
> Offs of buf2 = 0x7f7e1d4481c0
> Addr of buf3 = 0x7f7e1b447010
> Offs of buf3 = 0x7f7e1b447100
> Addr of buf4 = 0x7f7e19446010
> Offs of buf4 = 0x7f7e19446140
> Threads #: 8 Pthreads
> Matrix size: 2048
> Using multiply kernel: multiply1
> Execution time = 20.103 seconds
> [ perf record: Woken up 260 times to write data ]
> [ perf record: Compressed 193.024 MB to 31.588 MB, ratio is 6.111 ]
> [ perf record: Captured and wrote 32.139 MB perf.data ]
> 151.73user 4.21system 0:20.23elapsed 770%CPU (0avgtext+0avgdata 100616maxresident)k
> 0inputs+65848outputs (0major+37431minor)pagefaults 0swaps
> 
> ---
> TESTING:
> 
>   $ tools/perf/perf version --build-options
> perf version 4.13.rc5.gd8d056b
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                   gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ OFF ]  # HAVE_AIO_SUPPORT
>                   zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
> 
>   $ tools/perf/perf version --build-options
> perf version 4.13.rc5.gd8d056b
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                   gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> 
>   $ make -C tools/perf clean all
> ...
>   $ pushd tools/perf/ && ./perf test && popd
> ~/abudanko/kernel/acme/tools/perf ~/abudanko/kernel/acme
>  1: vmlinux symtab matches kallsyms                       : Skip
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
>  4: Read samples using the mmap interface                 : Ok
>  5: Test data source output                               : Ok
>  6: Parse event definition strings                        : Ok
>  7: Simple expression parser                              : Ok
>  8: PERF_RECORD_* events & perf_sample fields             : Ok
>  9: Parse perf pmu format                                 : Ok
> 10: DSO data read                                         : Ok
> 11: DSO data cache                                        : Ok
> 12: DSO data reopen                                       : Ok
> 13: Roundtrip evsel->name                                 : Ok
> 14: Parse sched tracepoints fields                        : Ok
> 15: syscalls:sys_enter_openat event fields                : Ok
> 16: Setup struct perf_event_attr                          : Ok
> 17: Match and link multiple hists                         : Ok
> 18: 'import perf' in python                               : Ok
> 19: Breakpoint overflow signal handler                    : Ok
> 20: Breakpoint overflow sampling                          : Ok
> 21: Breakpoint accounting                                 : Ok
> 22: Watchpoint                                            :
> 22.1: Read Only Watchpoint                                : Skip
> 22.2: Write Only Watchpoint                               : Ok
> 22.3: Read / Write Watchpoint                             : Ok
> 22.4: Modify Watchpoint                                   : Ok
> 23: Number of exit events of a simple workload            : Ok
> 24: Software clock events period values                   : Ok
> 25: Object code reading                                   : Ok
> 26: Sample parsing                                        : Ok
> 27: Use a dummy software event to keep tracking           : Ok
> 28: Parse with no sample_id_all bit set                   : Ok
> 29: Filter hist entries                                   : Ok
> 30: Lookup mmap thread                                    : Ok
> 31: Share thread mg                                       : Ok
> 32: Sort output of hist entries                           : Ok
> 33: Cumulate child hist entries                           : Ok
> 34: Track with sched_switch                               : Ok
> 35: Filter fds with revents mask in a fdarray             : Ok
> 36: Add fd to a fdarray, making it autogrow               : Ok
> 37: kmod_path__parse                                      : Ok
> 38: Thread map                                            : Ok
> 39: LLVM search and compile                               :
> 39.1: Basic BPF llvm compile                              : Skip
> 39.2: kbuild searching                                    : Skip
> 39.3: Compile source for BPF prologue generation          : Skip
> 39.4: Compile source for BPF relocation                   : Skip
> 40: Session topology                                      : Ok
> 41: BPF filter                                            :
> 41.1: Basic BPF filtering                                 : Skip
> 41.2: BPF pinning                                         : Skip
> 41.3: BPF prologue generation                             : Skip
> 41.4: BPF relocation checker                              : Skip
> 42: Synthesize thread map                                 : Ok
> 43: Remove thread map                                     : Ok
> 44: Synthesize cpu map                                    : Ok
> 45: Synthesize stat config                                : Ok
> 46: Synthesize stat                                       : Ok
> 47: Synthesize stat round                                 : Ok
> 48: Synthesize attr update                                : Ok
> 49: Event times                                           : Ok
> 50: Read backward ring buffer                             : Ok
> 51: Print cpu map                                         : Ok
> 52: Probe SDT events                                      : Ok
> 53: is_printable_array                                    : Ok
> 54: Print bitmap                                          : Ok
> 55: perf hooks                                            : Ok
> 56: builtin clang support                                 : Skip (not compiled in)
> 57: unit_number__scnprintf                                : Ok
> 58: mem2node                                              : Ok
> 59: x86 rdpmc                                             : Ok
> 60: Convert perf time to TSC                              : Ok
> 61: DWARF unwind                                          : Ok
> 62: x86 instruction decoder - new instructions            : Ok
> 63: x86 bp modify                                         : Ok
> 64: Check open filename arg using perf trace + vfs_getname: Skip
> 65: Add vfs_getname probe to get syscall args filenames   : Skip
> 66: probe libc's inet_pton & backtrace it with ping       : Ok
> 67: Use vfs_getname probe to get syscall args filenames   : Skip
> 68: record trace Zstd compression/decompression           : Ok
> ~/abudanko/kernel/acme
> 
>   $ make -C tools/perf NO_LIBZSTD=1 clean all
> ...
>   $ pushd tools/perf/ && ./perf test && popd
> ~/abudanko/kernel/acme/tools/perf ~/abudanko/kernel/acme
> ...
> 68: record trace Zstd compression/decompression           : Skip
> ~/abudanko/kernel/acme
> 

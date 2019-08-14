Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Ot8VCgpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfHNUC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:02:58 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:41520 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfHNUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:02:57 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x7EJvwkE022656;
        Wed, 14 Aug 2019 21:02:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=avFeVZg6Er4RG8Kprd47bJuJPWR48e3GkIqQkFX/Wfw=;
 b=Ot8VCgpzenKbCVByNjHHuI+1QmEwlKnEAjnwM8PhuSIv5EPdXqAQnT0qMBbR+D36WSUX
 B1WPizA8gN3uefMpPjYGx1hEUUzHVQej2wb3x3baWb0M9Feg5r0B2QpNRS/pQaXAEh7f
 5FCskea15vs049FMj2TV7JLdu5xxwI8HAfiFRsfm6J329jPU363i0fBCItusKvr9luwo
 kKXoRdea5VyoBz1f++KpA1tBgtd/PfbQeD/BsJ9o+dAWLdgCRkWFVXvF0ut5uK9sYopZ
 WRi5I7KzQ6FEbkMdK5kq5qixMcPS8emFauE6MTljTSWBIEl1f9F1CDgHrfw3WVVoYIdl Iw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2ubf8napqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 21:02:29 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7EK2GSu009672;
        Wed, 14 Aug 2019 16:02:27 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2u9s8vj1q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 16:02:27 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb1.msg.corp.akamai.com (172.27.123.101) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 14 Aug 2019 16:02:26 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Wed, 14 Aug 2019 16:02:26 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Topic: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Index: AQHVTS6ohXVeHma7aEyJ5mLyFs0geab7PiSAgAAMNACAAAEdgP//yqiw
Date:   Wed, 14 Aug 2019 20:02:26 +0000
Message-ID: <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org>
In-Reply-To: <20190814185213.GN9280@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.32.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140181
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-14_07:2019-08-14,2019-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908140180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, August 14, 2019 at 2:52 PM Arnaldo Carvalho de Melo <arnaldo.melo=
@gmail.com> wrote:
> Em Wed, Aug 14, 2019 at 03:48:14PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > Em Wed, Aug 14, 2019 at 12:04:33PM -0600, Mathieu Poirier escreveu:
> > > # echo 0 > /proc/sys/kernel/kptr_restrict # ./tools/perf/perf record
> > > -e instructions:k uname
> > > perf: Segmentation fault
> > > Obtained 10 stack frames.
> > > ./tools/perf/perf(sighandler_dump_stack+0x44) [0x55af9e5da5d4]
> > > /lib/x86_64-linux-gnu/libc.so.6(+0x3ef20) [0x7fd31efb6f20]
> > > ./tools/perf/perf(perf_event__synthesize_kernel_mmap+0xa7)
> > > [0x55af9e590337]
> > > ./tools/perf/perf(+0x1cf5be) [0x55af9e50c5be]
> > > ./tools/perf/perf(cmd_record+0x1022) [0x55af9e50dff2]
> > > ./tools/perf/perf(+0x23f98d) [0x55af9e57c98d]
> > > ./tools/perf/perf(+0x23fc9e) [0x55af9e57cc9e]
> > > ./tools/perf/perf(main+0x369) [0x55af9e4f6bc9]
> > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)
> > > [0x7fd31ef99b97]
> > > ./tools/perf/perf(_start+0x2a) [0x55af9e4f704a] Segmentation fault
> > >
> > > I can reproduce this on both x86 and ARM64.
> >
> > I don't see this with these two csets removed:
> >
> > 7ff5b5911144 perf symbols: Use CAP_SYSLOG with kptr_restrict checks
> > d7604b66102e perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid
> > checks
> >
> > Which were the ones I guessed were related to the problem you
> > reported, so they are out of my ongoing perf/core pull request to
> > Ingo/Thomas, now trying with these applied and your instructions...
>=20
> Can't repro:
>=20
> [root@quaco ~]# cat /proc/sys/kernel/kptr_restrict
> 0
> [root@quaco ~]# perf record -e instructions:k uname Linux [ perf record:
> Woken up 1 times to write data ] [ perf record: Captured and wrote 0.024 =
MB
> perf.data (1 samples) ] [root@quaco ~]# echo 1 >
> /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e instruction=
s:k
> uname Linux [ perf record: Woken up 1 times to write data ] [ perf record=
:
> Captured and wrote 0.024 MB perf.data (1 samples) ] [root@quaco ~]# echo
> 0 > /proc/sys/kernel/kptr_restrict [root@quaco ~]# perf record -e
> instructions:k uname Linux [ perf record: Woken up 1 times to write data =
] [
> perf record: Captured and wrote 0.024 MB perf.data (1 samples) ]
> [root@quaco ~]#
>=20
> [acme@quaco perf]$ git log --oneline --author Lubashev tools/
> 7ff5b5911144 (HEAD -> perf/cap, acme.korg/tmp.perf/cap,
> acme.korg/perf/cap) perf symbols: Use CAP_SYSLOG with kptr_restrict
> checks d7604b66102e perf tools: Use CAP_SYS_ADMIN with
> perf_event_paranoid checks c766f3df635d perf ftrace: Use CAP_SYS_ADMIN
> instead of euid=3D=3D0 c22e150e3afa perf tools: Add helpers to use capabi=
lities if
> present
> 74d5f3d06f70 tools build: Add capability-related feature detection perf
> version 5.3.rc4.g7ff5b5911144 [acme@quaco perf]$

I got an ARM64 cloud VM, but I cannot reproduce.
# cat /proc/sys/kernel/kptr_restrict
0

Perf trace works fine (does not die):
# ./perf trace -a

Here is my setup:
Repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
Branch: tmp.perf/cap
Commit: 7ff5b5911 "perf symbols: Use CAP_SYSLOG with kptr_restrict checks"
gcc --version: gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
uname -a: Linux arm-4-par-1 4.9.93-mainline-rev1 #1 SMP Tue Apr 10 09:54:46=
 UTC 2018 aarch64 aarch64 aarch64 GNU/Linux
lsb_release -a: Ubuntu 18.04.3 LTS

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

I also could not reproduce on x86:
lsb_release -a: Ubuntu 18.04.1 LTS
gcc --version: gcc (Ubuntu 7.4.0-1ubuntu1~18.04aka10.0.0) 7.4.0
uname -r: 4.4.0-154-generic

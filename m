Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F189C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE320656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfKZOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:41:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728332AbfKZOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:41:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQEWwVF039029
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:41:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf19xu6ev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:41:43 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Tue, 26 Nov 2019 14:41:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 14:41:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQEfUR658720358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 14:41:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0DF65204E;
        Tue, 26 Nov 2019 14:41:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7D95252052;
        Tue, 26 Nov 2019 14:41:30 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] S390 hardware compression support for kernel zlib
Date:   Tue, 26 Nov 2019 15:41:25 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19112614-0020-0000-0000-0000038F3E7E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112614-0021-0000-0000-000021E641E6
Message-Id: <20191126144130.75710-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_03:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IBM z15 mainframe the new DFLTCC instruction is available. It
implements deflate algorithm in hardware (Nest Acceleration Unit - NXU)
with estimated compression and decompression performance orders of
magnitude faster than the current zlib.

This patch-set adds s390 hardware compression support to kernel zlib.
The code is based on the userspace zlib implementation:
https://github.com/madler/zlib/pull/410
The coding style is also preserved for future maintainability.
There is only limited set of userspace zlib functions represented in
kernel. Apart from that, all the memory allocation should be performed
in advance. Thus, the workarea structures are extended with the parameter
lists required for the DEFLATE CONVENTION CALL instruction.
Since kernel zlib itself does not support gzip headers, only Adler-32
checksum is processed (also can be produced by DFLTCC facility).
Like it was implemented for userspace, kernel zlib will compress in
hardware on level 1, and in software on all other levels. Decompression
will always happen in hardware (when enabled).
Two DFLTCC compression calls produce the same results only when they
both are made on machines of the same generation, and when the
respective buffers have the same offset relative to the start of the
page. Therefore care should be taken when using hardware compression
when reproducible results are desired. However it does always produce
the standard conform output which can be inflated anyway.
The new kernel command line parameter 'dfltcc' is introduced to
configure s390 zlib hardware support:
    Format: { on | off | def_only | inf_only | always }
     on:       s390 zlib hardware support for compression on
               level 1 and decompression (default)
     off:      No s390 zlib hardware support
     def_only: s390 zlib hardware support for deflate
               only (compression on level 1)
     inf_only: s390 zlib hardware support for inflate
               only (decompression)
     always:   Same as 'on' but ignores the selected compression
               level always using hardware support (used for debugging)

The main purpose of the integration of the NXU support into the kernel zlib
is the use of hardware deflate in btrfs filesystem with on-the-fly
compression enabled. Apart from that, hardware support can also be used
during boot for decompressing the kernel or the ramdisk image 

With the patch for btrfs expanding zlib buffer from 1 to 4 pages (patch 5)
the following performance results have been achieved using the ramdisk
with btrfs. These are relative numbers based on throughput rate and
compression ratio for zlib level 1:

  Input data              Deflate rate   Inflate rate   Compression ratio
                          NXU/Software   NXU/Software   NXU/Software
  stream of zeroes        1.46           1.02           1.00
  random ASCII data       10.44          3.00           0.96
  ASCII text (dickens)    6,21           3.33           0.94
  binary data (vmlinux)   8,37           3.90           1.02

This means that s390 hardware deflate can provide up to 10 times faster
compression (on level 1) and up to 4 times faster decompression (refers to
all compression  levels) for btrfs zlib.

Disclaimer: Performance results are based on IBM internal tests using DD
command-line utility on btrfs on a Fedora 30 based internal driver in native
LPAR on a z15 system. Results may vary based on individual workload,
configuration and software levels.

Mikhail Zaslonko (5):
  lib/zlib: Add s390 hardware support for kernel zlib_deflate
  s390/boot: Rename HEAP_SIZE due to name collision
  lib/zlib: Add s390 hardware support for kernel zlib_inflate
  s390/boot: Add dfltcc= kernel command line parameter
  btrfs: Increase buffer size for zlib functions

 .../admin-guide/kernel-parameters.txt         |  12 +
 arch/s390/boot/compressed/decompressor.c      |   8 +-
 arch/s390/boot/ipl_parm.c                     |  14 +
 arch/s390/include/asm/setup.h                 |   7 +
 arch/s390/kernel/setup.c                      |   1 +
 fs/btrfs/compression.c                        |   2 +-
 fs/btrfs/zlib.c                               | 109 ++++---
 lib/Kconfig                                   |  22 ++
 lib/Makefile                                  |   1 +
 lib/decompress_inflate.c                      |  13 +
 lib/zlib_deflate/deflate.c                    |  79 ++---
 lib/zlib_deflate/deftree.c                    |  54 ----
 lib/zlib_deflate/defutil.h                    | 134 ++++++++-
 lib/zlib_dfltcc/Makefile                      |  11 +
 lib/zlib_dfltcc/dfltcc.c                      |  55 ++++
 lib/zlib_dfltcc/dfltcc.h                      | 144 +++++++++
 lib/zlib_dfltcc/dfltcc_deflate.c              | 280 ++++++++++++++++++
 lib/zlib_dfltcc/dfltcc_inflate.c              | 149 ++++++++++
 lib/zlib_dfltcc/dfltcc_syms.c                 |  17 ++
 lib/zlib_dfltcc/dfltcc_util.h                 | 124 ++++++++
 lib/zlib_inflate/inflate.c                    |  32 +-
 lib/zlib_inflate/inflate.h                    |   8 +
 lib/zlib_inflate/infutil.h                    |  18 +-
 23 files changed, 1137 insertions(+), 157 deletions(-)
 create mode 100644 lib/zlib_dfltcc/Makefile
 create mode 100644 lib/zlib_dfltcc/dfltcc.c
 create mode 100644 lib/zlib_dfltcc/dfltcc.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_syms.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_util.h

-- 
2.17.1


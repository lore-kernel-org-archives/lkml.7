Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6440C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7215206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfDYVqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:46:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388132AbfDYVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:46:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PLeZO1127116
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3n0vr5d1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Apr 2019 22:46:09 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 22:46:04 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PLk38I61145270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 21:46:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36671AE053;
        Thu, 25 Apr 2019 21:46:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5C44AE045;
        Thu, 25 Apr 2019 21:46:00 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 21:46:00 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 26 Apr 2019 00:45:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH 0/7] x86: introduce system calls addess space isolation
Date:   Fri, 26 Apr 2019 00:45:47 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19042521-0020-0000-0000-000003360BFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042521-0021-0000-0000-000021887A3B
Message-Id: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=580 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Address space isolation has been used to protect the kernel from the
userspace and userspace programs from each other since the invention of the
virtual memory.

Assuming that kernel bugs and therefore vulnerabilities are inevitable it
might be worth isolating parts of the kernel to minimize damage that these
vulnerabilities can cause.

The idea here is to allow an untrusted user access to a potentially
vulnerable kernel in such a way that any kernel vulnerability they find to
exploit is either prevented or the consequences confined to their isolated
address space such that the compromise attempt has minimal impact on other
tenants or the protected structures of the monolithic kernel.  Although we
hope to prevent many classes of attack, the first target we're looking at
is ROP gadget protection.

These patches implement a "system call isolation (SCI)" mechanism that
allows running system calls in an isolated address space with reduced page
tables to prevent ROP attacks.

ROP attacks involve corrupting the stack return address to repoint it to a
segment of code you know exists in the kernel that can be used to perform
the action you need to exploit the system.

The idea behind the prevention is that if we fault in pages in the
execution path, we can compare target address against the kernel symbol
table.  So if we're in a function, we allow local jumps (and simply falling
of the end of a page) but if we're jumping to a new function it must be to
an external label in the symbol table.  Since ROP attacks are all about
jumping to gadget code which is effectively in the middle of real
functions, the jumps they induce are to code that doesn't have an external
symbol, so it should mostly detect when they happen.

This is very early POC, it's able to run the simple dummy system calls and
a little bit beyond that, but it's not yet stable and robust enough to boot
a system with system call isolation enabled for all system calls. Still, we
wanted to get some feedback about the concept in general as early as
possible.
 
At this time we are not suggesting any API that will enable the system
calls isolation. Because of the overhead required for this, it should only
be activated for processes or containers we know should be untrusted. We
still have no actual numbers, but surely forcing page faults during system
call execution will not come for free.

One possible way is to create a namespace, and force the system calls
isolation on all the processes in that namespace. Another thing that came
to mind was to use a seccomp filter to allow fine grained control of this
feature.

The current implementation is pretty much x86-centric, but the general idea
can be used on other architectures.

A brief TOC of the set:
* patch 1 adds  definitions of X86_FEATURE_SCI
* patch 2 is the core implementation of system calls isolation (SCI)
* patches 3-5 add hooks to SCI at entry paths and in the page fault
  handler 
* patch 6 enables the SCI in Kconfig
* patch 7 includes example dummy system calls that are used to
  demonstrate the SCI in action.

Mike Rapoport (7):
  x86/cpufeatures: add X86_FEATURE_SCI
  x86/sci: add core implementation for system call isolation
  x86/entry/64: add infrastructure for switching to isolated syscall
    context
  x86/sci: hook up isolated system call entry and exit
  x86/mm/fault: hook up SCI verification
  security: enable system call isolation in kernel config
  sci: add example system calls to exercse SCI

 arch/x86/entry/calling.h                 |  65 ++++
 arch/x86/entry/common.c                  |  65 ++++
 arch/x86/entry/entry_64.S                |  13 +-
 arch/x86/entry/syscalls/syscall_64.tbl   |   3 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/processor-flags.h   |   8 +
 arch/x86/include/asm/sci.h               |  55 +++
 arch/x86/include/asm/tlbflush.h          |   8 +-
 arch/x86/kernel/asm-offsets.c            |   7 +
 arch/x86/kernel/process_64.c             |   5 +
 arch/x86/mm/Makefile                     |   1 +
 arch/x86/mm/fault.c                      |  28 ++
 arch/x86/mm/init.c                       |   2 +
 arch/x86/mm/sci.c                        | 608 +++++++++++++++++++++++++++++++
 include/linux/sched.h                    |   5 +
 include/linux/sci.h                      |  12 +
 kernel/Makefile                          |   2 +-
 kernel/exit.c                            |   3 +
 kernel/sci-examples.c                    |  52 +++
 security/Kconfig                         |  10 +
 21 files changed, 956 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/include/asm/sci.h
 create mode 100644 arch/x86/mm/sci.c
 create mode 100644 include/linux/sci.h
 create mode 100644 kernel/sci-examples.c

-- 
2.7.4


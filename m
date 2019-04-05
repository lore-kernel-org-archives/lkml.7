Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57014C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC932146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MeA+4IsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfDETgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:36:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731183AbfDETgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:21 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JWmHb028559
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Kaicfh5aC3qjM76NoAVCCtU2C/58HML7p6YGjuNMBts=;
 b=MeA+4IsFYzHar9jt1n2zATY2u1GOXuU4mnKUWt+zXtx0DJS2+T/fWQ7P7ejMjJ08a4hJ
 Njo9T8bu61yEERgbUC5h3XXHuwGZpVGwNP3HKDjmH1zKmZiUsJi5GlEaOr5yL4Kjr4Eu
 Lmk1UkepfRtXz1yu1tepzW7oQSUOn9dsUyI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpbqc0c2w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:20 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:19 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 1BF3B3701752; Fri,  5 Apr 2019 12:36:19 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <netdev@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <guro@fb.com>, <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Date:   Fri, 5 Apr 2019 12:35:22 -0700
Message-ID: <cover.1554485409.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
- simplify C based selftests by relying on variable offset stack access.

v1->v2:
- add fs/proc/proc_sysctl.c mainteners to Cc:.

The patch set introduces new BPF hook for sysctl.

It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
BPF_CGROUP_SYSCTL.

BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
that accesses (read/write) to sysctl can be controlled for specific cgroup
and either allowed or denied, or traced.

The hook has access to sysctl name, current sysctl value and (on write
only) to new sysctl value via corresponding helpers. New sysctl value can
be overridden by program. Both name and values (current/new) are
represented as strings same way they're visible in /proc/sys/. It is up to
program to parse these strings.

To help with parsing the most common kind of sysctl value, vector of
integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
semantic similar to user space strtol(3) and strtoul(3).

The hook also provides bpf_sysctl context with two fields:
* @write indicates whether sysctl is being read (= 0) or written (= 1);
* @file_pos is sysctl file position to read from or write to, can be
  overridden.

The hook allows to make better isolation for containerized applications
that are run as root so that one container can't change a sysctl and affect
all other containers on a host, make changes to allowed sysctl in a safer
way and simplify sysctl tracing for cgroups.

Patch 1 is preliminary refactoring.
Patch 2 adds new program and attach types.
Patches 3-5 implement helpers to access sysctl name and value.
Patch 6 adds file_pos field to bpf_sysctl context.
Patch 7 updates UAPI in tools.
Patches 8-9 add support for the new hook to libbpf and corresponding test.
Patches 10-14 add selftests for the new hook.
Patch 15 adds support for new arg types to verifier: pointer to integer.
Patch 16 adds bpf_strto{l,ul} helpers to parse integers from sysctl value.
Patch 17 updates UAPI in tools.
Patch 18 updates bpf_helpers.h.
Patch 19 adds selftests for pointer to integer in verifier.
Patches 20-21 add selftests for bpf_strto{l,ul}, including integration
              C based test for sysctl value parsing.


Andrey Ignatov (21):
  bpf: Add base proto function for cgroup-bpf programs
  bpf: Sysctl hook
  bpf: Introduce bpf_sysctl_get_name helper
  bpf: Introduce bpf_sysctl_get_current_value helper
  bpf: Introduce bpf_sysctl_{get,set}_new_value helpers
  bpf: Add file_pos field to bpf_sysctl ctx
  bpf: Sync bpf.h to tools/
  libbpf: Support sysctl hook
  selftests/bpf: Test sysctl section name
  selftests/bpf: Test BPF_CGROUP_SYSCTL
  selftests/bpf: Test bpf_sysctl_get_name helper
  selftests/bpf: Test sysctl_get_current_value helper
  selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers
  selftests/bpf: Test file_pos field in bpf_sysctl ctx
  bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types
  bpf: Introduce bpf_strtol and bpf_strtoul helpers
  bpf: Sync bpf.h to tools/
  selftests/bpf: Add sysctl and strtoX helpers to bpf_helpers.h
  selftests/bpf: Test ARG_PTR_TO_LONG arg type
  selftests/bpf: Test bpf_strtol and bpf_strtoul helpers
  selftests/bpf: C based test for sysctl and strtoX

 fs/proc/proc_sysctl.c                         |   25 +-
 include/linux/bpf-cgroup.h                    |   21 +
 include/linux/bpf.h                           |    4 +
 include/linux/bpf_types.h                     |    1 +
 include/linux/filter.h                        |   16 +
 include/uapi/linux/bpf.h                      |  139 +-
 kernel/bpf/cgroup.c                           |  364 +++-
 kernel/bpf/helpers.c                          |  131 ++
 kernel/bpf/syscall.c                          |    7 +
 kernel/bpf/verifier.c                         |   30 +
 tools/include/uapi/linux/bpf.h                |  139 +-
 tools/lib/bpf/libbpf.c                        |    3 +
 tools/lib/bpf/libbpf_probes.c                 |    1 +
 tools/testing/selftests/bpf/Makefile          |    3 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   19 +
 .../selftests/bpf/progs/test_sysctl_prog.c    |   70 +
 .../selftests/bpf/test_section_names.c        |    5 +
 tools/testing/selftests/bpf/test_sysctl.c     | 1567 +++++++++++++++++
 .../testing/selftests/bpf/verifier/int_ptr.c  |  160 ++
 19 files changed, 2697 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c

-- 
2.17.1


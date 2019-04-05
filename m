Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EDC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856E320B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FSM6xoLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDEX4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:56:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfDEX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:56:03 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35NsAN5023406;
        Fri, 5 Apr 2019 16:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=XO7pEgNNgDdwgj+Bcm3dgvjR/kMarNQKtlAomW9Abfc=;
 b=FSM6xoLOcqSG47yDgmCv5GMUeY26kCH4c+ZuNryRg8CU3xFD0HdISYgh1xe2inDaW7e1
 oKf9DmgUAwNcFuO9Gmqsdtzx1TwUe8ZTD1lM1+2bqqGFZbMOzsHuHl44UOv2mLQY9goX
 i7Ify7rzUPrruljl6/D4nyMQpxQjrpNP2Xg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpf288chw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 16:55:42 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 5 Apr 2019 16:55:39 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <hall@fb.com>, <mmullins@fb.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>
Subject: [PATCH bpf-next v2 0/5] writable contexts for bpf raw tracepoints
Date:   Fri, 5 Apr 2019 16:55:01 -0700
Message-ID: <20190405235506.29236-1-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c0a1:3::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an opt-in interface for tracepoints to expose a writable context to
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs that are attached, while
supporting read-only access from existing BPF_PROG_TYPE_RAW_TRACEPOINT
programs, as well as from non-BPF-based tracepoints.

The initial motivation is to support tracing that can be observed from the
remote end of an NBD socket, e.g. by adding flags to the struct nbd_request
header.  Earlier attempts included adding an NBD-specific tracepoint fd, but in
code review, I was recommended to implement it more generically -- as a result,
this patchset is far simpler than my initial try.

v1->v2:
  * add selftests
    * sync tools/include/uapi/linux/bpf.h
  * reject variable offset into the buffer
  * add string representation of PTR_TO_TP_BUFFER to reg_type_str

Andrew Hall (1):
  nbd: add tracepoints for send/receive timing

Matt Mullins (4):
  bpf: add writable context for raw tracepoints
  nbd: trace sending nbd requests
  tools: sync bpf.h
  selftests: bpf: test writable buffers in raw tps

 MAINTAINERS                                   |   1 +
 drivers/block/nbd.c                           |  13 ++
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/tracepoint-defs.h               |   1 +
 include/trace/bpf_probe.h                     |  27 +++-
 include/trace/events/bpf_test_run.h           |  50 ++++++
 include/trace/events/nbd.h                    | 148 ++++++++++++++++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         |  31 ++++
 kernel/trace/bpf_trace.c                      |  21 +++
 net/bpf/test_run.c                            |   4 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../raw_tp_writable_reject_nbd_invalid.c      |  40 +++++
 .../bpf/prog_tests/raw_tp_writable_test_run.c |  80 ++++++++++
 .../selftests/bpf/verifier/raw_tp_writable.c  |  34 ++++
 19 files changed, 461 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/bpf_test_run.h
 create mode 100644 include/trace/events/nbd.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
 create mode 100644 tools/testing/selftests/bpf/verifier/raw_tp_writable.c

-- 
2.17.1


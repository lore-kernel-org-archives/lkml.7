Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DAEC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003FD21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="at/I9UAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfC2AIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:08:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45138 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfC2AIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:08:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T000P7004256
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=3gkbfMJOneKV06XXP2I7GAO/385zTkTpsosCzIwinO8=;
 b=at/I9UAW4sQEBwttrECxQxGncyWJUj+MNQrzsxhigkg4zAQv7L6qYLxBGDYycuqsPo+d
 r7QvFZL42gHg8/BBtotinHzVhzVKM7+3LnKqGd+4FZqt5BEcY9a4aILP6inzZ7XLNcLC
 NDIRgSqIPKa2TBKgNbzHbapeVjPyPo8Kcac= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rh3171v2g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:08:34 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Mar 2019 17:08:32 -0700
Received: by dev003.prn2.facebook.com (Postfix, from userid 572441)
        id 6728B364575B; Thu, 28 Mar 2019 17:08:31 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Matt Mullins <mmullins@fb.com>
Smtp-Origin-Hostname: dev003.prn2.facebook.com
To:     <hall@fb.com>, <mmullins@fb.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/3] writable contexts for bpf raw tracepoints
Date:   Thu, 28 Mar 2019 17:07:55 -0700
Message-ID: <20190329000758.494762-1-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_15:,,
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

Andrew Hall (1):
  nbd: add tracepoints for send/receive timing

Matt Mullins (2):
  bpf: add writable context for raw tracepoints
  nbd: trace sending nbd requests

 MAINTAINERS                     |   1 +
 drivers/block/nbd.c             |  13 +++
 include/linux/bpf.h             |   2 +
 include/linux/bpf_types.h       |   1 +
 include/linux/tracepoint-defs.h |   1 +
 include/trace/bpf_probe.h       |  27 +++++-
 include/trace/events/nbd.h      | 148 ++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h        |   1 +
 kernel/bpf/syscall.c            |   8 +-
 kernel/bpf/verifier.c           |  11 +++
 kernel/trace/bpf_trace.c        |  21 +++++
 11 files changed, 230 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/nbd.h

-- 
2.17.1


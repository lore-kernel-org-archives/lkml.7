Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447020811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KOqtSGfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCNSZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:25:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53020 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727229AbfCNSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:25:45 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIEvIS009079
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=n28j6nh3lFBSHB8IRuS9jidfnodumZxnJPJHrdAGBwU=;
 b=KOqtSGfS9TWuSy1Uxk21dZ4dON7gYeXd+KNTE2po5U6g8jsTygqOPT4xsD+NHC3IbcxH
 ilpkpskUlbB6hHVRNdpA4k8c1TMCmM3mNC9F+3Dc3nfiPjbCC3W1qbm+EoLsaUWibPmh
 CtlEP8n6g9VcFsIDgqFRRkRPCEHI1853n/Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7h3g28kw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:44 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 14 Mar 2019 11:25:43 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CF9A662E1D1C; Thu, 14 Mar 2019 11:25:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH perf,bpf 0/2] show bpf program info from perf.data header
Date:   Thu, 14 Mar 2019 11:25:35 -0700
Message-ID: <20190314182538.1294526-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set enables printing name, address, and size of bpf programs stored
in perf.data file.

This set applies on top of https://lkml.org/lkml/2019/3/12/39 and the
uintptr_t fix (https://lkml.org/lkml/2019/3/14/624).

Thanks!

Song Liu (2):
  perf, bpf: refactor perf_event__synthesize_one_bpf_prog()
  perf, bpf: show BPF program name in print_bpf_prog_info()

 tools/perf/util/bpf-event.c | 96 +++++++++++++++++++++++++++----------
 tools/perf/util/bpf-event.h | 10 +++-
 tools/perf/util/header.c    |  5 +-
 3 files changed, 82 insertions(+), 29 deletions(-)

--
2.17.1

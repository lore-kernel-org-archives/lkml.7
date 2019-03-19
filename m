Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41E20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XAkFNDJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCSQzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:55:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbfCSQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:55:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JGsw6U030808
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kjrIyinGEmYU8C0T0ynJmw6/RNl4jcQUr2v1ebiwFyc=;
 b=XAkFNDJbU+f7JrR9Hg7mBky5lw21eeEna0TQkk2T3XFgoPr1FH0vWwK+AOA9zx+eEJEn
 iAxmMHLirqkEDYiOdHrBFW+phdddUvlqPv3u/62s3VbwTyTrD3kTbDfRmVoaIxCskvoR
 s2h3otHZkLN2ICAgQVYWehEUpBren5IXR0o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rb103gw7d-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:01 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 19 Mar 2019 09:54:58 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 08FA962E1F1B; Tue, 19 Mar 2019 09:54:57 -0700 (PDT)
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
Subject: [PATCH v2 perf,bpf 0/2] show bpf program info from perf.data header
Date:   Tue, 19 Mar 2019 09:54:52 -0700
Message-ID: <20190319165454.1298742-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v1 -> v2:
1. Rebase on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=23265467966555a7c379263369362d576d513643

This set enables printing name, address, and size of bpf programs stored
in perf.data file.

Thanks!

Song Liu (2):
  perf, bpf: refactor perf_event__synthesize_one_bpf_prog()
  perf, bpf: show more BPF program info in print_bpf_prog_info()

 tools/perf/util/bpf-event.c | 102 ++++++++++++++++++++++++++----------
 tools/perf/util/bpf-event.h |  10 +++-
 tools/perf/util/header.c    |   5 +-
 3 files changed, 87 insertions(+), 30 deletions(-)

--
2.17.1

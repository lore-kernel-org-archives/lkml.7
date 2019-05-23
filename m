Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EB8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A448620851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QrLRIfHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfEWTqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:46:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389327AbfEWTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:46:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NJguHc006984
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:46:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=1dJ4AOqI7Vb5uxtGciryBBpr5z5NcrrzB+SsZr5O+/U=;
 b=QrLRIfHSf86jnlYF71TU6L5NTcXbSoN6ZBYybFJdPfV4PpRN+T9codlvhhBEibQlFycI
 q0Hop9wVQbXyud0jCaKqjWQE+lppQ5UcsI/+Z/6zy0ziAvJVoqFg57pvrHSpJXav5/od
 PGwbbssvyEKI3KB1lwNNHlYn+ZFlg7/HR/k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2snuq59gg2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:46:15 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 May 2019 12:46:10 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4B0F2125B047E; Thu, 23 May 2019 12:45:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 0/4] cgroup bpf auto-detachment
Date:   Thu, 23 May 2019 12:45:28 -0700
Message-ID: <20190523194532.2376233-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230128
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements a cgroup bpf auto-detachment functionality:
bpf programs are detached as soon as possible after removal of the
cgroup, without waiting for the release of all associated resources.

Patches 2 and 3 are required to implement a corresponding kselftest
in patch 4.

v3:
  1) some minor changes and typo fixes

v2:
  1) removed a bogus check in patch 4
  2) moved buf[len] = 0 in patch 2


Roman Gushchin (4):
  bpf: decouple the lifetime of cgroup_bpf from cgroup itself
  selftests/bpf: convert test_cgrp2_attach2 example into kselftest
  selftests/bpf: enable all available cgroup v2 controllers
  selftests/bpf: add auto-detach test

 include/linux/bpf-cgroup.h                    |   8 +-
 include/linux/cgroup.h                        |  18 +++
 kernel/bpf/cgroup.c                           |  25 ++-
 kernel/cgroup/cgroup.c                        |  11 +-
 samples/bpf/Makefile                          |   2 -
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  57 +++++++
 .../selftests/bpf/test_cgroup_attach.c        | 146 ++++++++++++++++--
 8 files changed, 243 insertions(+), 28 deletions(-)
 rename samples/bpf/test_cgrp2_attach2.c => tools/testing/selftests/bpf/test_cgroup_attach.c (79%)

-- 
2.20.1


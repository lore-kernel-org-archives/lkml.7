Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C60AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F720656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DXYVVDna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDZSAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:00:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44834 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfDZR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:59:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QHjkQ3007872
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=I69yex02ZDfSNGZEwjXGsGyUJRCnW8gVyFqR8Q8tfUU=;
 b=DXYVVDnaj6nQj536siLMon43I6/AKsE16SGOuP0BGyR65THbS6q1r7k5p0U6a8URfBu5
 jNCoslGyZxHWSUbNZFc0bLRuZhzSm8XZQi8uvNRVa6ES4baplpiDiXn5tEeUyUOo575e
 nWhFCU+UHBJwg/C7okCo3HGcJzJBvvuMHTo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3uwmj13b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:53 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 10:59:50 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 5E497115F37BC; Fri, 26 Apr 2019 10:59:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 0/2] cgroup v2 freezer follow-up patches
Date:   Fri, 26 Apr 2019 10:59:43 -0700
Message-ID: <20190426175945.2559865-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=687 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tejun!

Please, pull these two follow-up patches for the cgroup v2 freezer.

These are a fix for a spurious state transition, which could happen
due to a race condition, and a cleanup of some dead code. Both patches
were suggested by Oleg Nesterov.

Thank you!


Roman Gushchin (2):
  cgroup: prevent spurious transition into non-frozen state
  cgroup: get rid of cgroup_freezer_frozen_exit()

 include/linux/cgroup.h  |  2 +-
 kernel/cgroup/cgroup.c  |  5 ++---
 kernel/cgroup/freezer.c | 26 +++++---------------------
 kernel/signal.c         |  2 +-
 4 files changed, 9 insertions(+), 26 deletions(-)

-- 
2.20.1


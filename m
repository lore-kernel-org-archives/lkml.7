Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A13C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097422184D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cWbc/657"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfHLW3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:29:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbfHLW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:29:18 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7CMTHZr029599
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=qiofHP19MlmvHdnj3l6VS7qqrTUvd1N7ucXGb2hoq9Y=;
 b=cWbc/657cZcEAPWc56tMtbVX3CK9tBi+AGft2GYziIy8AZ1v/UMfBB+t9JX5quMd5O9s
 d5HrnmFO1XrJ7ILnOYgFPikSOL9cEBAnaoQPzl0qWHVhWOA1h7yIOjrfLup1VgnWji4e
 xiGax47wfqKNW4h6WslxAFzcyDDj1Ng2pCk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ubbe5hkaw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:17 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 15:29:15 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 182E9163FCBF4; Mon, 12 Aug 2019 15:29:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 0/2] flush percpu vmstats
Date:   Mon, 12 Aug 2019 15:29:09 -0700
Message-ID: <20190812222911.2364802-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=554 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on v2 of the slabs vmstats flushing patch, I've realized
the the problem is much more generic and affects all vmstats, not only
slabs. So the patch has been converted to set of 2.

v2:
  1) added patch 1, patch 2 rebased on top
  2) s/for_each_cpu()/for_each_online_cpu() (by Andrew Morton)

Roman Gushchin (2):
  mm: memcontrol: flush percpu vmstats before releasing memcg
  mm: memcontrol: flush percpu slab vmstats on kmem offlining

 mm/memcontrol.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

-- 
2.21.0


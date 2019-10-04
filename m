Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D8DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7A21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJDK6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfJDK6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B278AB89;
        Fri,  4 Oct 2019 10:57:59 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 0/5] Optimize single thread migration
Date:   Fri,  4 Oct 2019 12:57:38 +0200
Message-Id: <20191004105743.363-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The important part is the patch 02 where the reasoning is.

The rest is mostly auxiliar and split out into separate commits for
better readability.

The patches are based on v5.3. 

Michal


Michal Koutný (5):
  cgroup: Update comments about task exit path
  cgroup: Optimize single thread migration
  selftests: cgroup: Simplify task self migration
  selftests: cgroup: Add task migration tests
  selftests: cgroup: Run test_core under interfering stress

 kernel/cgroup/cgroup-internal.h               |   5 +-
 kernel/cgroup/cgroup-v1.c                     |   5 +-
 kernel/cgroup/cgroup.c                        |  68 ++++----
 tools/testing/selftests/cgroup/Makefile       |   4 +-
 tools/testing/selftests/cgroup/cgroup_util.c  |  42 ++++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   6 +-
 tools/testing/selftests/cgroup/test_core.c    | 146 ++++++++++++++++++
 tools/testing/selftests/cgroup/test_freezer.c |   2 +-
 tools/testing/selftests/cgroup/test_stress.sh |   4 +
 tools/testing/selftests/cgroup/with_stress.sh | 101 ++++++++++++
 10 files changed, 342 insertions(+), 41 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_stress.sh
 create mode 100755 tools/testing/selftests/cgroup/with_stress.sh

-- 
2.21.0


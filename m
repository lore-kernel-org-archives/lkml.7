Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282C2063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897718;
	bh=nl69/LqSZ0ikgE119j+nbVp0VMyf7XDQgB3bsfKeOZY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1s3/Q67xOxzoP+1QvyWypfjWDz0dCTUQmsmwujE9MnlRGcQAp7y2GmfyzaH3EBEjS
	 eYILQjtr5k9CTcDylKpI0H/HCs5WOWCXYutU8MJbq445uAWY2vIrgYgIoJq4DStH2y
	 E83mZeBVwfcBr6iIbOLzu4ycry+NUQs/4m2HJY/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCFSl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:41:57 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43479 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCFSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:41:57 -0500
Received: by mail-yw1-f68.google.com with SMTP id u200so10847652ywu.10;
        Wed, 06 Mar 2019 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wWCXir4r1pXpp0Hmlieqg9dse5cFF3K/PCHaVFhMfhQ=;
        b=tRFLglF0sRpWn57v0VTg/oj/p1a+1b2gTkJcO76E9XuUyIu1KSElPmoDfq+o5uo+2Z
         HEKfjhTMkBEO7AY14hcLp8M12DnSF8HP7LTWLOALgLYKoAAXoerB0IjirLdFxWxnZwPN
         GkExV8yLjuT3HwlLs1nuJfdJU1C0Vu4MvtHk+tch5PtjVkTteupp3cH5HAO4uCePDy7w
         EggH+bUSFlHd8dRaG9jdViZhR26eqj43gQ5A+zTOG3aD0XiHn+LJgf8XG6oJ/ZzwMJvw
         K4t36jIyNtk6PQDigVaWwf2Xog3PENqkgB31LsJEbqiZVcyafHnAPzay4aKM/8Xvkl/h
         MZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wWCXir4r1pXpp0Hmlieqg9dse5cFF3K/PCHaVFhMfhQ=;
        b=hACwLNLUBzc5Gq+4Pw6xiOnIHLm9nGzHX5dmGGwb288WjtDV0lsjvUiDahXhk805TR
         IxbeVikVJW51SjOfvA9AfsbxanaSLyxXyVYgG2fut8EsQ7PfNvIfG/SUutYR5NEUhN58
         ohlhTYolziPcH2R/ArHqv00MYPxjEKwfXalcoXoxiQw68rOpQxYw86McMmdrI+7GZj90
         lYPQEuP3Vkz4fTNmuiqQ2ctI4lgP7EAKG+n/fPSSFD7k7egG+whHcCUmWCimb01JQ+ip
         xKHXUFQQJKowlxrUSIwOmALMymVmr3BerAyFSG2vAe6M1e5e2iQDSExijsBuvuPsAPE4
         67nw==
X-Gm-Message-State: APjAAAV4eBZ9bV6qPv0qgdfuK2UZoEzPxap2ifoorWZWJKc+DV3/DF1S
        Tj/J7iFCnRv6KYEO3cSKG//iQjyG
X-Google-Smtp-Source: APXvYqzqSDrHavDiJpJjXptB2uVZfl93ZjjJk6xRoO8jP7wsDd0t9++60KWY4VuiKMO7Oyc+WZaDLA==
X-Received: by 2002:a25:3f45:: with SMTP id m66mr6812907yba.238.1551897715885;
        Wed, 06 Mar 2019 10:41:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::2:a2f4])
        by smtp.gmail.com with ESMTPSA id l16sm885560ywk.39.2019.03.06.10.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:41:55 -0800 (PST)
Date:   Wed, 6 Mar 2019 10:41:53 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.1-rc1
Message-ID: <20190306184153.GI50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

* Oleg's pids controller accounting update which gets rid of rcu delay
  in pids accounting updates.

* rstat (cgroup hierarchical stat collection mechanism) optimization.

* Doc updates.

Thanks.

The following changes since commit af0c9af1b3f66052c369d08be3f60fa9a9559e48:

  fs/dcache: Track & report number of negative dentries (2019-01-30 11:02:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1

for you to fetch changes up to 6a613d24effcb875271b8a1c510172e2d6eaaee8:

  cpuset: remove unused task_has_mempolicy() (2019-02-19 06:26:02 -0800)

----------------------------------------------------------------
Andrea Parri (1):
      MAINTAINERS: Update cgroup entry

Masahiro Yamada (1):
      cpuset: remove unused task_has_mempolicy()

Oleg Nesterov (1):
      cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting

Randy Dunlap (1):
      Documentation: cgroup-v2: eliminate markup warnings

Tejun Heo (1):
      cgroup, rstat: Don't flush subtree root unless necessary

Tibor Billes (1):
      cgroup: add documentation for pids.events file

 Documentation/admin-guide/cgroup-v2.rst |  2 +-
 Documentation/cgroup-v1/pids.txt        |  3 +++
 MAINTAINERS                             |  5 +++--
 include/linux/cgroup-defs.h             |  2 +-
 include/linux/cgroup.h                  |  2 ++
 kernel/cgroup/cgroup.c                  | 15 +++++++++------
 kernel/cgroup/cpuset.c                  | 13 -------------
 kernel/cgroup/pids.c                    |  4 ++--
 kernel/cgroup/rstat.c                   | 10 ++++++----
 kernel/exit.c                           |  1 +
 10 files changed, 28 insertions(+), 29 deletions(-)

-- 
tejun

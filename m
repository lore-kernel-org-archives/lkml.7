Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15801FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C9E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230227;
	bh=t6+Yi230ePDkx55/7+saV7KkN358tyb4fBjNfTzWW7s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Z+Ja1VMZCereGORxt+s4LM5l3PSkM5jCW8Tt6FAl2d3/TKbaXceYILec5YmT4X4z/
	 J3dp+uAeRucQRsIAOCUPhRWITPfA+SRzU+qOq4PPSKWEEqYXbfslQHHXKFUwGI2u6u
	 N133pNLnIScTrjW6+Bh59SVvcIxm0Sg2LTN1hAJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393283AbfJPMu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:50:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36649 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJPMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:50:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so11241974plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ft7HBSmYOZNHpk5Bnm5Rvli5UhVaBHuSIgLdkON0UFI=;
        b=TSXf0j1dRJOAPyX+8XFXTXU26w+vW+BzorZMlS6SoK9stHKLeh9ylkttC8C8PZX2nX
         sJyuc9LGuVmOy6Ib3iW1jNVHZi+s3+Jlk+H/mRCs43Vm7Bn7NtzsK+5sLo7tZh5Gaaqb
         eb7naQSJU3xNpx2HZY2BCvvDsGHwoBeN3UE4gYWFHPuqh3zIHf7zA23emF4ZSS9g1l3o
         8AhrMRr2CLeFqKHY2qobwklBTVqNcUtdj7cJnRqvOt3qw7BSnwqFShYgnMaDLYsFiMzN
         OVTVC06yUIyZMQVdLgYFzz+H+1bwPjggzn2duQlgZsqzYJCCOWQEXu4FnfIGUWAPBr2q
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ft7HBSmYOZNHpk5Bnm5Rvli5UhVaBHuSIgLdkON0UFI=;
        b=LMyOTT17xmyM/X06oiykXbeF9mZNS3GD48n8KgukgQTZmgHMKRSVApqztRa35tXnUO
         DKoYpjYjVIX3riaDgm3EOFnmCLod1rvuDZx5sU6j9VYBAg6t9NoOd76BfJEwgPOHRsb4
         p4WKkiRuS4A6B9UfrhvFVEGIyVAf2JtZx6tqt4cYLFXUvL60MKqd8LsbeH8ihonrh9Sr
         2ET3PeCPf0tXBUmoJSKMKjGgmmdlbRWJwxClqCNgKHmafCNhAIX3JUTGSNxZ/pILXBcv
         LmYXPssNkzERIzsRrYu+tGTGH8bGa2ok3ZEUf0T+xHkEPuwVeey/y2Xm0mnmm+6BcJ9B
         E1QQ==
X-Gm-Message-State: APjAAAX0BaAlueeiRR6kd7LAs0r+bwYmJ/VveyzdXGRrGGxuP+88ia+y
        FACf7TFJdAVKxvxu2HUQcso=
X-Google-Smtp-Source: APXvYqzu9ZsgVuJ2AcK4h8U7MnFoopmGDyKUgn4rjBxrrgYSiNd7czvhbB4cSIX+LIBalwyiaEqaHw==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr38079190plo.77.1571230225450;
        Wed, 16 Oct 2019 05:50:25 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id j17sm24010620pfr.70.2019.10.16.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:50:24 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: [PATCH 0/2] cgroup: Sync cgroup id and inode number
Date:   Wed, 16 Oct 2019 21:50:17 +0900
Message-Id: <20191016125019.157144-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset changes cgroup inode number and id management to be in
sync with kernfs.  Currently cgroup inode is managed by kernfs while
cgroup id is allocated by its own idr.  And kernfs/cgroup file handle
uses inode and generation numbers.  So I added generation number to
cgroup and pass the numbers to kernfs.

The background of this work is that I want to add cgroup sampling
feature in the perf event subsystem.  As Tejun mentioned that using
cgroup id is not enough and it'd better using file handle instead.
But getting file handle in perf NMI handler is not possible so I want
to get the info from a cgroup node.

The first patch added generation number to cgroup and the second patch
allows kernfs node created with external generation and inode numbers.

The patches are based on the for-next branch in Tejun's cgroup tree.
Tested with tools/testing/selftests/cgroup/test_stress.sh.

Thanks
Namhyung


Namhyung Kim (2):
  cgroup: Add generation number with cgroup id
  kernfs: Allow creation with external gen + ino numbers

 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +-
 fs/kernfs/dir.c                        | 63 +++++++++++++++++------
 fs/kernfs/file.c                       |  9 ++--
 fs/kernfs/kernfs-internal.h            |  5 ++
 fs/sysfs/file.c                        |  2 +-
 include/linux/cgroup-defs.h            | 12 ++++-
 include/linux/kernfs.h                 | 25 ++++++---
 kernel/cgroup/cgroup.c                 | 70 +++++++++++++++++++-------
 8 files changed, 143 insertions(+), 47 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog


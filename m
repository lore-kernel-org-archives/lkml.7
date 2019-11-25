Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFE9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E954720836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574697800;
	bh=FSGAk9KgvmyVw1nMtBIX6LFrDe1T9kVqW3Ghh2NhhAE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ApdRJfL5EYrWuqhdG+xr8CYTeZhTboCzrAaE2f1/zvhxk5tt58mVd/Jl90MBTtE0c
	 8cCjcRrSxo0rqBD5GrOjTC+Hk/idFyNJN73r0SbKUyBCFcF5vGFxDdBO+9qz6N9SpC
	 j1z6hzmFNMTKMIBdSlqviMBQGbyKLBXD80lsx2tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfKYQDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:03:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44594 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfKYQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:03:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so13149083qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FCTsFGWHiKUPQf+HSaWNOb4AIF2C3CGsA200RO79UTM=;
        b=N1E6U3cjv/bzW4v5I9GI7D7m12C3uvCn/tubwqLrOnS1pSEAJ6UJeMylxAa1gtvxI2
         89txYS4GgC+CdnXdaarJM6gY1N7JDuKI8ZPpp8V5yR8K4ImBwCKgrapd9tz/0i712oWF
         Njaxg4vP4Wpt8cOruoxJr181eSVrcW7T2FwVZs+C4MU2r6wF1Fav43FbOgnly8M4O0fe
         6oQnZokA6JUtLk4UxSaVHrrrNmG71eJ6nC9+jRg4Qm7p/0Y53mqTo2U5cqddLj+FxkQY
         pjWYlcfGYYOhtwAP2+Vs0uoSKflAegaYJuJkVXG1CZQq9/yZAMmec7PwUz1u6k3/7Q8S
         oB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FCTsFGWHiKUPQf+HSaWNOb4AIF2C3CGsA200RO79UTM=;
        b=j8ejCqstze4E4h1FJkWNVRbCf0GIBUvygZ3mZP930h4n0H//I5gQazu+DCRadJkuXX
         bPwpHCDXhz88BFNofxMJpepPGc5HTs3W2JiB7WhZAptao6uRGz4Bx8zKwFpLAm39/ozW
         B0DQGqnc3YRnHqZiGyJne+aEbQv+kU77MDU3LG9AGy+02NNUWikJnZdbJjZfu93dfi5V
         m+Kme19ybOcVlDE+AR0msoqelmATxqBw5Rs8U7LJKMDYHuhZcmBw0oWizpoI7oC5/n0C
         8Elb9dYwfignqgIA7V5UhRkytuvQRDZdVrVtPSu29GPPlxnr8rRZTPr/H7K66cqQDTm3
         k/Bg==
X-Gm-Message-State: APjAAAXFXeulOdpNJoaOLMBbB7vecLsntlbMNQRcSnupohV+Oq4TT3Hg
        AqQAeJhJbFjVjDIwEC79pDc=
X-Google-Smtp-Source: APXvYqw0ey9kIphNGSFLxnwuDw6FbjaQuCxg3/W2ecZs5R9E/4fKksZNmmxqNNaB+rNFJVBYBpDwdA==
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr16666227qkj.227.1574697796864;
        Mon, 25 Nov 2019 08:03:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2f2e])
        by smtp.gmail.com with ESMTPSA id x10sm4175003qtj.25.2019.11.25.08.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:03:16 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:03:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.5-rc1
Message-ID: <20191125160314.GB2867037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There have been sporadic reports of sanity checks in
destroy_workqueue() failing spuriously over the years.  This pull
request contains the fix and its follow-up changes / fixes.  There's
also a RCU annotation improvement.

Thanks.

The following changes since commit f60c55a94e1d127186566f06294f2dadd966e9b4:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt (2019-09-18 16:59:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.5

for you to fetch changes up to 49e9d1a9faf2f71fdfd80a30697ee9a15070626d:

  workqueue: Add RCU annotation for pwq list walk (2019-11-15 11:53:35 -0800)

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      workqueue: Add RCU annotation for pwq list walk

Tejun Heo (5):
      workqueue: Fix spurious sanity check failures in destroy_workqueue()
      workqueue: Fix missing kfree(rescuer) in destroy_workqueue()
      workqueue: Minor follow-ups to the rescuer destruction change
      workqueue: more destroy_workqueue() fixes
      workqueue: Fix pwq ref leak in rescuer_thread()

 kernel/workqueue.c | 90 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 25 deletions(-)

-- 
tejun

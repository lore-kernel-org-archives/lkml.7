Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2102CC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 04:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81A6217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 04:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562991460;
	bh=ph3XGw6zau8X7bpAQOSEspvlOSAR6gSBpgZlxzoeHtg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lNN0WQ8C+ZOP3JXwlzTpS4MzaGlTVAzcZoAXTM1XmyPKqhu+imRV/G97BYVlXkivM
	 8wztR6hxFIcaSzjGEKDbM4siU4w3pMa32hGws7123FjjWfiO+DrQoUtLejJauBKCds
	 pwiILDjaKWhEiRlUPjrJHe/QGu7g7d/7htc8D7HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGMERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 00:17:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41081 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfGMERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 00:17:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so10346588qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 21:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IZTj4o3sxVMCsyfX3m8CbohJzz9KCaUXTlmAkCHs5I0=;
        b=jvyVLePiuMQFoAVCJhpzWHI3T8BlMnqFfvxpbke/BKgcOKsBG9DJHuDx6dwAjr09XA
         nVQJq9UpAwIkw5IKP/YIytnyJtNjNawJg4oh1CBKMicnld8XDZkXSWS4Zg6cEW4//vK7
         997SUPAlD5N5ZrMNa4alYRlm9sSR/BqJNilcnRJyhCQQh3JxXbrS9iqmmEdeecw0rzFz
         51GJDsdDz3x+rN5uNJreSwCnEhPZVyy7/EAlXEx/5iWLpHqyYjSr0IC3ePEMzO2mqfKA
         RhO3HbtQGxLsNACHcktxbegm+E4ayvmQGT+PhmG7MbP1DfwY57xUddoezCGWW5lFCyWH
         mX/w==
X-Gm-Message-State: APjAAAUmEUmqvOOWI3yx1Fl/XbggmDSHuQWAInE6XN16n7cgtSW6ntup
        WoVub2rW4NiOobPCpE3uZ1M=
X-Google-Smtp-Source: APXvYqxF1eYLVsY7QeuSzeHGr+KUu5nGWsxiirKYW9tnKHKk/OymrIHBXCN1OjwFRiJwthcJobLE3Q==
X-Received: by 2002:ac8:27db:: with SMTP id x27mr9635952qtx.4.1562991457525;
        Fri, 12 Jul 2019 21:17:37 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::da5d])
        by smtp.gmail.com with ESMTPSA id n18sm4379525qtr.28.2019.07.12.21.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 21:17:36 -0700 (PDT)
Date:   Sat, 13 Jul 2019 00:17:33 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.3-rc1
Message-ID: <20190713041733.GA80860@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request includes changes to let percpu_ref release the backing
percpu memory earlier after it has been switched to atomic in cases
where the percpu ref is not revived. This will help recycle percpu
memory earlier in cases where the refcounts are pinned for prolonged
periods of time.

Thanks,
Dennis

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.3

for you to fetch changes up to 7d9ab9b6adffd9c474c1274acb5f6208f9a09cf3:

  percpu_ref: release percpu memory early without PERCPU_REF_ALLOW_REINIT (2019-05-09 10:51:06 -0700)

----------------------------------------------------------------
Roman Gushchin (4):
      percpu_ref: introduce PERCPU_REF_ALLOW_REINIT flag
      io_uring: initialize percpu refcounters using PERCU_REF_ALLOW_REINIT
      md: initialize percpu refcounters using PERCU_REF_ALLOW_REINIT
      percpu_ref: release percpu memory early without PERCPU_REF_ALLOW_REINIT

 drivers/md/md.c                 |  3 ++-
 fs/io_uring.c                   |  3 ++-
 include/linux/percpu-refcount.h | 10 +++++++++-
 lib/percpu-refcount.c           | 13 +++++++++++--
 4 files changed, 24 insertions(+), 5 deletions(-)

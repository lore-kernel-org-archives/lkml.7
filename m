Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71264C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E120665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="0gCycQ1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfGaJmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:42:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37234 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfGaJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so46923029lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rqG+cIJiTcKTl4jj+UyKsbLA405xn5hnEZuM+vQ9m2s=;
        b=0gCycQ1IpbD4/DIdgmoTf//wxXx6+VbiEOx9PBs7wipdDuyJLOje2wWajDg7uLGj2L
         P3pnhFhpvZsQKL1bAOTTEeyEB26aidRybFixoH8AQ61n3qHTq5aTCppDV5vVnC96wyth
         fjTf0u1l0BlYNU1YX6aA5v/jsBeznHmUz/PVQAtq9R11+BoTDD1mDw/o2/iL64GkgC1C
         Weixn0ora792RiXSORUxmHYJbtdkhy3vRx8vdtQgrkkBm8dlcKQzdgIoC0kidLJ8vJJM
         A1FOIRQb1ic5Uu+BAP77II6khgO7FH8qqgKX8i89VvPXBhyKWhAjSjiUrosS64sAX++i
         omvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rqG+cIJiTcKTl4jj+UyKsbLA405xn5hnEZuM+vQ9m2s=;
        b=cNunFcNktXGkSBhkKQ7X9gMmvGgQlqEZLyAj96XiwhlIvwuYgx7c5j8YVOWy7NveU7
         dZVbQT8atyuLTskfsvrxnLOvB84o8iW8zIXF0vBHtnv/+pIhQOY8nxqsxGwektOs6WwD
         FEuMEKv/1sqcTL+shEhjdNwFQJduKJ/EciJL8HY1x1slLNFO1hgLsGDurOyxmBnv7btK
         ccT/8L4U3t8WVmTfMxbBWj/vlJjK8nAFA+6ueZV3NgYywcZxDJd4RpWLyYBrNSUsuHP1
         tUj9ITfPSDu53qKqzaAqjyOt2OmlNPBbOKWVUU/nqGSVBW3YJHpeRSzkYV/k7k9HxOuI
         TDZA==
X-Gm-Message-State: APjAAAXXt5KzVWdyjmtkTfDu2I7Wg939ZPgmCXNdaG5GHBmhPAk37T0p
        IdiFA5FZ+LV6sM0jRAYaCP4=
X-Google-Smtp-Source: APXvYqwgjLjCynceI0reBeEaL7wIlQZc3sok3R7oUvc1CqgSMjQm5/sluf7+n7dLWAOLW5dZ8sZ3KA==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr13167058lfl.0.1564566133483;
        Wed, 31 Jul 2019 02:42:13 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:12 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 0/4] lnvm/pblk mapping cleanups
Date:   Wed, 31 Jul 2019 11:41:32 +0200
Message-Id: <1564566096-28756-1-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up the metadata allocation/mapping in lnvm/pblk
by moving over to kvmalloc for metadata and moving metadata mapping
down to the lower lever driver where blk_rq_map_kern can be used.

Hans Holmberg (4):
  lightnvm: remove nvm_submit_io_sync_fn
  lightnvm: move metadata mapping to lower level driver
  lightnvm: pblk: use kvmalloc for metadata
  block: stop exporting bio_map_kern

 block/bio.c                      |   1 -
 drivers/lightnvm/core.c          |  43 ++++++++++++---
 drivers/lightnvm/pblk-core.c     | 116 +++++----------------------------------
 drivers/lightnvm/pblk-gc.c       |  19 +++----
 drivers/lightnvm/pblk-init.c     |  38 ++++---------
 drivers/lightnvm/pblk-read.c     |  22 +-------
 drivers/lightnvm/pblk-recovery.c |  39 ++-----------
 drivers/lightnvm/pblk-write.c    |  20 +------
 drivers/lightnvm/pblk.h          |  31 +----------
 drivers/nvme/host/lightnvm.c     |  45 +++++----------
 include/linux/lightnvm.h         |   8 +--
 11 files changed, 96 insertions(+), 286 deletions(-)

-- 
2.7.4


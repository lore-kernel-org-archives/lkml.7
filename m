Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E70C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109592085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557773567;
	bh=GSLDstGrF+kdukSym6LeQNIXRRRnCuBhycVenkCtta8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0AoxEx65k/x94L0mLw7FDBBDiDjPELOOJU/Q9FNOruZr8ISx//M1I198Xrs9ye0vh
	 0T38fSuMSUhXaWUZJ9iWZTipLtZDu0kkAqtbiU7uhMsI39ycLiJodXjjVnKYgBnQlG
	 wAiuiudPAHPVSVyHTLlzC9m6CMTcO4Zs/mj4xQWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEMSwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:52:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41931 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEMSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:52:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id y22so12591104qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b4TlRietwnM6oTPXcxhj2JOE8FV7T3pSL6QJavmQ1dg=;
        b=H5qenU/7jx8NlQhm7S99sirqKd61HRj6fvztvxwH8qxnHnyhxnM3vrRGU/DDlRxMNi
         9YteXtpVKNokOI7554+8eaokfgHk+gqKyuaVlN7BNAY80mUKipQQlX2r8/0N/qicdJRd
         YM3wCagWhQTXChqRXBSku//06FLq37M9iiLfou15xlsJIB2bn1B49534tBII79HZWCsx
         KnW8/mv/pTenMwi0D13Ff+ZhmoKnyD8noNvlP51qOFk4s2YOLeMBmq6fLeaxxDxrxQIi
         BV9Pap+2eZERZd5/gTC+T2RP4uQrorq9WtE8uKWEMTRpCnrJwTTjWG3kI+/XaU6LGHOT
         Wfpg==
X-Gm-Message-State: APjAAAVZxe+5nAY8SwRe13PBiLWi6CLvLdwebWq+g3XrSJLlRp1Wes69
        R9Cq4Yq07WAuyiJmVlXTQjM=
X-Google-Smtp-Source: APXvYqxSKsVgAu+I6jDct+Jb+foaVr1VkQpIWA0uKzdaIX/lqaAusSviehhQATr1kLcIrmTwBR5YQQ==
X-Received: by 2002:a0c:b161:: with SMTP id r30mr2632858qvc.15.1557773565039;
        Mon, 13 May 2019 11:52:45 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::3:b635])
        by smtp.gmail.com with ESMTPSA id y8sm2445558qki.26.2019.05.13.11.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:52:43 -0700 (PDT)
Date:   Mon, 13 May 2019 14:52:41 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.2-rc1
Message-ID: <20190513185241.GA74787@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request includes my scan hint update which helps address
performance issues with heavily fragmented blocks.

The other change is a lockdep fix when freeing an allocation causes
balance work to be scheduled.

Thanks,
Dennis

The following changes since commit fa3d493f7a573b4e4e2538486e912093a0161c1b:

  Merge tag 'selinux-pr-20190312' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux (2019-03-13 11:10:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.2

for you to fetch changes up to 198790d9a3aeaef5792d33a560020861126edc22:

  percpu: remove spurious lock dependency between percpu and sched (2019-05-08 12:08:48 -0700)

----------------------------------------------------------------
Dennis Zhou (12):
      percpu: update free path with correct new free region
      percpu: do not search past bitmap when allocating an area
      percpu: introduce helper to determine if two regions overlap
      percpu: manage chunks based on contig_bits instead of free_bytes
      percpu: relegate chunks unusable when failing small allocations
      percpu: set PCPU_BITMAP_BLOCK_SIZE to PAGE_SIZE
      percpu: add block level scan_hint
      percpu: remember largest area skipped during allocation
      percpu: use block scan_hint to only scan forward
      percpu: make pcpu_block_md generic
      percpu: convert chunk hints to be based on pcpu_block_md
      percpu: use chunk scan_hint to skip some scanning

John Sperbeck (1):
      percpu: remove spurious lock dependency between percpu and sched

 include/linux/percpu.h |  12 +-
 mm/percpu-internal.h   |  15 +-
 mm/percpu-km.c         |   2 +-
 mm/percpu-stats.c      |   5 +-
 mm/percpu.c            | 549 ++++++++++++++++++++++++++++++++++---------------
 5 files changed, 405 insertions(+), 178 deletions(-)

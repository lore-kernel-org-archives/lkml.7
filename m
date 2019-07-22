Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBFC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49CB2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NpyIgKdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfGVO0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:26:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56205 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGVO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:26:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so35389849wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSSG+/SPzy4dXqjSfDAF61vds83VEHomtFtlG6NVWCM=;
        b=NpyIgKdV7f7bde7xQbG/M3QiHf9/GjR0/rkrYOmJXU1I5elJ8P9PaSvQIxo+ZYHGSq
         vaDOB4Ht6EywdynGGeXW0KxBvlepXQnmdxhncg1tajY8pqZD7vD+Z5IWQ+70JEGjbCs8
         nOFjvRpLwdCpUbrZ63fIWeP1nEeAi7jxrKf+ZDupj06EaGQzWoPi4LeqNC7i9NY5Jy1J
         zlHts0hamZwcT653XwN1lghUIzuhDWZZDqqZVCShutAQ/Df8TVZ734qi0pmQhE/dc75b
         njomznYmB7pXlQ4tU1pYmv/JiS15gw3VrrUOkhRD96P/NWjSviyc1acQeIGNIJqUyNOn
         2BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSSG+/SPzy4dXqjSfDAF61vds83VEHomtFtlG6NVWCM=;
        b=VnKUjw7gOiM17ox+aZyR1V214dIpBIYowbMOC3ZEh54zg+w7hs7tqxAIm0PQysjuYu
         RrKCXbvY4i7D7IDiTSp8xyrkLx6iEgEs+b0KWY1Fs5fsib6dr2kSEVaUoeEvxJ2moVSa
         /67GxUMaqKXWJ+eRmbBojerKLBHj2EWb6svKNpPEtKjs4jQUn5NoRfMfNPtDBG3L1UX4
         S4zE6C0fqNcXAVNWeFII7vwPXFdwSvvoREJ/ojulaQbQ4cQ2yXnmLTDJRw7Rx8/PkJCF
         3vjVdad/YJt498jes5Ejm9Twr9zC8JHbM1qUlNgF9MMP5vnJDAkJA8jcsvooY32ApcNd
         9xgA==
X-Gm-Message-State: APjAAAWm8bVwGR43jMgUajF8109zpzttfFj1UMmKQ1mHCgMx6EJTrvj9
        J5ST0jri/DiyKZC1JbJ/ttc=
X-Google-Smtp-Source: APXvYqzcX3cd8YqK8GLkwwC4FaQWzXKuFq07UGXLTjQWfd0zeJDrfqoVabNOYoUrs4LwXjPuL3e9lQ==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr64401057wmi.141.1563805559521;
        Mon, 22 Jul 2019 07:25:59 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id x185sm28552203wmg.46.2019.07.22.07.25.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 07:25:58 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com, surenb@google.com,
        joel@joelfernandes.org
Subject: [GIT PULL] pidfd fixes
Date:   Mon, 22 Jul 2019 16:22:41 +0200
Message-Id: <20190722142238.16129-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a fix for pidfd polling. It ensures that the task's exit
state is visible to all waiters:

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190722

for you to fetch changes up to b191d6491be67cef2b3fa83015561caca1394ab9:

  pidfd: fix a poll race when setting exit_state (2019-07-22 16:02:03 +0200)

/* Summary */
The pidfd polling code suffered from a race condition. A waiter could be
notified via do_notify_pidfd() without the task's exit state being set and
thus not visible to the waiter. This would cause the waiter to be blocked
indefinitely. The following schematic illustrates how this could happen:

    CPU 0                            CPU 1
    ------------------------------------------------
    exit_notify
      do_notify_parent
        do_notify_pidfd
                                       pidfd_poll
                                          if (tsk->exit_state)
      tsk->exit_state = EXIT_DEAD

This is fixed by ensuring that the task's exit state is set before calling
into do_notify_pidfd(). 

Please consider pulling from the signed for-linus-20190722 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190722

----------------------------------------------------------------
Suren Baghdasaryan (1):
      pidfd: fix a poll race when setting exit_state

 kernel/exit.c | 1 +
 1 file changed, 1 insertion(+)

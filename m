Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89203217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL1n+6Ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfEIVhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34444 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEIVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id j6so4358077qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oFfudzRuyLzh+2A1P2cQ0fAyJle4ZBi25Y3DQB/lfhs=;
        b=DL1n+6BaQkL10EUzcfR+K7l287pS+hhFABF1+tmA0eVwO8mGD6x2Jc/R2rXEGrC8o1
         SqvOmukRZM+H2qpA0QQGZq8T7oJIoiFdKubAXX6KBi7+zXyNdxoG/briK24FU9ubCDIo
         0SxSG4Iew5XkaP5iE/WffO47ZvBS2ig3M3/JgEmLaVKrE5Emd2i8oxNCEMVK5HzYwZjg
         vxJDq35Hu99YfdARv+PDNouHluFvu96PpUUUPpuS4x4ZDlbfuyFHfIi5s2kvIecOPAKa
         Lj497zX6V/SwyB/vMkZNj65zWYhRNf12+kieqvzoq9Zme3qbgTSds4THeE/Qg78OrKfa
         jvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oFfudzRuyLzh+2A1P2cQ0fAyJle4ZBi25Y3DQB/lfhs=;
        b=S3pfrZb1Y+IeRhMbCESLEqpkfe2zpP8HBoFJBy0EQ5rO/SvD7hi2hgDjdJ8+q2pOUL
         2kuLX7SyGD/8faCQlkKXPUejF1/FYJuFj/wKSJYKlaYEpfc4YUvw/5mpflK90x/QkgUZ
         gPKYzPgR8q7PFd7orNnZv9JxcpWE/IhF92D4pQ7I5hLcBOmY6UgGUiMZ5hHA0TnYjOS0
         fTUrY49WsUx3zSTQxjSgqIz528sPSD0QGsiHrLbnj3z46PtUGuLb4JboLx6DRs3XDDiV
         kUhTqeeIQSDDXtkIOSFOxJii9S6yHyLS6OpJnl8mtC1ALkDO4p/UJZvzTLHvdIPF2iWT
         yjug==
X-Gm-Message-State: APjAAAVv44ydfN+hKY6FIq9CGAlnTEZNcdYpRsmczb3QM3ZbgbNiCfwr
        VRvJr9gZabc8YwtXNa7+oQ==
X-Google-Smtp-Source: APXvYqxmaMWm3bLSp/9/AWtjyYTycR8v+JlxSkVNFQVOQZK1UOxFEqj8deJCzjJJaC0SEUHnuIw18A==
X-Received: by 2002:ac8:30c6:: with SMTP id w6mr6348619qta.186.1557437828073;
        Thu, 09 May 2019 14:37:08 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:07 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] ktest: support for Boot Loader Specification
Date:   Thu,  9 May 2019 17:36:41 -0400
Message-Id: <20190509213647.6276-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Fedora 30 introduces Boot Loader Specification (BLS) [1],
it changes around grub entry configuration.

This patch series deals with the new configuration.

- Add grub2bls option as REBOOT_TYPE to deal with BLS.
- Some cleanup around getting kernel entries.

To use ktest.pl to BLS environment,

- Set REBOOT_TYPE = grub2bls.
- Set POST_INSTALL to add the kernel entry like as follows.

  POST_INSTALL = ssh root@Test "/usr/bin/kernel-install add \
             $KERNEL_VERSION /boot/vmlinuz-$KERNEL_VERSION"

- Set POST_KTEST to remove the kernel entry (optional).

  POST_KTEST = ssh root@Test "/usr/bin/kernel-install remove $KERNEL_VERSION"

[1] https://fedoraproject.org/wiki/Changes/BootLoaderSpecByDefault

Masayoshi Mizuma (6):
  ktest: introduce _get_grub_index
  ktest: cleanup get_grub_index
  ktest: introduce grub2bls REBOOT_TYPE option
  ktest: pass KERNEL_VERSION to POST_KTEST
  ktest: remove get_grub2_index
  ktest: update sample.conf for grub2bls

 tools/testing/ktest/ktest.pl    | 89 ++++++++++++++++-----------------
 tools/testing/ktest/sample.conf | 20 +++++++-
 2 files changed, 62 insertions(+), 47 deletions(-)

-- 
2.20.1


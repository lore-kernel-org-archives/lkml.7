Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F2620659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfLCUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:33:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58106 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfLCUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:33:49 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1icErh-0001Y7-RR; Tue, 03 Dec 2019 20:33:46 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor updates for 5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Organization: Canonical
Message-ID: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
Date:   Tue, 3 Dec 2019 12:33:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry I didn't manage to get these out before last weeks vacation.

Can you please pull the following changes for apparmor

Thanks!

- John

The following changes since commit 582549e3fbe137eb6ce9be591aca25c2222a36b4:

   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-04-10 09:39:04 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2019-12-03

for you to fetch changes up to 341c1fda5e17156619fb71acfc7082b2669b4b72:

   apparmor: make it so work buffers can be allocated from atomic context (2019-11-22 16:41:08 -0800)

----------------------------------------------------------------
+ Features
   - increase left match history buffer size to provide inproved conflict
     resolution in overlapping execution rules.
   - switch buffer allocation to use a memory pool and GFP_KERNEL
     where possible.
   - add compression of policy blobs to reduce memory usage.
+ Cleanups
   - fix spelling mistake "immutible" -> "immutable"
+ Bug fixes
   - fix unsigned len comparison in update_for_len macro
   - fix sparse warning for type-casting of current->real_cred

----------------------------------------------------------------
Bharath Vedartham (1):
       apparmor: Force type-casting of current->real_cred

Chris Coulson (1):
       apparmor: Initial implementation of raw policy blob compression

Colin Ian King (2):
       apparmor: fix spelling mistake "immutible" -> "immutable"
       apparmor: fix unsigned len comparison with less than zero

John Johansen (7):
       apparmor: fix blob compression build failure on ppc
       apparmor: fix missing ZLIB defines
       apparmor: fix blob compression when ns is forced on a policy load
       apparmor: increase left match history buffer size
       apparmor: fix wrong buffer allocation in aa_new_mount
       apparmor: reduce rcu_read_lock scope for aa_file_perm mediation
       apparmor: make it so work buffers can be allocated from atomic context

Sebastian Andrzej Siewior (2):
       apparmor: Use a memory pool instead per-CPU caches
       apparmor: Switch to GFP_KERNEL where possible

  security/apparmor/Kconfig                 |   2 +
  security/apparmor/apparmorfs.c            | 130 +++++++++++++++++++-
  security/apparmor/domain.c                |  46 +++----
  security/apparmor/file.c                  |  45 ++++---
  security/apparmor/include/apparmor.h      |   1 +
  security/apparmor/include/file.h          |   2 +-
  security/apparmor/include/match.h         |   3 +-
  security/apparmor/include/path.h          |  50 +-------
  security/apparmor/include/policy_unpack.h |   8 +-
  security/apparmor/label.c                 |  12 +-
  security/apparmor/lsm.c                   | 198 ++++++++++++++++++++++++------
  security/apparmor/match.c                 |   6 +-
  security/apparmor/mount.c                 |  67 +++++++---
  security/apparmor/policy.c                |   5 +-
  security/apparmor/policy_unpack.c         | 116 ++++++++++++++++-
  15 files changed, 526 insertions(+), 165 deletions(-)

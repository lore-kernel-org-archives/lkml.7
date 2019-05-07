Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37892C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327920825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEGXcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:32:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42137 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbfEGXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:32:12 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47NW8Nx014155
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 19:32:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CE9A420024; Tue,  7 May 2019 19:32:08 -0400 (EDT)
Date:   Tue, 7 May 2019 19:32:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random changes for 5.2
Message-ID: <20190507233208.GA28817@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

for you to fetch changes up to b7d5dc21072cda7124d13eae2aefb7343ef94197:

  random: add a spinlock_t to struct batched_entropy (2019-04-20 00:09:56 -0400)

----------------------------------------------------------------
Initialize the random driver earler; fix CRNG initialization when we
trust the CPU's RNG on NUMA systems; other miscellaneous cleanups and
fixes.

----------------------------------------------------------------
George Spelvin (1):
      random: document get_random_int() family

Jon DeVree (1):
      random: fix CRNG initialization when random.trust_cpu=1

Kees Cook (1):
      random: move rand_initialize() earlier

Rasmus Villemoes (3):
      drivers/char/random.c: constify poolinfo_table
      drivers/char/random.c: remove unused stuct poolinfo::poolbits
      drivers/char/random.c: make primary_crng static

Sebastian Andrzej Siewior (1):
      random: add a spinlock_t to struct batched_entropy

Theodore Ts'o (1):
      random: only read from /dev/random after its pool has received 128 bits

 drivers/char/random.c         | 199 +++++++++++++++++++++++++++++++++++++++++++++---------------------
 include/linux/random.h        |   1 +
 include/trace/events/random.h |  13 ++---
 init/main.c                   |  21 ++++---
 4 files changed, 156 insertions(+), 78 deletions(-)

Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ACDC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7A208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfEIObv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:31:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E498EABD4;
        Thu,  9 May 2019 14:31:49 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 0/4] staging: vchiq: use interruptible waits
Date:   Thu,  9 May 2019 16:31:32 +0200
Message-Id: <20190509143137.31254-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this series tries to address an issue that came up in Raspbian's kernel
tree [1] and upstream distros [2][3].

We adopted some changes that moved wait calls from a custom
implementation to the more standard killable family of functions. Users
complained that all the VCHIQ threads showed up in D state (which is the
expected behaviour).

The custom implementation we deleted tried to mimic the killable family
of functions, yet accepted more signals than the later; SIGKILL |
SIGINT | SIGQUIT | SIGTRAP | SIGSTOP | SIGCONT for the custom
implementation as opposed to plain old SIGKILL.

Raspbian maintainers decided roll back some of those changes and leave
the wait functions as interruptible. Hence creating some divergence
between both trees.

One could argue that not liking having the threads stuck in D state is
not really a software issue. It's more a cosmetic thing that can scare
people when they look at "uptime". On the other hand, if we are ever to
unstage this driver, we'd really need a proper justification for using
the killable family of functions. Which I think it's not really clear at
the moment.

As Raspbian's kernel has been working for a while with interruptible
waits I propose we follow through. If needed we can always go back to
killable. But at least we'll have a proper understanding on the actual
needs. In the end the driver is in staging, and the potential for errors
small.

The first 3 commits fix the issue, and should probably get in as soon as
possible, the last commit is just cosmetic and can wait until 5.3.

Regards,
Nicolas

[1] https://github.com/raspberrypi/linux/issues/2881
[2] https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13485
[3] https://lists.fedoraproject.org/archives/list/arm@lists.fedoraproject.org/message/GBXGJ7DOV5CQQXFPOZCXTRD6W4BEPT4Q/

--

Changes since v2:
  - Cleaned up revert commit message
  - Rebase & merge conflict resolutions
  - Add code cleanup suggested by Dan Carpenter

Changes since v1:
  - Proplery format revert commits
  - Add code comment to remind of this issue
  - Add Fixes tags

Nicolas Saenz Julienne (4):
  staging: vchiq_2835_arm: revert "quit using custom
    down_interruptible()"
  staging: vchiq: revert "switch to wait_for_completion_killable"
  staging: vchiq: make wait events interruptible
  staging: vchiq: stop explicitly comparing with zero to catch errors

 .../bcm2835-camera/bcm2835-camera.c           | 11 ++-
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 85 +++++++++----------
 .../interface/vchiq_arm/vchiq_connected.c     |  4 +-
 .../interface/vchiq_arm/vchiq_core.c          | 53 +++++++-----
 .../interface/vchiq_arm/vchiq_debugfs.c       |  4 +-
 .../interface/vchiq_arm/vchiq_util.c          |  6 +-
 7 files changed, 82 insertions(+), 83 deletions(-)

-- 
2.21.0


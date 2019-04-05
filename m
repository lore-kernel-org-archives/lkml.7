Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62251C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7CF2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfDELem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:34:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:43924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731068AbfDELel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:34:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74DB9AB76;
        Fri,  5 Apr 2019 11:34:40 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     phil@raspberrypi.org, eric@anholt.net, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vchiq: use interruptible waits
Date:   Fri,  5 Apr 2019 13:34:19 +0200
Message-Id: <20190405113423.14495-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this series tries to address an issue that came up in Raspbian's kernel
tree [1]. After pulling from upstream some changes that moved wait calls
from a custom implementation to the more standard killable family some
users complained that all the VCHIQ threads showed up in D state (which
is the expected behaviour).

The custom implementation we deleted tried to mimic the killable family
of functions, yet accepted more signals than the later.  SIGKILL |
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

Regards,
Nicolas

[1] https://github.com/raspberrypi/linux/issues/2881

---

Nicolas Saenz Julienne (3):
  Revert "staging: vchiq_2835_arm: quit using custom
    down_interruptible()"
  Revert "staging: vchiq: switch to wait_for_completion_killable"
  staging: vchiq: make wait events interruptible

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 21 +++++++++--------
 .../interface/vchiq_arm/vchiq_core.c          | 23 ++++++++++---------
 .../interface/vchiq_arm/vchiq_util.c          |  6 ++---
 4 files changed, 27 insertions(+), 25 deletions(-)

-- 
2.21.0


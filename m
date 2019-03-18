Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCRBAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:00:47 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:8677
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbfCRBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:00:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQk?=
 =?us-ascii?q?LAYIQgTghEieEC5QJAQECAQEGgRA4iS2JXoUTgXsgGAGENgoChFAiNAkNAQE?=
 =?us-ascii?q?DAQEBCAEDAm0ohUsGI1YQGAEMAhgOAgJHEAYThQsMqVGBLxoCigmBCyQBiy8?=
 =?us-ascii?q?XeIEHgUSCKohAglcDihsbgiKELUw7X5FqCZMlGYF8iSgDiDAtgxGIYJNTOIF?=
 =?us-ascii?q?WTS4KgyeCQI4YNTCBBQEBjUsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQkLAYIQgTghEieEC?=
 =?us-ascii?q?5QJAQECAQEGgRA4iS2JXoUTgXsgGAGENgoChFAiNAkNAQEDAQEBCAEDAm0oh?=
 =?us-ascii?q?UsGI1YQGAEMAhgOAgJHEAYThQsMqVGBLxoCigmBCyQBiy8XeIEHgUSCKohAg?=
 =?us-ascii?q?lcDihsbgiKELUw7X5FqCZMlGYF8iSgDiDAtgxGIYJNTOIFWTS4KgyeCQI4YN?=
 =?us-ascii?q?TCBBQEBjUsBAQ?=
X-IronPort-AV: E=Sophos;i="5.58,491,1544457600"; 
   d="scan'208";a="206152905"
Received: from unknown (HELO pluto.themaw.net) ([118.208.49.142])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 18 Mar 2019 09:00:40 +0800
Subject: [PATCH 4/5] autofs - update mount control expire desription with
 AUTOFS_EXP_FORCED
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 18 Mar 2019 09:00:40 +0800
Message-ID: <155287084078.12593.15000931045413195778.stgit@pluto.themaw.net>
In-Reply-To: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
References: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe AUTOFS_EXP_FORCED in addition to AUTOFS_EXP_IMMEDIATE in the
description of the AUTOFS_DEV_IOCTL_EXPIRE_CMD ioctl.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs-mount-control.txt |    6 ++++--
 Documentation/filesystems/autofs.txt               |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/autofs-mount-control.txt b/Documentation/filesystems/autofs-mount-control.txt
index 45edad6933cc..acc02fc57993 100644
--- a/Documentation/filesystems/autofs-mount-control.txt
+++ b/Documentation/filesystems/autofs-mount-control.txt
@@ -354,8 +354,10 @@ this ioctl is called until no further expire candidates are found.
 
 The call requires an initialized struct autofs_dev_ioctl with the
 ioctlfd field set to the descriptor obtained from the open call. In
-addition an immediate expire, independent of the mount timeout, can be
-requested by setting the how field of struct args_expire to 1. If no
+addition an immediate expire that's independent of the mount timeout,
+and a forced expire that's independent of whether the mount is busy,
+can be requested by setting the how field of struct args_expire to
+AUTOFS_EXP_IMMEDIATE or AUTOFS_EXP_FORCED, respectively . If no
 expire candidates can be found the ioctl returns -1 with errno set to
 EAGAIN.
 
diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 8fe43c97cb96..409e6411904d 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -410,6 +410,11 @@ The available ioctl commands are:
      **AUTOFS_EXP_IMMEDIATE** causes `last_used` time to be ignored
      and objects are expired if the are not in use.
 
+     **AUTOFS_EXP_FORCED** causes the in use status to be ignored
+     and objects are expired ieven if they are in use. This assumes
+     that the daemon has requested this because it is capable of
+     performing the umount.
+
      **AUTOFS_EXP_LEAVES** will select a leaf rather than a top-level
      name to expire.  This is only safe when *maxproto* is 4.
 


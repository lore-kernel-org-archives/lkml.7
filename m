Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53817C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5102085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCRBAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:00:36 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:8677
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbfCRBAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:00:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQk?=
 =?us-ascii?q?LAYFmKoE4IRInhAuUCQEBAgEBBoEQOIktjnGBeyAYAYRAAoRQIjQJDQEBAwE?=
 =?us-ascii?q?BAQgBAwJtKIVLBiNWEBgBDAIYDgICRxAGE4ULDKlRgS8aAooJgQskAYsvF3i?=
 =?us-ascii?q?BB4FEimqCVwOKAxgbgiKEeTtfkWoJkyUZgXyBfocqA4USgx6DPohgk1M4gVZ?=
 =?us-ascii?q?NLgqDJ4MtAQGNKTUwgQUBAY1LAQE?=
X-IPAS-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQkLAYFmKoE4IRInh?=
 =?us-ascii?q?AuUCQEBAgEBBoEQOIktjnGBeyAYAYRAAoRQIjQJDQEBAwEBAQgBAwJtKIVLB?=
 =?us-ascii?q?iNWEBgBDAIYDgICRxAGE4ULDKlRgS8aAooJgQskAYsvF3iBB4FEimqCVwOKA?=
 =?us-ascii?q?xgbgiKEeTtfkWoJkyUZgXyBfocqA4USgx6DPohgk1M4gVZNLgqDJ4MtAQGNK?=
 =?us-ascii?q?TUwgQUBAY1LAQE?=
X-IronPort-AV: E=Sophos;i="5.58,491,1544457600"; 
   d="scan'208";a="206152855"
Received: from unknown (HELO pluto.themaw.net) ([118.208.49.142])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 18 Mar 2019 09:00:30 +0800
Subject: [PATCH 2/5] autofs - update autofs.txt for strictexpire mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 18 Mar 2019 09:00:30 +0800
Message-ID: <155287083000.12593.2722713092537666885.stgit@pluto.themaw.net>
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

A "strictexpire" mount option has been added to the autofs file
system.

It is meant to be used in cases where a GUI continually accesses
or an application frquently scans an automount directory tree
causing an accumulation of otherwise unused mounts.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 05da806b1e88..ac50b47f02bd 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -240,11 +240,18 @@ Normally the daemon only wants to remove entries which haven't been
 used for a while.  For this purpose autofs maintains a "`last_used`"
 time stamp on each directory or symlink.  For symlinks it genuinely
 does record the last time the symlink was "used" or followed to find
-out where it points to.  For directories the field is a slight
-misnomer.  It actually records the last time that autofs checked if
-the directory or one of its descendants was busy and found that it
-was.  This is just as useful and doesn't require updating the field so
-often.
+out where it points to.  For directories the field is used slightly
+differently.  The field is updated at mount time and during expire
+checks if it is found to be in use (ie. open file descriptor or
+process working directory) and during path walks. The update done
+during path walks prevents frequent expire and immediate mount of
+frequently accessed automounts. But in the case where a GUI continually
+access or an application frequently scans an autofs directory tree
+there can be an accumulation of mounts that aren't actually being
+used. To cater for this case the "`strictexpire`" autofs mount option
+can be used to avoid the "`last_used`" update on path walk thereby
+preventing this apparent inability to expire mounts that aren't
+really in use.
 
 The daemon is able to ask autofs if anything is due to be expired,
 using an `ioctl` as discussed later.  For a *direct* mount, autofs


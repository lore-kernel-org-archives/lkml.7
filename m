Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4ABCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ADB2080F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="X9dFktO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKBPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:16:37 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42376 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbfKBPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:16:37 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 941382E099D;
        Sat,  2 Nov 2019 18:16:34 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id UjI6F08SWn-GXjiaB0J;
        Sat, 02 Nov 2019 18:16:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572707794; bh=AR0posdeGGjRMOUjYp9dgJq5OCpwQBAAcmepPzGDKWg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=X9dFktO77Na/G0mtC2+xSzpD1cMLgWOkM1P9fpb+ypv5Obc9xW91WTB8Mc1xm15fI
         f+vjegUUhK0i7hnoRfJ+Na/UVVXYuRet+Jx2AzVkMEQdB23FUCLveNYbe34Rajfqob
         WnSYBjjQfRvF4wy/a3HK7oM0Cf0Nz8wpJRNk4zps=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla1-5826f599457c.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id kxXcRS1iUB-GXVOVCeE;
        Sat, 02 Nov 2019 18:16:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date:   Sat, 02 Nov 2019 18:16:33 +0300
Message-ID: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
charge path") memcg invokes oom killer not only for user page-faults.
This means 0-order allocation will either succeed or task get killed.

Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5361ebec3361..eb47815e137b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
 
 		Failed allocation in its turn could be returned into
 		userspace as -ENOMEM or silently ignored in cases like
-		disk readahead.  For now OOM in memory cgroup kills
-		tasks iff shortage has happened inside page fault.
+		disk readahead.
+
+		Before 4.19 OOM in memory cgroup killed tasks iff
+		shortage has happened inside page fault, random
+		syscall may fail with ENOMEM or EFAULT. Since 4.19
+		failed memory cgroup allocation invokes oom killer and
+		keeps retrying until it succeeds.
 
 		This event is not raised if the OOM killer is not
 		considered as an option, e.g. for failed high-order


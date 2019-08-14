Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9802054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfHNPqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:46:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfHNPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:46:14 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxvTY-0005XX-2o; Wed, 14 Aug 2019 15:46:12 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc:     oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 0/1] waitid: process group enhancement
Date:   Wed, 14 Aug 2019 17:43:59 +0200
Message-Id: <20190814154400.6371-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This patch adds support for waiting on the current process group by
specifying waitid(P_PGID, 0, ...) as discussed in [1]. The details why
we need to do this are in the commit message of [PATCH 1/1] so I won't
repeat them here.

I've picked this up since the thread has gone stale and parts of
userspace are actually blocked by this.

Note that the patch has been changed to be more closely aligned with the
P_PIDFD changes to waitid() I have sitting in my for-next branch (cf. [2]).
This makes the merge conflict a little simpler and picks up on the
coding style discussions that guided the P_PIDFD patchset.

There was some desire to get this feature in with 5.3 (cf. [3]).
But given that this is a new feature for waitid() and for the sake of
avoiding any merge conflicts I would prefer to land this in the 5.4
merge window together with the P_PIDFD changes.

Thanks!
Christian

/* v0 */
Link: https://www.sourceware.org/ml/libc-alpha/2019-07/msg00587.html

/* v1 */
Link: https://lore.kernel.org/lkml/20190814113822.9505-1-christian.brauner@ubuntu.com/

/* v2 */
Link: https://lore.kernel.org/lkml/20190814130732.23572-1-christian.brauner@ubuntu.com/

/* References */
[1]: https://www.sourceware.org/ml/libc-alpha/2019-07/msg00587.html
[2]: https://lore.kernel.org/lkml/20190727222229.6516-1-christian@brauner.io/
[3]: https://www.sourceware.org/ml/libc-alpha/2019-08/msg00304.html

Eric W. Biederman (1):
  waitid: Add support for waiting for the current process group

 kernel/exit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.22.0


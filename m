Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A1D212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfD0P3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:29:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbfD0PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:18 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2q-0000zO-5B; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004cE-SS; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "James Morris" <james.morris@microsoft.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "David Howells" <dhowells@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.307177013@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 162/202] KEYS: allow reaching the keys quotas exactly
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a08bf91ce28ed3ae7b6fef35d843fef8dc8c2cd9 upstream.

If the sysctl 'kernel.keys.maxkeys' is set to some number n, then
actually users can only add up to 'n - 1' keys.  Likewise for
'kernel.keys.maxbytes' and the root_* versions of these sysctls.  But
these sysctls are apparently supposed to be *maximums*, as per their
names and all documentation I could find -- the keyrings(7) man page,
Documentation/security/keys/core.rst, and all the mentions of EDQUOT
meaning that the key quota was *exceeded* (as opposed to reached).

Thus, fix the code to allow reaching the quotas exactly.

Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/keys/key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -260,8 +260,8 @@ struct key *key_alloc(struct key_type *t
 
 		spin_lock(&user->lock);
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
-			if (user->qnkeys + 1 >= maxkeys ||
-			    user->qnbytes + quotalen >= maxbytes ||
+			if (user->qnkeys + 1 > maxkeys ||
+			    user->qnbytes + quotalen > maxbytes ||
 			    user->qnbytes + quotalen < user->qnbytes)
 				goto no_quota;
 		}


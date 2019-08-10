Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C0C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03032086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfHJUx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:53:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53898 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbfHJUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:43:49 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDJ-00053O-Lv; Sat, 10 Aug 2019 21:43:45 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDJ-0003Z1-03; Sat, 10 Aug 2019 21:43:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "NeilBrown" <neilb@suse.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>
Date:   Sat, 10 Aug 2019 21:40:07 +0100
Message-ID: <lsq.1565469607.524991198@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 020/157] NFS: fix mount/umount race in nlmclnt.
In-Reply-To: <lsq.1565469607.188083258@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.72-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 4a9be28c45bf02fa0436808bb6c0baeba30e120e upstream.

If the last NFSv3 unmount from a given host races with a mount from the
same host, we can destroy an nlm_host that is still in use.

Specifically nlmclnt_lookup_host() can increment h_count on
an nlm_host that nlmclnt_release_host() has just successfully called
refcount_dec_and_test() on.
Once nlmclnt_lookup_host() drops the mutex, nlm_destroy_host_lock()
will be called to destroy the nlmclnt which is now in use again.

The cause of the problem is that the dec_and_test happens outside the
locked region.  This is easily fixed by using
refcount_dec_and_mutex_lock().

Fixes: 8ea6ecc8b075 ("lockd: Create client-side nlm_host cache")
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
[bwh: Backported to 3.16: use atomic instead of refcount API]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/lockd/host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -288,12 +288,11 @@ void nlmclnt_release_host(struct nlm_hos
 
 	WARN_ON_ONCE(host->h_server);
 
-	if (atomic_dec_and_test(&host->h_count)) {
+	if (atomic_dec_and_mutex_lock(&host->h_count, &nlm_host_mutex)) {
 		WARN_ON_ONCE(!list_empty(&host->h_lockowners));
 		WARN_ON_ONCE(!list_empty(&host->h_granted));
 		WARN_ON_ONCE(!list_empty(&host->h_reclaim));
 
-		mutex_lock(&nlm_host_mutex);
 		nlm_destroy_host_locked(host);
 		mutex_unlock(&nlm_host_mutex);
 	}


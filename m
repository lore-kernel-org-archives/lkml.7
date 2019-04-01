Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE53C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A7920856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138907;
	bh=AAzHgASu+m41a6XvwQKiIo/B9ccdbDL3WolEEIULuHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTd7UhqMqNxrxAp6d/O+ji8wr1B5T0Lnhd7fsUpTzfG4y7KuxB57Cfd9LbR4n2qpu
	 yUdAXBRMzLygPKFbrjW27Smd0/lHczaxtKpAmL+rWssiIqcybHgaC77cVC/QOhDSep
	 jAdlhVMnLzw/THCk9/eV3bEB+XbQDPLNI9zcAse0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfDARPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfDARPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C29620856;
        Mon,  1 Apr 2019 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138901;
        bh=AAzHgASu+m41a6XvwQKiIo/B9ccdbDL3WolEEIULuHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJCH2RmOEaFTTFi4M7eBWuVfTr5DTfwOIJu1AC2y7StMwJvzA3BoqDvmBtca8q8Rv
         EgqenKMoCP3zpU9+68myr819Q7ueuNwHv2yUcN0GJ03b1BYAGd3xUh9IqzzpZNunMP
         CCDSvxeLkrJ9XUZyu3IaPSHB+3KoVkE8sCV94gnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 054/134] NFS: fix mount/umount race in nlmclnt.
Date:   Mon,  1 Apr 2019 19:01:30 +0200
Message-Id: <20190401170049.576428430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org (v2.6.38+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/lockd/host.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -290,12 +290,11 @@ void nlmclnt_release_host(struct nlm_hos
 
 	WARN_ON_ONCE(host->h_server);
 
-	if (refcount_dec_and_test(&host->h_count)) {
+	if (refcount_dec_and_mutex_lock(&host->h_count, &nlm_host_mutex)) {
 		WARN_ON_ONCE(!list_empty(&host->h_lockowners));
 		WARN_ON_ONCE(!list_empty(&host->h_granted));
 		WARN_ON_ONCE(!list_empty(&host->h_reclaim));
 
-		mutex_lock(&nlm_host_mutex);
 		nlm_destroy_host_locked(host);
 		mutex_unlock(&nlm_host_mutex);
 	}



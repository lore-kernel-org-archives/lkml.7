Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A256AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C4D206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142199;
	bh=KcSvhUOi1ztF/T2HVgbaRdwp+C5E4bjdZRuEATjt2nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NHQkpf3OP372vybWFcMFptfOao/14QOZ7CmQjJQpeG81reG9dWLpxQM8UJJ9qo5Ja
	 OZahcjoGF6TxW7AIG5veRuIsClHdm9ZW1nc7BEkpZp8bnymn+FgT7htekxHLM5ZcTH
	 M2ARvvGVfzfQOSD81yCOz+o0e3GhuahJVOj+RraQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfDASJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfDARIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B195821939;
        Mon,  1 Apr 2019 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138514;
        bh=KcSvhUOi1ztF/T2HVgbaRdwp+C5E4bjdZRuEATjt2nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JT3TDGA4m/6t4SS46jceCVtMtnJ3l1edidw7Vvj+b/pEbgF9S+5s5xVg1GyHQM8nD
         m8ZB451Lfm+jM6izijyUiO1rQWb9U/9ggUwYbnSNpn5K1j+39PUjm5rmf80FzmpUYo
         ECJ+HOIgSOoSnhd8R550OIkAavwRQtMaHc4Xxx1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 051/146] NFS: fix mount/umount race in nlmclnt.
Date:   Mon,  1 Apr 2019 19:01:03 +0200
Message-Id: <20190401170052.932349769@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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



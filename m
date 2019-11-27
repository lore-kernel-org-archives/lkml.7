Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A4FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832A52176D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888961;
	bh=FqJdKg0k9uBG6oJRzwGizfjzoPk3wcAiHCDz427tDiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAfubM4AxnGKuXRL+FYtofMn2ISAuNJalfk6rgvWOZrPulbnozc5bZ1m419aWtPeu
	 j+ckciuUhaK6BzyWOFN6IpkYlqotefD6GDMgFSuhF4KwMe1LiCZRnq4IpFDc/pN4CX
	 uGZ5z0rx+QItNYExIMdsn52PEvOGjkj+XsdlsARk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfK0VJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732198AbfK0VJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:09:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED792086A;
        Wed, 27 Nov 2019 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888952;
        bh=FqJdKg0k9uBG6oJRzwGizfjzoPk3wcAiHCDz427tDiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ulmy4lwyB/PRhW4bUVnve87cZvcx9nQOsrXyhKcVlmI/eAylZjR39MxypPuiR0Ry1
         ZPsK5kgIpdbpCmek1j3RzcEVCq/QHRhkKTz0R/mG1UFh2bWKjgZa1VzRKKgn75t1Qv
         BmQNiYDANYzYNmWlaym9uLJFGN0AzbVR5yGJIxIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5.3 26/95] virtio_balloon: fix shrinker count
Date:   Wed, 27 Nov 2019 21:31:43 +0100
Message-Id: <20191127202853.159506349@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wei.w.wang@intel.com>

commit c9a6820fc0da2603be3054ee7590eb9f350508a7 upstream.

Instead of multiplying by page order, virtio balloon divided by page
order. The result is that it can return 0 if there are a bit less
than MAX_ORDER - 1 pages in use, and then shrinker scan won't be called.

Cc: stable@vger.kernel.org
Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -820,7 +820,7 @@ static unsigned long virtio_balloon_shri
 	unsigned long count;
 
 	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-	count += vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
+	count += vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER;
 
 	return count;
 }



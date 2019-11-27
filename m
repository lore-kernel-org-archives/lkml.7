Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339FDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADA0215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888244;
	bh=2tfT+JNrdVWZ+oMRcmgZUtHbBrEltXM0CPEOcEo0S8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErmE5nl81jaQ9j3iQCUFnYjfbPukoXzS0mKqBrB2Kax2U5tbZgGete9xQhQB66D2B
	 0pRpe0RNWZLri2FpuPMBUgYUGzJvZsIDpjMG/01GXhhLGb1VOTppmSEVypmOz1BFwF
	 K7EPE0r4NsBoGL6xEUu8bVzWuIm3ZATSQhQ2AYCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfK0U5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbfK0U5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:57:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265102084D;
        Wed, 27 Nov 2019 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888235;
        bh=2tfT+JNrdVWZ+oMRcmgZUtHbBrEltXM0CPEOcEo0S8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJgBCY77HGP9bXTN45g+s93V4pMECjuF0jogJF371dcLcHlv2TUL0EuHSww6uB6lO
         UG9VX4EASi7pkixuUKPtDCBmFFbKCqMPBdYETWVqVO1Q26IL2xQZ3JiUC7gtIRSvjI
         6cpT4IUS+sq71WN+yXzmpQld120XIpJlwQy09W2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Mike Christie <mchristi@redhat.com>,
        Sun Ke <sunke32@huawei.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 014/306] nbd:fix memory leak in nbd_get_socket()
Date:   Wed, 27 Nov 2019 21:27:44 +0100
Message-Id: <20191127203115.750394671@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sun Ke <sunke32@huawei.com>

commit dff10bbea4be47bdb615b036c834a275b7c68133 upstream.

Before returning NULL, put the sock first.

Cc: stable@vger.kernel.org
Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/nbd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -945,6 +945,7 @@ static struct socket *nbd_get_socket(str
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
+		sockfd_put(sock);
 		return NULL;
 	}
 



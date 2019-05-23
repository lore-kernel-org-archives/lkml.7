Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27EAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FD92054F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639827;
	bh=tYOK5UjmDOen6D4s1GWJrMLr3jUVp3wk9PRppDv5W7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFYNMuFGd6BsHLAupF8AjRkLAlEvXsBreXAVFqzOoKcX3XZ304io3xW6YbB22i3p0
	 lD3EXE+sr8CAJX/K1Vozop8UE/oH9yECcApzTPaZ5zCdpd5qN2Jk1UqP16eeODikQh
	 rdULWfwrg7D7AEedxSdnF5kdoG2Bv//oG0mX73VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392148AbfEWTa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392132AbfEWTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:30:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DA3206BA;
        Thu, 23 May 2019 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639823;
        bh=tYOK5UjmDOen6D4s1GWJrMLr3jUVp3wk9PRppDv5W7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yVXI09eHh8s9r8I7BSsFpIEff0IjIgP7kdcuuD5kJfB0jLQH3RkqL0EXjAEQq7nND
         d09vfskeilEuyzSRI4EtVLFB+1/F0Ixz0JWcWLlm14gm2nh/Ny3JtvGVkIvYilqHYe
         dADdn7SwPxPiLVD9ltP3zujzrn/uph6etrkX5QlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.1 105/122] dm delay: fix a crash when invalid device is specified
Date:   Thu, 23 May 2019 21:07:07 +0200
Message-Id: <20190523181719.238984991@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 81bc6d150ace6250503b825d9d0c10f7bbd24095 upstream.

When the target line contains an invalid device, delay_ctr() will call
delay_dtr() with NULL workqueue.  Attempting to destroy the NULL
workqueue causes a crash.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-delay.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -121,7 +121,8 @@ static void delay_dtr(struct dm_target *
 {
 	struct delay_c *dc = ti->private;
 
-	destroy_workqueue(dc->kdelayd_wq);
+	if (dc->kdelayd_wq)
+		destroy_workqueue(dc->kdelayd_wq);
 
 	if (dc->read.dev)
 		dm_put_device(ti, dc->read.dev);



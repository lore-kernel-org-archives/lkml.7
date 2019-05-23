Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2D121873
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639836;
	bh=OXAKRAzjo2jHwrzZdwTydx34Rw0Yt7nFcc573flfAXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fSXosthSvBqixVLSBYaDOieTZHv1yOHLxYRdPZSEPMc2+UAO8+O+8rbamdB0fKsVr
	 IiS0F83LufuVK366DpQCD3rA2E8SiFaZPs97XF9xR92ZHGapKZvG7x5DOzK1rH3vms
	 V/uEUFw0qhespfmf2pdaH16HH9k7IBMrYntqX+C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfEWTag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392143AbfEWTac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:30:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E8520879;
        Thu, 23 May 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639831;
        bh=OXAKRAzjo2jHwrzZdwTydx34Rw0Yt7nFcc573flfAXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLFDIjIj9Ly86NwcuPcz5w4dMFAhWXGUdXKNVL2uh2jiwmOxF2LmXCLaOUXOZJ4Pn
         pkXL8ihreI+/aRHVVYVn+j9lgTI7xGMv9mBpqpC+GYf4tw20jRxNkleqfObTAINDX2
         v+bF2DqGvN5PEfdAAmuyvLi1QhhQIcFi9qsLWeNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Koike <helen.koike@collabora.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.1 108/122] dm ioctl: fix hang in early create error condition
Date:   Thu, 23 May 2019 21:07:10 +0200
Message-Id: <20190523181719.695301559@linuxfoundation.org>
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

From: Helen Koike <helen.koike@collabora.com>

commit 0f41fcf78849c902ddca564f99a8e23ccfc80333 upstream.

The dm_early_create() function (which deals with "dm-mod.create=" kernel
command line option) calls dm_hash_insert() who gets an extra reference
to the md object.

In case of failure, this reference wasn't being released, causing
dm_destroy() to hang, thus hanging the whole boot process.

Fix this by calling __hash_remove() in the error path.

Fixes: 6bbc923dfcf57d ("dm: add support to directly boot to a mapped device")
Cc: stable@vger.kernel.org
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-ioctl.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -2069,7 +2069,7 @@ int __init dm_early_create(struct dm_ioc
 	/* alloc table */
 	r = dm_table_create(&t, get_mode(dmi), dmi->target_count, md);
 	if (r)
-		goto err_destroy_dm;
+		goto err_hash_remove;
 
 	/* add targets */
 	for (i = 0; i < dmi->target_count; i++) {
@@ -2116,6 +2116,10 @@ int __init dm_early_create(struct dm_ioc
 
 err_destroy_table:
 	dm_table_destroy(t);
+err_hash_remove:
+	(void) __hash_remove(__get_name_cell(dmi->name));
+	/* release reference from __get_name_cell */
+	dm_put(md);
 err_destroy_dm:
 	dm_put(md);
 	dm_destroy(md);



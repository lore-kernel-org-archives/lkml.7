Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D7D24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781696;
	bh=li7Me4Z/dXWOeP5CzgaRWZCcBrs4ZHrbXmgR707Su98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OpS9eBEbRHKTSxB8NxLpGtbx6CuHPwhP9J4pOPU11UOvMrAsZm492mjccc9SATgiX
	 FPP84tOtE5B9xXUqVlkX02bgi1x0seDPIcbSwNWR+LxNgATmSD9NaOX90mrH8pOZ8I
	 5U8+J24pIPmdDjDcyRKpu0n+957LRB/VyUN7RxTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfLSSyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfLSSyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311B8206EC;
        Thu, 19 Dec 2019 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781692;
        bh=li7Me4Z/dXWOeP5CzgaRWZCcBrs4ZHrbXmgR707Su98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCrTOVpEAQAait+UnFSjEPadiTR0WXTKElWSHn9ubfxEbzFAZ6/QSy9DdDtPfoaMI
         +l3lNf404SjeIKcB7I9wB5xvYjWaYBhFwoLscoPIazOooDKqjvsGS3F/PUKYnG/I3y
         7DJYdaBjKfGkh7mpaBMvUVmkDgBq+HURwsegaT0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.4 42/80] dma-buf: Fix memory leak in sync_file_merge()
Date:   Thu, 19 Dec 2019 19:34:34 +0100
Message-Id: <20191219183110.617057484@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 6645d42d79d33e8a9fe262660a75d5f4556bbea9 upstream.

In the implementation of sync_file_merge() the allocated sync_file is
leaked if number of fences overflows. Release sync_file by goto err.

Fixes: a02b9dc90d84 ("dma-buf/sync_file: refactor fence storage in struct sync_file")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20191122220957.30427-1-navid.emamdoost@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma-buf/sync_file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -221,7 +221,7 @@ static struct sync_file *sync_file_merge
 	a_fences = get_fences(a, &a_num_fences);
 	b_fences = get_fences(b, &b_num_fences);
 	if (a_num_fences > INT_MAX - b_num_fences)
-		return NULL;
+		goto err;
 
 	num_fences = a_num_fences + b_num_fences;
 



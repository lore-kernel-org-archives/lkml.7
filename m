Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB846ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E90207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264126;
	bh=63xkLxkUotMUnWO/uNovp+BQgIxw8vaR63O7ZnTDUts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KQcsCIydUFTmLwI+GwFdFVqhF00gs+bqBBTBJVNaBtwcIq041kz8uf+T5+s7JxoD/
	 XzOEMVqSJnUMhPBNF7fvtyuyRaeJEcWa5fXwqrQC0ASuOdwPOjXhmN1BLUbbbiotFE
	 LYzeTYaQ8sdvezfGvdxKMsZbqrLUkKSoYpbhiVxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439364AbfJPWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437812AbfJPVzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:25 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A3221A49;
        Wed, 16 Oct 2019 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262924;
        bh=63xkLxkUotMUnWO/uNovp+BQgIxw8vaR63O7ZnTDUts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5SjW7VE1z9GV85vyha1guUU361DmMn4apVKB2NvQBD93drw6Os6dyl5hYLJ/lb3c
         P9e3T3iySHPwKm6iUrGazYtb2ksFvOSdHUwqpyznxIV+OK9oFeVEPFy7zoptQ5bKtQ
         l9gqHqIwNuVlWr6ed7QlLEdujhnujDqhVF4Er6Ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Dan Carpenter <dan.carpenter@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 84/92] Staging: fbtft: fix memory leak in fbtft_framebuffer_alloc
Date:   Wed, 16 Oct 2019 14:50:57 -0700
Message-Id: <20191016214847.665387092@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 5bdea6060618cfcf1459dca137e89aee038ac8b9 ]

In fbtft_framebuffer_alloc the error handling path should take care of
releasing frame buffer after it is allocated via framebuffer_alloc, too.
Therefore, in two failure cases the goto destination is changed to
address this issue.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190930030949.28615-1-navid.emamdoost@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f4682ba44cd74..d9ba8c0f1353b 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -814,7 +814,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par,
 			par->gamma.curves, gamma, strlen(gamma)))
-			goto alloc_fail;
+			goto release_framebuf;
 	}
 
 	/* Transmit buffer */
@@ -839,7 +839,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 			txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		}
 		if (!txbuf)
-			goto alloc_fail;
+			goto release_framebuf;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -875,6 +875,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+release_framebuf:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 
-- 
2.20.1




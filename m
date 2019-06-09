Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC74C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF7206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099053;
	bh=B2SiIh6nqU8JhbnZqr5zqXd+B9YpyaDEGxBG0NX2oos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKKpwWYNrQod/D16IUUmCeHFfKPUKrIRn2DT4tdDsE8L/gDgZmnrqUoc3b8WGMQD9
	 Qx6jDFIO2QiTWz75qGwJTGTNK7OBnu1MbpavnshxiPqcN2BCfvG39yDNmX3ru2JoYs
	 jAyQwziybmpU9gGbrGWFTJStsoed5Zo7ZAaMOUNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfFIQuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbfFIQut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:50:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0F6205ED;
        Sun,  9 Jun 2019 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099048;
        bh=B2SiIh6nqU8JhbnZqr5zqXd+B9YpyaDEGxBG0NX2oos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hp8zclJaXmtZ0EEMH+PZe4SdId+YHbl8oLSFDC/UOb5xIvAqyfNSL/e8PZUEUQKys
         STpg70e9D7MC5xowe0ZiAQO0ZCBc6I2iLd7felseIbA7lQSaHTc7CrvIkY2npRcU4z
         LEBJ5TVe34v7l6JGsNAP7nfBQVyfEKCGK25eV6cE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Dufresne <dufresnep@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 29/35] drm/radeon: prefer lower reference dividers
Date:   Sun,  9 Jun 2019 18:42:35 +0200
Message-Id: <20190609164127.196085204@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

commit 2e26ccb119bde03584be53406bbd22e711b0d6e6 upstream.

Instead of the closest reference divider prefer the lowest,
this fixes flickering issues on HP Compaq nx9420.

Bugs: https://bugs.freedesktop.org/show_bug.cgi?id=108514
Suggested-by: Paul Dufresne <dufresnep@gmail.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_display.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -923,12 +923,12 @@ static void avivo_get_fb_ref_div(unsigne
 	ref_div_max = max(min(100 / post_div, ref_div_max), 1u);
 
 	/* get matching reference and feedback divider */
-	*ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), ref_div_max);
+	*ref_div = min(max(den/post_div, 1u), ref_div_max);
 	*fb_div = DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);
 
 	/* limit fb divider to its maximum */
 	if (*fb_div > fb_div_max) {
-		*ref_div = DIV_ROUND_CLOSEST(*ref_div * fb_div_max, *fb_div);
+		*ref_div = (*ref_div * fb_div_max)/(*fb_div);
 		*fb_div = fb_div_max;
 	}
 }



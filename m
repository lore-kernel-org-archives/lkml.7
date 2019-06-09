Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2EC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000020833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098980;
	bh=N0Kw7vsq9JuxlQeOCDHpr+EA5dFjOJ5sWSKiUb2/ml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvHcoWQvdxPVoSBQEpiTR2VEcCO4up1jUuoRQL0VrAP4Jc20wJzQ6YXxIEfx29KMP
	 jeeJMrnFnaVA4B49Cd4mVhR27phCregfKcEeUDAFww/o91+peh8tchS4wCkUyhB1Hz
	 KtjfrpJAbTsPEddiv27D+11BbTokOggoO2tjP1IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfFIQtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731519AbfFIQth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:49:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4847F20833;
        Sun,  9 Jun 2019 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098976;
        bh=N0Kw7vsq9JuxlQeOCDHpr+EA5dFjOJ5sWSKiUb2/ml4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FibDr2eIhYKR15LIX5y185G8PcC0UajvzHcOIZ6/bRfQyVIhmQjmfu4HPCvh3Kqah
         zTpmrrJSSGqjUXSWpnGFMzCf0uLFpx7WSb8TrUO/7I2my4PBBj6S++fYzCaQQyswGI
         moOse/MG5jt/F/9JC8akwwcBJtQCLmFBl55tLgbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Dufresne <dufresnep@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 43/51] drm/radeon: prefer lower reference dividers
Date:   Sun,  9 Jun 2019 18:42:24 +0200
Message-Id: <20190609164130.191475090@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
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
@@ -921,12 +921,12 @@ static void avivo_get_fb_ref_div(unsigne
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



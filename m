Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A9A21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696827;
	bh=PQpdJK/h9ToD5AevYVxFZxB/f9VAVRWbA53bQfTfcew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6MJWD0JP8ZOjftMlTcI+nNfp9TqLFQ9n8lUWktzUOYW9nPt+vBjyv3Yg2boTl46A
	 6RJxjSdcgcetd1wjv0f/Gg1T4Tb3OpDryWRZH/eIijmkElTchJjYl5h3CUCFLAIq2U
	 d3kLJxOYZ5bWV84bnHVSkOVD7P187ZPtbrp4RNME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfJJIk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbfJJIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0715721D6C;
        Thu, 10 Oct 2019 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696824;
        bh=PQpdJK/h9ToD5AevYVxFZxB/f9VAVRWbA53bQfTfcew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iR5sm8Sa76ON4c1T/ffjovAvXJcRQG0nPltDjy76VDxG9wYKnt0KRUh5R+PyjJBJG
         ei13oh12qDImXHzRToFfi2O+h7j1vyN8n8oyToKR5TlATPMC/b5gCeot/l7oPBJrlw
         OY5+L8m5cwW5OcaOK5QoNLPkGxWJvEecX702vNNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [PATCH 5.3 065/148] drm: mali-dp: Mark expected switch fall-through
Date:   Thu, 10 Oct 2019 10:35:26 +0200
Message-Id: <20191010083615.398042278@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

commit 28ba1b1da49a20ba8fb767d6ddd7c521ec79a119 upstream.

Now that -Wimplicit-fallthrough is passed to GCC by default, the
following warnings shows up:

../drivers/gpu/drm/arm/malidp_hw.c: In function ‘malidp_format_get_bpp’:
../drivers/gpu/drm/arm/malidp_hw.c:387:8: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    bpp = 30;
    ~~~~^~~~
../drivers/gpu/drm/arm/malidp_hw.c:388:3: note: here
   case DRM_FORMAT_YUV420_10BIT:
   ^~~~
../drivers/gpu/drm/arm/malidp_hw.c: In function ‘malidp_se_irq’:
../drivers/gpu/drm/arm/malidp_hw.c:1311:4: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    drm_writeback_signal_completion(&malidp->mw_connector, 0);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/gpu/drm/arm/malidp_hw.c:1313:3: note: here
   case MW_START:
   ^~~~

Rework to add a 'break;' in a case that didn't have it so that
the compiler doesn't warn about fall-through.

Cc: stable@vger.kernel.org # v5.2+
Fixes: b8207562abdd ("drm/arm/malidp: Specified the rotation memory requirements for AFBC YUV formats")
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190730153056.3606-1-anders.roxell@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/arm/malidp_hw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -385,6 +385,7 @@ int malidp_format_get_bpp(u32 fmt)
 		switch (fmt) {
 		case DRM_FORMAT_VUY101010:
 			bpp = 30;
+			break;
 		case DRM_FORMAT_YUV420_10BIT:
 			bpp = 15;
 			break;
@@ -1309,7 +1310,7 @@ static irqreturn_t malidp_se_irq(int irq
 			break;
 		case MW_RESTART:
 			drm_writeback_signal_completion(&malidp->mw_connector, 0);
-			/* fall through to a new start */
+			/* fall through - to a new start */
 		case MW_START:
 			/* writeback started, need to emulate one-shot mode */
 			hw->disable_memwrite(hwdev);



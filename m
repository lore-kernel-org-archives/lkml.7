Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C8FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D008208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723987;
	bh=evdGKyD5k1ccTowkp8GnBdRSislkNYG2obtcT6+5mYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ia/6JN+AqaRuMMYtqgkjjrj/JsFigkB+nHJiMnm8YEhzlMeEOT1kTNfMhPKdL6KYc
	 9DtbTRUsLZQMKUt3EEqUTfk3kTIQlhfFebCETtDDaudOdaAyJA11eXLMl+JOgT3vEJ
	 K+e4tE+3o9wHBeZqqqngVsyZZybJIz6T7yA9xXeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfF1MNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfF1MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xgArw+nVtTXG7oezfdfD4Z1XiVxNfU8kA8v4SVH+Er8=; b=ITumh1hpTD7+B/EVZ6n1CFKo08
        GNhFv/qVUqvbCJ19/XtqTJnqth9v62XTiYrepBljgdrmRc7+HFU5dBP5gx+Hfli6bxFuht1r0ng72
        /sUimSqZA8hTpjawzsXch+hPAzngWgViX2d4EZrfM7RQ9XV9y1ijq5zaSRhnESpyThpmGIXY+rTfP
        FEzKpW77yh6bBHQRebCxcOU0E/s6bUt8oLNG+/w4R0LCICmrYay1RcIeK1+9nySeyWoUtaIRr551o
        GlXKxxFscTw5LxxYUkI+qjzU+jXmQIYOxglnckumXrXx78cDnX+zTJChsCeyvdC8E9Qrux7fA4TZC
        E/KTlIaQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BZ-Ab; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zn-Ck; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 8/9] drm: fix a reference for a renamed file: fb/modedb.rst
Date:   Fri, 28 Jun 2019 09:12:30 -0300
Message-Id: <987e1d181a3512b14ffb6702a6f1ad9a22ae8898.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to two patches being applied about the same time, the
reference for modedb.rst file got wrong:

	Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.

Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/gpu/drm/drm_modes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 57e6408288c8..4645af681ef8 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1680,7 +1680,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
  *
  * Additionals options can be provided following the mode, using a comma to
  * separate each option. Valid options can be found in
- * Documentation/fb/modedb.txt.
+ * Documentation/fb/modedb.rst.
  *
  * The intermediate drm_cmdline_mode structure is required to store additional
  * options from the command line modline like the force-enable/disable flag.
-- 
2.21.0


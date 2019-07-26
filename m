Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64DEC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F20216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1iiTaju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGZL1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36760 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so36876549lfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkrBq1SnQkOBmUfMH8XCY0QYWm6lQdUCAmJmwMI79D0=;
        b=M1iiTajuphNdCuVUNMETkotkLA2uwCvt8+fc0HhCeN8FY+jFkztC4vtaGleozZsjp0
         6RMNu1DG/drs0/txBSzX43RNK90A7jWVLQKj7569hfsTDoGateqOXe1wyVw2ycSt2flz
         WQE50mSYm5i94JOt4yAmI7YS+QcvOophZcWXbxWG5SMmo6KvALzHHE/IkQL/6c4yP81B
         RIPsLIdqUHaX33s/nJ46/ywpe+27JJ3KnbewYtlEdXxprzRmSC8RwalTuBTXMkecFgst
         ogj0phHtXMzsMPeheYDnkX5vAAIX2ZSvetV6x7plm+lhzWJymY3iXk8EpWfyRmHC/sI5
         JVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkrBq1SnQkOBmUfMH8XCY0QYWm6lQdUCAmJmwMI79D0=;
        b=KKIK6tDJIKcvj5rgjLFSDBDA5kh7lufFJWrmjCLIvky/gPKFYxj+7eyAbnqIXprmzI
         WwQDb3V/95NxDvFLt0pvQLFQVyXfwRPRYPJipRbQhlP7HV6XRvgBpfRfy0wktl5B9tZL
         cLrKs3X+wKnd8MQZivvS0QLIFsdCBvED9y/O262+B+6T7GMTkW3Qd+/1pWLZaFUu5iW0
         gc5z+jYFoArSSN8huaLq9JSMoIqir/Z8ANnQQrvRjXdlEaFXCEAfHM0wy1aRtD1rIchP
         fp25Hi/ossYUk3IzAuXLUnzX8YXLF/tbW/DmZPy9ROqzKyjmGwjw45/pJhNFd9EOyBeO
         13yA==
X-Gm-Message-State: APjAAAWk9h1oKZC9pTSpmYdXNNrVjRoPKYUJ9ek9iQtlHJ4VhMC+PG7v
        /21qzy7azdoNpIDpe78j7eCP3Q==
X-Google-Smtp-Source: APXvYqymqL8+0NGle9LgsNo7cZJpanm/SQJZbXSjQtqaniNF93z4a6wOvybY0QrHQE3O8e+4n1Fo6A==
X-Received: by 2002:ac2:5b09:: with SMTP id v9mr6868915lfn.22.1564140466048;
        Fri, 26 Jul 2019 04:27:46 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id u17sm8391919lfq.69.2019.07.26.04.27.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:45 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] drm: mali-dp: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:41 +0200
Message-Id: <20190726112741.19360-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default, commit d93512ef0f0e
("Makefile: Globally enable fall-through warning"), the following
warnings was starting to show up:

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

Cc: stable@vger.kernel.org # v4.9+
Fixes: b8207562abdd ("drm/arm/malidp: Specified the rotation memory requirements for AFBC YUV formats")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/arm/malidp_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 50af399d7f6f..dc5fff9af338 100644
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
@@ -1309,7 +1310,7 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 			break;
 		case MW_RESTART:
 			drm_writeback_signal_completion(&malidp->mw_connector, 0);
-			/* fall through to a new start */
+			/* fall through */
 		case MW_START:
 			/* writeback started, need to emulate one-shot mode */
 			hw->disable_memwrite(hwdev);
-- 
2.20.1


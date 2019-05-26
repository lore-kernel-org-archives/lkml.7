Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B69C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ABC2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO2OJ6bU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfEZK7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 06:59:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41374 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEZK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 06:59:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id d14so368989pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2pMI0TxvbszUYLNen9JiMBX7dkFbg/aa3u3WzyR2uKI=;
        b=rO2OJ6bUDdn6tVbaU9JLevvxpMRho/K0ImE8V7MP/hoeb0j8tancISakTvTwhJxSUi
         HqQ1L9zqv5raxhOOpIvvhFuUquFEVkT0zu929Byuil3v4RTy3I6v5p6h8jN7QvlKYBYr
         CZCo63eDlK0eF1Omb3y1Sq5JuCayY8yW7nuzh8FlvOzQwln621/3DWUX+LW0qvIJys6r
         U8Ty97aCxHfYqc2NNqVs0L2CkV6xJyJBjkBtbopzyuLo2UKVKwpUpui/c5DEWFlWpTNT
         dWaHAeK2KFxnHFQ3MUSkBqpbEAlwqtOAzcQIcBLJv6qRgpkxlIyqL4P+YiVwqI64NyZU
         UKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2pMI0TxvbszUYLNen9JiMBX7dkFbg/aa3u3WzyR2uKI=;
        b=S2tTOfOi7EicQ+8Rnw/6I4p36gIShg4d9nYYRVutIbPJgQAPfdLgeVWz9EqVtEe0DY
         NJvvQgEE1lt2f7WeW0HGP8zZoK9JXSI6aTvxD+jY6sCubxAk5FwFeMOEZJig0WTmFUvl
         86SysHYBdtA/NOvVVy+Tw//RMRWZUIvSm0UyhOc3G+6UdbDCBmBIW5J/+XUThLdwfWfN
         vjMPwCo8iWr6iPRTijDeUodW0PHKhZEV50W1ErxVrLi0VC4rD1qVipq4DWrZ/8fpV7j1
         JMC2n9HC4tg9IvZssMmrRrChY16tTe2TfP3miitvfQv89JFF4RnbkzL1dI9U5wAnvydY
         5hpA==
X-Gm-Message-State: APjAAAWUvwh7hoi4ynTJzs+W7tU+4RqvEOfbj7DuCbt+RoZaYde/hiIM
        jn4joptTWwB/DGJZfn0Q3Wc=
X-Google-Smtp-Source: APXvYqzZ/Ql4lxowsEEZVCxTIcuNT0XsMDFt0ghrVHkXu7ZIypKWI/BiwkKkceYcHwozVWeOxD7pNw==
X-Received: by 2002:a17:902:e40a:: with SMTP id ci10mr73060394plb.195.1558868382078;
        Sun, 26 May 2019 03:59:42 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id d85sm9011325pfd.94.2019.05.26.03.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 03:59:41 -0700 (PDT)
Date:   Sun, 26 May 2019 16:29:36 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/dispnv04: subdev/bios.h is included more than
 once
Message-ID: <20190526105935.GA2983@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicate inclusion of subdev/bios.h

Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/disp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.h b/drivers/gpu/drm/nouveau/dispnv04/disp.h
index c6ed20a..195d899 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.h
@@ -161,7 +161,6 @@ nv_match_device(struct drm_device *dev, unsigned device,
 		dev->pdev->subsystem_device == sub_device;
 }
 
-#include <subdev/bios.h>
 #include <subdev/bios/init.h>
 
 static inline void
-- 
2.7.4


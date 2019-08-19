Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA1922CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuR2cIhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfHSXE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44366 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfHSXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so2024207pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6m141WDgWo2fEqKOTQPkh65ch/WaZ2zC8BGag2kGAk=;
        b=HuR2cIhjFWz+4JWrKq4LPu+TjN9IyLdmlpABHg6FpMPw8pF218Oqvf9YVNMUAgT+ZQ
         sLeCCgC3vmOwiPEZyMojK3wG0zhYyUADo4mCJA2OUb1yEg4s0eGV/cZUycvnm9GR8fJ0
         Ufk4ce6n6CJ4LTnq4ttEKktmGl4lTrix5wNVKAGKa8Xxg2a/HdfZwWSMn1XyHStyImMX
         ArMe/zCWSjcBwhVq+ymr85UBC2LsCmjEKOE/xpvezdW1xE0a1Jxv0cbmaUzMKEduL6Qr
         I+pUxL83x/pgtjfyBOIACYuCJkkSGW9Wk2kM8d3mX3/9HXqoVqz8XmocHRndfednTYCy
         VVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6m141WDgWo2fEqKOTQPkh65ch/WaZ2zC8BGag2kGAk=;
        b=CMUxgSOcwqZo55KF9Za3b9OY28eepY5fjxvkhJXXW4P3tmGR3g28Eyuhl8YcX99Stp
         rMxE2ToehU+4XejPwKJe5whOiMgksdNnJfuwEs5VXN85IHvNs4GiK/0OTY9/O2hbL/vr
         dtZTTS0QddMDbbPnIRJ0zR2X3Pp7wqWi26VC9qiugz+QmrJXril5eW3vG/AQbWHdJEij
         7dhVkWzPAghCFIlRO84nYEWb1S0sp67yIF5HteBGAzKHxdMagpTag2wy+b4PZew9kjMI
         MQrP5pSkHXbHnUUhOVaOUSsujWxxx+1bWYI5wXP/mIKSPeXJTr3AvfyCTl/XXzB7p4TK
         LFAA==
X-Gm-Message-State: APjAAAWS7QT80g5PdU9K0SYac2gRNE4kTz8RbXlpgqLF9Xwjemtw6prS
        tHPpaw0aHiEICdqLgcnhW6zSQBXrTpo=
X-Google-Smtp-Source: APXvYqwG9W4CfZHOjBvxvQuucJnsWPQbrgBVAkuIl+wmQF01BSo9fnI1CCwcy8t95kgUzAi6UtR7Qg==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr26730739pfa.96.1566255810038;
        Mon, 19 Aug 2019 16:03:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:29 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 03/25] drm: kirin: Remove unreachable return
Date:   Mon, 19 Aug 2019 23:02:59 +0000
Message-Id: <20190819230321.56480-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'return 0' in kirin_drm_platform_probe() is unreachable
code, so remove it.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Suggested by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 204c94c01e3d..fcdd6b1e167d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -208,8 +208,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	of_node_put(remote);
 
 	return component_master_add_with_match(dev, &kirin_drm_ops, match);
-
-	return 0;
 }
 
 static int kirin_drm_platform_remove(struct platform_device *pdev)
-- 
2.17.1


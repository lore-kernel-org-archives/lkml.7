Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290C20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xU3RqNBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfHTXGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44186 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfHTXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so209749plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6m141WDgWo2fEqKOTQPkh65ch/WaZ2zC8BGag2kGAk=;
        b=xU3RqNBdba+sjj16E8oEggAfQ3tfoyAiSrPQbTkSPPgvVvJd17JZENyO47OSnMtF/J
         arQsfrqPH6HE4qSgYaDIVVZ6NYgELBTOHWU/uyOzReRxybENDaylvj05Wldh9PDCSIq+
         klWJKX6XnHYYBbQjNTWo7zETkfk8t+J8XCBHpHQo8hKOQ1S/r/9h/0fWizsnZfbbCjIo
         AnEX938ZPQIanIojy4XrVQtESf5XZhDnt1rTmD/UY/C6opfQvyxkOscJKzqEW4vhIZj8
         nn9z024aVq6ZGP02cOJejzYba2lo48VNhCqvPSz+C1pNe1BTXFzJ+ttD2lu/QbK81nDn
         k2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6m141WDgWo2fEqKOTQPkh65ch/WaZ2zC8BGag2kGAk=;
        b=LYyU5qZ/rN7eJa3OtncRnS7oDwoC01F9FbBHw7GbCwoZ+ggv4gLoDh+vNgWnVZXW5g
         gXHgt8qDv7+4D8V0POuL51PRud+psKY+P5G7wDD1osG2JSVykfgexIAqxz9861JPzy2a
         AuuY+J1YF0yYH354jdkJxhPNMfy+dDocHSKusNZSGQCI98mRhqYUUcqp/63HxjuRrjp8
         wttBAgNbgoKwf9GcntfgM2kEJQeIGpa/tcn6oSOAgUgxNpiDL2KrecRd5ZabqiR3cFEN
         sfw2j5NghNDIVr6gNn4HvLFafFyv5uaYfuF2zOtETNnDgi10SG31mIjxOykR7dR+Co6G
         ED5g==
X-Gm-Message-State: APjAAAXAzP9wG+6myJE/mA7762oQ92UnvSwWMMJh32FUX85gu2N8cub0
        nwHNpUnT6lqrVpqcIZjorTqnH0L5hRw=
X-Google-Smtp-Source: APXvYqwSD86miSdIr5XIL6amQdd092Qu4cUoqGCUj8MABeZCa7rID5KZaxQ4HCPPF75msEeuaCPuMg==
X-Received: by 2002:a17:902:9f8e:: with SMTP id g14mr31066446plq.67.1566342394450;
        Tue, 20 Aug 2019 16:06:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 03/25] drm: kirin: Remove unreachable return
Date:   Tue, 20 Aug 2019 23:06:04 +0000
Message-Id: <20190820230626.23253-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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


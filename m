Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523E206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3/bLx0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfENHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:31:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:31:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so8649994pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=s/sQlqp99nJA/7VNGTPHqYbSkGF5LqoG/HcNRpQv3Nk=;
        b=f3/bLx0YYNpy6z0dOLKo6LV1cUhkhK9f9VbG9O2g/twcl+paKF47Ro0iLj3XEydSbY
         IRPeeEkj05Hs6KIZaEeDreBRMWvCD+cGPrPcm6B0CaILWzyvUlj+19RVF28MIZl/nDvF
         xSJE4/flkQCkDNOZzCERY123sqWTYLt6PP4dnvzlPc+bVF4fxvy0kqSw1nFD9UxgiKT5
         Vcy+ziDvYHtjQ2lvfQCeM/S3MdBv2qqS07OgrIIgtbIDWuKOtHQiSYFPC+pO4WUESobg
         5EGxVNHY0VPCg7olywfXOolqyZbfATL3qycYIK3/5uQur4BbSx5fyRHgx236fpEPcl9r
         jPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=s/sQlqp99nJA/7VNGTPHqYbSkGF5LqoG/HcNRpQv3Nk=;
        b=tD9xoNgMHIdCH2/7Epv8xynNyGYoRQvjKLUANu/6DY8MkS06cKEpokxVanolyGoEp4
         ltzSUgUobCDd5TNeTR0IdjRMYFfhJu2gmmtSnJXTvNJgopJFvZJ5N9jsdspIGggnPZru
         qHfgGTGAuB70PN0Ns0vhnlEdq9HMf5UHYoZGklktuWLxxTYuIWkFyJRwCDvN2hiPEZo3
         KzzFSpY/ivQjE8p6WkvgupLBqceKXfic9H+n97D8BgFGkWLi/7qclOdDqstzHWyA6zzF
         gBkxuloZB5U4ay+Z/DxRJ0yWzOm/VTLWkAljHhajcvOjRaoavK3OBH9pxawIrD28c4ih
         3YJw==
X-Gm-Message-State: APjAAAWPkuUzgzQo7e4WnAhQwSOR/K4gamXKSstXTwM0umq7aXhMI156
        1dFWKd065JXWSMBBo/xlq54baz5j
X-Google-Smtp-Source: APXvYqyBzzYvLZ+Pvf4kW5/ghr5RDfsFaIP4txDqRiWRkUKnEmS4jWZnLlSnc+i+ja/3theR44iHjg==
X-Received: by 2002:a63:555a:: with SMTP id f26mr36910942pgm.197.1557819107219;
        Tue, 14 May 2019 00:31:47 -0700 (PDT)
Received: from sabyasachi ([2405:205:641d:f30a:5511:e7cb:49d8:c4c3])
        by smtp.gmail.com with ESMTPSA id z6sm4527479pfr.135.2019.05.14.00.31.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 May 2019 00:31:46 -0700 (PDT)
Message-ID: <5cda6ee2.1c69fb81.2949b.d3e7@mx.google.com>
X-Google-Original-Message-ID: <20190514073141.GA6446@sabyasachi.linux@gmail.com>
Date:   Tue, 14 May 2019 13:01:41 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove drm/drm_panel.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/gpu/drm/bridge/panel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 7cbaba2..402b318 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -15,7 +15,6 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_panel.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
-- 
2.7.4


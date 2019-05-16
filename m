Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB0FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF620657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDAE0MkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfEPP0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:26:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36833 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfEPP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:26:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so1740957pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=vIQF8u3sZo2Bokqjd92RxldddXdBrsm+Bpa1o3oiahw=;
        b=IDAE0MkQ0jC55/yjj5oRUaa00DdXxU/xZUKnuZxDdjqQjUPFhuKUUtbsbJHIHMhJG3
         5ZQhvJovZWRnZvPp+R24lXk2ZchxecmHuTkVB7fr2awQn3teq1kTTxteEDhoYp/v72cO
         cM/qSdG808ffBbxz1gs6FV9ofuYpEZhGoRxvx8PhPdnJ79zMklDGNkiVWoZIdBzZC1kg
         KR0aphYsg8QYpaAH7SxcFohmatmUUmaAWTdQHK5ZSa9R4pnGzrJSM121skkGNfuNbeyx
         RgkFNTe4ooMHNYTP6may6kxgjQT0JgGRNi7QpUm3KHGK74oz7YOXGLQ8DqZHp10YQpNa
         QBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=vIQF8u3sZo2Bokqjd92RxldddXdBrsm+Bpa1o3oiahw=;
        b=LdQ807wONFjB9ZdLLt07KLm54nuX9WChzAjbGyhplSCeaTEs+DkGqwQO9VacjJWfEd
         TAqLZX258kYqop7xiEOYuWe6CKpnplu3QFpdQFl/qaASQAxraGuI2/bQuUkMOwlvp0yu
         AibIITB/LCUm41J0dT7bIT1XOoUYsAteGXO+XHHqyJ04p/d90EvE1K4Uyoh6u++4vwXd
         EB4+k9AowNjVF6JmOdG+tYm0KhTcDH0WGiS4oKzH3MCpM7TNp270K+JeJ75plSvQbEpU
         mmZqqWtQEv6BgCC+kH8DPd1nEzddVexX+atWlJ6kQHBDiQVRhIVHtHWDOvCmiWzcx3Uj
         ECfw==
X-Gm-Message-State: APjAAAVSpQ/aRjhUOpKPWqF0LtjenH9QSjvZwMhLWFi07Eo3EOOMzlqw
        nuJF+Tzy3GaQTddywgRatgEFlz9d
X-Google-Smtp-Source: APXvYqz72dew1ToMOg5F8RliET5tFWucXwzWX7IAcySJmTaous3XrKM27Vpe+r64itfI0uYjOFs1Zw==
X-Received: by 2002:a63:e43:: with SMTP id 3mr8094389pgo.253.1558020361972;
        Thu, 16 May 2019 08:26:01 -0700 (PDT)
Received: from sabyasachi ([2405:205:6486:db74:e0d2:7d60:25b1:4824])
        by smtp.gmail.com with ESMTPSA id 79sm10944464pfz.144.2019.05.16.08.26.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 May 2019 08:26:01 -0700 (PDT)
Message-ID: <5cdd8109.1c69fb81.6e003.b84b@mx.google.com>
X-Google-Original-Message-ID: <20190516152556.GA10079@sabyasachi.linux@gmail.com>
Date:   Thu, 16 May 2019 20:55:56 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
v2: rebased the code against drm -next and arranged the headers alphabetically

 drivers/gpu/drm/bridge/panel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 38eeaf8..000ba7c 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -9,13 +9,12 @@
  */
 
 #include <drm/drmP.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
-- 
2.7.4


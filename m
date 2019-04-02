Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7814C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9376B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/fEjY31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfDBNqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:46:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38224 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbfDBNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:46:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so6608634pgl.5;
        Tue, 02 Apr 2019 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YqIMrmQmzYreFIlvoeInJvCRgvZcjQ6FaeyL6F6VsK0=;
        b=b/fEjY31h2ev31RUjROYMOXFnb+FhtLSgt7bhUiKTvqRBa547xZiJpJuw7oCMnwCoI
         TlUqxxoVEbzt0XaHBvZWkQ3tJpjTkZcAq1IP94GXbrQ/3Wkcxcq57N5zTcB9mv3UdAAc
         DOazaFv+1xz8dmCk5Hxp9OU/9ftdmtT5NVOnkd05kPAMD1FCD+5wMzC6Jo+chAik0+2u
         pwIZrQC/UVHbOgzhkzYSzzG+6Nvfw9oGCD+AW0pY3hQrYt/a4rJiaUS/dky+7TXuiI+K
         xCSGWgaVoQU5kbDIMiVqatE3GGNaudsW/CqfO8SpFbec/MdjGC9aWw4dpIvE8QnP+2af
         tjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YqIMrmQmzYreFIlvoeInJvCRgvZcjQ6FaeyL6F6VsK0=;
        b=LUbQcf6biQ4fuNhLMkYE8hNOS7H0XV2US2DFSksjnGziQIKJuP6rReJ3H8dPlR36Tc
         tLJfFOa1OAwlVGhPm+CEygloX6Q2CDwMLMXJHfgIq9rkYEjH8Bht52AvRhSWIhc46ka5
         H6K/YCs7eO9zL5NnmUSSajwddBXChF+CTIpFAsQi4NnhLgtdDbnokSOtJyOm4r/C8a1f
         RCUMiOEkTaio/uubBvAQpYWAZ3Cfktb36TQpj5oGFdlFCvQFZH5bu0ZILotXzSYcON7I
         mAi0ci0kjF4zswwFM+0ZSiHrsPMET/m4LwUcXaRH9ynOduO06wImQF2EzVR3bN/E6UFu
         74eg==
X-Gm-Message-State: APjAAAXxYUwv4uB9SaXWrchyibCs6bFe1nevO+aK1i+6LT06AJI12jWS
        hZMM6mPdmLyb3enYWajkmzc=
X-Google-Smtp-Source: APXvYqwDpJiWmikkeIUz+Fl2HB0idgREqO5veygsJplxlF3zWjbo1vnHCIoQ6EtvO/6MSG0kJRWTuw==
X-Received: by 2002:a63:ce45:: with SMTP id r5mr15216012pgi.330.1554212793398;
        Tue, 02 Apr 2019 06:46:33 -0700 (PDT)
Received: from localhost.localdomain ([150.109.119.235])
        by smtp.gmail.com with ESMTPSA id g4sm19786662pfo.38.2019.04.02.06.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 06:46:32 -0700 (PDT)
From:   Qiang Yu <yuq825@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, Qiang Yu <yuq825@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/lima: adopt xa_alloc API change
Date:   Tue,  2 Apr 2019 21:45:47 +0800
Message-Id: <20190402134547.15314-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKGbVbt4W8UUST8HZ0tPuHyGv4qx98hMqmkhWmJB5K-TbReg5A@mail.gmail.com>
References: <CAKGbVbt4W8UUST8HZ0tPuHyGv4qx98hMqmkhWmJB5K-TbReg5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
index c8d12f7c6894..22fff6caa961 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 			goto err_out0;
 	}
 
-	err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
+	err = xa_alloc(&mgr->handles, id, ctx, xa_limit_32b, GFP_KERNEL);
 	if (err < 0)
 		goto err_out0;
 
-- 
2.17.1


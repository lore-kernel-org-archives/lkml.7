Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0876FC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C7B2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAqSgrQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfEKGDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 02:03:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfEKGDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 02:03:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so4027980pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBIV0O0qGoeY97ZaUi2m9+lkbOG6A0guIBzLPEYh3y8=;
        b=XAqSgrQEObDwj/mPPtLgS0JSVjBIlJJ/0JJnvBFfJ+3+31lwnxrp1DvnQ57VnKE9X0
         EZD1SyQi6bcCqGn6+UpqH0tzOiXQ+9oiv1q8HTd7CvybmcfKD5FnLzKPbKIHKe30jCZL
         kDhbyCVATD5KXgcGwRtzAKeCmQqqVmR/QvJw5+IjT+el2LTK5cptFWDB8Xu85xZF5Afv
         qIjg/QHW4EmhVtP3c/SDYWnB7LFr3YATCix5ipOP+n+YAKyJiP4w0eza0J6qk5643WAU
         TqJnKWSMp8QAoSsfe03TaJlsv5O8DKGZO0dYjJRXkG5dEu9Em/oKJM29est7aD/uu5tN
         MFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBIV0O0qGoeY97ZaUi2m9+lkbOG6A0guIBzLPEYh3y8=;
        b=LCvcIJysoLx/8fe+OyxK1vfjRGw4AxoPZowZe4SfkG/okbxLye3UfdcKMLO6VXFoXd
         QjW96gLxVaihAmakSzwVnNxtAx6MPU6sM5fchXCAXCKGcwTd7Bk4yihKChjKLe5xmWrA
         iqS10o7xmxed/+bf0RKXYfg3hUvWrEpyJtNM9uXYpkk9A3buP71CEpl1OG52Yo4bcfDK
         B5evCotRHgtUJNpCpKr1U4//LwsRhYlH3bYwK4P2fYC8pqE87RhHcMlLitQ71FF9I669
         +XMpcBjvJmmMQ+taGYDK9YRkDAYmSNzA97dCVhknPzc+4iCOqWWmWT2cV68/GZk8jI4L
         gYqA==
X-Gm-Message-State: APjAAAUTJW8vWlxa6d+MuWQxQUgMXoellcIF70wUd4tAv33gyY21gTDl
        hMt8E6pX+BaNAg75bWwwlB09Zj7h+v9+Sw==
X-Google-Smtp-Source: APXvYqxZTw/+JETq1S5v5JxKB0pyLjUgcIwpOyyHOLrwQhYgB19EUcR23ia58Yj0e4cZbS6D2rfyjw==
X-Received: by 2002:a65:4589:: with SMTP id o9mr18550951pgq.381.1557554599593;
        Fri, 10 May 2019 23:03:19 -0700 (PDT)
Received: from localhost.localdomain (115.193.225.49.dyn.cust.vf.net.nz. [49.225.193.115])
        by smtp.gmail.com with ESMTPSA id m17sm11687559pfi.17.2019.05.10.23.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 23:03:19 -0700 (PDT)
From:   Murray McAllister <murray.mcallister@gmail.com>
Cc:     murray.mcallister@gmail.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: NULL pointer dereference from vmw_cmd_dx_view_define()
Date:   Sat, 11 May 2019 18:01:37 +1200
Message-Id: <20190511060138.20592-1-murray.mcallister@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SVGA_3D_CMD_DX_DEFINE_RENDERTARGET_VIEW is called with a surface
ID of SVGA3D_INVALID_ID, the srf struct will remain NULL after
vmw_cmd_res_check(), leading to a null pointer dereference in
vmw_view_add().

Signed-off-by: Murray McAllister <murray.mcallister@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 2ff7ba04d8c8..447afd086206 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2414,6 +2414,10 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cmd = container_of(header, typeof(*cmd), header);
+	if (unlikely(cmd->sid == SVGA3D_INVALID_ID)) {
+		DRM_ERROR("Invalid surface id.\n");
+		return -EINVAL;
+	}
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				VMW_RES_DIRTY_NONE, user_surface_converter,
 				&cmd->sid, &srf);
-- 
2.20.1


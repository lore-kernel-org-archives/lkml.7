Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F8C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75C6206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUn1g5/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfETJ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:58:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42794 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfETJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:58:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so6479945pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fjtvBI18+4dOm0uYdGwPyts2yAmhCRRn5DGw8hysxY=;
        b=KUn1g5/T7/kkbkiWBQl45OWxshQehWVf1/UP9bgWFIfx9chCmsx6fpjCJaoEzKBo1a
         otJJsSeR/66OGpQdHq0U4tSLrCZ7lvim/usSC67EgaavaxXFCPxSrC+yZvHVK0Bhn7HX
         PTkga2R/vMEJgUP8LDZst+RSCzXwxAtMgNEuv0fpbqQQnONeSeYKi2MIoVDVB+GE9WbE
         IT5Ua3LPBc3IgbQidvWKTlxqeKkABXxE20AbQlTGAbvG7xXx+iJXX2W2igMBVmeNU574
         2aY64x0kCJGofeBSsN8VLt7zCSBcR7azS0Bt/Ag8JuJkm7y4DIbtoKThbVX8F3bF+oB8
         ZdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fjtvBI18+4dOm0uYdGwPyts2yAmhCRRn5DGw8hysxY=;
        b=WaLdOH2aGsfwfOZgoEgWdMXwYc0cHH2Lx0Dy+6UhY7RMPAip+/N4Koe/ARlN1qlE62
         MdTsBOjF7hIwgZyiEGcSccfTbmRQt+34VZLWDi/viP7gusW44mYxekjtmwH1L1ms3XPH
         1C8wZ/GE7GRdlweWeAhb3agYF5PNTFZhoLZGiKwJ5XqqPjQkcBdSPYfECOgPtrvK9u1a
         IjXUvxUZNPtNcCrWDdrlEREOEUYnuLOqVqwiCieZCjrMAMZapIjQuQRa/TR18X5QVZ7s
         oyI9DE7/ZFsqMQBiug8UM883bXR7HXfanPRxox3zF040YPHGfIE47LFroFdDiLkkm/BO
         j6cA==
X-Gm-Message-State: APjAAAWF+fzTpqAXebYH/z0UKpaAsjwgAaz0Bk6nt/jIbv8kqN3dNnh1
        MjtEzuxjm0+UM2TRn0+SuQV0paqMhTcXFQ==
X-Google-Smtp-Source: APXvYqy7fU+iLxVDEbeDCOO1oSk707NS1Ej98E8zi7p3r9tceXsN3JCf0fIzWH/wPdSZspfZX5UMXQ==
X-Received: by 2002:a17:902:243:: with SMTP id 61mr30834953plc.132.1558346332842;
        Mon, 20 May 2019 02:58:52 -0700 (PDT)
Received: from localhost.localdomain (112.237.225.49.dyn.cust.vf.net.nz. [49.225.237.112])
        by smtp.gmail.com with ESMTPSA id o7sm25129376pfp.168.2019.05.20.02.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 02:58:52 -0700 (PDT)
From:   Murray McAllister <murray.mcallister@gmail.com>
Cc:     murray.mcallister@gmail.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading to an invalid read
Date:   Mon, 20 May 2019 21:57:34 +1200
Message-Id: <20190520095734.4655-1-murray.mcallister@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SVGA_3D_CMD_DX_SET_SHADER is called with a shader ID
of SVGA3D_INVALID_ID, and a shader type of
SVGA3D_SHADERTYPE_INVALID, the calculated binding.shader_slot
will be 4294967295, leading to an out-of-bounds read in vmw_binding_loc()
when the offset is calculated.

Signed-off-by: Murray McAllister <murray.mcallister@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 2ff7ba04d8c8..9aeb5448cfc1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2193,7 +2193,8 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX) {
+	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX ||
+	    cmd->body.type < SVGA3D_SHADERTYPE_MIN) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
 			       (unsigned int) cmd->body.type);
 		return -EINVAL;
-- 
2.20.1


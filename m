Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E3BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF572063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807185;
	bh=5FKgHiwaps52oURHQqc1RE4Wu7mEfpAXnwncpeXbwZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iwJtgoTgevWZXBUOt0JW+FqmovgzR6UOe23OOKbBov9rhLf9RV2gg8Ou7L5W0Z4xR
	 9oRBALhREkl8qqQpZQ7jX/NMzziVvhv4Nh5X1UFPeHDVER8VOYJPeEwT1MbcyM5O0S
	 KsVzh10zIM1WxoKYynGi3FH66Qd027wCJ3r/JONs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfFQV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbfFQV0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:26:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5671D20657;
        Mon, 17 Jun 2019 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806790;
        bh=5FKgHiwaps52oURHQqc1RE4Wu7mEfpAXnwncpeXbwZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHPbjfVM43XASP3zaaInNWR4/Rc/mZylqtAaNk0FIT8DgCZqN3dWLlAYUgxJm0KHI
         YXAysyIxhyMn9H6S9anJr6JX6WpC9sr8a+LnmIB2ey7i5mT0V8QYGlAN67JXe87hHC
         1Q8hWb7lSonrmdebvvPNRQTYSBYs5KPtMZb+5bBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Murray McAllister <murray.mcallister@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.19 57/75] drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading to an invalid read
Date:   Mon, 17 Jun 2019 23:10:08 +0200
Message-Id: <20190617210755.036336191@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murray McAllister <murray.mcallister@gmail.com>

commit 5ed7f4b5eca11c3c69e7c8b53e4321812bc1ee1e upstream.

If SVGA_3D_CMD_DX_SET_SHADER is called with a shader ID
of SVGA3D_INVALID_ID, and a shader type of
SVGA3D_SHADERTYPE_INVALID, the calculated binding.shader_slot
will be 4294967295, leading to an out-of-bounds read in vmw_binding_loc()
when the offset is calculated.

Cc: <stable@vger.kernel.org>
Fixes: d80efd5cb3de ("drm/vmwgfx: Initial DX support")
Signed-off-by: Murray McAllister <murray.mcallister@gmail.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2493,7 +2493,8 @@ static int vmw_cmd_dx_set_shader(struct
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX) {
+	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX ||
+	    cmd->body.type < SVGA3D_SHADERTYPE_MIN) {
 		DRM_ERROR("Illegal shader type %u.\n",
 			  (unsigned) cmd->body.type);
 		return -EINVAL;



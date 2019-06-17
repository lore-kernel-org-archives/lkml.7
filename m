Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0177C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A921019
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806963;
	bh=F/5YopCuNRb4BRWc18ZBCtqau+J9v363jyHKhUDFiKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qdGSueDYd3OLGye5V+ijR4ieYtE0f92WVkE203haBJlAjt7ZA2VZ1txfm8k0hXIu6
	 P3UeTBta+WhlMXDmhe0Ogtpa4Hhh/Mot9nuakI4lKMkg1WrxAEPzvkG3JGMyFnplP2
	 xdHiTQAEajT1bIjgsaRoK2IrLzyMpltHvXFIsmX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfFQV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729863AbfFQV3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:29:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBED62070B;
        Mon, 17 Jun 2019 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806957;
        bh=F/5YopCuNRb4BRWc18ZBCtqau+J9v363jyHKhUDFiKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFxVzqQ1Lt3j4TwuoWFPeUbuZeFTEALTDs/qbC21spHWOvDAbRFw9kUoW6iVL8ot3
         DD7rmyTpYwSrg8Utb1fbOijKp3X+KCHM6TI/rBCWNE2QRW8cLh7ZYYWJ2wPchFHx3F
         FgD9ZfBvULehFFNKRUUrmeAc/itYMWmrsyPYBc6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Murray McAllister <murray.mcallister@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.14 41/53] drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading to an invalid read
Date:   Mon, 17 Jun 2019 23:10:24 +0200
Message-Id: <20190617210752.019874935@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210745.104187490@linuxfoundation.org>
References: <20190617210745.104187490@linuxfoundation.org>
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
@@ -2495,7 +2495,8 @@ static int vmw_cmd_dx_set_shader(struct
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX) {
+	if (cmd->body.type >= SVGA3D_SHADERTYPE_DX10_MAX ||
+	    cmd->body.type < SVGA3D_SHADERTYPE_MIN) {
 		DRM_ERROR("Illegal shader type %u.\n",
 			  (unsigned) cmd->body.type);
 		return -EINVAL;



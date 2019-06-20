Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98018C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662222082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054038;
	bh=rTRSA2ixgXrIK32n3nUn99ovwkIyyyPn4BpR/+aI+fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjWvs6v4B3ZXO5D9HjWIdQ0oifBDdD/5bt/c16OjEymiDe1U2CLA39Ys38jz0rcrZ
	 K6VetDEcF9cnwZSw5NmZjw3obT6dWvncPr3MTZZn8DC/5apKN4Y0H8BynUaFlxa8YE
	 Wa482mipKQ0BsvKw0mLG8Vzf8HyK3kJoT3Gc2rsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFTSHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfFTSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B060E2089C;
        Thu, 20 Jun 2019 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054032;
        bh=rTRSA2ixgXrIK32n3nUn99ovwkIyyyPn4BpR/+aI+fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQZIR4zU9I16yzxeWRQjhGxrGqDWsljo7Fmk3/yfpIZ95wOewcE6uSdp+Z9RjTp1V
         5CVBQo1T2+JIpCIYohStgeA93vPvWvk30t9Xg6RtjkAEP7nQ4SRb1QaBEzvX8hIZ6P
         hwLMT1MlDnfNiLk5k3jgEP06qrsXCzvDg46eU3d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Murray McAllister <murray.mcallister@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.9 082/117] drm/vmwgfx: NULL pointer dereference from vmw_cmd_dx_view_define()
Date:   Thu, 20 Jun 2019 19:56:56 +0200
Message-Id: <20190620174357.216317178@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murray McAllister <murray.mcallister@gmail.com>

commit bcd6aa7b6cbfd6f985f606c6f76046d782905820 upstream.

If SVGA_3D_CMD_DX_DEFINE_RENDERTARGET_VIEW is called with a surface
ID of SVGA3D_INVALID_ID, the srf struct will remain NULL after
vmw_cmd_res_check(), leading to a null pointer dereference in
vmw_view_add().

Cc: <stable@vger.kernel.org>
Fixes: d80efd5cb3de ("drm/vmwgfx: Initial DX support")
Signed-off-by: Murray McAllister <murray.mcallister@gmail.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2733,6 +2733,10 @@ static int vmw_cmd_dx_view_define(struct
 	if (view_type == vmw_view_max)
 		return -EINVAL;
 	cmd = container_of(header, typeof(*cmd), header);
+	if (unlikely(cmd->sid == SVGA3D_INVALID_ID)) {
+		DRM_ERROR("Invalid surface id.\n");
+		return -EINVAL;
+	}
 	ret = vmw_cmd_res_check(dev_priv, sw_context, vmw_res_surface,
 				user_surface_converter,
 				&cmd->sid, &srf_node);



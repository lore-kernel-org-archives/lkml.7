Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D91C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7AC207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLIKWD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:22:03 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58624 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfLIKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:22:02 -0500
X-IronPort-AV: E=Sophos;i="5.69,294,1571695200"; 
   d="scan'208";a="419359771"
X-MGA-submission: =?us-ascii?q?MDEy0mNecwNuL9Jk5yYbF2EQVnchtra1QLxSda?=
 =?us-ascii?q?LVt2y4q13qmPpebNroNPIYago/EeZChF1k1i8WrzH2uQbUIlF5P+NBEb?=
 =?us-ascii?q?zQ45Lx2dyOC7BDW8GJHNWgCr6Dib9AlaQwu2cPD16slJUMVl5OoQGXuy?=
 =?us-ascii?q?KwBuaKZZ69PpoINS8s52KQlw=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2019 11:21:57 +0100
Date:   Mon, 9 Dec 2019 11:21:57 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer@vmware.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1606305704.12702713.1575886917867.JavaMail.zimbra@inria.fr>
In-Reply-To: <20191208105328.15335-1-lukas.bulwahn@gmail.com>
References: <20191208105328.15335-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace deprecated PTR_RET
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [202.161.33.40]
X-Mailer: Zimbra 8.7.11_GA_3800 (ZimbraWebClient - FF70 (Linux)/8.7.11_GA_3800)
Thread-Topic: drm/vmwgfx: Replace deprecated PTR_RET
Thread-Index: E97hwnQVmXIxUQ0U2XENNb5kIN+0Tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> De: "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
> À: "Thomas Hellstrom" <thellstrom@vmware.com>, dri-devel@lists.freedesktop.org
> Cc: "David Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, "Sinclair Yeh" <syeh@vmware.com>,
> linux-graphics-maintainer@vmware.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "Lukas Bulwahn"
> <lukas.bulwahn@gmail.com>
> Envoyé: Dimanche 8 Décembre 2019 18:53:28
> Objet: [PATCH] drm/vmwgfx: Replace deprecated PTR_RET

> Commit 508108ea2747 ("drm/vmwgfx: Don't refcount command-buffer managed
> resource lookups during command buffer validation") slips in use of
> deprecated PTR_RET. Use PTR_ERR_OR_ZERO instead.
> 
> As the PTR_ERR_OR_ZERO is a bit longer than PTR_RET, we introduce
> local variable ret for proper indentation and line-length limits.

Is 0 actually possible?  I have the impression that it is not, but perhaps I missed something.

julia


> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master (9455d25f4e3b) and next-20191207
> compile-tested on x86_64_defconfig + DRM_VMWGFX=y
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 21 +++++++++++++++------
> 1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 934ad7c0c342..73489a45decb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -2377,9 +2377,12 @@ static int vmw_cmd_dx_clear_rendertarget_view(struct
> vmw_private *dev_priv,
> {
> 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXClearRenderTargetView) =
> 		container_of(header, typeof(*cmd), header);
> +	struct vmw_resource *ret;
> 
> -	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_rt,
> -					   cmd->body.renderTargetViewId));
> +	ret = vmw_view_id_val_add(sw_context, vmw_view_rt,
> +				  cmd->body.renderTargetViewId);
> +
> +	return PTR_ERR_OR_ZERO(ret);
> }
> 
> /**
> @@ -2396,9 +2399,12 @@ static int vmw_cmd_dx_clear_depthstencil_view(struct
> vmw_private *dev_priv,
> {
> 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXClearDepthStencilView) =
> 		container_of(header, typeof(*cmd), header);
> +	struct vmw_resource *ret;
> +
> +	ret = vmw_view_id_val_add(sw_context, vmw_view_ds,
> +				  cmd->body.depthStencilViewId);
> 
> -	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_ds,
> -					   cmd->body.depthStencilViewId));
> +	return PTR_ERR_OR_ZERO(ret);
> }
> 
> static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
> @@ -2741,9 +2747,12 @@ static int vmw_cmd_dx_genmips(struct vmw_private
> *dev_priv,
> {
> 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXGenMips) =
> 		container_of(header, typeof(*cmd), header);
> +	struct vmw_resource *ret;
> +
> +	ret = vmw_view_id_val_add(sw_context, vmw_view_sr,
> +				  cmd->body.shaderResourceViewId);
> 
> -	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_sr,
> -					   cmd->body.shaderResourceViewId));
> +	return PTR_ERR_OR_ZERO(ret);
> }
> 
> /**
> --
> 2.17.1

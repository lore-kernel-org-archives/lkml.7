Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7909EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C514206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfCKRAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:00:42 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:32482 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbfCKRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:00:42 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 Mar 2019 10:00:38 -0700
Received: from promb-2n-dhcp77.eng.vmware.com (promb-2n-dhcp77.eng.vmware.com [10.20.88.77])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id E32771B828B;
        Mon, 11 Mar 2019 13:00:40 -0400 (EDT)
Message-ID: <35b4b2dfe93ce406ff26e6d75d6c6b97824de36e.camel@vmware.com>
Subject: Re: [PATCH] drm/vmwgfx: Zero initialize handle in
 vmw_execbuf_process
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Mar 2019 10:01:16 -0700
In-Reply-To: <20190307222611.18100-1-natechancellor@gmail.com>
References: <20190307222611.18100-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: drawat@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thanks for doing this. I will include this in vmwgfx-next.

Reviewed-by: Deepak Rawat <drawat@vmware.com>

On Thu, 2019-03-07 at 15:26 -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:3964:7: warning: variable
> 'handle' is used uninitialized whenever '?:' condition is false
> [-Wsometimes-uninitialized]
> 
> It's not wrong; however, in practice, this is never an issue because
> the value of handle isn't used when user_fence_rep is NULL because
> vmw_execbuf_copy_fence_user returns immediately when that is the
> case.
> Just zero initialize this variable so that Clang no longer warns.
> 
> Link: 
> https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F397&amp;data=02%7C01%7Cdrawat%40vmware.com%7C6b9c429d16d844a5740c08d6a34bedb4%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636875943916412703&amp;sdata=Yf7%2BzrbZS96yNJQewYQQ7YsHUDtJSvPaomyTJFZjsDk%3D&amp;reserved=0
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 88b8178d4687..4ba06c2828a1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -3829,7 +3829,7 @@ int vmw_execbuf_process(struct drm_file
> *file_priv,
>  	struct vmw_sw_context *sw_context = &dev_priv->ctx;
>  	struct vmw_fence_obj *fence = NULL;
>  	struct vmw_cmdbuf_header *header;
> -	uint32_t handle;
> +	uint32_t handle = 0;
>  	int ret;
>  	int32_t out_fence_fd = -1;
>  	struct sync_file *sync_file = NULL;


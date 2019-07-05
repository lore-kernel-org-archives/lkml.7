Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C74BC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C400216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfGEQFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:05:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36898 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfGEQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:05:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BF778263AA0
Message-ID: <1fdb3115e6f5903b55a915c45bbfdec484842e83.camel@collabora.com>
Subject: Re: [PATCH 3/9] media: hantro: Constify the control array
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Fri, 05 Jul 2019 13:05:10 -0300
In-Reply-To: <20190619121540.29320-4-boris.brezillon@collabora.com>
References: <20190619121540.29320-1-boris.brezillon@collabora.com>
         <20190619121540.29320-4-boris.brezillon@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-19 at 14:15 +0200, Boris Brezillon wrote:
> controls[] is not supposed to be modified at runtime, let's make it
> explicit by adding a const specifier.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 28b0fed89dcb..db49d643ddb7 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -264,7 +264,7 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>  	.s_ctrl = hantro_s_ctrl,
>  };
>  
> -static struct hantro_ctrl controls[] = {
> +static const struct hantro_ctrl controls[] = {
>  	{
>  		.id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
>  		.codec = HANTRO_JPEG_ENCODER,

This patch here breaks the build:

  CC [M]  drivers/staging/media/hantro/hantro_drv.o
/home/zeta/repos/linux/media_tree/drivers/staging/media/hantro/hantro_drv.c: In function ‘hantro_ctrls_setup’:
/home/zeta/repos/linux/media_tree/drivers/staging/media/hantro/hantro_drv.c:319:23: error: assignment of member ‘id’ in read-only object
    controls[i].cfg.id = controls[i].id;
                       ^
You can fix it by simply moving it after:

[PATCH 4/9] media: hantro: Simplify the controls creation logic

Regards,
Ezequiel


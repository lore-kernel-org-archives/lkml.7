Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFAFC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D684520851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFNJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:11:56 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:57466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725859AbfFNJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:11:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7610C182CF668;
        Fri, 14 Jun 2019 09:11:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eyes88_4aa5799cf532f
X-Filterd-Recvd-Size: 1967
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Jun 2019 09:11:52 +0000 (UTC)
Message-ID: <9fd990d12ea1488592c5a590046f001a187b9c3f.camel@perches.com>
Subject: Re: [PATCH v2] media: mtk-vcodec: remove unneeded proxy functions
From:   Joe Perches <joe@perches.com>
To:     Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jun 2019 02:11:51 -0700
In-Reply-To: <20190614075640.106709-1-acourbot@chromium.org>
References: <20190614075640.106709-1-acourbot@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 16:56 +0900, Alexandre Courbot wrote:
> We were getting the codec interface through a proxy function that does
> not bring anything compared to just accessing the interface definition
> directly, so just do that. Also make the decoder interfaces const.
[]
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
[]
> @@ -485,16 +485,9 @@ static int vdec_h264_get_param(void *h_vdec, enum vdec_get_param_type type,
>  	return 0;
>  }
>  
> -static struct vdec_common_if vdec_h264_if = {
> +const struct vdec_common_if vdec_h264_if = {

probably better to fixup whatever chains prevent
this (if any) from being static const

>  	.init		= vdec_h264_init,
>  	.decode		= vdec_h264_decode,
>  	.get_param	= vdec_h264_get_param,
>  	.deinit		= vdec_h264_deinit,
>  };



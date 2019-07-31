Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEFD206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfGaGG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:06:27 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56288 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725209AbfGaGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:06:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 692871802E6E7;
        Wed, 31 Jul 2019 06:06:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: door01_1ac50e83e2663
X-Filterd-Recvd-Size: 2235
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 06:06:23 +0000 (UTC)
Message-ID: <520bd0f7367e77ffd2e0150187f6ffb64b0e8b71.camel@perches.com>
Subject: Re: [PATCH] drm: use trace_printk rather than printk in drm_dbg.
From:   Joe Perches <joe@perches.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jul 2019 23:06:22 -0700
In-Reply-To: <20190731024533.22264-1-huangfq.daxian@gmail.com>
References: <20190731024533.22264-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 10:45 +0800, Fuqian Huang wrote:
> In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
> amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
> finally calls printk.
> As amdgpu_ih_process is called from an interrupt handler,
> and interrupt handler should be short as possible.
> 
> As printk may lead to bogging down the system or can even
> create a live lock. printk should not be used in IRQ context.
> Instead, trace_printk is recommended.
> Link: https://lwn.net/Articles/365835
[]
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
[]
> @@ -236,7 +236,7 @@ void drm_dbg(unsigned int category, const char *format, ...)
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +	trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
>  	       __builtin_return_address(0), &vaf);
>  
>  	va_end(args);

This makes all 4000+ drm_dbg/DRM_DEBUG uses emit
a trace_printk.

I suggest instead you make only the interrupt uses
use a different function and not drm_dbg.

Or maybe add an in_interrupt() check like

	if (in_interrupt())
		printk(KERN_DEBUG etc...)
	else
		trace_printk(etc...)




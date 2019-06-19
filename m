Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA7C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F1E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfFSM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:26:27 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57532 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:26:27 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 6507420025;
        Wed, 19 Jun 2019 14:26:23 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:26:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v5 2/2] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
Message-ID: <20190619122622.GB29084@ravnborg.org>
References: <20190603152331.23160-1-paul@crapouillou.net>
 <20190603152331.23160-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603152331.23160-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=p6pI0oa4AAAA:8 a=e5mUnYsNAAAA:8 a=H0UmMNABUbsaJNjzNOkA:9
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=9cw2y2bKwytFd151gpuR:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Mon, Jun 03, 2019 at 05:23:31PM +0200, Paul Cercueil wrote:
> Add a KMS driver for the Ingenic JZ47xx family of SoCs.
> This driver is meant to replace the aging jz4740-fb driver.
> 
> This driver does not make use of the simple pipe helper, for the reason
> that it will soon be updated to support more advanced features like
> multiple planes, IPU integration for colorspace conversion and up/down
> scaling, support for DSI displays, and TV-out and HDMI outputs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: - Remove custom handling of panel. The panel is now discovered using
>     	  the standard API.
>     	- Lots of small tweaks suggested by upstream
>     
>     v3: - Use devm_drm_dev_init()
>     	- Update compatible strings to -lcd instead of -drm
>     	- Add destroy() callbacks to plane and crtc
>     	- The ingenic,lcd-mode is now read from the bridge's DT node
>     
>     v4: Remove ingenic,lcd-mode property completely. The various modes are now
>     	deduced from the connector type, the pixel format or the bus flags.
>     
>     v5: - Fix framebuffer size incorrectly calculated for 24bpp framebuffers
>     	- Use 32bpp framebuffer instead of 16bpp, as it'll work with both
>     	  16-bit and 24-bit panel
>     	- Get rid of drm_format_plane_cpp() which has been dropped upstream
>     	- Avoid using drm_format_info->depth, which is deprecated.
In the drm world we include the revision notes in the changelog.
So I did this when I applied it to drm-misc-next.

Fixed a few trivial checkpatch warnings about indent too.
There was a few too-long-lines warnings that I ignored. Fixing them
would have hurt readability.

I assume you will maintain this driver onwards from now.
Please request drm-misc commit rights (see
https://www.freedesktop.org/wiki/AccountRequests/)
You will need a legacy SSH account.

And you should familiarize yourself with the maintainer-tools:
https://drm.pages.freedesktop.org/maintainer-tools/index.html

For my use I use "dim update-branches; dim apply; dim push
So only a small subset i needed for simple use.

	Sam

Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B30AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F12084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCAUQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:16:31 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:60881 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:16:31 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id F3D30803E0;
        Fri,  1 Mar 2019 21:16:25 +0100 (CET)
Date:   Fri, 1 Mar 2019 21:16:24 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for the ingenic-drm driver
Message-ID: <20190301201624.GA22317@ravnborg.org>
References: <20190228220756.20262-1-paul@crapouillou.net>
 <20190228220756.20262-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228220756.20262-2-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=p6pI0oa4AAAA:8
        a=NUxJ9A_SPYP8DFnNYRMA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=9cw2y2bKwytFd151gpuR:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

Good to see work migrating fbdev => drm.

Following comments is based on experience while working on migrating
another driver from fbdev => drm.

On Thu, Feb 28, 2019 at 07:07:54PM -0300, Paul Cercueil wrote:
> Add documentation for the devicetree bindings of the DRM driver for the
> JZ47xx family of SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../devicetree/bindings/display/ingenic,drm.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> new file mode 100644
> index 000000000000..52a368ec35cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> @@ -0,0 +1,30 @@
> +Ingenic JZ47xx DRM driver
> +
> +Required properties:
> +- compatible: one of:
> +  * ingenic,jz4740-drm
> +  * ingenic,jz4725b-drm
> +- reg: LCD registers location and length
The fbdev way of doing this was to hardcode register setttings.
In the drm world we read the configuration of the panel and let
this decide the actual configuration.

Note that no drm drivers supports stn displays and that there
is really no use for this these days. So you can skip the STN parts.

Also the modern way to specify a panel in the DT is using OF graph bindings.
You can find many examples how to do this.

I was there with the atmel LCDC driver (not in the kernel yet),
and had some challenges with this.

	Sam

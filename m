Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1751C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F120830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="SmEqBimn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfCDCNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:13:31 -0500
Received: from chill.innovation.ch ([216.218.245.220]:52358 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDCNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:13:31 -0500
Date:   Sun, 3 Mar 2019 18:13:25 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 557D4640126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1551665605;
        bh=JB4ZjTxoH+1bdFsZFMpyaLJ1r498asmhYn0lwzhSQbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmEqBimnq8EBs5pJHxn8VVsweXB5swBYNMo9hc1J5M1/lFVIED0lIv2dBMqs5tnNJ
         iZSNVHRz2+J+XSa6kvXPnDRp280+PjYl0HmLAzm87OmBTWAC/gZxU6NBe4GAfN1tn1
         RzbAbazu9/DfReAUIOd+PkfyXPJJcl3q8Bl3WOL3ibiVC01gA3eNy/blyg2siCZayJ
         z8VnNnRmqnnQJDR3SYLldFokLjGWWxldeFOQigYzaRJHLde0g4+jNpMfQD9TPhkEdZ
         Kx+VEW5T8n2Idm7IIOaJPhwwtG8N+QJeNDQguXxZORaxScztJg03jSuEdhX7YyNsZx
         qf5sUu5x1cUyQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: sil_sii8620: make remote control optional.
Message-ID: <20190304021325.GA30785@innovation.ch>
Mail-Followup-To: Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190124072125.GA28127@innovation.ch>
 <20190125013355.GA6722@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125013355.GA6722@innovation.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 05:33:55PM -0800, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
> 
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> 
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
> 
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).
> 
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
> Resending this, as I somehow managed to forget to cc dri-devel.
> Apologies for the duplication.
> 
> Changes in v2:
>  - completely remove dependencies on both RC_CORE and INPUT in Kconfig,
>  - make remote control functionality in driver contingent on RC_CORE
>    being defined
> 
>  drivers/gpu/drm/bridge/Kconfig       |  2 --
>  drivers/gpu/drm/bridge/sil-sii8620.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
[snip]

Is there anything I can do to help get this reviewed and moved forward?


  Cheers,

  Ronald


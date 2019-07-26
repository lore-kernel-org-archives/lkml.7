Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B2C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B43122BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbfGZSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:43:11 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43927 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbfGZSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:43:11 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3F74320117;
        Fri, 26 Jul 2019 20:43:08 +0200 (CEST)
Date:   Fri, 26 Jul 2019 20:43:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/panel: jh057n00900: Move dsi init sequence to
 prepare
Message-ID: <20190726184306.GA14981@ravnborg.org>
References: <cover.1564146727.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1564146727.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8
        a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=D0Xkq8Vs1On2DmSM1iMA:9
        a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Fri, Jul 26, 2019 at 03:14:35PM +0200, Guido Günther wrote:
> 
> If the panel is wrapped in a panel_bridge it gets prepar()ed before the
> upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
> are not enabled yet). To avoid this move the panel's first DSI access to
> enable() so the upstream bridge can prepare the DSI host controller in
> it's pre_enable().
> 
> The second patch makes the disable() call symmetric to the above and the third
> one just eases debugging.
> 
> Changes from v1:
> * As per review comments by Sam Ravnborg
>   * Ignore failures to disable the backlight in jh057n_disable()
>   * Add 'drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently'
> * Collected Reviewed-By: Thanks Sam!
> 
> To: "Guido Günther" <agx@sigxcpu.org>,Purism Kernel Team <kernel@puri.sm>,Thierry Reding <thierry.reding@gmail.com>,Sam Ravnborg <sam@ravnborg.org>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> 
> 
> Guido Günther (4):
>   drm/panel: jh057n00900: Move panel DSI init to enable()
>   drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
>   drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
>   drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently

Looks good. Series applied to drm-misc-next and pushed out.

	Sam

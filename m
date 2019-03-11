Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF84EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C85A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfCKVrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:47:15 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37731 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:47:14 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9414B80395;
        Mon, 11 Mar 2019 22:47:09 +0100 (CET)
Date:   Mon, 11 Mar 2019 22:47:08 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/atomic-helper: Validate pointer before dereference
Message-ID: <20190311214708.GB24416@ravnborg.org>
References: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=83PfsViYTA30QWSY9fAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo


On Mon, Mar 11, 2019 at 06:01:20PM -0300, Rodrigo Siqueira wrote:
> The function disable_outputs() and
> drm_atomic_helper_commit_modeset_enables() tries to retrieve
> helper_private from the target CRTC, for dereferencing some operations.
> However, the current implementation does not check whether
> helper_private is null and, if not, if it has a valid pointer to a dpms
> and commit functions. This commit adds pointer validations before
> trying to dereference the dpms and commit function.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 30 ++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> @@ -1277,11 +1279,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		if (new_crtc_state->enable) {
>  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
>  					 crtc->base.id, crtc->name);
This DEBUG_ print is only relevant if the code actually
do something in the following.
So it seems more correct to fix the upper if () to:

>               if (new_crtc_state->enable && funcs != NULL) {
>  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
			...

The you also loose one indent and the calls are nicer.

(If used "funcs != NULL", but this is a matter of taste).

	Sam

Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA76C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9520420862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbfETRI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:08:29 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:51380 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390373AbfETRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:08:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 640F720087;
        Mon, 20 May 2019 19:08:22 +0200 (CEST)
Date:   Mon, 20 May 2019 19:08:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Message-ID: <20190520170820.GA27230@ravnborg.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520082216.26273-11-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
        a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=SJz97ENfAAAA:8
        a=bDN84i_9AAAA:8 a=VwQbUJbxAAAA:8 a=AUPil0-6CJQSJ-L3P-oA:9
        a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=vFet0B0WnEQeilDPIY6i:22
        a=J2PsDwZO0S0EpbpLmD-j:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

While browsing this nice patch series I stumbled upon a detail.

On Mon, May 20, 2019 at 10:21:53AM +0200, Daniel Vetter wrote:
> With
> 
> commit 6104c37094e729f3d4ce65797002112735d49cd1
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Tue Aug 1 17:32:07 2017 +0200
> 
>     fbcon: Make fbcon a built-time depency for fbdev
> 
> we have a static dependency between fbcon and fbdev, and we can
> replace the indirection through the notifier chain with a function
> call.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> ---
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index f52ef0ad6781..701abaf79c87 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -136,10 +136,6 @@ struct fb_cursor_user {
>  #define FB_EVENT_RESUME			0x03
>  /*      An entry from the modelist was removed */
>  #define FB_EVENT_MODE_DELETE            0x04
> -/*      A driver registered itself */
> -#define FB_EVENT_FB_REGISTERED          0x05
> -/*      A driver unregistered itself */
> -#define FB_EVENT_FB_UNREGISTERED        0x06
>  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
>  #define FB_EVENT_GET_CONSOLE_MAP        0x07
>  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */

This breaks build of arch/arm/mach-pxa/am200epd.c thats uses
FB_EVENT_FB_*REGISTERED:


       if (event == FB_EVENT_FB_REGISTERED)
                return am200_share_video_mem(info);
        else if (event == FB_EVENT_FB_UNREGISTERED)
                return am200_unshare_video_mem(info);


Found while grepping for "FB_EVENT" so this is not a build
error I triggered.

	Sam

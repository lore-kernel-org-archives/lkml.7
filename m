Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B20C33C8C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97A2068D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKMQfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:35:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36998 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:35:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 388EA28E964
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] drm: bridge: dw_mipi_dsi: access registers via a
 regmap
In-Reply-To: <CACvgo51sNzSHCcix89giYEq=iGJa_-nYbgpOKY-MxPRGCM_cRQ@mail.gmail.com>
References: <20191106163031.808061-1-adrian.ratiu@collabora.com>
 <20191106163031.808061-2-adrian.ratiu@collabora.com>
 <CACvgo51sNzSHCcix89giYEq=iGJa_-nYbgpOKY-MxPRGCM_cRQ@mail.gmail.com>
Date:   Wed, 13 Nov 2019 18:35:30 +0200
Message-ID: <87r22bhgz1.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Emil Velikov <emil.l.velikov@gmail.com> 
wrote:
> On Wed, 6 Nov 2019 at 16:30, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> Convert the common bridge code and the two rockchip & stm 
>> drivers which currently use it to the regmap API in 
>> anticipation for further changes to make it more generic and 
>> add older DSI host controller support as found on i.mx6 based 
>> devices. 
>> 
>> The regmap becomes an internal state of the bridge. No 
>> functional changes other than requiring the platform drivers to 
>> use the pre-configured regmap supplied by the bridge after its 
>> probe() call instead of ioremp'ing the registers themselves. 
>> 
>> In subsequent commits the bridge will become able to detect the 
>> DSI host core version and init the regmap with different 
>> register layouts. The platform drivers will continue to use the 
>> regmap without modifications or worrying about the specific 
>> layout in use (in other words the layout is abstracted away via 
>> the regmap). 
>> 
>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com> 
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> 
>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com> 
> 
> I should have been clearer earlier - I didn't quite review the 
> patch.  Is is now though.  Reviewed-by: Emil Velikov 
> <emil.velikov@collabora.com>

Sorry about that, I got confused and thought you reviewed it all.
 
> 
> Admittedly a couple of nitpicks (DRIVER_NAME, zero initialize of 
> val) could have been left out.  It's not a big deal, there's no 
> need to polish those.

I'll address them in v3 as well as updating your mail address.

Thanks for reviewing!

>
> -Emil
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

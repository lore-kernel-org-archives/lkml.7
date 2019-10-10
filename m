Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC951C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB0218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTpMvin4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbfJJHiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40641 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbfJJHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:24:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so4484770edm.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3z5xsYuGI9Tu3hogsHQpREAbRY7gTtghNiSpU/J3oU=;
        b=aTpMvin4UR3Y+GqBZUEXUSlE/N1e1h/5CeUiSTAjWqPoyNYd3yCMpw52TAVTtJr7Rp
         H8O9IkcLedmQ5rU4UP+iCw0WxO9d6J8HB6QjuHy172SJ7kJjHHgQ9kWEHGOldZNpvJ6o
         +W3XDpcK0uPJ3Kpk+QRcObX/aRSzQdGq5OB6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3z5xsYuGI9Tu3hogsHQpREAbRY7gTtghNiSpU/J3oU=;
        b=bDlSYJQ46mxgUXIhCFaSqWYD7Pirb7rFQ2QUxCdPTyB8w1F010ZObh3uL/GoOAHoYz
         2cVLUQK7jfcnTCa4O5b3dkz9nF+NOmohq2Za+l3K2CeOXqYXCPJ+CIhGLPRkWZGyBh9X
         K1VQdI6fS/bSDxPCdCzTiPpltmYS1j+RjoXN2jtI/YdqKHfFWGk7fOBLfuBRe3ou96av
         aYMmcQG44VTtghCS7C+/hvgnhXzI+brpfZszJ/JZViLcJqOBHtATYREeaYHXM8p8cUVq
         YMIJsfYGvGkxUFt1jVkUnqhWxLnOA/5ppasLkqaCw2vpUfiqueokdYqqfsGR1AVrdpfm
         3lpw==
X-Gm-Message-State: APjAAAWi3rn/XucUJVymU09VZ0fVnwH2Kvrh+2cFTtlzi4XCdot3uYwC
        vrdTqptXiY3ymlTIF29TEDY6uBjd3OZ02w==
X-Google-Smtp-Source: APXvYqwb5to/Q8rvaULYydBmeg/Ng7dGW0HmVBtZtYXnsQzZvChnb8jSvAcADYCSTI3sVI845ypnCg==
X-Received: by 2002:a05:6402:649:: with SMTP id u9mr6561794edx.200.1570692250326;
        Thu, 10 Oct 2019 00:24:10 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 30sm786848edr.78.2019.10.10.00.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 00:24:09 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 7so5727145wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:24:09 -0700 (PDT)
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr6698598wmu.64.1570692248666;
 Thu, 10 Oct 2019 00:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191007174505.10681-1-ezequiel@collabora.com>
 <20191007174505.10681-3-ezequiel@collabora.com> <CAAFQd5BNu2ea3ei_imHmEwmdna0+iiSbQSv_SBsdHfP4Uh1h4Q@mail.gmail.com>
 <HE1PR06MB4011EC9E93ECBB6773252247AC9A0@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <CAAFQd5CWoAP1psrEW6bVMkRmhFeTvFKtDSLjT7nefc2YiFovqQ@mail.gmail.com>
 <CAAFQd5AYCiKcA9pGc44L3gGHLPx6iMSb7KywkO8OqVv4gS8KvQ@mail.gmail.com>
 <CAAFQd5AQXGX_2gmKLfymH5mLG-uVh-v+XXtGXzbfzYzVVV42mA@mail.gmail.com> <HE1PR06MB4011B897EA5497659A19BCC6AC9A0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB4011B897EA5497659A19BCC6AC9A0@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Oct 2019 16:23:56 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DEhHF+_oO_0ZKS1mi26hJ-JueFxXfdpyQ3ATzMW5Czaw@mail.gmail.com>
Message-ID: <CAAFQd5DEhHF+_oO_0ZKS1mi26hJ-JueFxXfdpyQ3ATzMW5Czaw@mail.gmail.com>
Subject: Re: [PATCH v2 for 5.4 2/4] media: hantro: Fix H264 max frmsize
 supported on RK3288
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        "fbuergisser@chromium.org" <fbuergisser@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 11:12 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-10-08 15:53, Tomasz Figa wrote:
> > On Tue, Oct 8, 2019 at 10:35 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >> On Tue, Oct 8, 2019 at 7:42 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >>> On Tue, Oct 8, 2019 at 3:31 PM Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>> On 2019-10-08 07:27, Tomasz Figa wrote:
> >>>>> Hi Ezequiel, Jonas,
> >>>>>
> >>>>> On Tue, Oct 8, 2019 at 2:46 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >>>>>> From: Jonas Karlman <jonas@kwiboo.se>
> >>>>>>
> >>>>>> TRM specify supported image size 48x48 to 4096x2304 at step size 16 pixels,
> >>>>>> change frmsize max_width/max_height to match TRM.
> >>>>>>
> >>>>>> Fixes: 760327930e10 ("media: hantro: Enable H264 decoding on rk3288")
> >>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>>> ---
> >>>>>> v2:
> >>>>>> * No changes.
> >>>>>>
> >>>>>>  drivers/staging/media/hantro/rk3288_vpu_hw.c | 4 ++--
> >>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/staging/media/hantro/rk3288_vpu_hw.c b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >>>>>> index 6bfcc47d1e58..ebb017b8a334 100644
> >>>>>> --- a/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >>>>>> +++ b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> >>>>>> @@ -67,10 +67,10 @@ static const struct hantro_fmt rk3288_vpu_dec_fmts[] = {
> >>>>>>                 .max_depth = 2,
> >>>>>>                 .frmsize = {
> >>>>>>                         .min_width = 48,
> >>>>>> -                       .max_width = 3840,
> >>>>>> +                       .max_width = 4096,
> >>>>>>                         .step_width = H264_MB_DIM,
> >>>>>>                         .min_height = 48,
> >>>>>> -                       .max_height = 2160,
> >>>>>> +                       .max_height = 2304,
> >>>>> This doesn't match the datasheet I have, which is RK3288 Datasheet Rev
> >>>>> 1.4 and which has the values as in current code. What's the one you
> >>>>> got the values from?
> >>>> The RK3288 TRM vcodec chapter from [1], unknown revision and date, lists 48x48 to 4096x2304 step size 16 pixels under 25.5.1 H.264 decoder.
> >>>>
> >>>> I can also confirm that one of my test samples (PUPPIES BATH IN 4K) is 4096x2304 and can be decoded after this patch.
> >>>> However the decoding speed is not optimal at 400Mhz, if I recall correctly you need to set the VPU1 clock to 600Mhz for 4K decoding on RK3288.
> >>>>
> >>>> I am not sure if I should include a v2 of this patch in my v2 series, as-is this patch do not apply on master (H264_MB_DIM has changed to MB_DIM in master).
> >>>>
> >>>> [1] http://www.t-firefly.com/download/firefly-rk3288/docs/TRM/rk3288-chapter-25-video-encoder-decoder-unit-(vcodec).pdf
> >>> I checked the RK3288 TRM V1.1 too and it refers to 3840x2160@24fps as
> >>> the maximum.
> >>>
> >>> As for performance, we've actually been getting around 33 fps at 400
> >>> MHz with 3840x2160 on our devices (the old RK3288 Asus Chromebook
> >>> Flip).
> >>>
> >>> I guess we might want to check that with Hantro.
> >> Could you check the value of bits 10:0 in register at 0x0c8? That
> >> should be the maximum supported stream width in the units of 16
> >> pixels.
> > Correction: The unit is 1 pixel and there are additional 2 most
> > significant bits at 0x0d8, 15:14.
>
> I will check this later tonight when I have access to my devices.
> The PUPPIES BATH IN 4K (4096x2304) sample decoded without issue using rockchip 4.4 BSP kernel and mpp last time I tested.
>
> The vcodec driver in 4.4 BSP kernel use 300/400 Mhz as default clock rate and will change to 600 Mhz when width is over 2560, see [1]:
>   raise frequency for resolution larger than 1440p avc
>
> [1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/video/rockchip/vcodec/vcodec_service.c#L2551-L2570

How comes it works for us well at 400 MHz? Better DRAM? Differences in
how Vcodec BSP handles the hardware that somehow make the decoding
slower?

Best regards,
Tomasz

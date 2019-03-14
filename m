Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B25A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pKE9FWOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCNUHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:07:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:07:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so4378745wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=FjAcSKJqzDX3s5cCpFMPy9SjU+PstHwSU7dyfv72OTo=;
        b=pKE9FWOaxLiTqR81OfppvwXr0XcHRrvqMl4ymocIFvQvv98Zqh5I7j3SNjAo+VxxVb
         rmZsfJVIdOb021IVqryQ3z6N+kwvfQei5wu/JUWqgUAxxn4ogGoahCGXmdyHlMlGZwzC
         BFbFbwGCQhz/PhoIBCnVK127M3yCDvUkciFXWSlNfj3q6OyqLkvmSvo8Hgj9rsdRUIQI
         wh/XncfEwRd1WhpLjVvoHkAsRr+J4x9vh7xzwtpay+U8j4bnlJHO7nIjELdHuFFFCmo7
         VmEouFkBKL7W3vuS2vIZf2RmBO7OPjCFUMEfOzFX/57sf6v4eungCzYXx26l8dD1tA9+
         Sunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=FjAcSKJqzDX3s5cCpFMPy9SjU+PstHwSU7dyfv72OTo=;
        b=WmWc4qSeHVNBQLQoPAhOliXJVpPLeW77Yz+h78LAk3rIvn4+9H4KFoGdYfDbTHr46i
         PYFOxIvsRiBe65C3f47LZdUHgwidaTtDhUS8khmT7c6NXIzk5JBYOgPsy+IvL58Uhy56
         FVCpNS8/lE1NHm/elyBw+oCBHqukyukynmlThGKTZx/87vHY+BakblM8wQZB8UdVi5JW
         nmpKITxgC6Rc5a+lWWS2y5GCw1xOUoBRmipwrqGNH8MRw1qzOpwV62cHmgn4h/LrqI+J
         WRJ+338RhPvkm1ta/BO0JXceF4UyWiT29tztrSsCMMyFtjbTfq8NHbGzR/LAB391+Yzf
         fXgg==
X-Gm-Message-State: APjAAAXgeEoZNwl27/P3OOEN1Rni77gBiOpv3q+DeDVtDkqyTJy49GzN
        oWKUVSUv3hMzl4XtOgTX9IFrFg==
X-Google-Smtp-Source: APXvYqy1j+jdwlg6ZoMYfS11o4d9hri4qOmL3S1gJva4iASfo96QffmedFVYpyzZ6v0N06nqlwK8ZQ==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr169343wmc.112.1552594058763;
        Thu, 14 Mar 2019 13:07:38 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f6sm16481116wrt.87.2019.03.14.13.07.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 13:07:38 -0700 (PDT)
Message-ID: <5C8AB489.3000202@baylibre.com>
Date:   Thu, 14 Mar 2019 21:07:37 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling
 support
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com> <1549022873-40549-2-git-send-email-narmstrong@baylibre.com> <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com> <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com> <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com> <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com> <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
In-Reply-To: <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le 14/03/2019 19:55, Rob Herring a écrit :
> On Mon, Mar 11, 2019 at 3:53 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 08/03/2019 15:54, Rob Herring wrote:
>>> On Fri, Mar 8, 2019 at 2:05 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On 08/03/2019 00:13, Rob Herring wrote:
>>>>> On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>>
>>>>>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
>>>>>> Scrambling when supported or mandatory.
>>>>>>
>>>>>> This patch also adds an helper to setup the control bit to support
>>>>>> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
>>>>>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
>>>>>>
>>>>>> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
>>>>>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
>>>>>> on the Rockchip 4.4 BSP kernel at [1]
>>>>>>
>>>>>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>>>>>>
>>>>>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
>>>>>> Cc: Huicong Xu <xhc@rock-chips.com>
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
>>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>>>>>>  include/drm/bridge/dw_hdmi.h              |  1 +
>>>>>>  3 files changed, 85 insertions(+), 2 deletions(-)
>>>>>
>>>>> This commit in drm-misc-next is breaking booting on the Rock960. I
>>>>> have FB and fbcon enabled. The boot hangs after this message:
>>>>>
>>>>> [    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
>>>>> kvaddr=(____ptrval____) offset=0 size=8294400
>>>>
>>>> Could you give more details on the tree used ? did you bisect to find this commit ?
>>>
>>> As I said above, drm-misc-next (from drm-misc tree) is the branch. I
>>> bisected between it and v5.0. Reverting it fixes booting.
>>
>> Thanks, could you give more details on the environment ? Did you test over the latest linux-next ?
> 
> Here's a log of the drm parts: https://pastebin.com/tFJ9Gs6h
> 
> linux-next also hangs.
> 
>> Can you share the EDID of your monitor ?
> 
> Maybe not mode related. I tried forcing to 1280x720 and it hangs too.
> In any case, here's the parsed EDID:
> 
> 256-byte EDID successfully retrieved from i2c bus 3
> Looks like i2c was successful. Have a good day.
> Checksum Correct
> 
> Section "Monitor"
> Identifier "CYS-R101"
> ModelName "CYS-R101"
> VendorName "CYX"
> # Monitor Manufactured week 28 of 2018
> # EDID version 1.3
> # Digital Display
> DisplaySize 220 130
> Gamma 2.20
> Option "DPMS" "true"
> Horizsync 30-102
> VertRefresh 48-75
> # Maximum pixel clock is 190MHz
> #Not giving standard mode: 1920x1080, 60Hz
> #Not giving standard mode: 1920x1080, 60Hz
> #Not giving standard mode: 1920x1080, 60Hz
> #Not giving standard mode: 1440x900, 60Hz
> #Not giving standard mode: 1400x1050, 60Hz
> #Not giving standard mode: 1280x1024, 60Hz
> #Not giving standard mode: 1280x960, 60Hz
> #Not giving standard mode: 1280x720, 60Hz
> 
> #Extension block found. Parsing...
> Modeline "Mode 5" 54.00 2560 2608 2640 2720 1440 1443 1448 1481 +hsync +vsync
> Modeline "Mode 0" 267.81 2560 2608 2640 2720 1600 1603 1608 1641 +hsync +vsync
> Modeline "Mode 1" 148.500 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
> Modeline "Mode 2" 74.250 1920 2008 2052 2200 1080 1082 1087 1125
> +hsync +vsync interlace
> Modeline "Mode 3" 74.250 1280 1390 1420 1650 720 725 730 750 +hsync +vsync
> Modeline "Mode 4" 148.500 1920 2448 2492 2640 1080 1084 1089 1125 +hsync +vsync
> Option "PreferredMode" "Mode 5"
> EndSection
> 
>> Can you check this patch :
> 
> Still hangs with it.


Thanks for testing, the only impact would be if hdmi_info->scdc.supported
and hdmi_info->scdc.scrambling.low_rate were true.
Honestly, hdmi_info->scdc.scrambling.low_rate wasn't really tested.

Could you dump the edid in binary format ? or parse it with https://github.com/rpavlik/edid-decode
supporting modern HDMI EDIDs.


Thanks,
Neil
> 
>>
>> ----><----------------------------------------------------------------------------------------
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index a63e5f0dae56..f33c2ac158c1 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -1268,8 +1268,6 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
>>
>>         dw_hdmi_phy_power_off(hdmi);
>>
>> -       dw_hdmi_set_high_tmds_clock_ratio(hdmi);
>> -
>>         /* Leave low power consumption mode by asserting SVSRET. */
>>         if (phy->has_svsret)
>>                 dw_hdmi_phy_enable_svsret(hdmi, 1);
>>
>>

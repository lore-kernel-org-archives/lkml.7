Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBADF20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:27:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLWO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:27:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8D11B292129
Subject: Re: [PATCH v22 2/2] drm/bridge: Add I2C based driver for ps8640
 bridge
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ulrich Hecht <uli@fpond.eu>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20191220081738.1895-1-enric.balletbo@collabora.com>
 <20191220081738.1895-3-enric.balletbo@collabora.com>
 <CANMq1KBHsc8oqcjWnjLPCpRToyOm16X6EcQqmqPjZf=D7wA2-Q@mail.gmail.com>
 <05db638b-02a6-0e3a-43ed-44a0a1458d87@collabora.com>
 <CANMq1KA4mp648p1LicOzAyra6tdgN2qdDY=N0XyDYhgt6BP26w@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1c68fa67-c4c4-ea78-bfe4-6344799bbf46@collabora.com>
Date:   Mon, 23 Dec 2019 15:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KA4mp648p1LicOzAyra6tdgN2qdDY=N0XyDYhgt6BP26w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 23/12/19 10:14, Nicolas Boichat wrote:
> On Mon, Dec 23, 2019 at 3:10 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Nicolas,
>>
>> Many thanks for you review. Just preparing a new version with your comments
>> addressed.
>>
>> On 20/12/19 9:44, Nicolas Boichat wrote:
>>> On Fri, Dec 20, 2019 at 4:17 PM Enric Balletbo i Serra
>>> <enric.balletbo@collabora.com> wrote:
>>>>
>>>> From: Jitao Shi <jitao.shi@mediatek.com>
>>>>
>>>> This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
>>>>
>>>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>>>> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
>>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> [uli: followed API changes, removed FW update feature]
>>>> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>> [snip]
>>>> +       ret = i2c_smbus_write_byte_data(client, PAGE2_MCS_EN,
>>>> +                                       status & ~MCS_EN);
>>>> +       if (ret < 0) {
>>>> +               DRM_ERROR("failed write PAGE2_MCS_EN: %d\n", ret);
>>>> +               goto err_regulators_disable;
>>>> +       }
>>>> +
>>>> +       ret = ps8640_bridge_unmute(ps_bridge);
>>>> +       if (ret)
>>>> +               DRM_ERROR("failed to enable unmutevideo: %d\n", ret);
>>>
>>> failed to unmute? Or failed to enable?
>>>
>>
>> failed to unmute sound more clear to me.
> 
> I may be wrong, but I have the feeling that the functions
> "mute/unmute" video/display, actually... And that the function naming
> is strange...
> 

Yes, that's strange.

> You could just try to remove the calls, as there is no audio on the
> board you have (elm), so if video still works, maybe this is actually
> audio ,-)
> 

And without those the display doesn't work. So I suspect that what is wrong and
confusing is the message, instead of mute/unmute, and based on the register
names this looks more like an internal regulator that you need to enable and
disable, so I'll change the error message accordingly.

Thanks,
 Enric

> Thanks,
> 

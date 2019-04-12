Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3488C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF6E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfDLKQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:16:08 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:52154 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbfDLKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:16:08 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EtDth01lNNG8zEtDuhCHKq; Fri, 12 Apr 2019 12:16:06 +0200
Subject: Re: [PATCH v2 0/2] drm/sun4i: dw-hdmi: Improve CEC support
To:     Jernej Skrabec <jernej.skrabec@siol.net>, maxime.ripard@bootlin.com
Cc:     narmstrong@baylibre.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, Laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org
References: <20190401191513.23159-1-jernej.skrabec@siol.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <57d23024-b67b-cf16-93da-2ff47518c079@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401191513.23159-1-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE2ob9XPYKx/066OK9rsuo8l/dP+sUg6zpXvoPvxzygyFtpc9TlsTBfHQUHsuXyXqM4/CpFeXTpvUzSjKf9LfGeQURKCHTl4g8P1KkYoWRL7xQfP5z2X
 g4eZs6+XWXJCWMf4yYfpWyx/5rAbsp9QK9zXB3NCCtADYtW223mPOpwBJaEZOqNOoRC9g9M5j2P0udYp6lAVUuz/2q74R2a2tCLiXgsQy9gLVKuPWw3xedS8
 iVB9VwptpjyE415n+goRr/0Na6dl6va3yVfBUGqmxyADYnHYnufCsVkbuwLRdMdzZVnAWjukSJkp8BBnKCHjwHk2tCXRBvACw8TzTUM5DqhJvRbFmLFI3H+Y
 d439Y/OyuV9plcUqP6kZV9ID2vld30+lLwPnWd7GlZQXWkid/PYlXz497S9EtW0sNEyBRNZLY+j55EGiHWsb/Wab2ejzpnYJ9TXZ/MkOqBvEh0qBoQ+wj3+N
 UxfeG2hAvQS1aAoy2vO/AT3Sip+f5cCL5atAkQ26mZ7BC744CzLZRfFDofVRN1fZmDwayPmXpE7sZXE1lNAdJWFdq7WXj6cIbAsAtEdqnuNLRIRktaCcrHCE
 kFc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On 4/1/19 9:15 PM, Jernej Skrabec wrote:
> It turns out that additional logic between HDMI CEC controller and
> pins on PHY on some Allwinner SoCs prevents proper communication.
> It might be possible to fix it, but it's much easier and less error
> prone to just directly drive pins using software implementation of
> CEC protocol.

1) Please CC linux-media as well, I had almost missed this series.

2) Is this a SoC limitation or a board limitation?

3) Is the bit-banging support sunxi specific? Or is it still using some
   DW CEC functionality? It appears to be sunxi specific.

4) I had an old patch series: https://www.spinics.net/lists/dri-devel/msg170232.html

Rob Herring disagreed with that, but the discussion fizzled out at the end.
I still think doing this in the device tree is the right approach since this
is very much hardware related.

If the DW CEC implementation doesn't work for some reason (CEC pins not hooked up,
or for other reasons non-functional), then it should be disabled in the device
tree. So then adding a new SUN8I option to enable bitbanging CEC support seems
logical.

Regards,

	Hans

> 
> Let me know what do you think.
> 
> Best regards,
> Jernej
> 
> Changes from v1:
> - renamed is_cec_unusable to disable_cec
> - added review-by tag
> 
> Jernej Skrabec (2):
>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
>     driver
>   drm/sun4i: dw-hdmi: Bit bang CEC on some SoCs
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |  2 +-
>  drivers/gpu/drm/sun4i/Kconfig             | 10 +++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h     | 11 +++
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    | 83 ++++++++++++++++++++++-
>  include/drm/bridge/dw_hdmi.h              |  2 +
>  5 files changed, 105 insertions(+), 3 deletions(-)
> 


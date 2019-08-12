Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7A5214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ltoZPdDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfHLMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:35:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHLMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:35:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so18569360wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bI/XNvST8XNcDi45EkijYU3OEXqnGirukbOk+hlTQLA=;
        b=ltoZPdDDIHtFi84wMSTH18qO2lGDQMLD8q+GOlpjwYklx43w44pX9RLkk/UEZFpp5n
         bC3GzphMPhB6+tvx7gw90L/wzbAvYXiJYpTKgP7bknRq8nKamLiU29/teVYUoULSOnXe
         xB07Udy9o+Ewk9kywDosNx9NasLrbCnySassqAWfxNE6NFMRO4BQiv20TcDX5FBVg+PZ
         brYqdp7nHkUCz/6c1yVQyh0SMQ0UtN2WJEO78ZnxD+4ybl6lF7VHgxG0G4mdmmjyC/GP
         7Ry/2trw/UXrHkHdoGEa+h6YHou2Lmn7FgyUbmvc62VUHNe4NltIs8wpjufZpOKRvo8v
         zbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bI/XNvST8XNcDi45EkijYU3OEXqnGirukbOk+hlTQLA=;
        b=RN52rdcHjSJKE+IBFre+4MzTEzBtNu3XS90pVSkWwzjMrbIZSa39Cji0bUsUP3OQ7u
         RFgxdKGfqfRRITHcAxo1EWHIayk9SkuvfVY2cpII0ixCsefG1IyUdx63dLdM6Snha/EP
         T5PnVasXkWKo9xYIu1M8XMXuSEutLnmLAKEWJrp6EgwbS2SqkcC5NDJG8Nz/o/SnS0d4
         if7ClIBTPTYDDsZe2frjcaUrIYz+yrU8cgJ+dN0m57DxdUPzzaVE7uhDuY+oernW5i1K
         oiNzcCiLNAm5QJ/ON0ov9OxkASUFQgrYTr1Qj/e/VQ8lRJ4HnOPgHE2nApVwPzhW7TsU
         Dmmg==
X-Gm-Message-State: APjAAAUq1+FcnL9JA6zUMMsOFAThpFaYlUPCayoHCBqRiGMVvBD5h7uL
        xcoTUbXQAwXCsCKq4/QhWuaAsg==
X-Google-Smtp-Source: APXvYqwcxXo5+Ieqa7x45x82mtMfFr5hiRSw/QjuF6zvGPfArN1YfCX/7LH4MHP/oMjJqqKPm3GOmw==
X-Received: by 2002:adf:f281:: with SMTP id k1mr40956211wro.154.1565613340871;
        Mon, 12 Aug 2019 05:35:40 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm14914204wrm.52.2019.08.12.05.35.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:35:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/8] drm/bridge: dw-hdmi: improve i2s support
In-Reply-To: <408dffda-fb9c-5f57-4f7b-404437359a69@baylibre.com>
References: <20190812120726.1528-1-jbrunet@baylibre.com> <408dffda-fb9c-5f57-4f7b-404437359a69@baylibre.com>
Date:   Mon, 12 Aug 2019 14:35:39 +0200
Message-ID: <1jo90uimsk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Aug 2019 at 14:19, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>
> On 12/08/2019 14:07, Jerome Brunet wrote:
>> The purpose of this patchset is to improve the support of the i2s
>> interface of the synopsys hdmi controller.
>> 
>> Once applied, the interface should support all the usual i2s bus formats,
>> 8 channels playback and properly setup the channel number and allocation
>> in the infoframes.
>> 
>> Also, the dw-hdmi i2s interface will now provide the eld to the generic
>> hdmi-codec so it can expose the related controls to user space.
>> 
>> This work was inspired by Jonas Karlman's work, available here [0].
>> 
>> This was tested the Amlogic meson-g12a-sei510 platform.
>> For this specific platform, which uses codec2codec links, there is a
>> runtime dependency for patch 8 on this ASoC series [1].
>> 
>> Changes since v1 [2]:
>>  * Fix copy size in .get_eld()
>> 
>> [0]: https://github.com/Kwiboo/linux-rockchip/commits/rockchip-5.2-for-libreelec-v5.2.3
>> [1]: https://lkml.kernel.org/r/20190725165949.29699-1-jbrunet@baylibre.com
>> [2]: https://lkml.kernel.org/r/20190805134102.24173-1-jbrunet@baylibre.com
>> 
>> Jerome Brunet (8):
>>   drm/bridge: dw-hdmi-i2s: support more i2s format
>>   drm/bridge: dw-hdmi: move audio channel setup out of ahb
>>   drm/bridge: dw-hdmi: set channel count in the infoframes
>>   drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
>>   drm/bridge: dw-hdmi-i2s: set the channel allocation
>>   drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
>>   drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
>>   drm/bridge: dw-hdmi-i2s: add .get_eld support
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Jonas, is patch 8 ok for you now ? If yes I'll apply them to
> drm-misc-next.

Please don't ! I did not pick the right change and what I just sent is
just crazy, give me a second to resend

>
> Neil
>
>> 
>>  .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   | 20 ++-----
>>  .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  1 +
>>  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 60 +++++++++++++++++--
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 37 ++++++++++++
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     | 13 +++-
>>  include/drm/bridge/dw_hdmi.h                  |  2 +
>>  6 files changed, 108 insertions(+), 25 deletions(-)
>> 

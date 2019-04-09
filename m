Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BE92070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TD9qT7dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDIIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:51:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50890 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:51:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so2492566wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VcLnaE+mYzxaCcjZmBEJENIQDKK9CTlE/jMRNbJo6p8=;
        b=TD9qT7dG5nEY2W/OIZuD26dSRbT4HtoY2dlm7+y2sivb9Gcf5l6gcsB9/GashAWgmh
         Az/eqrfm7dDeOIIpX0mFR0CYcCUvWeGFvtFwTibkgkGmN0PBTYIUV16h0wEtgC4Z65Db
         ctF0UJ/qbZSfnRf2ViELad+5J+dTIy2TxJfOdUXATpcauUExIsQZ9gIIPCm+gaY2/jcQ
         mUvTS7miz7YzlXWljpwZqWWuoOe/PcoMMjf1XFzXr6VelypZ9IOH4DhhAWsJGTXa4okg
         exXZj6vSCVQY1+wIvzgeyam6n+EFvGb3WzJFslCAKD9y0GWst5HVUjtVSdbYG9EgCc/V
         4VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VcLnaE+mYzxaCcjZmBEJENIQDKK9CTlE/jMRNbJo6p8=;
        b=LoTNrbrACPCj43IuN7qiRWlyXf96NQJfSui5SWEjQ0B0lS0XEW2dNVfDviMu5DYiW3
         8eRfPRSHHJe9g6pwQc3KinMTwP8Sel/aCohey/XW7dnP9JZWWi0x2OgBfwL736cuAqh7
         Dvpjy0t4mXdGuTwndEc0XitP8+MEBH0pPk15WFInfi41IQsP8hRzIeVgBnc3NX9edLpS
         cHOjsMeBz25gu9I4NGaCTPvA2WptAHmSnMKzJodpeVsUOzT5YMRHaoMq9I1I3deoUevZ
         PNJCSbDV7CzGRN60N/FBp2YTQUrHoB7UajHuAS/I5UXfQ52CDIve632SpXj7WrgEpg4W
         iWDg==
X-Gm-Message-State: APjAAAX03ijm/tyFE8VbAA+jIdj7m2p0BWASwyduPRsPibumLFKstFOb
        Ey6OadmBrYILQU1naBUZStONQ/tgd8w5gA==
X-Google-Smtp-Source: APXvYqzAMayyaLgUiQW0z+SDjD062FGCAVxgjC1XgnecaRbF4qdfGV7sEJGkl2o5jpzfCbveNde7Sw==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr21120140wme.91.1554799912612;
        Tue, 09 Apr 2019 01:51:52 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v16sm58612200wro.48.2019.04.09.01.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:51:51 -0700 (PDT)
Subject: Re: [PATCH 00/11] drm/meson: Add G12A Support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190325141824.21259-1-narmstrong@baylibre.com>
 <84e8a61db1be6e83e7dcd9630fde17cfc59eb8a3.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <83b873f0-f816-9997-4e62-82d4dfce4f04@baylibre.com>
Date:   Tue, 9 Apr 2019 10:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <84e8a61db1be6e83e7dcd9630fde17cfc59eb8a3.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/04/2019 10:42, Jerome Brunet wrote:
> On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
>> The Amlogic G12A SoC offers very close Video Display
>> functionnalities with it's older GXBB, GXL & GXM predecessors.
>>
>> The main differences are :
>> - G12A Support now 3 "real" OSD planes with a new Blender module
>> - Instead of having a single Scaler for OSD1, G12A has two scaler
>>   that can be applied to 2 out of the 3 OSD planes or on the outputs
>>   of the blender module.
>> - The HDMI PHY now support RX-SENSE, Dynamic HDR and it's registers are
>>   now memory mapped instead of using an internal bus.
>> - The VPU now support a DSI interface to connect a display, using
>>   the Synopsys DSI controller and a custom PHY
>>
>> The complex Blender routing, HDMI RX-SENSE, Dynamic HDR and DSI support
>> are not handled in this patchset.
>>
>> This patchset implements on-par support with the currently support
>> GXBB, GXL and GXM SoCs. There is no support delta with this patchset.
>>
>> patch 10 & 11 implements the bindings found at [1].
>>
>> [1] https://lkml.kernel.org/r/20190313141030.5958-1-narmstrong@baylibre.com
>>
>> Neil Armstrong (11):
>>   drm/meson: Switch PLL to 5.94GHz base for 297Mhz pixel clock
>>   drm/meson: Add registers for G12A SoC
>>   drm/meson: Add G12A Support for VPP setup
>>   drm/meson: Add G12A Support for VIU setup
>>   drm/meson: Add G12A support for OSD1 Plane
>>   drm/meson: Add G12A Support for the Overlay video plane
>>   drm/meson: Add G12A support for plane handling in CRTC driver
>>   drm/meson: Add G12A support for CVBS Encoer
>>   drm/meson: Add G12A Video Clock setup
>>   drm/meson: Add G12A compatible
>>   drm/meson: Add G12A support for the DW-HDMI Glue
>>
>>  drivers/gpu/drm/meson/meson_crtc.c      | 269 +++++++++++++++++++-----
>>  drivers/gpu/drm/meson/meson_drv.c       |   1 +
>>  drivers/gpu/drm/meson/meson_drv.h       |   4 +
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 163 +++++++++++---
>>  drivers/gpu/drm/meson/meson_dw_hdmi.h   |  32 ++-
>>  drivers/gpu/drm/meson/meson_overlay.c   |  10 +-
>>  drivers/gpu/drm/meson/meson_plane.c     |  15 +-
>>  drivers/gpu/drm/meson/meson_registers.h | 247 ++++++++++++++++++++++
>>  drivers/gpu/drm/meson/meson_vclk.c      | 123 +++++++++--
>>  drivers/gpu/drm/meson/meson_venc.c      |  11 +-
>>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  25 ++-
>>  drivers/gpu/drm/meson/meson_viu.c       |  72 ++++++-
>>  drivers/gpu/drm/meson/meson_vpp.c       |  51 +++--
>>  13 files changed, 880 insertions(+), 143 deletions(-)
>>
> 
> on the u200 and sei510
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> I can't pretend to have a deep understanding of this subsystem, but as far as
> I can tell, there is nothing crazy in there. With the comments around the use
> of constants and defines fixed, you can add
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> As a possible future enhancement, it would be nice if you could trim the use
> of *_is_compatible() functions. I think it would make the code easier to
> follow and review.
> 

Thanks for the overall review,

I will do a complete fixup of the constants and defines in a follow-up patchset,
since the already-merged code also needs a good cleanup.

I'll do a more complete refactoring to get rid of the _is_compatible() stuff
in a second time, it needs much more work to handle correctly the 4 SoC families.

Neil

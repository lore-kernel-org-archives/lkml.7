Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB80C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D320857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JM+27wJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbfCAQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:46:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33030 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfCAQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:46:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so26641256wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVjxnJ++Y8X+uS2vpURGAPjkEdwS8EqouJumi+2009s=;
        b=JM+27wJyO274PiVrQRVM+DZhKBjGPhHcbHLImIFFwR8Mm0LenFEjfzdCn9oknGbCZx
         MdppzTexY6/VQv/3a2UYhOeZ6HuqArmvC+UHVwMRMbIJVBIVG1w+IQWi/VG6oeGROoBj
         k1JDNkRBphtaxwwHOeCB17VrIdu+Hbfjn2+9oUdeEuC8S2O+J3i+UF+anRTIY+FaOkP2
         yLqdwcV6dnpJK9DVE7iCyxP18nd6f4mOxZMHSj6azaNab7x2kaFa9wcZLp7drSWFHHAq
         DhSxW9+Q4lhzjByWS9VqNTXZsLxs247ScR8YbY9O5RjYvsRKc142hB32XycKNFtajqEK
         o5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVjxnJ++Y8X+uS2vpURGAPjkEdwS8EqouJumi+2009s=;
        b=XtF/5dJVuisduAKdun1IoO8vM+zggdOv7hT+PkjTAuvcjgUlUxUhMI70kOAuCOohBI
         rWl8S4muWGVgCMi0hX+Uji/GTtHJzDPC7KwEXBYNI2SMOrSaDDZSjb4hjercbmQBK9n2
         Cvp/hv5tcnMRAVRAAIAaVW5d63FIWXX3Xlk3rjyBAjQSeg1L8TNdxCtlBz9h7Nxe/t75
         JixGWk6+0FqLEHUeSadwjZibLRlRFm89v0AsTXErc5VWp9BPR4MzX030LyWRDr5ZDs0H
         Tt5jQAx/6h7wK1EV6OfrObbysJtp1QeVcnbbzO0VgrgCzxKjn++gIJsPtPwXn8zx5KQi
         egOw==
X-Gm-Message-State: APjAAAU2b4tm53hpMq24ipLJUSNjyL0c/nPiEcaNbbyLm9tG6jMwHcbH
        pXnLw4sHx2nH19nTOEErS6aLYdL6gm72XQeFx0YcXA==
X-Google-Smtp-Source: APXvYqwlN92e8UHz+MnQ1ksoMeUuP/P/iC3lxq4B0U7FLJgWSSIDL7scOme9bpQAJF/CjhMqQOS/YaqOM7xHLG1FSwo=
X-Received: by 2002:adf:c543:: with SMTP id s3mr3874801wrf.192.1551458759221;
 Fri, 01 Mar 2019 08:45:59 -0800 (PST)
MIME-Version: 1.0
References: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
In-Reply-To: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 Mar 2019 08:45:47 -0800
Message-ID: <CALAqxLUNG6wyQGVoenTqCU1dD=001hjqMRh=3xEiJsn2BXWWYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: hi3660-hikey960: Add i2s & sound device
To:     Pengcheng Li <lipengcheng8@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Liyuequan <liyuequan@hisilicon.com>,
        "Qianli (A)" <cash.qianli@hisilicon.com>,
        "huangli (I)" <huangli295@hisilicon.com>,
        Hantanglei <hantanglei@huawei.com>,
        wangyoulin <wangyoulin1@hisilicon.com>,
        ninggaoyu <ninggaoyu@hisilicon.com>,
        "xuwei (O)" <xuwei5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 6:24 AM Pengcheng Li <lipengcheng8@huawei.com> wrote:
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 186251f..457cebc 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -27,6 +27,35 @@
>                 /* rewrite this at bootloader */
>                 reg = <0x0 0x0 0x0 0x0>;
>         };
> +
> +       i2s2: hi3660_i2s {
> +               compatible = "hisilicon,hi3660-i2s-1.0";
> +               reg = <0x0 0xe804f800 0x0 0x400>,
> +                       <0x0 0xe804e000 0x0 0x400>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
> +               dmas = <&asp_dmac 18 &asp_dmac 19>;
> +               dma-names = "rx", "tx";
> +               #sound-dai-cells = <0>;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "hikey-hdmi";
> +               simple-audio-card,format = "i2s";
> +
> +               simple-audio-card,bitclock-master = <&sound_master>;
> +               simple-audio-card,frame-master = <&sound_master>;
> +
> +               sound_master: simple-audio-card,cpu {
> +                       sound-dai = <&i2s2>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&adv7533>;
> +               };
> +       };
> +
>  };

Hey Pengcheng,
  Thanks for sending this out!   I've noticed one small issue with
this dts patch compared to the previous iterations.

When building I hit the following errors:
arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts:292.27-294.5:
Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing
property '#sound-dai-cells' in node /soc/i2c@ffd72000/adv7533@39 or
bad phandle (referred from sound-dai[0])

Which seems to us missing the sound-dai-cells addition to the adv7511
node we had the first chunk of the patch here:
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=4279d58b622acd686b4d17fbf378ace1c467763e

thanks
-john

Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F33CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F68520862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VLQKO+JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfJ2Cl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:41:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34926 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfJ2ClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:41:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so11953201wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZeDXYfJYer9ewRjx0PKDp7gkl9UyDafoP/CtcLx8QMs=;
        b=VLQKO+JOvP8uz/jmVZM9OjdCfHDXyDMWpkMpTUHQHfjmA84+CUWD7XxXQNaduG/DhK
         WpLIlhGmDUXteBLSWlDLv3lLQKGl9plS/P7jNHsE1n2OgqkcjY1MB0T3Q0WBTvNA1F40
         PLq6JygSU3JQITuvsF6azO0JElsbcTQp8BtSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZeDXYfJYer9ewRjx0PKDp7gkl9UyDafoP/CtcLx8QMs=;
        b=uib2oGZIQ8KfAN5LQ5P5Zw9AIUNUbKp/Vdmab/+DJg4Okzu7jsEtgl4I55Z3F0KE6O
         AuTcleLIicfIbo5u9azkqyZ2CeapHN8pNISYE3BDMX3zkuhlyfq/tTUMpdfu5O7n6yYC
         fl7CcRhX0PohM29mq1xpb1KIeytM0ycdWvmLXRsgPtsVG83tYzCIFcV21l4H+Q27tT9V
         1FcF9upD+15I74YslBRwQX/0GMldbwMb0O+EIlInMWpHDc1vSIC6IoPDKfsU0gA+ki7F
         hBw1tbEZB2JKG+0dJqShdgd//ThBnon/VeeRBuCJ+WlnvLWYWJvXkad2PpJG93ePKW/m
         CJBA==
X-Gm-Message-State: APjAAAXmmePq4nNLdwNHnxLp6nFDen6DRq9tKy8BgbREUtCFo1k8TpsD
        E3Y+RQyz/DdmIkNwAGOrQOemzbr1JdbZxEG32929tg==
X-Google-Smtp-Source: APXvYqyc+JXXHY09WmrhUa6gx/7O5d2iKpnoJiK3FXpiuNcBFCoy0/gMtIdx+mtcV6BqjcvdZ3c6ru0/7R8MCJ1fJrA=
X-Received: by 2002:adf:e806:: with SMTP id o6mr15942278wrm.139.1572316882248;
 Mon, 28 Oct 2019 19:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191025133007.11190-4-cychiang@chromium.org> <201910290345.w2EEW5S3%lkp@intel.com>
In-Reply-To: <201910290345.w2EEW5S3%lkp@intel.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 29 Oct 2019 10:40:55 +0800
Message-ID: <CAFv8NwJYrpT=hCFwWfbdRvC971X-XGS-mjEBJrggQTJ02nhv7g@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] ASoC: rockchip_max98090: Optionally support HDMI
 use case
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 3:10 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Cheng-Yi,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on rockchip/for-next]
> [also build test ERROR on v5.4-rc5 next-20191028]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Cheng-Yi-Chiang/Add-HDMI=
-jack-support-on-RK3288/20191028-212502
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockc=
hip.git for-next
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    sound/soc/rockchip/snd-soc-rockchip-max98090: struct of_device_id is 1=
96 bytes.  The last of 3 is:
>    0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x72 0x6f 0x63 0x6b 0x63 0x68 0x69 0x70 0x2c 0x72 =
0x6f 0x63 0x6b 0x63 0x68 0x69 0x70 0x2d 0x61 0x75 0x64 0x69 0x6f 0x2d 0x6d =
0x61 0x78 0x39 0x38 0x30 0x39 0x30 0x2d 0x68 0x64 0x6d 0x69 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x10 0x00 =
0x00 0x00
> >> FATAL: sound/soc/rockchip/snd-soc-rockchip-max98090: struct of_device_=
id is not terminated with a NULL entry!

Please ignore this error for v8 patch series because the change in
rockchip_max98090.c of of_device_id is removed in v9 patch series.
Thanks!

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

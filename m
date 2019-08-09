Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D555AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838221743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565326671;
	bh=c2r9FC9z+EDj4pfOEGxUvJFcx8xbR4EhmThEzzCOMRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qTYIdsR8JwMjkyMvelwxqXIi/ZXRyBYyrWNip+URZ+8FM/9VTrbXB5MffNWeAqY/p
	 hcyKx6Ev3FHASK+ueoXvlAIil6cCm2oEsV+bZc/ga91uV6G6qtYDZE9Hu/aWax1i+1
	 NosEVm1w0xndznkGikdcS29gIERnmV0DQvisfzN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHIE5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 00:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfHIE5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:57:50 -0400
Received: from localhost (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7C22173E;
        Fri,  9 Aug 2019 04:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565326669;
        bh=c2r9FC9z+EDj4pfOEGxUvJFcx8xbR4EhmThEzzCOMRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEQXtV1oQBgjC9+EI0rtsFoOwtAFPNHyZWBA4tRxjGk3V3wHBC8NrVusknkHTFVPJ
         nDnn9FDpvWmdLV+QH266JQjeEfMa2NPt0XWZ7QGP9XXbdGGoD/4dfpjqc4w95G/LkB
         /OLw++KZcT/y1UU5qfggjoF/s2R2qA132VIaUxoY=
Date:   Fri, 9 Aug 2019 10:26:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier
 support
Message-ID: <20190809045630.GH12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 15:45, Srinivas Kandagatla wrote:
> This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier which is SoundWire interfaced.
> This also adds support to some missing bits in SoundWire bus layer like
> Device Tree support and module_sdw_driver macro.
                                ^^^^^^^^^^^^^^^
That part we already applied :D

> This patchset along with DB845c machine driver and WCD934x codec driver
> has been tested on SDM845 SoC based DragonBoard DB845c with two
> WSA8810 speakers.
> 
> Most of the code in this driver is rework of Qualcomm downstream drivers
> used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.
> 
> TODO:
> 	Add thermal sensor support in WSA881x.
> 
> This patchset also depends on the soundwire Kconfig patch
> https://lkml.org/lkml/2019/7/18/834 from Pierre
> 
> Thanks,
> srini
> 
> Changes since v1 RFC:
> - bindings document renamed to slave.txt
> - fix error code from dt slave parsing
> 
> Srinivas Kandagatla (4):
>   dt-bindings: soundwire: add slave bindings
>   soundwire: core: add device tree support for slave devices
>   dt-bindings: ASoC: Add WSA881x bindings
>   ASoC: codecs: add wsa881x amplifier support
> 
>  .../bindings/sound/qcom,wsa881x.txt           |   27 +
>  .../devicetree/bindings/soundwire/slave.txt   |   46 +
>  drivers/soundwire/bus.c                       |    2 +
>  drivers/soundwire/bus.h                       |    1 +
>  drivers/soundwire/slave.c                     |   47 +
>  sound/soc/codecs/Kconfig                      |   10 +
>  sound/soc/codecs/Makefile                     |    2 +
>  sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
>  8 files changed, 1295 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
>  create mode 100644 sound/soc/codecs/wsa881x.c
> 
> -- 
> 2.21.0

-- 
~Vinod

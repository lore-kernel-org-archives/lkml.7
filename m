Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D472089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFQUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:51:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:38897 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFQUvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:51:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 13:51:43 -0700
X-ExtLoop1: 1
Received: from rmbutler-mobl.amr.corp.intel.com ([10.255.231.126])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 13:51:42 -0700
Message-ID: <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 17 Jun 2019 13:51:42 -0700
In-Reply-To: <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
         <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:
> When we unload Skylake driver we may end up calling
> hdac_component_master_unbind(), it uses acomp->audio_ops, which we
> set
> in hdmi_codec_probe(), so we need to set it to NULL in
> hdmi_codec_remove(),
> otherwise we will dereference no longer existing pointer.

Hi Amadeusz,

It looks like the audio_ops should be deleted snd_hdac_acomp_exit().
Also, this doesnt seem to be the case with when the SOF driver is
removed.
Could you please give a bit more context on what error you see when
this happens?

Thanks,
Ranjani
> 
> Signed-off-by: Amadeusz Sławiński <
> amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c
> b/sound/soc/codecs/hdac_hdmi.c
> index 911bb6e2a1ac..9ee1bff548d8 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1890,6 +1890,12 @@ static void hdmi_codec_remove(struct
> snd_soc_component *component)
>  {
>  	struct hdac_hdmi_priv *hdmi =
> snd_soc_component_get_drvdata(component);
>  	struct hdac_device *hdev = hdmi->hdev;
> +	int ret;
> +
> +	ret = snd_hdac_acomp_register_notifier(hdev->bus, NULL);
> +	if (ret < 0)
> +		dev_err(&hdev->dev, "notifier unregister failed: err:
> %d\n",
> +				ret);
>  
>  	pm_runtime_disable(&hdev->dev);
>  }


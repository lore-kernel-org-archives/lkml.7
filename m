Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E34020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFRETR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:19:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:42165 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRETQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:19:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 21:19:16 -0700
X-ExtLoop1: 1
Received: from rmbutler-mobl.amr.corp.intel.com ([10.255.231.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2019 21:19:15 -0700
Message-ID: <1fd4af8e1b4bad5eda6f1e2f747b7988c74408fb.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        "\"Amadeusz" =?UTF-8?Q?S=C5=82awi=C5=84ski=22?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 21:19:15 -0700
In-Reply-To: <s5h7e9jc2s1.wl-tiwai@suse.de>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
         <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
         <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
         <s5h7e9jc2s1.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 23:36 +0200, Takashi Iwai wrote:
> On Mon, 17 Jun 2019 22:51:42 +0200,
> Ranjani Sridharan wrote:
> > 
> > On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:
> > > When we unload Skylake driver we may end up calling
> > > hdac_component_master_unbind(), it uses acomp->audio_ops, which
> > > we
> > > set
> > > in hdmi_codec_probe(), so we need to set it to NULL in
> > > hdmi_codec_remove(),
> > > otherwise we will dereference no longer existing pointer.
> > 
> > Hi Amadeusz,
> > 
> > It looks like the audio_ops should be deleted
> > snd_hdac_acomp_exit().
> 
> It's a different one.  The codec driver registers / de-registers the
> notifier at its probe/remove, while the controller driver takes care
> of snd_hdac_acomp_init().  snd_hdac_acomp_exit() is usually not
> needed
> to be called explicitly, as it's managed via devres.

Makes sense, thanks Takashi. But I am still wondering why we havent
seen this issue with SOF yet. We run the module unload/reload stress
test as well and havent seen this yet. 

Thanks,
Ranjani
> 
> 
> Takashi
> 
> > Also, this doesnt seem to be the case with when the SOF driver is
> > removed.
> > Could you please give a bit more context on what error you see when
> > this happens?
> > 
> > Thanks,
> > Ranjani
> > > 
> > > Signed-off-by: Amadeusz Sławiński <
> > > amadeuszx.slawinski@linux.intel.com>
> > > ---
> > >  sound/soc/codecs/hdac_hdmi.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/sound/soc/codecs/hdac_hdmi.c
> > > b/sound/soc/codecs/hdac_hdmi.c
> > > index 911bb6e2a1ac..9ee1bff548d8 100644
> > > --- a/sound/soc/codecs/hdac_hdmi.c
> > > +++ b/sound/soc/codecs/hdac_hdmi.c
> > > @@ -1890,6 +1890,12 @@ static void hdmi_codec_remove(struct
> > > snd_soc_component *component)
> > >  {
> > >  	struct hdac_hdmi_priv *hdmi =
> > > snd_soc_component_get_drvdata(component);
> > >  	struct hdac_device *hdev = hdmi->hdev;
> > > +	int ret;
> > > +
> > > +	ret = snd_hdac_acomp_register_notifier(hdev->bus, NULL);
> > > +	if (ret < 0)
> > > +		dev_err(&hdev->dev, "notifier unregister failed: err:
> > > %d\n",
> > > +				ret);
> > >  
> > >  	pm_runtime_disable(&hdev->dev);
> > >  }
> > 
> > 


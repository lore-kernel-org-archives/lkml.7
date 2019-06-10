Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61469C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfFJITT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:19:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:46121 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbfFJITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:19:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 01:19:18 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com (HELO xxx) ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2019 01:19:15 -0700
Date:   Mon, 10 Jun 2019 10:23:10 +0200
From:   Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 08/14] ASoC: Intel: Skylake: Properly
 cleanup on component removal
Message-ID: <20190610102310.572abe45@xxx>
In-Reply-To: <36e24c2a-feb4-4c6f-7bc5-76b13ff625a3@intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
        <20190605134556.10322-9-amadeuszx.slawinski@linux.intel.com>
        <36e24c2a-feb4-4c6f-7bc5-76b13ff625a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 09:17:21 +0200
Cezary Rojewski <cezary.rojewski@intel.com> wrote:

> On 2019-06-05 15:45, Amadeusz Sławiński wrote:
> > When we remove component we need to reverse things which were done
> > on init, this consists of topology cleanup, lists cleanup and
> > releasing firmware.
> > 
> > Currently cleanup handlers are put in wrong places or otherwise
> > missing. So add proper component cleanup function and perform
> > cleanups in it.
> > 
> > Signed-off-by: Amadeusz Sławiński
> > <amadeuszx.slawinski@linux.intel.com> ---
> >   sound/soc/intel/skylake/skl-pcm.c      |  8 ++++++--
> >   sound/soc/intel/skylake/skl-topology.c | 15 +++++++++++++++
> >   sound/soc/intel/skylake/skl-topology.h |  2 ++
> >   sound/soc/intel/skylake/skl.c          |  2 --
> >   4 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sound/soc/intel/skylake/skl-pcm.c
> > b/sound/soc/intel/skylake/skl-pcm.c index
> > 44062806fbed..7e8110c15258 100644 ---
> > a/sound/soc/intel/skylake/skl-pcm.c +++
> > b/sound/soc/intel/skylake/skl-pcm.c @@ -1459,8 +1459,12 @@ static
> > int skl_platform_soc_probe(struct snd_soc_component *component) 
> >   static void skl_pcm_remove(struct snd_soc_component *component)
> >   {
> > -	/* remove topology */
> > -	snd_soc_tplg_component_remove(component,
> > SND_SOC_TPLG_INDEX_ALL);
> > +	struct hdac_bus *bus = dev_get_drvdata(component->dev);
> > +	struct skl *skl = bus_to_skl(bus);
> > +
> > +	skl_tplg_exit(component, bus);
> > +
> > +	skl_debugfs_exit(skl);
> >   }
> >   
> >   static const struct snd_soc_component_driver skl_component  = {
> > diff --git a/sound/soc/intel/skylake/skl-topology.c
> > b/sound/soc/intel/skylake/skl-topology.c index
> > 44f3b29a7210..3964262109ac 100644 ---
> > a/sound/soc/intel/skylake/skl-topology.c +++
> > b/sound/soc/intel/skylake/skl-topology.c @@ -3748,3 +3748,18 @@ int
> > skl_tplg_init(struct snd_soc_component *component, struct hdac_bus
> > *bus) return 0;
> >   }
> > +
> > +void skl_tplg_exit(struct snd_soc_component *component, struct
> > hdac_bus *bus) +{
> > +	struct skl *skl = bus_to_skl(bus);
> > +	struct skl_pipeline *ppl, *tmp;
> > +
> > +	if (!list_empty(&skl->ppl_list))
> > +		list_for_each_entry_safe(ppl, tmp, &skl->ppl_list,
> > node)
> > +			list_del(&ppl->node);
> > +
> > +	/* clean up topology */
> > +	snd_soc_tplg_component_remove(component,
> > SND_SOC_TPLG_INDEX_ALL); +
> > +	release_firmware(skl->tplg);
> > +}  
> 
> In debugfs cleanup patch:
> [PATCH 07/14] ASoC: Intel: Skylake: Add function to cleanup debugfs 
> interface
> 
> you define skl_debugfs_exit separately - its usage is split and
> present in this very patch instead. However, for tplg counterpart - 
> skl_tplg_exit - you've decided to combine both together. Why not 
> separate tplg cleanup too?
> 

This is done because skl_debugfs_exit() can be introduced standalone.
However skl_tplg_exit() has code that is being moved from other places.
If I introduced it in separate commit, other one would be adding call
to this function while removing things that happen inside, losing part
of information, about the fact that code is actually just being moved.

> > diff --git a/sound/soc/intel/skylake/skl-topology.h
> > b/sound/soc/intel/skylake/skl-topology.h index
> > 82282cac9751..7d32c61c73e7 100644 ---
> > a/sound/soc/intel/skylake/skl-topology.h +++
> > b/sound/soc/intel/skylake/skl-topology.h @@ -471,6 +471,8 @@ void
> > skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai, struct
> > skl_pipe_params *params, int stream); int skl_tplg_init(struct
> > snd_soc_component *component, struct hdac_bus *ebus);
> > +void skl_tplg_exit(struct snd_soc_component *component,
> > +				struct hdac_bus *bus);
> >   struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
> >   		struct snd_soc_dai *dai, int stream);
> >   int skl_tplg_update_pipe_params(struct device *dev,
> > diff --git a/sound/soc/intel/skylake/skl.c
> > b/sound/soc/intel/skylake/skl.c index 6d6401410250..e4881ff427ea
> > 100644 --- a/sound/soc/intel/skylake/skl.c
> > +++ b/sound/soc/intel/skylake/skl.c
> > @@ -1119,14 +1119,12 @@ static void skl_remove(struct pci_dev *pci)
> >   	struct skl *skl = bus_to_skl(bus);
> >   
> >   	cancel_work_sync(&skl->probe_work);
> > -	release_firmware(skl->tplg);
> >   
> >   	pm_runtime_get_noresume(&pci->dev);
> >   
> >   	/* codec removal, invoke bus_device_remove */
> >   	snd_hdac_ext_bus_device_remove(bus);
> >   
> > -	skl->debugfs = NULL;
> >   	skl_platform_unregister(&pci->dev);
> >   	skl_free_dsp(skl);
> >   	skl_machine_device_unregister(skl);
> >   
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel


Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E13C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F3A215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfFSVJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:09:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:60631 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSVJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:09:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="243428686"
Received: from nmendi-mobl.amr.corp.intel.com ([10.251.150.122])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2019 14:09:22 -0700
Message-ID: <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 19 Jun 2019 14:09:22 -0700
In-Reply-To: <20190619103859.15bf51c5@xxx>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
         <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
         <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
         <20190618130015.0fc388b4@xxx>
         <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
         <20190619103859.15bf51c5@xxx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-19 at 10:38 +0200, Amadeusz Sławiński wrote:
> On Tue, 18 Jun 2019 08:58:22 -0700
> Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:
> 
> > On Tue, 2019-06-18 at 13:00 +0200, Amadeusz Sławiński wrote:
> > > On Mon, 17 Jun 2019 13:51:42 -0700
> > > Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:
> > >   
> > > > On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:  
> > > > > When we unload Skylake driver we may end up calling
> > > > > hdac_component_master_unbind(), it uses acomp->audio_ops,
> > > > > which
> > > > > we
> > > > > set
> > > > > in hdmi_codec_probe(), so we need to set it to NULL in
> > > > > hdmi_codec_remove(),
> > > > > otherwise we will dereference no longer existing pointer.    
> > > > 
> > > > Hi Amadeusz,
> > > > 
> > > > It looks like the audio_ops should be deleted
> > > > snd_hdac_acomp_exit().
> > > > Also, this doesnt seem to be the case with when the SOF driver
> > > > is
> > > > removed.
> > > > Could you please give a bit more context on what error you see
> > > > when this happens?  
> > > 
> > > Hi,
> > > 
> > > I get Oops. This is what happens with all other patches in this
> > > series and only this one reverted:
> > > 
> > > root@APL:~# rmmod snd_soc_sst_bxt_rt298
> > > root@APL:~# rmmod snd_soc_hdac_hdmi
> > > root@APL:~# rmmod snd_soc_skl  
> > 
> > Thanks, Amadeusz. I think the order in which the drivers are
> > removed
> > is what's causing the oops in your case. With SOF, the order we
> > remove is
> > 
> > 1. rmmod sof_pci_dev
> > 2. rmmod snd_soc_sst_bxt_rt298
> > 3. rmmod snd_soc_hdac_hdmi
> > 
> 
> Well, there is nothing enforcing the order in which modules can be
> unloaded (and I see no reason to force it), as you can see from
> following excerpt, you can either start unloading from
> snd_soc_sst_bxt_rt298 or snd_soc_skl, and yes if you start from
> snd_soc_skl, there is no problem.
> 
I am good with this patch. I just wanted to understand why we werent
seeing this error with SOF. Sure, there's nothing enforcing the order
in which modules are unloaded  but there must be a logical order for
testing purposes. 

Pierre, can you please comment on it. I vaguely remember discussing
this with you last year.

Thanks,
Ranjani


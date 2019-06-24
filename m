Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2837F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfFXHrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:47:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:55575 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfFXHrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:47:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 00:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="312629841"
Received: from xxx.igk.intel.com (HELO xxx) ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2019 00:46:33 -0700
Date:   Mon, 24 Jun 2019 09:50:36 +0200
From:   Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
Message-ID: <20190624095036.034ab575@xxx>
In-Reply-To: <26946ff4-1c91-a7e0-4354-132cbd06235a@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
        <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
        <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
        <20190618130015.0fc388b4@xxx>
        <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
        <20190619103859.15bf51c5@xxx>
        <0c939329d17c50c353acacf164583ba259a775c0.camel@linux.intel.com>
        <26946ff4-1c91-a7e0-4354-132cbd06235a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 08:17:33 +0200
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> >>>>> Could you please give a bit more context on what error you see
> >>>>> when this happens?  
> >>>>
> >>>> Hi,
> >>>>
> >>>> I get Oops. This is what happens with all other patches in this
> >>>> series and only this one reverted:
> >>>>
> >>>> root@APL:~# rmmod snd_soc_sst_bxt_rt298
> >>>> root@APL:~# rmmod snd_soc_hdac_hdmi
> >>>> root@APL:~# rmmod snd_soc_skl  
> >>>
> >>> Thanks, Amadeusz. I think the order in which the drivers are
> >>> removed
> >>> is what's causing the oops in your case. With SOF, the order we
> >>> remove is
> >>>
> >>> 1. rmmod sof_pci_dev
> >>> 2. rmmod snd_soc_sst_bxt_rt298
> >>> 3. rmmod snd_soc_hdac_hdmi
> >>>  
> >>
> >> Well, there is nothing enforcing the order in which modules can be
> >> unloaded (and I see no reason to force it), as you can see from
> >> following excerpt, you can either start unloading from
> >> snd_soc_sst_bxt_rt298 or snd_soc_skl, and yes if you start from
> >> snd_soc_skl, there is no problem.  
> 
> there is a fundamental dependency that you are ignoring: the module 
> snd_soc_sst_bxt_rt298 is a machine driver which will be probed when 
> snd_soc_skl creates a platform_device.
> Sure you can remove modules in a different order, but that's a bit of
> an artificial/academic exercise isn't it?
> 
> >>  
> > I am good with this patch. I just wanted to understand why we werent
> > seeing this error with SOF. Sure, there's nothing enforcing the
> > order in which modules are unloaded  but there must be a logical
> > order for testing purposes.
> > 
> > Pierre, can you please comment on it. I vaguely remember discussing
> > this with you last year.  
> 
> Our tests remove the modules by taking care of dependencies and it's 
> already unveiled dozens of issues.
> We could add a sequence similar to Amadeusz and unbind the modules
> which are loaded with the creation of a platform_device (machine
> driver, dmic), I am just not sure how of useful this would be.

You work under the assumption that users will remove modules in
"correct" order. Because it is not enforced by modules dependencies you
can expect users to do everything possible at some point in time. In
this case unloading modules in not expected order will lead to kernel
Oops, which is not what should happen.

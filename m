Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18068C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B12089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbfHVPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:19:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:50932 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389528AbfHVPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:19:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 08:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="173166237"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.36.176])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2019 08:19:30 -0700
Date:   Thu, 22 Aug 2019 17:19:29 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/5] ASoC: SOF: Intel: SoundWire initial
 integration
Message-ID: <20190822151928.GB1200@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

In patch 4/5 I forgot to mention superfluous braces around dev_err() 
in sdw_config_stream() and sdw_free_stream(). Otherwise for the series:

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Thanks
Guennadi

On Wed, Aug 21, 2019 at 03:17:15PM -0500, Pierre-Louis Bossart wrote:
> This RFC is the companion of the other RFC 'soundwire: intel: simplify
> DAI/PDI handling​'. Our purpose at this point is to gather feedback on
> the interfaces between the Intel SOF parts and the SoundWire code.
> 
> The suggested solution is a simple init/release inserted at
> probe/remove and resume/suspend, as well as two callbacks for the SOF
> driver to generate IPC configurations with the firmware. That level of
> separation completely hides the details of the SoundWire DAIs and will
> allow for 'transparent' multi-cpu DAI support, which will be handled
> in the machine driver and the soundwire DAIs.
> 
> This solution was tested on IceLake and CometLake, and captures the
> feedback from SOF contributors on an initial integration that was
> deemed too complicated (and rightly so).
> 
> Pierre-Louis Bossart (5):
>   ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
>   ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
>   ASoC: SOF: Intel: hda: add SoundWire IP support
>   ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
>   ASoC: SOF: Intel: add support for SoundWire suspend/resume
> 
>  include/sound/sof/dai-intel.h |  18 ++--
>  sound/soc/sof/intel/hda-dsp.c |  11 +++
>  sound/soc/sof/intel/hda.c     | 157 ++++++++++++++++++++++++++++++++++
>  sound/soc/sof/intel/hda.h     |  11 +++
>  4 files changed, 188 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 3b3aaa017e8072b1bfddda92be296b3463d870be
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

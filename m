Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC95C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3FA2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbfHVPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:11:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:65427 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387755AbfHVPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:11:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 08:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="169810435"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.36.176])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2019 08:11:19 -0700
Date:   Thu, 22 Aug 2019 17:11:18 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Message-ID: <20190822151117.GA1200@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
 <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:53:06AM -0500, Pierre-Louis Bossart wrote:
> Thanks for the review Guennadi
> 
> > > +static int sdw_config_stream(void *arg, void *s, void *dai,
> > > +			     void *params, int link_id, int alh_stream_id)
> > 
> > I realise, that these function prototypes aren't being introduced by these
> > patches, but just wondering whether such overly generic prototype is really
> > a good idea here, whether some of those "void *" pointers could be given
> > real types. The first one could be "struct device *" etc.
> 
> In this case the 'arg' parameter is actually a private 'struct snd_sof_dev',
> as shown below [1]. We probably want to keep this relatively opaque, this is
> a context that doesn't need to be exposed to the SoundWire code.

Right, that's why I proposed struct device and not struct snd_sof_dev, to not 
make it SOF-specific, then sdev could be obtained from dev_get_drvdata(). But 
yes, that's unrelated to this series.

Thanks
Guennadi

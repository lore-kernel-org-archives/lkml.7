Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CCC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF78216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfGZIXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:23:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:17846 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:23:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 01:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="254256631"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.35.244])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2019 01:23:00 -0700
Date:   Fri, 26 Jul 2019 10:22:59 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "slawomir.blauciak@intel.com" <slawomir.blauciak@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Message-ID: <20190726082258.GF16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <20190726073931.GE16003@ubuntu>
 <716D5D19-D494-4F4E-9180-24CB5A575648@global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716D5D19-D494-4F4E-9180-24CB5A575648@global.cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Fri, Jul 26, 2019 at 07:47:04AM +0000, Jan Kotas wrote:
> Hello,
> 
> I while back I proposed a patch for this, but it went nowhere.
> 
> https://patchwork.kernel.org/patch/10887405/
> Maybe something similar can be implemented?

Yes, I was thinking about checkint -EACCESS too, but then I noticed this code
in rpm_resume():

	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
	    && dev->power.runtime_status == RPM_ACTIVE)
		retval = 1;

i.e. if RT-PM is disabled on the device (but only exactly once?..) and it's
active and the device is suspended for a system suspend, the function will
return 1. I don't understand the logic of this code, but it seems to me it
could break the -EACCESS check?

Thanks
Guennadi

> Jan
> 
> > On 26 Jul 2019, at 09:39, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com> wrote:
> > 
> > EXTERNAL MAIL
> > 
> > 
> > Hi Pierre,
> > 
> > I might be wrong but this doesn't seem right to me. (Supposedly) all RT-PM
> > functions check for "enabled" internally. The only thing that can happen is
> > that if RT-PM isn't enabled some of those functions will return an error.
> > So, in those cases where the return value of RT-PM functions isn't checked,
> > I don't think you need to do anything. Where it is checked maybe do
> > 
> > +	if (ret < 0 && pm_runtime_enabled(slave->bus->dev))
> > 
> > Thanks
> > Guennadi
> > 
> > On Thu, Jul 25, 2019 at 06:40:09PM -0500, Pierre-Louis Bossart wrote:
> >> Not all platforms support runtime_pm for now, let's use runtime_pm
> >> only when enabled.
> >> 
> >> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> ---
> >> drivers/soundwire/bus.c | 25 ++++++++++++++++---------
> >> 1 file changed, 16 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> >> index 5ad4109dc72f..0a45dc5713df 100644
> >> --- a/drivers/soundwire/bus.c
> >> +++ b/drivers/soundwire/bus.c
> >> @@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> >> 	if (ret < 0)
> >> 		return ret;
> >> 
> >> -	ret = pm_runtime_get_sync(slave->bus->dev);
> >> -	if (ret < 0)
> >> -		return ret;
> >> +	if (pm_runtime_enabled(slave->bus->dev)) {
> >> +		ret = pm_runtime_get_sync(slave->bus->dev);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	}
> >> 
> >> 	ret = sdw_transfer(slave->bus, &msg);
> >> -	pm_runtime_put(slave->bus->dev);
> >> +
> >> +	if (pm_runtime_enabled(slave->bus->dev))
> >> +		pm_runtime_put(slave->bus->dev);
> >> 
> >> 	return ret;
> >> }
> >> @@ -359,13 +363,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> >> 			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
> >> 	if (ret < 0)
> >> 		return ret;
> >> -
> >> -	ret = pm_runtime_get_sync(slave->bus->dev);
> >> -	if (ret < 0)
> >> -		return ret;
> >> +	if (pm_runtime_enabled(slave->bus->dev)) {
> >> +		ret = pm_runtime_get_sync(slave->bus->dev);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	}
> >> 
> >> 	ret = sdw_transfer(slave->bus, &msg);
> >> -	pm_runtime_put(slave->bus->dev);
> >> +
> >> +	if (pm_runtime_enabled(slave->bus->dev))
> >> +		pm_runtime_put(slave->bus->dev);
> >> 
> >> 	return ret;
> >> }
> >> -- 
> >> 2.20.1
> >> 
> >> _______________________________________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__mailman.alsa-2Dproject.org_mailman_listinfo_alsa-2Ddevel&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=g7GAQENVXx_RQdyXHInPMg&m=vETGQLSPeGb7K_ZsXv4Tl3VFfdXzyummTDga97ozJcg&s=LiW4SToh5U0zhnkox54oRhJ1u3vFNbBB9nmzRDuCDjI&e=
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6423C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C012166E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573186489;
	bh=zOjttgD2pBwUmq+N/FgixVnx02tlYEDPZijO3Al3aMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SlBBoePYd2hHgbKU57h2vMIyErpro/Jo30BXRUqLGzTZxJfMesPHcwvoCtzb0trHN
	 tkvT1GIuyG+qIhtoeyv6IfrLjV/RqpY118uIBZ4adSXj4tBG+JuVVib/J3vC13Wqn1
	 VDfZauBeFQI4dDNjjnEPtsBVFN5LWBYJisUTE2JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfKHEOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:14:44 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1CE2166E;
        Fri,  8 Nov 2019 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573186483;
        bh=zOjttgD2pBwUmq+N/FgixVnx02tlYEDPZijO3Al3aMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODir7oPnb77Dpzy0Q3osndcpcCopiWfOU9NLOt1ahdLP+x6JipQBzz30EgOTgSMUr
         +hckTJdPKkZOibSu7HJLmhTbo903xvY9k8JlIHlYzSuO8ly4GbvjjAgdWZEivLZKoW
         juumdGON8icbc8jTJB6dHx0Q1psElet0hLkYxnbE=
Date:   Fri, 8 Nov 2019 09:44:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 13/14] soundwire: intel: free all resources
 on hw_free()
Message-ID: <20191108041435.GV952516@vkoul-mobl>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-14-pierre-louis.bossart@linux.intel.com>
 <42403ea0-e337-81b6-f11a-2a32c1473750@intel.com>
 <0374d162-2cea-2fca-ec12-a0377130c711@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0374d162-2cea-2fca-ec12-a0377130c711@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 15:46, Pierre-Louis Bossart wrote:
> On 11/4/19 2:08 PM, Cezary Rojewski wrote:
> > On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
> > > @@ -816,6 +835,7 @@ static int
> > >   intel_hw_free(struct snd_pcm_substream *substream, struct
> > > snd_soc_dai *dai)
> > >   {
> > >       struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
> > > +    struct sdw_intel *sdw = cdns_to_intel(cdns);
> > >       struct sdw_cdns_dma_data *dma;
> > >       int ret;
> > > @@ -823,12 +843,28 @@ intel_hw_free(struct snd_pcm_substream
> > > *substream, struct snd_soc_dai *dai)
> > >       if (!dma)
> > >           return -EIO;
> > > +    ret = sdw_deprepare_stream(dma->stream);
> > > +    if (ret) {
> > > +        dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
> > > +        return ret;
> > > +    }
> > > +
> > 
> > I understand that you want to be transparent to caller with failure
> > reasons via dev_err/_warn. However, sdw_deprepare_stream already dumps
> > all the logs we need. The same applies for most of the other calls (and
> > not just in this patch..).

I think this is a valid concern! In linux we do not do that, for example
we ask people to not log errors on kmalloc as it will be logged on
failures so drivers do not need to do that.

> > Do we really need to be that verbose? Maybe just agree on caller -or-
> > subject being the source for the messaging, align existing usages and
> > thus preventing further duplication?
> > 
> > Not forcing anything, just asking for your opinion on this.
> 
> the sdw_prepare/deprepare_stream calls provide error logs, but they are not
> mapped to specific devices/dais (pr_err vs. dev_dbg). I found it was easier
> to check for which dai the error was reported.

Well in that case we should fix pr_err, there are only 17 instances of
these in core, and few of them are justified in core (no dev pointer)
and 11 in stream (few of them valid (no stream pointer) but rest can be
converted to use dev_err! Even then they print stream name, so checking
error is not justified argument!

> We are also in the middle of integration with new hardware/boards, and
> erring on the side of more traces will help everyone involved. We can
> revisit later which ones are strictly necessary.

Naah you are having duplicate logs, it does *not* help in debug seems
1000 line logs and few lines conveying duplicate info, I would rather
have each line unique so that I dont have to skip duplicate ones while
debugging!

-- 
~Vinod

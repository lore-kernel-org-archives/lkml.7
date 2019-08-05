Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CE42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfHEQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:30:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:33996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfHEQat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:30:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 09:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="178892890"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2019 09:30:41 -0700
Date:   Mon, 5 Aug 2019 22:02:33 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
Message-ID: <20190805163233.GA24889@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
 <20190805095620.GD22437@buildpc-HP-Z230>
 <12799e97-d6e3-5027-a409-0fe37dba86fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12799e97-d6e3-5027-a409-0fe37dba86fd@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:33:25AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 8/5/19 4:56 AM, Sanyog Kale wrote:
> > On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
> > > When we disable the stream and then call hw_free, two bank switches
> > > will be handled and as a result we re-enable the stream on hw_free.
> > > 
> > 
> > I didnt quite get why there will be two bank switches as part of disable flow
> > which leads to enabling of stream?
> 
> You have two bank switches, one to stop streaming and on in de-prepare. It's
> symmetrical with the start sequence, where we do a bank switch to prepare
> and another to enable.

Got it. I misunderstood it that two bank switches are performed as part of
disable_stream.

> 
> Let's assume we are using bank0 when streaming.
> 
> Before the first bank switch, the channel_enable is set to false in the
> alternate bank1. When the bank switch happens, bank1 become active and the
> streaming stops. But bank0 registers have not been modified so when we do
> the second bank switch in de-prepare we make bank0 active, and the ch_enable
> bits are still set so streaming will restart... When we stop streaming, we
> need to make sure the ch_enable bits are cleared in the two banks.

This is clear. Even though the channels remains enabled, i believe there
won't be any data pushed on lines as stream will be closed.

Regarding mirroring approach, I assume after bank switch we will take
snapshot of active bank and program same in inactive bank.

> 
> 
> > 
> > > Make sure the stream is disabled on both banks.
> > > 
> > > TODO: we need to completely revisit all this and make sure we have a
> > > mirroring mechanism between current and alternate banks.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/stream.c | 19 ++++++++++++++++++-
> > >   1 file changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > > index 53f5e790fcd7..75b9ad1fb1a6 100644
> > > --- a/drivers/soundwire/stream.c
> > > +++ b/drivers/soundwire/stream.c
> > > @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
> > >   		}
> > >   	}
> > > -	return do_bank_switch(stream);
> > > +	ret = do_bank_switch(stream);
> > > +	if (ret < 0) {
> > > +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* make sure alternate bank (previous current) is also disabled */
> > > +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> > > +		bus = m_rt->bus;
> > > +		/* Disable port(s) */
> > > +		ret = sdw_enable_disable_ports(m_rt, false);
> > > +		if (ret < 0) {
> > > +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > >   }
> > >   /**
> > > -- 
> > > 2.20.1
> > > 
> > 

-- 

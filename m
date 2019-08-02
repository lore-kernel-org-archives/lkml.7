Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E42C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC62621773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761757;
	bh=HqRMBzEVJ91zUIcc/7XgWIBNC/V47cjTHlM+0R3V3G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VseklMeQWOldOMu9AnTNO//giIz4FY26/yhQExBxODvYikGCsp8uN0GCXyON3cZVc
	 huUsFp+hE7WVH9uxfT+jA7MiWR0Sd0CtdUJpA0vgCDdRBOEB6Qt1Yz+SY0ZzEpQoOG
	 rKOf723aoYZFMAJsAC+sK839Ker6qTtCNeerKZx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbfHBQCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388743AbfHBQCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:02:34 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE70216C8;
        Fri,  2 Aug 2019 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761753;
        bh=HqRMBzEVJ91zUIcc/7XgWIBNC/V47cjTHlM+0R3V3G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PI+K16WnDzjYDJFQEXnmXMix0PX19y08kd4ZT7xqWqQzxOGKlt8aKzwzK64V758RH
         Gjns+UqAJSEnLz8c6Vg0mgFUP4NH9P2EiZvGc28KyevydcpjqtlxFMKtX+fssge1Sf
         VA23rXbwNn07SqLJBqMiULQ1y2kgdJEBHZ/ljO3M=
Date:   Fri, 2 Aug 2019 21:31:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple
 status reports per Slave
Message-ID: <20190802160115.GS12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190802122003.GQ12733@vkoul-mobl.Dlink>
 <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 10:29, Pierre-Louis Bossart wrote:
> On 8/2/19 7:20 AM, Vinod Koul wrote:
> > On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

> > > +				status[i] = SDW_SLAVE_UNATTACHED;
> > > +				break;
> > > +			case 1:
> > > +				status[i] = SDW_SLAVE_ATTACHED;
> > > +				break;
> > > +			case 2:
> > > +				status[i] = SDW_SLAVE_ALERT;
> > > +				break;
> > > +			default:
> > > +				status[i] = SDW_SLAVE_RESERVED;
> > > +				break;
> > > +			}
> > 
> > we have same logic in the code block preceding this, maybe good idea to
> > write a helper and use for both
> 
> Yes, I am thinking about this. There are multiple cases where we want to
> re-check the status and clear some bits, so helpers would be good.
> 
> > 
> > Also IIRC we can have multiple status set right?
> 
> Yes, the status bits are sticky and mirror all values reported in PING
> frames. I am still working on how to clear those bits, there are cases where
> we clear bits and end-up never hearing from that device ever again. classic
> edge/level issue I suppose.

Then the case logic above doesn't work, it should be like the code block
preceding this..

Thanks
-- 
~Vinod

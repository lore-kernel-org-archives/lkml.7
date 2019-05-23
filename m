Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3DAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED32721019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfEWJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:20:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:15388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfEWJUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:20:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 02:20:17 -0700
X-ExtLoop1: 1
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2019 02:20:15 -0700
Date:   Thu, 23 May 2019 14:50:34 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
Message-ID: <20190523092034.GA23777@buildpc-HP-Z230>
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
 <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
 <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:43:14AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 22/05/2019 17:41, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
> > > This patch fixes below warning due to unlocking without locking.
> > > 
> > > ?? =====================================
> > > ?? WARNING: bad unlock balance detected!
> > > ?? 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G?????????????? W
> > > ?? -------------------------------------
> > > ?? aplay/2954 is trying to release lock (&bus->msg_lock) at:
> > > ?? do_bank_switch+0x21c/0x480
> > > ?? but there are no more locks to release!
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > > ?? drivers/soundwire/stream.c | 3 ++-
> > > ?? 1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > > index 544925ff0b40..d16268f30e4f 100644
> > > --- a/drivers/soundwire/stream.c
> > > +++ b/drivers/soundwire/stream.c
> > > @@ -814,7 +814,8 @@ static int do_bank_switch(struct
> > > sdw_stream_runtime *stream)
> > > ?????????????????????????? goto error;
> > > ?????????????????? }
> > > -?????????????? mutex_unlock(&bus->msg_lock);
> > > +?????????????? if (mutex_is_locked(&bus->msg_lock))
> > > +?????????????????????? utex_unlock(&bus->msg_lock);
> > 
> > Does this even compile? should be mutex_unlock, no?
> > 
> > We also may want to identify the issue in more details without pushing
> > it under the rug. The locking mechanism is far from simple and it's
> > likely there are a number of problems with it.
> > 
> msg_lock is taken conditionally during multi link bank switch cases, however
> the unlock is done unconditionally leading to this warning.
> 
> Having a closer look show that there could be a dead lock in this path while
> executing sdw_transfer(). And infact there is no need to take msg_lock in
> multi link switch cases as sdw_transfer should take care of this.
> 
> Vinod/Sanyog any reason why msg_lock is really required in this path?
>

In case of multi link we use sdw_transfer_defer instead of sdw_transfer
where lock is not acquired, hence lock is acquired in do_bank_switch for
multi link. we should add same check of multi link to release lock in
do_bank_switch.

> --srini
> 
> > > ?????????? }
> > > ?????????? return ret;
> > > 

-- 

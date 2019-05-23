Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4C6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336ED2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfEWJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:41:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:27664 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfEWJlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:41:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 02:41:24 -0700
X-ExtLoop1: 1
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2019 02:41:21 -0700
Date:   Thu, 23 May 2019 15:11:41 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
Message-ID: <20190523094141.GA24259@buildpc-HP-Z230>
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
 <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
 <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
 <20190523092034.GA23777@buildpc-HP-Z230>
 <b85e54e8-5ba8-38ff-3538-f54526c67b31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85e54e8-5ba8-38ff-3538-f54526c67b31@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:30:20AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/05/2019 10:20, Sanyog Kale wrote:
> > On Thu, May 23, 2019 at 09:43:14AM +0100, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 22/05/2019 17:41, Pierre-Louis Bossart wrote:
> > > > 
> > > > 
> > > > On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
> > > > > This patch fixes below warning due to unlocking without locking.
> > > > > 
> > > > > ?? =====================================
> > > > > ?? WARNING: bad unlock balance detected!
> > > > > ?? 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G?????????????? W
> > > > > ?? -------------------------------------
> > > > > ?? aplay/2954 is trying to release lock (&bus->msg_lock) at:
> > > > > ?? do_bank_switch+0x21c/0x480
> > > > > ?? but there are no more locks to release!
> > > > > 
> > > > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > > ---
> > > > > ?? drivers/soundwire/stream.c | 3 ++-
> > > > > ?? 1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > > > > index 544925ff0b40..d16268f30e4f 100644
> > > > > --- a/drivers/soundwire/stream.c
> > > > > +++ b/drivers/soundwire/stream.c
> > > > > @@ -814,7 +814,8 @@ static int do_bank_switch(struct
> > > > > sdw_stream_runtime *stream)
> > > > > ?????????????????????????? goto error;
> > > > > ?????????????????? }
> > > > > -?????????????? mutex_unlock(&bus->msg_lock);
> > > > > +?????????????? if (mutex_is_locked(&bus->msg_lock))
> > > > > +?????????????????????? utex_unlock(&bus->msg_lock);
> > > > 
> > > > Does this even compile? should be mutex_unlock, no?
> > > > 
> > > > We also may want to identify the issue in more details without pushing
> > > > it under the rug. The locking mechanism is far from simple and it's
> > > > likely there are a number of problems with it.
> > > > 
> > > msg_lock is taken conditionally during multi link bank switch cases, however
> > > the unlock is done unconditionally leading to this warning.
> > > 
> > > Having a closer look show that there could be a dead lock in this path while
> > > executing sdw_transfer(). And infact there is no need to take msg_lock in
> > > multi link switch cases as sdw_transfer should take care of this.
> > > 
> > > Vinod/Sanyog any reason why msg_lock is really required in this path?
> > > 
> > 
> > In case of multi link we use sdw_transfer_defer instead of sdw_transfer
> > where lock is not acquired, hence lock is acquired in do_bank_switch for
> > multi link. we should add same check of multi link to release lock in
> > do_bank_switch.
> 
> probably we should just add the lock around the sdw_transfer_defer call in
> sdw_bank_switch()?
> This should cleanup the code a bit too.
> 
> something like:
> 
> ------------------------------------>cut<-----------------------------
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index d01060dbee96..f455af5b8151 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -676,10 +676,13 @@ static int sdw_bank_switch(struct sdw_bus *bus, int
> m_rt_count)
>          */
>         multi_link = bus->multi_link && (m_rt_count > 1);
> 
> -       if (multi_link)
> +       if (multi_link) {
> +               mutex_lock(&bus->msg_lock);
>                 ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
> -       else
> +               mutex_unlock(&bus->msg_lock);

you cant release bus_lock here since message is not yet transferred.
we can only release bus_lock after sdw_ml_sync_bank_switch function where
we confirm that message transfer is completed.

> +       } else {
>                 ret = sdw_transfer(bus, wr_msg);
> +       }
> 
>         if (ret < 0) {
>                 dev_err(bus->dev, "Slave frame_ctrl reg write failed\n");
> @@ -742,25 +745,19 @@ static int do_bank_switch(struct sdw_stream_runtime
> *stream)
>         struct sdw_master_runtime *m_rt = NULL;
>         const struct sdw_master_ops *ops;
>         struct sdw_bus *bus = NULL;
> -       bool multi_link = false;
>         int ret = 0;
> 
>         list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>                 bus = m_rt->bus;
>                 ops = bus->ops;
> 
> -               if (bus->multi_link) {
> -                       multi_link = true;
> -                       mutex_lock(&bus->msg_lock);
> -               }
> -
>                 /* Pre-bank switch */
>                 if (ops->pre_bank_switch) {
>                         ret = ops->pre_bank_switch(bus);
>                         if (ret < 0) {
>                                 dev_err(bus->dev,
>                                         "Pre bank switch op failed: %d\n",
> ret);
> -                               goto msg_unlock;
> +                               return ret;
>                         }
>                 }
> 
> @@ -814,7 +811,6 @@ static int do_bank_switch(struct sdw_stream_runtime
> *stream)
>                         goto error;
>                 }
> 
> -               mutex_unlock(&bus->msg_lock);
>         }
> 
>         return ret;
> @@ -827,16 +823,6 @@ static int do_bank_switch(struct sdw_stream_runtime
> *stream)
>                 kfree(bus->defer_msg.msg);
>         }
> 
> -msg_unlock:
> -
> -       if (multi_link) {
> -               list_for_each_entry(m_rt, &stream->master_list, stream_node)
> {
> -                       bus = m_rt->bus;
> -                       if (mutex_is_locked(&bus->msg_lock))
> -                               mutex_unlock(&bus->msg_lock);
> -               }
> -       }
> -
>         return ret;
>  }
> 
> ------------------------------------>cut<-----------------------------
> > 
> > > --srini
> > > 
> > > > > ?????????? }
> > > > > ?????????? return ret;
> > > > > 
> > 

-- 

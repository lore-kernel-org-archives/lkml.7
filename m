Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAFAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58327206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLPJv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:51:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:4935 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfLPJvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:51:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 01:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="416382548"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2019 01:51:20 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ign28-0003JT-8d; Mon, 16 Dec 2019 11:51:20 +0200
Date:   Mon, 16 Dec 2019 11:51:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chen Gang <chengang@emindsoft.com.cn>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or
 disable irq sharing based on isa or pci bus
Message-ID: <20191216095120.GN32742@smile.fi.intel.com>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
 <20191213105033.GT32742@smile.fi.intel.com>
 <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:27:23AM +0800, Chen Gang wrote:
> Thank you for your reply.
> 
> I guess, this patch has to be refactored to match the related linux
> versions. And excuse me, my orignal hardware environments has been gone,
> so I can not give the new refactored patch additional test.
> 
> It is necessary to continue discussing and reviewing this patch to let
> it be known completely, but I guess I am not the suitable persion to
> refactor the patch.

Yeah, you may refactor it, but please mention in the comment (the text going
after '---' line) that you are not able to test it. At least for maintainer it
may be a crucial point either to take your change or not.

> After finish discussing and reviewing, if anyone still wants me to
> refactor the patch, please let me know, I shall try.
> 
> The contents below are my reply, pelease check, thanks.

My reply below.

> On 2019/12/13 下午6:50, Andy Shevchenko wrote:
> > On Fri, Dec 13, 2019 at 01:17:17PM +0800, chengang@emindsoft.com.cn wrote:

> >>  				aux |= inb(addr[i] + DATA_PORT) << 8;
> >>  				if (aux != io_address)
> >>  					continue;
> > 
> >> -
> > 
> > What the point?

(1)

> >> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
> >> +				set_icsr(addr[i], k);
> >> +#endif
> >>  				fintek_8250_exit_key(addr[i]);
> >>  				*key = keys[j];
> >>  				*index = k;
> >> @@ -179,53 +212,6 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
> >>  	return -ENODEV;
> >>  }
> >>  
> 
> In my case at that time, for fintex irq sharing, it needed additional
> initinalization, or it could not work well. I wrote the related code
> based on the fintek data-sheet which was downloaded from internet.

I guess it's an answer to the (1). Though in (1) I simple meant the removal
of blank line (see, I emphasized the excerpt I'm commenting with blank lines
before and after).

> >> -static int
> >> -fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
> > 
> > Why did you move this function?
> > It's now not only hard to follow what has been changed, and to review.
> > 
> >> --- a/drivers/tty/serial/8250/8250_pnp.c
> >> +++ b/drivers/tty/serial/8250/8250_pnp.c
> >> @@ -438,8 +438,13 @@ static int
> >>  serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
> >>  {
> >>  	struct uart_8250_port uart, *port;
> >> -	int ret, line, flags = dev_id->driver_data;
> >> +	int ret, line, flags;
> >>  
> > 
> 
> I thought locating the main probe function at the end of the source file
> was better for normal code reading (maybe it need be a seperate patch).

Yes, it needs to be in a separated (preparatory) patch.

> But if we don't mind, we can still remain its orignal position.

I do mind, sorry. The rule of thumb is one logical change per patch.

> >> +#if IS_BUILTIN(CONFIG_SERIAL_8250_FINTEK)
> >> +	if (!fintek_8250_probe(dev, dev_id))
> >> +		return 0;
> >> +#endif
> >> +	flags = dev_id->driver_data;
> > 
> > Oh, I don't like this.
> > It needs a bit more refactoring done first.
> > 
> > The idea that we are not going to pollute generic driver(s) with quirks anymore
> > (only when it's really unavoidable).
> > 
> 
> At that time, for me, I could not get any new better ways in a short
> time, and the issue had to be fixed in time, so the code was not good
> engough.

It's not an excuse to put hacks in the code that will make maintenance hard.
The usual case is such situations is that author of the fix do:

- provide a fix (perhaps ugly one)
- refactor and clean up the code

So at the result we have keep maintainable piece in kernel.
This is by the way my main motivation to NAK this change.

> At present, Linux version has been changed much, welcome any one to
> refactor it for current linux version or another related old linux
> versions if this patch is valuable more or less.

Then it's no go for this patch, sorry.

-- 
With Best Regards,
Andy Shevchenko



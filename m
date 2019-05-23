Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558614710;
	bh=5nRlD3WZ/bsqEm3eeGEBMTBdvCwuuaiFXuFrpJhFLyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M9m9o/TDp0zDwASzY0ndbQqRU1F5AFGkHFbBXFHcT1y5DKaZ/T2IVhHkxJmyxIN/o
	 FiVamvE1r9Q41DgYVVbIaNectkfc/S73jJ7TOY6XxxuMUYDsqxPp7wVheIgbR5lI14
	 jAQuSOgIkkIE2F6qCTw6pCf5fg2sHFs3Q7/nV/gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfEWMbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:31:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40903 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfEWMbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:31:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so4263992lfc.7;
        Thu, 23 May 2019 05:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cW+Duxkb0l6n+0TMBaP6GzkhbfcmvI4Sk/o1kv7aeRY=;
        b=hQaBajn5ORhs6gRSIn4zcLfW4jkcPyXdKxL8v+sDrUNi6o2WnaAPJWE+cJvfIuA05G
         D0xSqdRpwqMDpxAfhwQL1wZpWVWhCQuYqC7NOVU1JeNygzU/fs4cjBPPjrfbmPSPw9k7
         tC08xBFkwedUQZoWp8NrtCx9zvXpaHH1LVyVvXpr7035T9QQ3ZK2pkpZGrkajYynChkC
         f7JKDZofQmNhRbmZr3ZGyO/A9nQJE1phsK+kohmOqTSowX/cSxyPMxgj7FRFDLA8EY1x
         RLkrGIbFj9u1UH/Y9e90ixYFwFeiieb2m7cNEtPRs8IRccxzcvqITl1U8BRSbVwI05Af
         zcXw==
X-Gm-Message-State: APjAAAWquRk8fYT4SSWpUGNupj5Vu+TWCaOhNUiW14eJwpQwpKMZoetW
        m/s077++9T/dhJoACVVj6fkLfZSQM9w=
X-Google-Smtp-Source: APXvYqwB4x0ydmnmIFoqgM5NHc3o6dlAonNIfmwzOXQ25DlY9MIW3eDrTVwS+IFBIHt8466swa/FRw==
X-Received: by 2002:ac2:5222:: with SMTP id i2mr41860242lfl.80.1558614705902;
        Thu, 23 May 2019 05:31:45 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d195sm789590lfd.10.2019.05.23.05.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:31:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTmsm-0003ZW-AI; Thu, 23 May 2019 14:31:40 +0200
Date:   Thu, 23 May 2019 14:31:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Message-ID: <20190523123140.GF568@localhost>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost>
 <20190521101059.GB13612@kroah.com>
 <20190523091839.GC568@localhost>
 <3bdfe2ab-daec-e222-8e2b-cac96fd218a2@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdfe2ab-daec-e222-8e2b-cac96fd218a2@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 12:46:38PM +0200, Michal Simek wrote:
> Hi Johan,
> 
> On 23. 05. 19 11:18, Johan Hovold wrote:
> > On Tue, May 21, 2019 at 12:10:59PM +0200, Greg Kroah-Hartman wrote:
> >> On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
> >>> On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
> >>>> If ulite_probe is not called or failed to registed
> >>>> uart_register_driver, unload the module will call
> >>>> uart_unregister_driver, which will tigger NULL
> >>>> pointer dereference like this:
> >>>>
> >>>> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> >>>> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
> >>>
> >>>> This patch fix this by moving uart_unregister_driver
> >>>> to ulite_remove.
> >>>>
> >>>> Reported-by: Hulk Robot <hulkci@huawei.com>
> >>>> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> >>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>> ---
> >>>>  drivers/tty/serial/uartlite.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> >>>> index b8b912b..2e49fb6 100644
> >>>> --- a/drivers/tty/serial/uartlite.c
> >>>> +++ b/drivers/tty/serial/uartlite.c
> >>>> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
> >>>>  	pm_runtime_disable(&pdev->dev);
> >>>>  	pm_runtime_set_suspended(&pdev->dev);
> >>>>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>>> +	uart_unregister_driver(&ulite_uart_driver);
> >>>
> >>> This broken. Consider what happens if you have tho ports registered and
> >>> you unbind the first.
> >>>
> >>> Someone else sent a fix for this here
> >>>
> >>> 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
> >>>
> >>> That fix also has some issues, but is still better given the current
> >>> state this driver is in.
> >>
> >> I'm not taking any of these patches until people agree on what needs to
> >> be done here :)
> > 
> > Good. :)
> > 
> >> Why is this driver so "special" it is having these types of problems?
> >> Why can't it do what all other drivers do in this case?
> > 
> > Apparently some vendor-tree hacks has made it into mainline.
> 
> I have designed this change and it didn't go to vendor tree first.
> I have been also asking if this is the right way to go.
> You can find the whole series started with this RFC
> https://lore.kernel.org/lkml/e2039dc5-92ec-d3a1-bc4f-6565a8c901ac@suse.de/t/
> 
> https://lkml.org/lkml/2018/6/6/346
> and then
> 
> https://lkml.org/lkml/2018/9/3/404

Looks like you didn't get any real feedback to your first two RFC
series, before you resent as non-RFC and it was merged without any
discussion. :/

> And even this step was discussed before in
> [RFC PATCH 0/4] serial: uartps: Dynamic allocation
> which was July 2017.

Yeah, you definitely tried to get feedback on this.

> And all these patches have been merged by Greg and then I have taken
> them back to Xilinx Linux tree.

Right, I had missed some of the back story.

> And the same concept was also applied to uartlite and intention is also
> to apply it to pl011 driver to avoid this warning.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/amba-pl011.c?h=v5.2-rc1#n2538

Perhaps you should hold off on spreading this further until it can be
reviewed. Looks like it's mostly contained to xilinx_uartps right now.

> > They're trying to register one tty/uart driver per physical port
> > which sounds like a terrible idea. And even the implementation is
> > broken as these bug reports indicate.
> 
> I have followed standard process and I have been asking for advices how
> to do it without hardcoded any number and limiting amount of
> pre-registered uarts because adding Kconfig options for NR_UARTs was
> NACK in past too.

Yep, you clearly tried to get feedback, but our process fails sometimes.

> If you know better way how this can be done, please let us know.

Having separate tty drivers and allocating a new major number for every
serial port clearly isn't the right way at least (and especially not for
fpga uarts of which there could be plenty).

If you can't implement what you're after with the current serial-core
and tty infrastructure, those subsystems may need to be updated first.

> And if there is bug we should definitely fix it.

Yes, but not by papering over the problem. 

> > A series was apparently first posted for xilinks_uartps.c, but that one
> > has not yet been merged AFAICT.
> 
> Series have been applied by Great 2018-09-18. Feel free to check log here:

"Greg the Great" does have a nice ring to it. ;)

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/tty/serial/xilinx_uartps.c?h=v5.2-rc1

Yeah, sorry, I was obviously looking at the wrong tree this morning.

> > A similar series was later posted for
> > uartlite.c, but only the first half or so got in:
> > 
> > 	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com
> > 
> > Actually, it looks like the problems started already with:
> > 
> > 	https://lkml.kernel.org/r/1533545534-24458-1-git-send-email-shubhrajyoti.datta@gmail.com
> > 
> > So the first broken commit is
> > 
> > 	415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> > 
> > I think the offending patches should be reverted, but unfortunately they
> > may no longer revert cleanly since there were some new features (e.g.
> > runtime pm) thrown in the mix.
> 
> Similar changes have been sent for uartlite but they should use the same
> concept as I started to use for uartps.
> But based on what I see in linux-next these patches haven't been merged
> there.
> That's why I don't understand the reason for this patch.

As I mentioned above, only half of the uartlite series was merged, but
that was enough to break module unload.

> If you want to see latest state of uartlite you can find it out here.
> https://github.com/Xilinx/linux-xlnx

Thanks for the pointer.

Johan

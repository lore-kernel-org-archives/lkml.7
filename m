Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F23C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F71E2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfGLNMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:12:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfGLNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:12:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B877AD5D;
        Fri, 12 Jul 2019 13:11:59 +0000 (UTC)
Date:   Fri, 12 Jul 2019 15:11:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Vincent Whitchurch <rabinv@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190712131158.5wgy5wxjtqn6uqly@pathway.suse.cz>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
 <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
 <20190712092253.GA7922@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712092253.GA7922@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-07-12 18:22:53, Sergey Senozhatsky wrote:
> On (07/12/19 11:12), Petr Mladek wrote:
> > > For example, with the following two final prints:
> > > 
> > > [    6.427502] AAAAAAAAAAAAA
> > > [    6.427769] BBBBBBBB12345
> > > 
> > > A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> > > patch:
> > > 
> > >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
> > >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> > >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > > 
> > > After this patch:
> > > 
> > >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 35 36 36 37 38  <0>[    6.456678
> > >  00000010: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
> > >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > > 
> > > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > 
> > I think that I need vacation. I have got lost in all the checks
> > and got it wrongly in the morning.
> > 
> > This patch fixes the calculation of messages that might fit
> > into the buffer. It makes sure that the function that writes
> > the messages will really allow to write them.
> > 
> > It seems to be the correct fix.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Looks correct to me as well.
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been committed into printk.git, branch for-5.3-fixes.

I am still a bit undecided whether to send pull request the following
week or wait for 5.4. On one hand, it is very old bug (since 3.5).
On the other hand, I think that it was not reported/fixed earlier
only because it was hard to notice. And loosing the very last message
is quite pity.

Anyway, I added stable tag.

Best Regards,
Petr

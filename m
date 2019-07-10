Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B287C73C64
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7683620651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGJMKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:10:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfGJMKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:10:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCD7AAC1E;
        Wed, 10 Jul 2019 12:10:49 +0000 (UTC)
Date:   Wed, 10 Jul 2019 14:10:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
 <20190709101230.GA16909@jagdpanzerIV>
 <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
 <20190710080402.ab3f4qfnvez6dhtc@axis.com>
 <20190710081922.GA7020@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710081922.GA7020@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-07-10 17:19:22, Sergey Senozhatsky wrote:
> On (07/10/19 10:04), Vincent Whitchurch wrote:
> > > > [..]
> > > > 
> > > > > @@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
> > > > >  		}
> > > > >  
> > > > >  		if (buf) {
> > > > > -			if (prefix_len + text_len + 1 >= size - len)
> > > > > +			if (prefix_len + text_len + 1 > size - len)
> > > > >  				break;
> > > > 
> > > > So with this patch the last byte of the buffer is 0xA. It's a bit
> > > > uncomfortable that `len', which we return from msg_print_text(),
> > > > now points one byte beyond the buffer:
> > > > 
> > > > 	buf[len++] = '\n';
> > > > 	return len;
> > > > 
> > > > This is not very common. Not sure what usually happens to kmsg_dump
> > > > buffers, but anyone who'd do a rather innocent
> > > > 
> > > > 	kmsg_dump(buf, &len);
> > > > 	buf[len] = 0x00;
> > > > 
> > > > will write to something which is not a kmsg buffer (in some cases).
> 
> [..]
> 
> > arch/powerpc/xmon/xmon.c
> > 2836:	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
> > 2837-		buf[len] = '\0';
> > 
> > arch/um/kernel/kmsg_dump.c
> > 29:	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
> > 30-		line[len] = '\0';
> > 
> > I guess we should fix these first and leave this patch as is?
> 
> We certainly need to fix something here, and I'd say that we
> better handle it on the msg_print_text() side. There might be
> more kmsg_dump_get_line() users doing `buf[len] = '\0'' in the
> future.

I though more about it and I agree with Sergey. One unused byte does
not look worth the risk. Especially when we are talking about strings
where many people expect the trailing '\0'.

I would even modify msg_print_text() to always add the trailing '\0'.
All bytes will be used and it will be more error-proof API. I guess
that this is what Sergey meant by better handling it on the
msg_print_text() side.

Best Regards,
Petr

Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492CCC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259F02082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGIO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:29:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfGIO3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:29:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 351B0ACA7;
        Tue,  9 Jul 2019 14:29:40 +0000 (UTC)
Date:   Tue, 9 Jul 2019 16:29:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Vincent Whitchurch <rabinv@axis.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
 <20190709101230.GA16909@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709101230.GA16909@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-07-09 19:12:30, Sergey Senozhatsky wrote:
> On (07/09/19 10:10), Vincent Whitchurch wrote:
> > A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> > patch:
> > 
> >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
> >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > 
> > After this patch:
> > 
> >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 35 30 32  <0>[    6.427502
> >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> >  00000020: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 37 36 39  <0>[    6.427769
> >  00000030: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
> 
> [..]
> 
> > @@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
> >  		}
> >  
> >  		if (buf) {
> > -			if (prefix_len + text_len + 1 >= size - len)
> > +			if (prefix_len + text_len + 1 > size - len)
> >  				break;
> 
> So with this patch the last byte of the buffer is 0xA. It's a bit
> uncomfortable that `len', which we return from msg_print_text(),
> now points one byte beyond the buffer:
> 
> 	buf[len++] = '\n';
> 	return len;
> 
> This is not very common. Not sure what usually happens to kmsg_dump
> buffers, but anyone who'd do a rather innocent
> 
> 	kmsg_dump(buf, &len);
> 	buf[len] = 0x00;
> 
> will write to something which is not a kmsg buffer (in some cases).

I have the same worries.

On the other hand. The function does not store the trailing '\0'
into the buffer itself. The callers would need to add it themself.
It is their responsibility to avoid a buffer overflow.

I have checked several users and it seems that nobody adds or
needs the trailing '\0'.

It is ugly to do not use the entire buffer just because theoretical
buggy users. It is only one byte. But it might be more bytes if
each function in the call chain gives up one byte from the same reason.

With some fear I give it:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Anyway, if nobody vetoes the patch, I would schedule it for 5.4.
We are already in the merge window and it deserves some testing
in linux-next.

Best Regards,
Petr

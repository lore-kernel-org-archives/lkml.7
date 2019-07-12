Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEEC742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D150B21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGLJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:12:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:53848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfGLJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:12:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26689AE20;
        Fri, 12 Jul 2019 09:12:52 +0000 (UTC)
Date:   Fri, 12 Jul 2019 11:12:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Vincent Whitchurch <rabinv@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711142937.4083-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-11 16:29:37, Vincent Whitchurch wrote:
> kmsg_dump_get_buffer() is supposed to select all the youngest log
> messages which fit into the provided buffer.  It determines the correct
> start index by using msg_print_text() with a NULL buffer to calculate
> the size of each entry.  However, when performing the actual writes,
> msg_print_text() only writes the entry to the buffer if the written len
> is lesser than the size of the buffer.  So if the lengths of the
> selected youngest log messages happen to precisely fill up the provided
> buffer, the last log message is not included.
> 
> We don't want to modify msg_print_text() to fill up the buffer and start
> returning a length which is equal to the size of the buffer, since
> callers of its other users, such as kmsg_dump_get_line(), depend upon
> the current behaviour.
> 
> Instead, fix kmsg_dump_get_buffer() to compensate for this.
> 
> For example, with the following two final prints:
> 
> [    6.427502] AAAAAAAAAAAAA
> [    6.427769] BBBBBBBB12345
> 
> A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> patch:
> 
>  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
>  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
>  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 
> After this patch:
> 
>  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 35 36 36 37 38  <0>[    6.456678
>  00000010: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
>  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

I think that I need vacation. I have got lost in all the checks
and got it wrongly in the morning.

This patch fixes the calculation of messages that might fit
into the buffer. It makes sure that the function that writes
the messages will really allow to write them.

It seems to be the correct fix.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

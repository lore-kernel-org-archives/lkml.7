Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB58C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5DB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGLIJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:09:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfGLIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:09:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FD6CAF9C;
        Fri, 12 Jul 2019 08:09:06 +0000 (UTC)
Date:   Fri, 12 Jul 2019 10:09:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Vincent Whitchurch <rabinv@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190712080904.tab57k3rtyeaxs5z@pathway.suse.cz>
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
> ---
> v2: Move fix to kmsg_dump_get_buffer()
> 
>  kernel/printk/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1888f6a3b694..424abf802f02 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3274,7 +3274,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
>  	/* move first record forward until length fits into the buffer */
>  	seq = dumper->cur_seq;
>  	idx = dumper->cur_idx;
> -	while (l > size && seq < dumper->next_seq) {
> +	while (l >= size && seq < dumper->next_seq) {

This cycle searches how many messages would fit into the buffer.

The patch looks like a hack using a hole that the next cycle
does not longer check the number of really stored characters.

What would happen when msg_print_text() starts adding
the trailing '\0' as suggested by
https://lkml.kernel.org/r/20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz

I would much more appreciate if we make the code more secure instead
of stretching its weakness to the limits.

BTW: What is the motivation for this fix? Is a bug report
or just some research of possible buffer overflows?

The commit message pretends that the problem is bigger than
it really is. It is about one byte and not one line.

Best Regards,
Petr

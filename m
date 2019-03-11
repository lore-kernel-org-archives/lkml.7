Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A87C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498DE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCKMEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:04:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:04:43 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h3JfS-0003L7-Ag; Mon, 11 Mar 2019 13:04:30 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-20-john.ogness@linutronix.de>
        <20190307073029.GA489@jagdpanzerIV>
        <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
Date:   Mon, 11 Mar 2019 13:04:28 +0100
In-Reply-To: <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 8 Mar 2019 11:31:27 +0100")
Message-ID: <87k1h5zkfn.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-08, Petr Mladek <pmladek@suse.com> wrote:
>>> +static bool console_can_emergency(int level)
>>> +{
>>> +	struct console *con;
>>> +
>>> +	for_each_console(con) {
>>> +		if (!(con->flags & CON_ENABLED))
>>> +			continue;
>>> +		if (con->write_atomic && level < emergency_console_loglevel)
>>> +			return true;
>>> +		if (con->write && (con->flags & CON_BOOT))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> +static void call_emergency_console_drivers(int level, const char *text,
>>> +					   size_t text_len)
>>> +{
>>> +	struct console *con;
>>> +
>>> +	for_each_console(con) {
>>> +		if (!(con->flags & CON_ENABLED))
>>> +			continue;
>>> +		if (con->write_atomic && level < emergency_console_loglevel) {
>>> +			con->write_atomic(con, text, text_len);
>>> +			continue;
>>> +		}
>>> +		if (con->write && (con->flags & CON_BOOT)) {
>>> +			con->write(con, text, text_len);
>>> +			continue;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void printk_emergency(char *buffer, int level, u64 ts_nsec, u16 cpu,
>>> +			     char *text, u16 text_len)
>>> +{
>>> +	struct printk_log msg;
>>> +	size_t prefix_len;
>>> +
>>> +	if (!console_can_emergency(level))
>>> +		return;
>>> +
>>> +	msg.level = level;
>>> +	msg.ts_nsec = ts_nsec;
>>> +	msg.cpu = cpu;
>>> +	msg.facility = 0;
>>> +
>>> +	/* "text" must have PREFIX_MAX preceding bytes available */
>>> +
>>> +	prefix_len = print_prefix(&msg,
>>> +				  console_msg_format & MSG_FORMAT_SYSLOG,
>>> +				  printk_time, buffer);
>>> +	/* move the prefix forward to the beginning of the message text */
>>> +	text -= prefix_len;
>>> +	memmove(text, buffer, prefix_len);
>>> +	text_len += prefix_len;
>>> +
>>> +	text[text_len++] = '\n';
>>> +
>>> +	call_emergency_console_drivers(level, text, text_len);
>> 
>> So this iterates the console list and calls consoles' callbacks, but
>> what prevents console driver to be rmmod-ed under us?
>> 
>> CPU0                                  CPU1
>> 
>> printk_emergency()                    rmmod netcon
>>  call_emergency_console_drivers()
>>   con_foo->flags & CON_ENABLED == 1
>>                                       unregister_console(con_foo)
>>                                       con_foo->flags &= ~CON_ENABLED
>>                                       __exit // con_foo gone ?
>>   con_foo->write()
>> 
>> We use console_lock()/console_trylock() in order to protect the list
>> and console drivers; but this brings scheduler to the picture, with
>> all its locks.
>
> Great catch!

Yes, thanks!

> I think that it is doable to guard the list using RCU.

I think it would be enough to take the prb_cpulock when modifying the
console linked list. That will keep printk_emergency() out until the
list has been updated. (registering/unregistering consoles is not
something that happens often.)

John Ogness

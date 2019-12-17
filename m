Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C71C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D622146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLQMzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:55:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63654 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:55:01 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBHCs3Gj062399;
        Tue, 17 Dec 2019 21:54:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 17 Dec 2019 21:54:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBHCs2LC062394
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 17 Dec 2019 21:54:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+b6ZMfLCSe_x8_ME4hyKB9hz9B84LiNV8-u1SVDzqLCHA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a62a6576-940b-31a8-1d37-8b4c0828d86b@i-love.sakura.ne.jp>
Date:   Tue, 17 Dec 2019 21:54:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b6ZMfLCSe_x8_ME4hyKB9hz9B84LiNV8-u1SVDzqLCHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/17 17:41, Dmitry Vyukov wrote:
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 90655910b0c7..367b92ad598b 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -519,11 +519,14 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
>>         case UPIO_MEM32:
>>         case UPIO_MEM32BE:
>>         case UPIO_AU:
>> -               p->serial_out(p, offset, value);
>> +               /* Writing to random kernel address causes crash. */
>> +               if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
>> +                       p->serial_out(p, offset, value);
> 
> Does this do the same as LOCKDOWN_TIOCSSERIAL? How is it different?

I don't know. If there were an oversight in condition of lines 852-858,
uart_startup() might be called due to "goto check_and_exit;" without
hitting security_locked_down(LOCKDOWN_TIOCSSERIAL) check.

846:    old_flags = uport->flags;
847:    new_flags = (__force upf_t)new_info->flags;
848:    old_custom_divisor = uport->custom_divisor;
849:
850:    if (!capable(CAP_SYS_ADMIN)) {
851:            retval = -EPERM;
852:            if (change_irq || change_port ||
853:                (new_info->baud_base != uport->uartclk / 16) ||
854:                (close_delay != port->close_delay) ||
855:                (closing_wait != port->closing_wait) ||
856:                (new_info->xmit_fifo_size &&
857:                 new_info->xmit_fifo_size != uport->fifosize) ||
858:                (((new_flags ^ old_flags) & ~UPF_USR_MASK) != 0))
859:                    goto exit;
860:            uport->flags = ((uport->flags & ~UPF_USR_MASK) |
861:                           (new_flags & UPF_USR_MASK));
862:            uport->custom_divisor = new_info->custom_divisor;
863:            goto check_and_exit;
864:    }
865:
866:    retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
867:    if (retval && (change_irq || change_port))
868:            goto exit;

> 
>>                 p->serial_in(p, UART_LCR);      /* safe, no side-effects */
>>                 break;
>>         default:
>> -               p->serial_out(p, offset, value);
>> +               if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
>> +                       p->serial_out(p, offset, value);
>>         }
>>  }

But I came think that "BUG: unable to handle kernel NULL pointer dereference in
mem_serial_out" is a real kernel bug which should be fixed. It seems that crash
occurs only when "struct serial_struct"->iomem_base == NULL, and EBUSY is
returned otherwise. That is, some sanity check is wrong.


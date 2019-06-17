Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC44C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2628A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfFQMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:42:14 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:63922 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfFQMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:42:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 19A6B50E01;
        Mon, 17 Jun 2019 14:42:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id iMWmPFIHnIXO; Mon, 17 Jun 2019 14:42:02 +0200 (CEST)
Subject: Re: [PATCH 3/3 v6] tty/serial/8250: use mctrl_gpio helpers
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-serial@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190613154542.32438-1-sr@denx.de>
 <20190613154542.32438-3-sr@denx.de>
 <CAGm1_kuyt5ue_3CuvryXw8L0=z0Bti5BeQMA50yRYhFmffcJuQ@mail.gmail.com>
 <CAGm1_ksdQ5CNLGGNzHKBNKeLE3ByHvPyOkjYNoWWM+rw0q214Q@mail.gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <d62c1a2b-3e24-c109-a7fb-57190388d75f@denx.de>
Date:   Mon, 17 Jun 2019 14:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAGm1_ksdQ5CNLGGNzHKBNKeLE3ByHvPyOkjYNoWWM+rw0q214Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.19 11:51, Yegor Yefremov wrote:

<snip>

>>> @@ -1944,11 +1948,15 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>>>   {
>>>          struct uart_8250_port *up = up_to_u8250p(port);
>>>          unsigned int status;
>>> +       unsigned int val = 0;
>>>
>>>          serial8250_rpm_get(up);
>>>          status = serial8250_modem_status(up);
>>>          serial8250_rpm_put(up);
>>>
>>> +       if (up->gpios)
>>> +               return mctrl_gpio_get(up->gpios, &val);
>>> +
>>
>> What happens when you have a mixed setup i.e. CTS controlled by UART
>> but other status pins controlled by GPIO? In this case CTS status
>> won't be returned. Do I see it right?

Yes, your analysis does seem to be correct. Please note that I did
not intentionally did change it this way. I was not thinking about
such a "mixed design".
  
> What about something like this:
> 
> unsigned int serial8250_do_get_mctrl(struct uart_port *port)
>    {
>            struct uart_8250_port *up = up_to_u8250p(port);
>            unsigned int status;
>            unsigned int val;
> 
>            serial8250_rpm_get(up);
>            status = serial8250_modem_status(up);
>            serial8250_rpm_put(up);
> 
>            val = serial8250_MSR_to_TIOCM(status);
>            if (up->gpios)
>                    mctrl_gpio_get(up->gpios, &val);
> 
>            return val;
>    }

Looks good to me, thanks. Do you have such a setup with some modem
control signal handled via GPIO and some via the UART? Could you
test such a change?

Thanks,
Stefan

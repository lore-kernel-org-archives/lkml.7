Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB940C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7216920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTnpULdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfCFCEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:04:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfCFCEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TLgRSEn8Xldp3Ri8AGhTfePuzbZ9QAxJ17REEn8vp4c=; b=UTnpULdxu/T/K/CCsFcL7HUbY
        8Ff5VMfr6W3Oh9KJKRCVPYQikBy7iVOO0JTPmVr1IJFNz6rRxospnCUoWtqL3G9AjGXMn3bplUcJP
        pR+jxGIEuOWG7hUU8qo6yIxpwB882J4ZN8EOVaKq52mbGT54Xsd22xWUwYJnleyVQVrhdkmKTbYNi
        Y6pkijNOfFMz3NQ4B6GRReTAx9+wL+svjuKLmKoJK0P/M2lbFoOC1pdEc+hwj2mJwPymPaWOMAVST
        FOGDk1qfcdcWZfA6koYzUKBBTHfYVsolGMofpdvnnRm7gFpaYETA4Fe4U7sh5Tm04e0Rcp/YpB86V
        7YTXVV92Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Lv9-0005mz-5w; Wed, 06 Mar 2019 02:04:35 +0000
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
To:     cminyard@mvista.com
Cc:     minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
Date:   Tue, 5 Mar 2019 18:04:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306015149.GD4290@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:51 PM, Corey Minyard wrote:
> On Tue, Mar 05, 2019 at 03:29:51PM -0800, Randy Dunlap wrote:
>> Hi Corey,
>>
>> Just some doc comments.
> 
> Thanks a bunch.  A few comments inline on things I didn't do quite
> like you suggested..
> 
>>
>> On 3/5/19 9:12 AM, minyard@acm.org wrote:
>>> diff --git a/Documentation/serial/serialsim.rst b/Documentation/serial/serialsim.rst
>>> new file mode 100644
>>> index 000000000000..655e10b4908e
>>> --- /dev/null
>>> +++ b/Documentation/serial/serialsim.rst
>>> @@ -0,0 +1,149 @@
>>> +.. SPDX-License-Identifier: GPL-2.0+
>>> +=====================================
>>> +serialsim - A kernel serial simualtor
>>                                xxxxxxxxx
>>                         serial device simulator
>>
>>> +=====================================
>>> +
>>> +:Author: Corey Minyard <minyard@mvista.com> / <minyard@acm.org>
>>> +
>>> +The serialsim device is a serial simulator with echo and pipe devices.
>>> +It is quite useful for testing programs that use serial ports.
>>> +
>>> +This attempts to emulate a basic serial device.  It uses the baud rate
>>> +and sends the bytes through the loopback or pipe at approximately the
>>> +speed it would on a normal serial device.
>>> +
>>> +There is a python interface to the special ioctls for controlling the
>>> +remote end of the termios in addition to the standard ioctl interface
>>> +documented below.  See https://github.com/cminyard/serialsim
>>> +
>>> +=====
>>> +Using
>>> +=====
>>> +
>>> +The serialsim.ko module creates two types of devices.  Echo devices
>>> +simply echo back the data to the same device.  These devices will
>>> +appear as /dev/ttyEcho<n>.
>>> +
>>> +Pipe devices will transfer the data between two devices.  The
>>> +devices will appear as /dev/ttyPipeA<n> and /dev/ttyPipeB<n>.  And
>>
>>                                                                   Any
>>
>>> +data written to PipeA reads from PipeB, and vice-versa.
>>> +
>>> +You may create an arbitrary number of devices by setting the
>>> +nr_echo ports and nr_pipe_ports module parameters.  The default is
>>
>>    nr_echo_ports
>>
>>> +four for both.
>>
>> or for each.
>>
>>> +
>>> +This driver supports modifying the modem control lines and
>>> +injecting various serial errors.  It also supports a simulated null
>>> +modem between the two pipes, or in a loopback on the echo device.
>>> +
>>> +By default a pipe or echo comes up in null modem configuration,
>>> +meaning that the DTR line is hooked to the DSR and CD lines on the
>>> +other side and the RTS line on one side is hooked to the CTS line
>>> +on the other side.
>>> +
>>> +The RTS and CTS lines don't currently do anything for flow control.
>>> +
>>> +You can modify null modem and control the lines individually
>>> +through an interface in /sys/class/tty/ttyECHO<n>/ctrl,
>>> +/sys/class/tty/ttyPipeA<n>/ctrl, and
>>> +/sys/class/tty/ttyPipeB<n>/ctrl.  The following may be written to
>>> +those files:
>>> +
>>> +[+-]nullmodem
>>> +    enable/disable null modem
>>> +
>>> +[+-]cd
>>> +    enable/disable Carrier Detect (no effect if +nullmodem)
>>> +
>>> +[+-]dsr
>>> +    enable/disable Data Set Ready (no effect if +nullmodem)
>>> +
>>> +[+-]cts
>>> +    enable/disable Clear To Send (no effect if +nullmodem)
>>> +
>>> +[+-]ring
>>> +    enable/disable Ring
>>> +
>>> +frame
>>> +    inject a frame error on the next byte
>>> +
>>> +parity
>>> +    inject a parity error on the next byte
>>> +
>>> +overrun
>>> +    inject an overrun error on the next byte
>>> +
>>> +The contents of the above files has the following format:
>>
>>                                    have
> 
> This intrigued me a bit.  I assumed, even though "contents" can
> be plural, it is used in a singular fashion here because it is one
> "thing".  So I did some research.  I couldn't really find
> anything definitive, and there seems to be a lot of debate on
> this.  But if you look at:
> https://dictionary.cambridge.org/grammar/british-grammar/content-or-contents
> you will see, when they use "contents", they use a singular verb
> with it:
>    The contents of a book is the list of chapters or articles...
> So if it's good enough for Cambridge, it's good enough for me :).
> Though I'm certainly no grammar expert.

OK :)

>>
>>> +
>>> +tty[Echo|PipeA|PipeB]<n>
>>> +    <mctrl values>
>>> +
>>> +where <mctrl values> is the modem control values above (not frame,
>>> +parity, or overrun) with the following added:
>>> +
>>> +[+-]dtr
>>> +    value of the Data Terminal Ready
>>> +
>>> +[+-]rts
>>> +    value of the Request To Send
>>> +
>>> +The above values are not settable through this interface, they are
>>> +set through the serial port interface itself.
>>> +
>>> +So, for instance, ttyEcho0 comes up in the following state::
>>> +
>>> +   # cat /sys/class/tty/ttyEcho0/ctrl
>>> +   ttyEcho0: +nullmodem -cd -dsr -cts -ring -dtr -rts
>>> +
>>> +If something connects, it will become::
>>> +
>>> +   ttyEcho0: +nullmodem +cd +dsr +cts -ring +dtr +rts
>>> +
>>> +To enable ring::
>>> +
>>> +   # echo "+ring" >/sys/class/tty/ttyEcho0/ctrl
>>> +   # cat /sys/class/tty/ttyEcho0/ctrl
>>> +   ttyEcho0: +nullmodem +cd +dsr +cts +ring +dtr +rts
>>> +
>>> +Now disable NULL modem and the CD line::
>>> +
>>> +   # echo "-nullmodem -cd" >/sys/class/tty/ttyEcho0/ctrl
>>> +   # cat /sys/class/tty/ttyEcho0/ctrl
>>> +   ttyEcho0: -nullmodem -cd -dsr -cts +ring -dtr -rts
>>> +
>>> +Note that these settings are for the side you are modifying.  So if
>>> +you set nullmodem on ttyPipeA0, that controls whether the DTR/RTS
>>> +lines from ttyPipeB0 affect ttyPipeA0.  It doesn't affect ttyPipeB's
>>> +modem control lines.
>>> +
>>> +The PIPEA and PIPEB devices also have the ability to set these
>>> +values for the other end via an ioctl.  The following ioctls are
>>> +available:
>>> +
>>> +TIOCSERSNULLMODEM
>>> +    Set the null modem value, the arg is a boolean.
>>> +
>>> +TIOCSERSREMMCTRL
>>> +    Set the modem control lines, bits 16-31 of the arg is
>>
>>                                                           are
> 
> Same comment as above.  IMHO, it's one set of bits.
> 
>>
>>> +    a 16-bit mask telling which values to set, bits 0-15 are the
>>> +    actual values.  Settable values are TIOCM_CAR, TIOCM_CTS,
>>> +    TIOCM_DSR, and TIOC_RNG.  If NULLMODEM is set to true, then only
>>> +    TIOC_RNG is settable.  The DTR and RTS lines are not here, you can
>>> +    set them through the normal interface.
>>> +
>>> +TIOCSERSREMERR
>>> +    Send an error or errors on the next sent byte.  arg is
>>> +    a bitwise OR of (1 << TTY_xxx).  Allowed errors are TTY_BREAK,
>>
>> is this better: (or I don't understand?)
>>        a bitwise OR of (1 << TTY_xxx) and one (or more of) the
>>        allowed error flags TTY_BREAK, TTY_FRAME, TTY_PARITY, and TTY_OVERRUN.
> 
> Well, not really.  But what I wrote isn't great, so, how about:
> 
>     Send an error or errors on the next sent byte.  arg is a bitwise
>     OR of (1 << TTY_BREAK), (1 << TTY_FRAME), (1 << TTY_PARITY), and
>     (1 << TTY_OVERRUN).  If none of those are set, then no error
>     is sent.

I see.  Thanks.

> Thanks,
> 
> -corey
> 
>>
>>> +    TTY_FRAME, TTY_PARITY, and TTY_OVERRUN.
>>> +
>>> +TIOCSERGREMTERMIOS
>>> +    Return the termios structure for the other side of the pipe.
>>> +    arg is a pointer to a standard termios struct.
>>> +
>>> +TIOCSERGREMRS485
>>> +    Return the remote RS485 settings, arg is a pointer to a struct
>>> +    serial_rs485.
>>> +
>>> +Note that unlike the sysfs interface, these ioctls affect the other
>>> +end.  So setting nullmodem on the ttyPipeB0 interface sets whether
>>> +the DTR/RTS lines on ttyPipeB0 affect ttyPipeA0.
>>
>>
>> cheers.
>> -- 
>> ~Randy


-- 
~Randy

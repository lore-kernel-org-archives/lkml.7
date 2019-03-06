Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABF20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="Nyo0J13M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfCFBv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:51:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33553 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:51:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id q24so9345778otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5yTYgyJclgcmeRWtpMQ6L5dAi+mhUvbN4G6pcy/PF4U=;
        b=Nyo0J13M+WVWy44ZHSm5hSyQDRrDwDG04NQKJr5mAI0QWA9R1oeb0HZbLEPfZZ9oOr
         YJ7JQCSQs0uHjXqnyX4KIzemuI76A6Z53nxaW5tN87K6BA1DmpgeVzLu4erIek5oVSZr
         L/oOiOiz8dSCyQ9tQo6y1J5ztN9uPTMaPwGogDFPpK3TTjD1uplZWy2gQSDtENRqk/FF
         FAxPAN8eXUGyopNBcZJ11idamATjbzHqZrJ4TF3y5jJw+ieuhI/HpAYtStqK8zYO3AeN
         N6tcaKcKTtds8qOXwrszce1UxJ4ryvyzHC/xcuhEObw2JhkEmxEsC67ycbC3QfWqX4Vu
         lVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yTYgyJclgcmeRWtpMQ6L5dAi+mhUvbN4G6pcy/PF4U=;
        b=PMsNggwV80TltiDXD94PedpirMJ6uQ3xBhHie1m3gtAxYiP5+4RBcXMAbzxFgrPUNx
         JS7PWcqDgCewkTXn/4KhCJND8jqoDIJjL/tyWKl+0eYQy70+c0VJtqVy2Tolib05FzdX
         m1BPqiV3QWnDHpKDzVLIGcRolLB4HZN2WW9XWRkJqIgzbRa3OBS72iiq/dk/cHoMhdYd
         L+Evt85zGFC65bx3NXk92TQCVH+Rnb6gX4OBtdyruUOL0PfH7VYf8bFHIpaLrF7f/tx4
         nP5BkFu3vBEoHWoNGfdflxS7IMLnqGmBNj3fo+VfjnkkK+awYGGkR45XIR5ZxaTOa5hS
         IRYw==
X-Gm-Message-State: APjAAAWO6sGxoxKjsdIi6ytWJFj2t7CUziAjikcokKnTvacpEJ281mtU
        sNR9VsVp8a4x+xnglvAzK49evw==
X-Google-Smtp-Source: APXvYqzSSYSKW7aKhPUqzZUS1xSMRkLxhwptAmiZVUqYpnQJ+6uYDHlIKl22zLnPahdVkzwjNaLTTA==
X-Received: by 2002:a9d:4685:: with SMTP id z5mr2846337ote.251.1551837112265;
        Tue, 05 Mar 2019 17:51:52 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:6936:2464:9c6e:d444])
        by smtp.gmail.com with ESMTPSA id a15sm129443otq.35.2019.03.05.17.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 17:51:51 -0800 (PST)
Date:   Tue, 5 Mar 2019 19:51:49 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Message-ID: <20190306015149.GD4290@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:29:51PM -0800, Randy Dunlap wrote:
> Hi Corey,
> 
> Just some doc comments.

Thanks a bunch.  A few comments inline on things I didn't do quite
like you suggested..

> 
> On 3/5/19 9:12 AM, minyard@acm.org wrote:
> > diff --git a/Documentation/serial/serialsim.rst b/Documentation/serial/serialsim.rst
> > new file mode 100644
> > index 000000000000..655e10b4908e
> > --- /dev/null
> > +++ b/Documentation/serial/serialsim.rst
> > @@ -0,0 +1,149 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +=====================================
> > +serialsim - A kernel serial simualtor
>                                xxxxxxxxx
>                         serial device simulator
> 
> > +=====================================
> > +
> > +:Author: Corey Minyard <minyard@mvista.com> / <minyard@acm.org>
> > +
> > +The serialsim device is a serial simulator with echo and pipe devices.
> > +It is quite useful for testing programs that use serial ports.
> > +
> > +This attempts to emulate a basic serial device.  It uses the baud rate
> > +and sends the bytes through the loopback or pipe at approximately the
> > +speed it would on a normal serial device.
> > +
> > +There is a python interface to the special ioctls for controlling the
> > +remote end of the termios in addition to the standard ioctl interface
> > +documented below.  See https://github.com/cminyard/serialsim
> > +
> > +=====
> > +Using
> > +=====
> > +
> > +The serialsim.ko module creates two types of devices.  Echo devices
> > +simply echo back the data to the same device.  These devices will
> > +appear as /dev/ttyEcho<n>.
> > +
> > +Pipe devices will transfer the data between two devices.  The
> > +devices will appear as /dev/ttyPipeA<n> and /dev/ttyPipeB<n>.  And
> 
>                                                                   Any
> 
> > +data written to PipeA reads from PipeB, and vice-versa.
> > +
> > +You may create an arbitrary number of devices by setting the
> > +nr_echo ports and nr_pipe_ports module parameters.  The default is
> 
>    nr_echo_ports
> 
> > +four for both.
> 
> or for each.
> 
> > +
> > +This driver supports modifying the modem control lines and
> > +injecting various serial errors.  It also supports a simulated null
> > +modem between the two pipes, or in a loopback on the echo device.
> > +
> > +By default a pipe or echo comes up in null modem configuration,
> > +meaning that the DTR line is hooked to the DSR and CD lines on the
> > +other side and the RTS line on one side is hooked to the CTS line
> > +on the other side.
> > +
> > +The RTS and CTS lines don't currently do anything for flow control.
> > +
> > +You can modify null modem and control the lines individually
> > +through an interface in /sys/class/tty/ttyECHO<n>/ctrl,
> > +/sys/class/tty/ttyPipeA<n>/ctrl, and
> > +/sys/class/tty/ttyPipeB<n>/ctrl.  The following may be written to
> > +those files:
> > +
> > +[+-]nullmodem
> > +    enable/disable null modem
> > +
> > +[+-]cd
> > +    enable/disable Carrier Detect (no effect if +nullmodem)
> > +
> > +[+-]dsr
> > +    enable/disable Data Set Ready (no effect if +nullmodem)
> > +
> > +[+-]cts
> > +    enable/disable Clear To Send (no effect if +nullmodem)
> > +
> > +[+-]ring
> > +    enable/disable Ring
> > +
> > +frame
> > +    inject a frame error on the next byte
> > +
> > +parity
> > +    inject a parity error on the next byte
> > +
> > +overrun
> > +    inject an overrun error on the next byte
> > +
> > +The contents of the above files has the following format:
> 
>                                    have

This intrigued me a bit.  I assumed, even though "contents" can
be plural, it is used in a singular fashion here because it is one
"thing".  So I did some research.  I couldn't really find
anything definitive, and there seems to be a lot of debate on
this.  But if you look at:
https://dictionary.cambridge.org/grammar/british-grammar/content-or-contents
you will see, when they use "contents", they use a singular verb
with it:
   The contents of a book is the list of chapters or articles...
So if it's good enough for Cambridge, it's good enough for me :).
Though I'm certainly no grammar expert.

> 
> > +
> > +tty[Echo|PipeA|PipeB]<n>
> > +    <mctrl values>
> > +
> > +where <mctrl values> is the modem control values above (not frame,
> > +parity, or overrun) with the following added:
> > +
> > +[+-]dtr
> > +    value of the Data Terminal Ready
> > +
> > +[+-]rts
> > +    value of the Request To Send
> > +
> > +The above values are not settable through this interface, they are
> > +set through the serial port interface itself.
> > +
> > +So, for instance, ttyEcho0 comes up in the following state::
> > +
> > +   # cat /sys/class/tty/ttyEcho0/ctrl
> > +   ttyEcho0: +nullmodem -cd -dsr -cts -ring -dtr -rts
> > +
> > +If something connects, it will become::
> > +
> > +   ttyEcho0: +nullmodem +cd +dsr +cts -ring +dtr +rts
> > +
> > +To enable ring::
> > +
> > +   # echo "+ring" >/sys/class/tty/ttyEcho0/ctrl
> > +   # cat /sys/class/tty/ttyEcho0/ctrl
> > +   ttyEcho0: +nullmodem +cd +dsr +cts +ring +dtr +rts
> > +
> > +Now disable NULL modem and the CD line::
> > +
> > +   # echo "-nullmodem -cd" >/sys/class/tty/ttyEcho0/ctrl
> > +   # cat /sys/class/tty/ttyEcho0/ctrl
> > +   ttyEcho0: -nullmodem -cd -dsr -cts +ring -dtr -rts
> > +
> > +Note that these settings are for the side you are modifying.  So if
> > +you set nullmodem on ttyPipeA0, that controls whether the DTR/RTS
> > +lines from ttyPipeB0 affect ttyPipeA0.  It doesn't affect ttyPipeB's
> > +modem control lines.
> > +
> > +The PIPEA and PIPEB devices also have the ability to set these
> > +values for the other end via an ioctl.  The following ioctls are
> > +available:
> > +
> > +TIOCSERSNULLMODEM
> > +    Set the null modem value, the arg is a boolean.
> > +
> > +TIOCSERSREMMCTRL
> > +    Set the modem control lines, bits 16-31 of the arg is
> 
>                                                           are

Same comment as above.  IMHO, it's one set of bits.

> 
> > +    a 16-bit mask telling which values to set, bits 0-15 are the
> > +    actual values.  Settable values are TIOCM_CAR, TIOCM_CTS,
> > +    TIOCM_DSR, and TIOC_RNG.  If NULLMODEM is set to true, then only
> > +    TIOC_RNG is settable.  The DTR and RTS lines are not here, you can
> > +    set them through the normal interface.
> > +
> > +TIOCSERSREMERR
> > +    Send an error or errors on the next sent byte.  arg is
> > +    a bitwise OR of (1 << TTY_xxx).  Allowed errors are TTY_BREAK,
> 
> is this better: (or I don't understand?)
>        a bitwise OR of (1 << TTY_xxx) and one (or more of) the
>        allowed error flags TTY_BREAK, TTY_FRAME, TTY_PARITY, and TTY_OVERRUN.

Well, not really.  But what I wrote isn't great, so, how about:

    Send an error or errors on the next sent byte.  arg is a bitwise
    OR of (1 << TTY_BREAK), (1 << TTY_FRAME), (1 << TTY_PARITY), and
    (1 << TTY_OVERRUN).  If none of those are set, then no error
    is sent.

Thanks,

-corey

> 
> > +    TTY_FRAME, TTY_PARITY, and TTY_OVERRUN.
> > +
> > +TIOCSERGREMTERMIOS
> > +    Return the termios structure for the other side of the pipe.
> > +    arg is a pointer to a standard termios struct.
> > +
> > +TIOCSERGREMRS485
> > +    Return the remote RS485 settings, arg is a pointer to a struct
> > +    serial_rs485.
> > +
> > +Note that unlike the sysfs interface, these ioctls affect the other
> > +end.  So setting nullmodem on the ttyPipeB0 interface sets whether
> > +the DTR/RTS lines on ttyPipeB0 affect ttyPipeA0.
> 
> 
> cheers.
> -- 
> ~Randy

Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D6C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7722081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578338921;
	bh=p4krI4mmLRWy5J5wdNZktPxatQppDV8qfZJMEorKCIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v2ir5LawryaFIAmKeY1Da/hk51t5ZxKSYrAuHnbyysRnzAaCm32eQ5pmiikAdJBA/
	 wuh9l5fywMc+zenqM23hdofbNJ0zfcfJMKI6DlWcYAcolERJgL8/N/GAVYg89Cnhwz
	 uB1rJskHJp5XYI01r2rS64qfWMXWnYnOcBoYBB4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFT2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFT2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:28:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8413207FD;
        Mon,  6 Jan 2020 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578338920;
        bh=p4krI4mmLRWy5J5wdNZktPxatQppDV8qfZJMEorKCIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PM9VHRKeoZjq03p1VVgIrczZn8wLSV8JCK+Ui8E786repZRgbzHkin0vK5TcbxZt
         oi2qY1g1x+fbU2bykg7myjCW72cGXZffrpAJSH1lMYQo5nRHLMjgKT57xHxT3lY3W+
         KfJJbuPIrBZvKAAvXtTy6DfobC8HvmVfKl0+ny8A=
Date:   Mon, 6 Jan 2020 20:28:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Add virtual serial null modem emulation driver
Message-ID: <20200106192838.GA754821@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:51:52PM +0530, Rishi Gupta wrote:
> The driver named ttyvs creates virtual tty/serial device which emulates
> behaviour of a real serial port device. Serial port events like parity,
> frame, overflow errors, ring indications, break assertions, flow controls
> are also emulated.

Emulated in what way?

> It supports both device-tree and non device-tree platforms. And works in
> both built-in and loadable driver methods.
> 
> Use cases
> ~~~~~~~~~~~~~~~~~
> This driver saves time to market and have following use cases including
> but not limited to; automated testing, GPS and other data simulation, data
> injection for corner case testing, scaleability testing, data sniffing,
> robotics emulator/simulator, application development when hardware,
> firmware and driver is still not available, identifying hardware issues
> from software bugs quickly during development, development cost reduction
> across team, product demo where data from hardware needs to be sent to the
> GUI application, data forwarding, serial port redirection etc.
> 
> Basic idea
> ~~~~~~~~~~~~~~~~~
> 
> This driver implements a virtual multi-port serial card in such a
> way that the virtual card can have 0 to N number of virtual serial
> ports (tty devices). The devices created in this card are used in
> exactly the same way as the real tty devices using standard termios
> and Linux/Posix APIs.
>  
>      /dev/ttyvs_card
>    +~~~~~~~~~~~~~~~~~~~~~+
>    |   +-------------+   |
>    |   | /dev/ttyvs0 |   |
>    |   +-------------+   |
>    |   .                 |
>    |   .                 |
>    |   +-------------+   |
>    |   | /dev/ttyvsN |   |
>    |   +-------------+   |
>    +~~~~~~~~~~~~~~~~~~~~~+
> 
> Creating devices
> ~~~~~~~~~~~~~~~~~
> 
> Devices can be created/deleted by writing to /dev/ttyvs_card node.
> 
> # Create a loop back device using given number (for ex; ttyvs8):
> echo "genlb#00008#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card

That's a crazy api, why not just use configfs so you do not have to
parse long strings in the kernel?  That is exactly what configfs was
created for.

And you are just creating a "fake" tty device, how is that going to be
used to test anything?  There's no hardware attached to it, are you just
talking about testing userspace programs?


> 
> # Create a null modem pair using given numbers (for ex; ttyvs5/6):
> echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card
> 
> # Create null modem pair using next free number (index)
> echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card
> 
> # Create loopback devices using next free number (index)
> echo "genlb#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card
> 
> Devices can also be created through DT. This patch describes this in detail:
> [PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
> 
> Deleting devices
> ~~~~~~~~~~~~~~~~~
> 
> Devices can be deleted by writing pre-formatted string only. Driver
> returns negative error code if invalid, out of range values or
> syntactically invalid values are supplied.
> 
> # To delete all devices in one shot write 'xxxxx' as shown below:
> echo "del#xxxxx#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card

Again, please use configfs.

And document this all somewhere really really really good, in the kernel
tree.


> 
> # To delete a device by number specify its number for ex; to delete 5th device:
> echo "del#00005#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card
> 
> Device tree bindings
> ~~~~~~~~~~~~~~~~~~~~
> 
> Devices can also be created and configured through DT. Following patch
> describes how to do it in detail.
> [PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
> 
> Module parameters
> ~~~~~~~~~~~~~~~~~
> 
> The ttyvs driver can be passd 3 optional parameters.
> 
> max_num_vs_devs: specifies how may virtyal tty devices this driver should
> support. By default driver supports upto 64 devices. This can also be
> specified through DT property.
> 
> init_num_nm_pairs: specifies how many standard type null modem pairs should
> be created when driver is loaded. If this parameter is used and devices are
> also created through DT, then all of these devices will be deleted. DT is
> given more preference in all cases.
> 
> init_num_lb_devs: specifies how many standard type loop-back devices should
> be created when driver is loaded. If this parameter is used and devices are
> also created through DT, then all of these devices will be deleted. DT is
> given more preference in all cases.

Please no new module parameters, this is not the 1990's. :)

> Udev rules example
> ~~~~~~~~~~~~~~~~~~
> 
> # Set permissions on card node to manage devices
> ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"
> 
> # Set permissions of sysfs files for event emulation
> ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*", MODE="0666",\
> RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"

If you really want those permissions on your sysfs files, then set them
to those values in your kernel code.

But I really doubt you want those permissions on them, that's really
wide open.

> Emulating events
> ~~~~~~~~~~~~~~~~~
> 
> Event emulation is through per-device sysfs file.
> 
> 1. Emulate framing error (insert TTY_FRAME in data buffer):
> $ echo "1" > /sys/devices/virtual/tty/ttyvsN/event
> 
> 2. Emulate parity error (insert TTY_PARITY in data buffer):
> $ echo "2" > /sys/devices/virtual/tty/ttyvsN/event
> 
> 3. Emulate overrun error (insert TTY_OVERRUN in data buffer):
> $ echo "3" > /sys/devices/virtual/tty/ttyvsN/event
> 
> 4. Emulate ring indicator (set RI signal):
> $ echo "4" > /sys/devices/virtual/tty/ttyvsN/event
> 
> 5. Emulate ring indicator (unset RI signal):
> $ echo "5" > /sys/devices/virtual/tty/ttyvsN/event
> 
> 6. Emulate break received (insert TTY_BREAK in data buffer):
> $ echo "6" > /sys/devices/virtual/tty/ttyvsN/event

We can handle strings, right?  Why all of the numbers?

> 7. Emulate cable is faulty (data sent is not received):
> $ echo "1" > /sys/devices/virtual/tty/ttyvsN/faultycable
> 
> 8. Emulate cable is not faulty (default):
> $ echo "0" > /sys/devices/virtual/tty/ttyvsN/faultycable

Why is this a separate sysfs file?

This all feels really odd, what is this going to be used for?

greg k-h

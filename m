Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F212067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suJJ3YZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgAIJWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:22:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46136 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgAIJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:22:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so5253996qtr.13;
        Thu, 09 Jan 2020 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcED/XVvzmSCTwwxZ8VHAe4+Pngzr4NFvd91pgY7Z0Y=;
        b=suJJ3YZVYA+VJVwKEMTEl56H4ZkU1R97BxdXLFRiHdwWygt5Yvn/cvcpXRg43owU8g
         GNTRD+yD0qad2Gn/rNdC1xJ5WFul+Zc6eFyjfzfoI0ELy9x+7u/MBWMlxqq38gClvO/+
         macRHad3/2BoitSV5WEQOOWiCYWjfxwttuvwhjysGrW39TcvLbPntmI2RhA//+Efpu1t
         odYRd8wRusZOfFl01soKjA3XHZaZnuN3pGwfVbyAqy1VwlFRUK8Qn12sIArsk67StW3p
         hlbtDRfTRPaEHuXwas5OOAK/RjlGQlmbXr60cu+Vp83hK2UdGBsUUBkgL3JMIoAw1phm
         TtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcED/XVvzmSCTwwxZ8VHAe4+Pngzr4NFvd91pgY7Z0Y=;
        b=EIttZB2qKNIEO4JpeA2u59fG08B11OSBlVcVWaUrS48cjqwAsiDNOlMLueFvtEHNNW
         PfTDs8ZZte0s9K2fabWbi79Oze3olqC/NNaILledCnU5W09SKTaUiLlIYTRv8NCx9kFG
         HwzcZP0GPFNroPGVHebdWUGkrOoD6qlYdt/0tGuHmDcF67emRsbF6tsC6Lw8oPnjgZyV
         ad/OrP/gHsR/trJwVN4W6yhA0s9SuHg8zTjZ/PxNaljLzc2RkuR29alOER/yySVRLUYy
         Uyx6pbrXdBWM/3u01sba9A5ac9zV+GiB26leXdm/rKtAcOIjQ7WckfOVDcBWokqSVhqF
         jNGg==
X-Gm-Message-State: APjAAAUHQ+lXJexTDI8aa3XTrc4oJYKB3WiO3LJLtP4T5S61syNzaEp2
        3aEJQ7qkM8DQudMVHN0elt/hUrZgdHOgYiv5rrQ=
X-Google-Smtp-Source: APXvYqzWxnE7hcdhZF7Hdh+4088bkzZUUCXd+oANDa7T91zlamXzfETxQRL2VKMk5H+2ng764SOhzc/U7v5Qg0D5jgg=
X-Received: by 2002:aed:3044:: with SMTP id 62mr7205455qte.61.1578561735122;
 Thu, 09 Jan 2020 01:22:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578235515.git.gupt21@gmail.com> <20200106192838.GA754821@kroah.com>
In-Reply-To: <20200106192838.GA754821@kroah.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 9 Jan 2020 14:52:04 +0530
Message-ID: <CALUj-gvEhSyBFrsBCZKkn-GqZtDp32ELc73a7n08krvwW4esjA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add virtual serial null modem emulation driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg for the review, please find my replies inline.

On Tue, Jan 7, 2020 at 12:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 06, 2020 at 12:51:52PM +0530, Rishi Gupta wrote:
> > The driver named ttyvs creates virtual tty/serial device which emulates
> > behaviour of a real serial port device. Serial port events like parity,
> > frame, overflow errors, ring indications, break assertions, flow controls
> > are also emulated.
>
> Emulated in what way?
It emulates as if the data is from real hardware. For ex; suppose a
GPS receiver sends through UART interface.
GUI application simply opens /dev/ttyUSB0 and gets the MNEA strings.
Through this driver we can create pair /dev/ttyvs0<--/dev/ttyvs1 where
test app will write fake
data to /de/vttyvs0 while the GUI app (under testing) will receive it.
This way dependency on
the hardware can be removed to certain extent.
Furthermore, suppose the GPS receiver uses 8N1 with even parity. UART
driver on host
reads a register and finds that parity error has happened. To emulate
this we expose a
sysfs node to user space. Test script can write '1' to this and driver
will insert TTY-PARITY
in the tty buffer.
>
> > It supports both device-tree and non device-tree platforms. And works in
> > both built-in and loadable driver methods.
> >
> > Use cases
> > ~~~~~~~~~~~~~~~~~
> > This driver saves time to market and have following use cases including
> > but not limited to; automated testing, GPS and other data simulation, data
> > injection for corner case testing, scaleability testing, data sniffing,
> > robotics emulator/simulator, application development when hardware,
> > firmware and driver is still not available, identifying hardware issues
> > from software bugs quickly during development, development cost reduction
> > across team, product demo where data from hardware needs to be sent to the
> > GUI application, data forwarding, serial port redirection etc.
> >
> > Basic idea
> > ~~~~~~~~~~~~~~~~~
> >
> > This driver implements a virtual multi-port serial card in such a
> > way that the virtual card can have 0 to N number of virtual serial
> > ports (tty devices). The devices created in this card are used in
> > exactly the same way as the real tty devices using standard termios
> > and Linux/Posix APIs.
> >
> >      /dev/ttyvs_card
> >    +~~~~~~~~~~~~~~~~~~~~~+
> >    |   +-------------+   |
> >    |   | /dev/ttyvs0 |   |
> >    |   +-------------+   |
> >    |   .                 |
> >    |   .                 |
> >    |   +-------------+   |
> >    |   | /dev/ttyvsN |   |
> >    |   +-------------+   |
> >    +~~~~~~~~~~~~~~~~~~~~~+
> >
> > Creating devices
> > ~~~~~~~~~~~~~~~~~
> >
> > Devices can be created/deleted by writing to /dev/ttyvs_card node.
> >
> > # Create a loop back device using given number (for ex; ttyvs8):
> > echo "genlb#00008#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card
>
> That's a crazy api, why not just use configfs so you do not have to
> parse long strings in the kernel?  That is exactly what configfs was
> created for.
I have updated the driver to use configfs and tested. Thanks for the guidance.
>
> And you are just creating a "fake" tty device, how is that going to be
> used to test anything?  There's no hardware attached to it, are you just
> talking about testing userspace programs?
Yes, testing user space programs. There are other use cases as well.
IoT Smart nursery project: decoupling App, middleware and board
Board gets data from 5 sensors. It sends this data to Host PC (GUI
app) thorough RS-232 serial port.
Same board now located at a remote site will collect data and send to
server through internet.
The middleware running on server will receive and write it to /dev/ttyvs0.
GUI app will open /de/vttyvs1 and gets this data. This way GUI app can
work seamlessly
in both local and remote setup. Similarly, dependency on board is also removed.
>
>
> >
> > # Create a null modem pair using given numbers (for ex; ttyvs5/6):
> > echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card
> >
> > # Create null modem pair using next free number (index)
> > echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card
> >
> > # Create loopback devices using next free number (index)
> > echo "genlb#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card
> >
> > Devices can also be created through DT. This patch describes this in detail:
> > [PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
> >
> > Deleting devices
> > ~~~~~~~~~~~~~~~~~
> >
> > Devices can be deleted by writing pre-formatted string only. Driver
> > returns negative error code if invalid, out of range values or
> > syntactically invalid values are supplied.
> >
> > # To delete all devices in one shot write 'xxxxx' as shown below:
> > echo "del#xxxxx#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card
>
> Again, please use configfs.
Done.
>
> And document this all somewhere really really really good, in the kernel
> tree.
>
>
> >
> > # To delete a device by number specify its number for ex; to delete 5th device:
> > echo "del#00005#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card
> >
> > Device tree bindings
> > ~~~~~~~~~~~~~~~~~~~~
> >
> > Devices can also be created and configured through DT. Following patch
> > describes how to do it in detail.
> > [PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
> >
> > Module parameters
> > ~~~~~~~~~~~~~~~~~
> >
> > The ttyvs driver can be passd 3 optional parameters.
> >
> > max_num_vs_devs: specifies how may virtyal tty devices this driver should
> > support. By default driver supports upto 64 devices. This can also be
> > specified through DT property.
> >
> > init_num_nm_pairs: specifies how many standard type null modem pairs should
> > be created when driver is loaded. If this parameter is used and devices are
> > also created through DT, then all of these devices will be deleted. DT is
> > given more preference in all cases.
> >
> > init_num_lb_devs: specifies how many standard type loop-back devices should
> > be created when driver is loaded. If this parameter is used and devices are
> > also created through DT, then all of these devices will be deleted. DT is
> > given more preference in all cases.
>
> Please no new module parameters, this is not the 1990's. :)
I need to learn something here. Do you mean we should avoid add
parameters completely.
Or if possible we should avoid in general. However, if there is a
reason we can use parameters.

I am removing them anyway as configfs view will go out of sync.
>
> > Udev rules example
> > ~~~~~~~~~~~~~~~~~~
> >
> > # Set permissions on card node to manage devices
> > ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"
> >
> > # Set permissions of sysfs files for event emulation
> > ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*", MODE="0666",\
> > RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"
>
> If you really want those permissions on your sysfs files, then set them
> to those values in your kernel code.
This is just an example. It completely depends upon end user to write udev rule.
>
> But I really doubt you want those permissions on them, that's really
> wide open.
>
> > Emulating events
> > ~~~~~~~~~~~~~~~~~
> >
> > Event emulation is through per-device sysfs file.
> >
> > 1. Emulate framing error (insert TTY_FRAME in data buffer):
> > $ echo "1" > /sys/devices/virtual/tty/ttyvsN/event
> >
> > 2. Emulate parity error (insert TTY_PARITY in data buffer):
> > $ echo "2" > /sys/devices/virtual/tty/ttyvsN/event
> >
> > 3. Emulate overrun error (insert TTY_OVERRUN in data buffer):
> > $ echo "3" > /sys/devices/virtual/tty/ttyvsN/event
> >
> > 4. Emulate ring indicator (set RI signal):
> > $ echo "4" > /sys/devices/virtual/tty/ttyvsN/event
> >
> > 5. Emulate ring indicator (unset RI signal):
> > $ echo "5" > /sys/devices/virtual/tty/ttyvsN/event
> >
> > 6. Emulate break received (insert TTY_BREAK in data buffer):
> > $ echo "6" > /sys/devices/virtual/tty/ttyvsN/event
>
> We can handle strings, right?  Why all of the numbers?
Using numbers allowed me to write a switch case statement to handle
all possible values. Should I replace them with string to make
more user friendly.
>
> > 7. Emulate cable is faulty (data sent is not received):
> > $ echo "1" > /sys/devices/virtual/tty/ttyvsN/faultycable
> >
> > 8. Emulate cable is not faulty (default):
> > $ echo "0" > /sys/devices/virtual/tty/ttyvsN/faultycable
>
> Why is this a separate sysfs file?
Okay, I will merge with event file itself.
>
> This all feels really odd, what is this going to be used for?
Let me give an example of faulty cable itself. We were testing a fleet
tracker. During
field testing a cable become loose and we lost some of the data.
Because there was
no logic written to handle this corner case, middleware could not detect this.
>
> greg k-h

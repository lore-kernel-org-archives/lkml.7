Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9EC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E02073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfHCPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:16:01 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:33818 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHCPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:16:00 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1htvlE-0002YB-QL; Sat, 03 Aug 2019 17:15:56 +0200
Date:   Sat, 3 Aug 2019 17:15:56 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Message-ID: <20190803151556.GA9187@angband.pl>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
 <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
 <20190803132323.GB6703@angband.pl>
 <20190803135537.GA1743@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190803135537.GA1743@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 03:55:37PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 03, 2019 at 03:23:23PM +0200, Adam Borowski wrote:
> > On Fri, Aug 02, 2019 at 09:59:06PM +0200, Paul Menzel wrote:
> > > Because the cable is always connected to the port on the back side, and
> > > sometimes the port in the front has ID 0, and the one in the back 1, and
> > > other times vice versa. We do not want to track that, and it would be
> > > convenient to just write to both ports.
> > 
> > Sounds like an XY problem then: what you want is not writing to all ports,
> > but to have the port assignments stable (see also: disk device reordering).
> 
> You can get that information from the symlinks in /dev/serial/ which
> udev creates.

Doesn't seem to work for me, for any ttyS0 ttyS1 ttySAC1 device:

Box one, PCIe card + one USB dongle:
07:00.0 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller
07:00.1 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller
Bus 003 Device 004: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter

/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
/dev/serial/by-path/pci-0000:0b:00.3-usb-0:4:1.0-port0

Only ttyUSB0 is there.


Box two, on-board + one USB dongle:
[    3.404340] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.431287] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Bus 001 Device 002: ID 10c4:ea60 Cygnal Integrated Products, Inc. CP2102/CP2109 UART Bridge Controller [CP210x family]

/dev/serial/by-id/usb-Silicon_Labs_CP2104_USB_to_UART_Bridge_Controller_00DB1604-if00-port0
/dev/serial/by-path/pci-0000:00:14.0-usb-0:1:1.0-port0


Box three: RockPro64, euler + USB dongle, kernel 4.4.
Box four: Pine64, euler.
Box five: Odroid-U2, something GPIOish (ttySAC1), kernel 5.0.


Most are running kernel 5.2, Debian unstable.

And indeed, in /lib/udev/rules.d/60-serial.rules :
# /dev/serial/by-path/, /dev/serial/by-id/ for USB devices
KERNEL!="ttyUSB[0-9]*|ttyACM[0-9]*", GOTO="serial_end"


Like me, Paul is using ttyS0 for server-side.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 10 people enter a bar: 1 who understands binary,
⢿⡄⠘⠷⠚⠋⠀ 1 who doesn't, D who prefer to write it as hex,
⠈⠳⣄⠀⠀⠀⠀ and 1 who narrowly avoided an off-by-one error.

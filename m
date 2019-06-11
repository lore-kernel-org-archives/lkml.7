Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43222C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2574B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406072AbfFKR1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:27:07 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:43676 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405718AbfFKR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:27:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 3F9B13FA1F;
        Tue, 11 Jun 2019 19:26:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gYRQZqnvAFS5; Tue, 11 Jun 2019 19:26:57 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 579773F8E0;
        Tue, 11 Jun 2019 19:26:56 +0200 (CEST)
Date:   Tue, 11 Jun 2019 19:26:54 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190611172654.GA2602@sx9>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611133223.GA30054@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> > This patch results in usb access failures when trying to boot from the
> > sm501-usb controller on sh4 with qemu.
> > 
> > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
> > print_req_error: I/O error, dev sda, sector 2172 flags 80700
> > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
> > print_req_error: I/O error, dev sda, sector 474 flags 84700
> > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
> > print_req_error: I/O error, dev sda, sector 730 flags 84700
> > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
> > print_req_error: I/O error, dev sda, sector 2896 flags 84700
> > 
> > Qemu command line is:
> > 
> > The qemu command line is:
> > 
> > qemu-system-sh4 -M r2d \
> >         -kernel ./arch/sh/boot/zImage \
> > 	-snapshot \
> > 	-usb -device usb-storage,drive=d0 \
> > 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> > 	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
> > 	-serial null -serial stdio \
> > 	-net nic,model=rtl8139 -net user -nographic -monitor null
> > 
> > Reverting this patch as well as "USB: drop HCD_LOCAL_MEM flag" fixes the
> > problem. Reverting "USB: drop HCD_LOCAL_MEM flag" alone does not help.
> > 
> 
> This problem is still seen in next-20190611.
> Has anyone actually tested this code ?

I tested patches 1, 2 and 5 with v5.0.19. Perhaps yet another part of the
OHCI subsystem allocates memory from the wrong pool? With some luck it is
relatively easy to trace backwards from the error messages to the point
where the memory is being allocated. One way to establish this is to
sprinkle printk around if-statements. There may be 10-20 levels of calls
including one or two indirect calls via pointers. Would you be able to do
that?

Fredrik

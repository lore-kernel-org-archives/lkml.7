Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3621871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA9NWr5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbfFKTDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33398 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405041AbfFKTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so5530879plq.0;
        Tue, 11 Jun 2019 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+QbRljIgJwWBCzWz9e7i8YONsVM1yUd4G7aQc2LYOeY=;
        b=KA9NWr5iz/A4jsEJ5AhARMgh4T+UpkqjqJScqAcDG8v7nBlWcBgURc6KT+/PgUSCnZ
         M2a6GpogN88X5FwqHoYdH/ayMg2/+yQxwR+MRIPai5lz8UNvM1Y/BZGKN/tLk9H9e8OX
         YUhgcFrLj1rraz7ESB6QInR7wgqKpLFp/kThW4h70qzOIV3tQk4PTXQuPmR71/ZB1IrV
         06ZymkBmp2BF49v1bzsA7TsmnF/1rriUiO8GUAzIeCO2guljtlJ0VpLyiX33aSxPGaZX
         AvD9Ee3LWAVYHx7bwyHIsBazojz5xrlBLd8htP6r5OuvQBh97wSr3WoHAvUsZ0zzkCbT
         mw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+QbRljIgJwWBCzWz9e7i8YONsVM1yUd4G7aQc2LYOeY=;
        b=qYB39Mx7x+pQrB5sihDrsdfpUpBgkgAWSldyUbLW40FxJtq6ghAnQ5vjM9ld6q4J5M
         7P2px2BTTdN2nXIxjxTfu0hWWZEeoSmT6dxaUYOOA+wM51AtRlQaJQ8PpGpJM8IbZh+h
         d7Ky9NcZxov+9IARgW++VBitCpEnL8azwrzAjuWCjkKuoIiINfjeLB7GonjvzTuROn8m
         GXVrXnfLJ5hybuUK1MBSRspP1+bPn0umgY6xR6KG8Z7oRLI3wGOG1dvTyPXZmauJ47Z2
         QFo2gj2d1R25qGJLq6tG178ZbWtvgFAzUeoJp9y49Z1tnz2OL2pDQHNxCrxW4mxp02xN
         S1bw==
X-Gm-Message-State: APjAAAU8gHbnPYcrjOpXkosqUur941nBLXNRWudKISoAIbYIyVtwW5P5
        YlreT3CJE4JdWtrEk3pPbo4=
X-Google-Smtp-Source: APXvYqxh+O8fngACzCZvf/EiUwldMGLtMTvUx+/ODjcXz0khddZweOpl0aIOTJZal4YiWoFsmIKA3A==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr71539969ply.12.1560279826423;
        Tue, 11 Jun 2019 12:03:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j14sm16520690pfe.10.2019.06.11.12.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:03:44 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:03:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190611190343.GA18459@roeck-us.net>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611172654.GA2602@sx9>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:26:54PM +0200, Fredrik Noring wrote:
> Hi Guenter,
> 
> > > This patch results in usb access failures when trying to boot from the
> > > sm501-usb controller on sh4 with qemu.
> > > 
> > > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
> > > print_req_error: I/O error, dev sda, sector 2172 flags 80700
> > > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
> > > print_req_error: I/O error, dev sda, sector 474 flags 84700
> > > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
> > > print_req_error: I/O error, dev sda, sector 730 flags 84700
> > > usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> > > sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> > > sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
> > > print_req_error: I/O error, dev sda, sector 2896 flags 84700
> > > 
> > > Qemu command line is:
> > > 
> > > The qemu command line is:
> > > 
> > > qemu-system-sh4 -M r2d \
> > >         -kernel ./arch/sh/boot/zImage \
> > > 	-snapshot \
> > > 	-usb -device usb-storage,drive=d0 \
> > > 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> > > 	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
> > > 	-serial null -serial stdio \
> > > 	-net nic,model=rtl8139 -net user -nographic -monitor null
> > > 
> > > Reverting this patch as well as "USB: drop HCD_LOCAL_MEM flag" fixes the
> > > problem. Reverting "USB: drop HCD_LOCAL_MEM flag" alone does not help.
> > > 
> > 
> > This problem is still seen in next-20190611.
> > Has anyone actually tested this code ?
> 
> I tested patches 1, 2 and 5 with v5.0.19. Perhaps yet another part of the
> OHCI subsystem allocates memory from the wrong pool? With some luck it is
> relatively easy to trace backwards from the error messages to the point
> where the memory is being allocated. One way to establish this is to
> sprinkle printk around if-statements. There may be 10-20 levels of calls
> including one or two indirect calls via pointers. Would you be able to do
> that?
> 

I don't think I'll have time to do that anytime soon. Not that I know what
exactly to look for in the first place.

Can you do that debugging yourself ? All you would need is a cross-compiler
(eg from kernel.org), qemu, and a working configuration (the root file
system doesn't really matter since the code doesn't get to the point of
loading it, but you can use [1]). For the configuration file, you can use
rts7751r2dplus_defconfig with CONFIG_CMDLINE and CONFIG_CMDLINE_OVERWRITE
removed.

Thanks,
Guenter

---
[1] https://github.com/groeck/linux-build-test/blob/master/rootfs/sh/rootfs.ext2.gz


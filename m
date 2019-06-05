Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645EEC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0D42067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9AJGRyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFEVqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:46:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:46:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so85719pgg.1;
        Wed, 05 Jun 2019 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVHClWl83LJ+u63GhFAh1l0RQa+NY4Hk0/D4slzQzV0=;
        b=t9AJGRyI9SEqXVZAmAUs3ZqRfMyaQekOOYs/ZD8huILdYj5wezynTdJTEzpTaQUA/I
         IbX+nUZ8ZaR/gQjgV5WnQno2tB8vpSEvZl23fY6+Z1hEAqgk339Wlry8xPCHVIauNMHu
         cf/EDc3o3byv2vPvlFwqZtdgw3s3H/IP6IxQvgX/J2GeTw4lxPhrQx335Kto4tpXqLcJ
         3rI0w4PqFGXWAymbzWX64UaOdqZ/D+MokoA7stnLz1sBybjFZpSQm7bIrhkxhLdrxpaB
         psLHnY3mcGuu5Tu2zUUcgdYV3swchhXSiUZyFSGQ0B4BT9pBU1audVh2HGoS7ME1rhMP
         moqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVHClWl83LJ+u63GhFAh1l0RQa+NY4Hk0/D4slzQzV0=;
        b=k0b4TMedpb8DvC9yYyfhstvXL3x0SBgsZrOUWZFcighLF5/LN9L6/8DOCGM2CaH7FG
         V0fLsPzHKDEPFwyS4mbWXJRtQ5/jgff8Um6XjXBhZlVUziStR1tlaJBm3Rby6sCFd/07
         OKXaZdwoQIVlg38YhL9Uyq/oeueQxhl2mZjtrTQyarBd79FT0OdmYtV/GiYpbVpZAnh0
         gl2i/DVN6X9fA/w9Ap76nvfGdFMj1NWp9XxUU4HGt1RTYDidfz0cWYUI55j8XTOVm/CD
         p0HO2AdqY+sksewnX3shh+hOPoYkeVGop3q8rI1Av+oTLPXuy0cjoNaZL2TzXejyPJo9
         RtYw==
X-Gm-Message-State: APjAAAURa+1Y+G2bLRg2PJ6zzTOgW7yMX982zv70bjjJX0EhU/wdXXYx
        ouBsda/S+Efp61aBFBEoIS4=
X-Google-Smtp-Source: APXvYqz+eJgUTibPNjLvxTAaqTSeA0VFGgm+wTGI1UNNuJwrIeGZusYtqZ067RvWqrF8dFnX/afUZg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr47466072pjv.118.1559771184444;
        Wed, 05 Jun 2019 14:46:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15sm6282401pge.40.2019.06.05.14.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:46:23 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:46:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190605214622.GA22254@roeck-us.net>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529102843.13174-4-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:28:41PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> In preparation for dropping the existing "coherent" dma mem declaration
> APIs, replace the current dma_declare_coherent_memory() based mechanism
> with the creation of a genalloc pool that will be used in the OHCI
> subsystem as replacement for the DMA APIs.
> 
> For context, see thread here: https://lkml.org/lkml/2019/4/22/357
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch results in usb access failures when trying to boot from the
sm501-usb controller on sh4 with qemu.

usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
print_req_error: I/O error, dev sda, sector 2172 flags 80700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
print_req_error: I/O error, dev sda, sector 474 flags 84700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
print_req_error: I/O error, dev sda, sector 730 flags 84700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
print_req_error: I/O error, dev sda, sector 2896 flags 84700

Qemu command line is:

The qemu command line is:

qemu-system-sh4 -M r2d \
        -kernel ./arch/sh/boot/zImage \
	-snapshot \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
	-serial null -serial stdio \
	-net nic,model=rtl8139 -net user -nographic -monitor null

Reverting this patch as well as "USB: drop HCD_LOCAL_MEM flag" fixes the
problem. Reverting "USB: drop HCD_LOCAL_MEM flag" alone does not help.

Guenter

Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB96C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CB62063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isY0UqSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390852AbfFKNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:32:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45478 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbfFKNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:32:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so6973459pga.12;
        Tue, 11 Jun 2019 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9Fzo35JippV1+onM33v00Qp5Y8cxbvuNyBylk/rwIE=;
        b=isY0UqSM3MN0f0vbHrtxJK7GrAYz4XTlnUN1rn7Bqy1qZMwMD0/gJaLhxHEAdwnqRV
         uC2e3GsKM6Sp0TnQXrZ+VuHVvJ/7nUmL/+jwB92wl8w/2orDthUlpEPyUfvhD7IMKhTk
         wW6wVmoniu/4YM31UabwwMn/+AjtBKHuPcJbDh/1qB8MAcEmjMbLW/LaRODQskbq8ElN
         UBLj4Qt2ROaYrESoLSAKCmwd1GAcSEYNOoXn3UXzfWcchnQmGm8wTdnJ041dSY1d7fFa
         tN5ZT2p2rQfuDN1vAwwAXCvjtlALzuhAZJkmkpMyPN1No+ODNcSGfK2LL1cTS/4t1Aok
         TRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9Fzo35JippV1+onM33v00Qp5Y8cxbvuNyBylk/rwIE=;
        b=cN7+C3K/Omg/hpWM8glGaQ1JJecDFPuT+zkEjb528SUrG6GAqb5wn7gppuhs6lgfXa
         t64TVzAN6vFULQ9SpUbojFW6oRyANxwiUG616g7Pzm3j4o1g4cTtggFYzLgP9J9MtXhY
         fHMqgm58FBHymB5rjuyhdkHp/+J5DWo17n/oFuI9Ozpz8DXI9qoWfgoxjbcM2ynxSKke
         xvRccw5tj/CkDiIRV1qvcucyNMiAZF8rPeYf4jiAVS/HvB65lL9QId8QVUtJSNW+8mPi
         wnPWCzl0e7+LwTYrgBr5XIPkfIvJOfPQLPQq4j+Q8rfXRBgPBJ2cid0SULm3UIfdPMwI
         bxQQ==
X-Gm-Message-State: APjAAAUCBILzQlbjWtbcf6bz/PXwnIfrOW8WYjzdfeFHjKofKqL88u7d
        DD6GZWITnUqF9dxKJr13Sus=
X-Google-Smtp-Source: APXvYqzgM7j+1ULipofOzb+BHyeyPojALXL0hAC+L66dUnWLPRw9CPge0p8r/cA3bJc5I/UYVcpUKA==
X-Received: by 2002:a63:c903:: with SMTP id o3mr8935810pgg.295.1560259946998;
        Tue, 11 Jun 2019 06:32:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6sm36249pgs.77.2019.06.11.06.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:32:25 -0700 (PDT)
Date:   Tue, 11 Jun 2019 06:32:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190611133223.GA30054@roeck-us.net>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605214622.GA22254@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:46:22PM -0700, Guenter Roeck wrote:
> On Wed, May 29, 2019 at 01:28:41PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > 
> > In preparation for dropping the existing "coherent" dma mem declaration
> > APIs, replace the current dma_declare_coherent_memory() based mechanism
> > with the creation of a genalloc pool that will be used in the OHCI
> > subsystem as replacement for the DMA APIs.
> > 
> > For context, see thread here: https://lkml.org/lkml/2019/4/22/357
> > 
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This patch results in usb access failures when trying to boot from the
> sm501-usb controller on sh4 with qemu.
> 
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 2172 flags 80700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 474 flags 84700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 730 flags 84700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 2896 flags 84700
> 
> Qemu command line is:
> 
> The qemu command line is:
> 
> qemu-system-sh4 -M r2d \
>         -kernel ./arch/sh/boot/zImage \
> 	-snapshot \
> 	-usb -device usb-storage,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> 	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
> 	-serial null -serial stdio \
> 	-net nic,model=rtl8139 -net user -nographic -monitor null
> 
> Reverting this patch as well as "USB: drop HCD_LOCAL_MEM flag" fixes the
> problem. Reverting "USB: drop HCD_LOCAL_MEM flag" alone does not help.
> 

This problem is still seen in next-20190611.
Has anyone actually tested this code ?

Guenter

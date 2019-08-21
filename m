Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72C8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C3622CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfHUHMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:12:08 -0400
Received: from verein.lst.de ([213.95.11.211]:35293 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfHUHMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:12:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D162968C7B; Wed, 21 Aug 2019 09:12:04 +0200 (CEST)
Date:   Wed, 21 Aug 2019 09:12:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
Message-ID: <20190821071204.GA25836@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-16-hch@lst.de> <3BF39A0F-558D-40E0-880D-27829486F9F0@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BF39A0F-558D-40E0-880D-27829486F9F0@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:14:41PM -0700, Troy Benjegerdes wrote:
> 
> 
> > On Aug 13, 2019, at 8:47 AM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > No point in bloating the kernel image with a bootloader header if
> > we run bare metal.
> 
> I would say the same for S-mode. EFI booting should be an option, not
> a requirement. I have M-mode U-boot working with bootelf to start BBL,
> and at some point, I’m hoping we can have a M-mode linux kernel be
> the SBI provider for S-mode kernels, which seem most logical to me
> to start using the vmlinux elf binaries using something like kexec()

Strictly speaking we could just add another option for the header so
that you could also disable it for S-mode.  But then again the header
is not very harmful, as you don't have to use it.  It just eats up
a little more kernel space.  And as that aspace is very tight for my
M-mode target (the Kendryte KD210) and it is totally pointless for
M-mode I just remove it there.

The idea of using M-mode Linux as the SBI sounds cool.

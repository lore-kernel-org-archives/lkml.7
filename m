Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E5212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfFXLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:55:02 -0400
Received: from verein.lst.de ([213.95.11.211]:54634 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfFXLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:55:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 647BB68B02; Mon, 24 Jun 2019 13:54:29 +0200 (CEST)
Date:   Mon, 24 Jun 2019 13:54:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v2
Message-ID: <20190624115428.GA9538@lst.de>
References: <20190624054311.30256-1-hch@lst.de> <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:47:07PM +0100, Vladimir Murzin wrote:
> Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
> CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
> find it.

There is no such thing in RISC-V.  I don't know of any 64-bit RISC-V
cpu that can actually run 32-bit RISC-V code, although in theory that
is possible.  There also is nothing like the x86 x32 or mips n32 mode
available either for now.

But it turns out that with a few fixes to binfmt_flat it can run 64-bit
binaries just fine.  I sent that series out a while ago, and IIRC you
actually commented on it.

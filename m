Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34334C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EB8206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCEC6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:58:50 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:44984 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCEC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:58:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 945A529D6B;
        Mon,  4 Mar 2019 21:58:47 -0500 (EST)
Date:   Tue, 5 Mar 2019 13:59:03 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
In-Reply-To: <alpine.LNX.2.21.1903051154200.135@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com> <alpine.LNX.2.21.1903051154200.135@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Finn Thain wrote:

> 
> Looks bogus to me.
> 
> If you change memcpy to __builtin_memcpy, then we avoid the macro and the 
> warning changes to,
> 
> ./include/linux/string.h:456:3: warning: '__builtin_memcpy' forming offset [7, 8] is out of the bounds [0, 6] [-Warray-bounds]
>    __builtin_memcpy(dest, src, dest_len);
> 
> The compiler has nothing to complain about here. dest is known to be 
> id->fr and dest_len is known to be sizeof(id->fr).
> 
> The error message indicates that gcc has applied the bounds [0, 6] to dest 
> when in fact those are the bounds for src.
> 

My mistake. GCC is right, it seems memcpy will read past the end of 
"5.0.0+".

-- 

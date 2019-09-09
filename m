Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59869C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A082086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNYWMeKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfIIAo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 20:44:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbfIIAoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojsJuYEOGwGEQk6cZLIzzaB2BBsuAHmwETmV0gnscTA=; b=mNYWMeKWmGcS6bUQggEoI1cT5
        mg1VV+DVS0DTG8mcTygfZxivN7itbRaGLrO2WwxQo1I2ZcRzd7H8bcSrnYTtg3ejKmtEdpAE94hot
        t4tve982sADs5n45eIr9O4/rJOgd9kCe8rV5cTxjQ02SMKPjG5OFF5vcnbzSjElIRoKKKJN0AAKU/
        AsgkJnYKcGAzIi7B1OjTNbsDoGR3dRMWnaPE09bkDoq/WEqp1Ll3oZYeKTVmMkdNfqJW/7YAwLct6
        Jle4LDUBmMMN9xV8YguxI8M96C8ZYjeqhtcF8RomL+83uwFc6ujOeh5J2zatnAU2n9/rA0C5QF1wf
        5OjVTwelg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i77na-0001Ml-Qw; Mon, 09 Sep 2019 00:44:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/8] kconfig/hacking: make 'kernel hacking' menu better
 structured
To:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190908012800.12979-1-changbin.du@gmail.com>
Message-ID: <81a27c4e-98d4-bf6a-c81c-b85666c9a366@infradead.org>
Date:   Sun, 8 Sep 2019 17:44:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/19 6:27 PM, Changbin Du wrote:
> This series is a trivial improvment for the layout of 'kernel hacking'
> configuration menu. Now we have many items in it which makes takes
> a little time to look up them since they are not well structured yet.
> 
> Early discussion is here:
> https://lkml.org/lkml/2019/9/1/39
> 
> Changbin Du (8):
>   kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
>     Instruments'
>   kconfig/hacking: Create submenu for arch special debugging options
>   kconfig/hacking: Group kernel data structures debugging together
>   kconfig/hacking: Move kernel testing and coverage options to same
>     submenu
>   kconfig/hacking: Move Oops into 'Lockups and Hangs'
>   kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
>   kconfig/hacking: Create a submenu for scheduler debugging options
>   kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
> 
>  lib/Kconfig.debug | 627 ++++++++++++++++++++++++----------------------
>  1 file changed, 324 insertions(+), 303 deletions(-)

Hi,

Series applies to v5.3-rc7.  Has some problems applying to linux-next.

Under 'Compile-time checks and compiler options', "Debug Filesystem" does not belong here.
Maybe move it under 'Generic Kernel Debugging Instruments'.

I mostly like it.  I might have put 'Debug notifier call chains' under
'Debug kernel data structures', but that's not a big deal.

-- 
~Randy

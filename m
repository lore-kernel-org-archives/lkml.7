Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5865EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343C720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfETJuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:50:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:59074 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730353AbfETJuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:50:22 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hSevv-0006pA-Jj; Mon, 20 May 2019 12:50:15 +0300
Subject: Re: [ubsan] f0996bc297: netperf.Throughput_total_tps -7.6% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190520053851.GY31424@shao2-debian>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <4834add1-711e-b441-1956-1ab2b2d89353@virtuozzo.com>
Date:   Mon, 20 May 2019 12:50:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520053851.GY31424@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/19 8:38 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -7.6% regression of netperf.Throughput_total_tps due to commit:
> 
> 
> commit: f0996bc2978e02d2ea898101462b960f6119b18f ("ubsan: Fix nasty -Wbuiltin-declaration-mismatch GCC-9 warnings")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

This can't be right. First of all the commit makes changes only lib/ubsan.c which is compiled only when CONFIG_UBSAN=y.
In your config:
# CONFIG_UBSAN is not set 

But even in the case of enabled UBSAN that commit doesn't change the generated machine code at all.

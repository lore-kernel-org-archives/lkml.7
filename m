Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFCC10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF6208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553683072;
	bh=ezjpCDCkTHOuKNYwC6P7BLhLee/p6Im3y26aES/lc3s=;
	h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:
	 From;
	b=KRQw75ZoHs3oUnmCwHXTNDfYBaokA/TUfoEkAG8kJlQRHYy5Zq/S90Vrs1xhPo2d8
	 1INdSGpYPl4AGlyzdXKrb53CX05NwePOKZKQQ1rTfhVkUupvHXtv73XUEXdazYHzk8
	 ptWKXoKzK0ip2TSTqfAlJjo1eMCcs9TD2W/8wdrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfC0Khv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfC0Khv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:37:51 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA742075E;
        Wed, 27 Mar 2019 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553683069;
        bh=ezjpCDCkTHOuKNYwC6P7BLhLee/p6Im3y26aES/lc3s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=x0CZ4Uzb8eEsrkx3JK1SUqMJBn1IWFrevf7muOF1pahQ835fOrCZrJ8vJJAkD9gne
         +KzsmDM/AY0i83Fq8jzoWFq0zXGIrwDGxthdwjTybs6GmFe5VpRK8gL4DsfaD/FGHM
         VbY/0zdcMpY/8LOHKsz8r9H+uP4SYzejL8oSfJF0=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
References: <20190325184522.260535-1-swboyd@chromium.org>
 <20190325184522.260535-4-swboyd@chromium.org>
 <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org>
 <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com>
From:   Kieran Bingham <kbingham@kernel.org>
Openpgp: preference=signencrypt
Message-ID: <88d66467-1d0d-da23-3cee-f09e680d8078@kernel.org>
Date:   Wed, 27 Mar 2019 10:37:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 26/03/2019 17:05, Stephen Boyd wrote:
> Quoting Kieran Bingham (2019-03-26 01:52:10)
>> Hi Stephen,
>>
>> On 25/03/2019 18:45, Stephen Boyd wrote:
>>> Implement gdb functions for rb_first(), rb_last(), rb_next(), and
>>> rb_prev(). These can be useful to iterate through the kernel's red-black
>>> trees.
>>
>> I definitely approve of getting data-structure helpers into scripts/gdb,
>> as it will greatly assist debug options but my last attempt to do this
>> was with the radix-tree which I had to give up on as the internals were
>> changing rapidly and caused continuous breakage to the helpers.
> 
> Thanks for the background on radix-tree. I haven't looked at that yet,
> but I suppose I'll want to have that too at some point.

Sure, it will be useful to get going again, if you get round to it -
feel free to either dig out my old patches from the list, or
git-history. (I believe they actually made it into the kernel but I had
to revert them because of the breakage, and no time to continue that
development).

Or of course - start from scratch might also be a good option :D


>> Do you foresee any similar issue here? Or is the corresponding RB code
>> in the kernel fairly 'stable'?
>>
>>
>> Please could we make sure whomever maintains the RBTree code is aware of
>> the python implementation?
>>
>> That said, MAINTAINERS doesn't actually seem to list any ownership over
>> the rb-tree code, and get_maintainers.pl [0] seems to be pointing at
>> Andrew as the probable route in for that code so perhaps that's already
>> in place :D
> 
> I don't think that the rb tree implementation is going to change. It
> feels similar to the list API. I suppose this problem of keeping things
> in sync is a more general problem than just data-structures changing.
> The only solution I can offer is to have more testing and usage of these
> scripts. Unless gdb can "simulate" or run arbitrary code for us then I
> think we're stuck reimplementing kernel internal code in gdb scripts so
> that we can get debug info out.

I agree - RB seems a lot more stable than the radix-tree was back when I
tried to mirror that implementation.

I would hope at some point we could get some automated tests going for
scripts/gdb as we see more and more functionality.

Everything should be automatable using GDB hooked up to QEmu.

GDB can 'run' arbitrary functions - but it's not a good idea as we won't
know the state of the target, and of course in the case of crash-dump
examination - the target won't even exist.

Anyway, I'm glad this is all useful to you - let us know if there's
anything we can do to help. Myself and Jan are trying to take care of
scripts/gdb - but there's not a lot of active development of new
features currently - so I'm very pleased to see your contributions !


--
Kieran

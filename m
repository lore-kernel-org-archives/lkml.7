Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YanfXBs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfCKHW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:22:28 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:33065 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfCKHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:22:28 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 49C3020E78;
        Mon, 11 Mar 2019 10:22:25 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Gkx1l42XAW-MPc0sKWf;
        Mon, 11 Mar 2019 10:22:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552288945; bh=Cm07HFWXwAmgARt5HAhE4IFJAUEgXtQmZLLiS3zFmq4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=YanfXBs8iQx+LJfjHOx1TEozl/uF31xiQhkJomC/2gPjoW6cFCV9AZwWoMvIgIBdN
         whteQUx51rdBf1XVHnRLAhYUSIkCDbxcFH2PY+GcbX1t1ov5vuhP+3ev0PAKWE+ARo
         D7BuIjf4lX14t/1ng6/3EHwLQwIgQCVG8pXOtoHw=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:65e1:a124:95f1:7d47])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id FrHXc8FV8Q-MO48UZ3c;
        Mon, 11 Mar 2019 10:22:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 2/6] lib: scanf: handle integer overflows in vsscanf
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
 <155223699287.4075.13184771244455866778.stgit@buzz>
 <9da44b6b-49c1-3383-e272-d61065f81de4@rasmusvillemoes.dk>
 <CAHk-=wj95tXzuox8eXPhBtJtV_NzWksxyQ+nPPty1atWH2T-xg@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <b0851627-5c27-c4b6-7807-276131728d0e@yandex-team.ru>
Date:   Mon, 11 Mar 2019 10:22:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj95tXzuox8eXPhBtJtV_NzWksxyQ+nPPty1atWH2T-xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2019 0:52, Linus Torvalds wrote:
> On Sun, Mar 10, 2019 at 2:06 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> IIRC, this has been attempted before, causing a userspace regression
>> because some sysfs/procfs file matched with %u or %x, and somebody wrote
>> -1 to get 0xffffffff .
> 
> .. which is correct anyway. That's how scanf is supposed to work.

Well. In this case '%u' sscanf in kernel is already broken.
%u does not accept minus sign and looks like never does.

'is_sign' is set only for %d and %i,
without it string couldn't pass initial check of first "digit".

More over simple_strtoul never accepted '-'.

Glibc version indeed accepts '-1' as %u and returns 0xFFFFFFFF
which isn't in manpage:' optionally signed' mentioned only for %d and %i.
But this explicitly mentioned in manpage for 'stroul'.

> 
> If somebody needs overflow checking, they shouldn't be using scanf.
> 
>                    Linus
> 

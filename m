Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4583DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFE62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553701233;
	bh=Vv69CyZDAdI5phXsBuaCREGJToik5CgoOszAvDKqv60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0fTG5DZExHLIvnL1ZSoNRGbvRRe3sp+IcZAJcEUXyVpP7rnQdaI21BK4ATt6bOzs8
	 JJLtHKYB+CIZouTsNte6Spl4Kh7FFkGOPZm84cfvsmVz20tZJJuIC/sOIO8kcafjyC
	 dcckA0LC9utFs0d1BSnlMJuzvb1Il4yChBBWA+w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfC0Pkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfC0Pkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:40:31 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBEE206B8;
        Wed, 27 Mar 2019 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553701230;
        bh=Vv69CyZDAdI5phXsBuaCREGJToik5CgoOszAvDKqv60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmbV03XskTRR6jrWyq2R+1dRwypI5hAv8q7enXSyuvKoNpVAoM/8yNqTulKyXeF+7
         LzE7kX8TliUZxd/ewfZ7WjtZOjNVKkMQg787QYjLyq9cwn9NwsApj1kMgXY+vybGk3
         xr7+1Ws6qxbCMNpEnR/kSjlky9andvbs2n71t6P4=
Date:   Wed, 27 Mar 2019 16:40:25 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
Message-ID: <20190327154025.GB23293@linux-8ccs>
References: <20190315101013.GN8455@Legion-PC.fortress>
 <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190326172411.GA15936@Legion-PC.fortress>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Alexey Gladkov [26/03/19 18:24 +0100]:
>On Fri, Mar 22, 2019 at 02:34:12PM +0900, Masahiro Yamada wrote:
>> Hi.
>>
>> (added some people to CC)

(Thanks Masahiro for the CC!)

>>
>> On Fri, Mar 15, 2019 at 7:10 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>> >
>> > Problem:
>> >
>> > When a kernel module is compiled as a separate module, some important
>> > information about the kernel module is available via .modinfo section of
>> > the module.  In contrast, when the kernel module is compiled into the
>> > kernel, that information is not available.
>>
>>
>> I might be missing something, but
>> vmlinux provides info of builtin modules
>> in /sys/module/.
>
>No. There are definitely not all modules. I have a builtin sha256_generic,
>but I can't find him in the /sys/module.

Yeah, you'll only find builtin modules under /sys/module/ if it has any module
parameters, otherwise you won't find it there. As Masahiro already mentioned,
if a builtin module has any parameters, they would be accessible under /sys/module/.

>> (Looks like currently only module_param and MODULE_VERSION)
>>
>> This patch is not exactly the same, but I see a kind of overwrap.
>> I'd like to be sure if we want this new scheme.
>
>The /sys/module is only for running kernel. One of my use cases is
>to create an initrd for a new kernel.
>
>>
>> > Information about built-in modules is necessary in the following cases:
>> >
>> > 1. When it is necessary to find out what additional parameters can be
>> > passed to the kernel at boot time.
>>
>>
>> Actually, /sys/module/<module>/parameters/
>> exposes this information.
>>
>> Doesn't it work for your purpose?
>
>No, since creating an initrd needs to know all the modalias before
>I get the sysfs for new kernel. Also there are no modalias at all.
>
>> > 2. When you need to know which module names and their aliases are in
>> > the kernel. This is very useful for creating an initrd image.
>> >

Hm, I do see one possible additional use-case for preserving module alias
information for built-in modules - modprobe will currently error (I think,
correct me if I'm wrong) if we try invoking modprobe with an alias of a
built-in module, simply because this information is not in modules.builtin or
modules.alias.

Since kbuild already outputs modules.builtin, I would suggest outputting
something like a modules.builtin.alias file (and I guess maybe a modules.builtin.param
file too if that's deemed useful), in a format that is consumable by kmod/modprobe,
so that modprobing an alias of a built-in module doesn't produce an error. I
think this should be easy to do if we keep and parse the resulting .modinfo for
builtin modules. This is just an idea, opinions welcome. I've added Lucas to CC
in case he has any thoughts.


Thanks,

Jessica


Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F30C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FD920848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEPI14 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:27:56 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36516 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:27:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 58C71608A39B;
        Thu, 16 May 2019 10:27:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aJQJGYihpwvn; Thu, 16 May 2019 10:27:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CACBF608A3BE;
        Thu, 16 May 2019 10:27:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 62UdxJy2aWde; Thu, 16 May 2019 10:27:53 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A8DBA608A39B;
        Thu, 16 May 2019 10:27:53 +0200 (CEST)
Date:   Thu, 16 May 2019 10:27:53 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     "Shreya Gangan (shgangan)" <shgangan@cisco.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1060037520.60545.1557995273554.JavaMail.zimbra@nod.at>
In-Reply-To: <5B190BFA-DF2A-4469-85E2-14A7347B7A8E@cisco.com>
References: <E44E4181-1CFB-493C-8023-147472049D19@cisco.com> <CAFLxGvysPg3FO4kT0QrRsYTr219WVttQMeat_StqbifTPrGLmA@mail.gmail.com> <5B190BFA-DF2A-4469-85E2-14A7347B7A8E@cisco.com>
Subject: Re: Removal of dump_stack()s from /fs/ubifs/io.c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: Removal of dump_stack()s from /fs/ubifs/io.c
Thread-Index: AQHVC2FVil2C0hxsCESyeW0kls9eBqZsX3uAr4vQGkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> They are not required, but they are just useful. While you are right that the
>> locations within UBIFS are unique,
>> they are not for the whole kernel context.
>> Filesystem functions can get called via many different paths from VFS...
> 
> Isn't that true for any kernel error though.
> Want to understand why it would be essential for ubifs to have these over the
> other kernel modules?
> Can't the developer add the dump_stack later for debugging reasons?

In UBIFS the dump_stack() calls are more or less a WARN_ON().
Such situations should not happen. If they do, we want the details.

So, in the long rung we could replace most of them by a WARN_ON().
Maybe even WARN_ON_ONCE().

>> Why do you want to remove them, what is the benefit?
> 
> The way our system is using the ubifs, for a device which is 'no longer there'
> could be frequent
> 'no such device' errors when
> 1. there might be multiple write accesses to the filesystem before the
> responsible process is terminated
> 2. the filesystem is unmounted after this
> The result would be flooding of the console or message logs with both the error
> messages and the dump_stack,
> making it really ugly.
> Is there a specific way a 'no such device' issue is handled to avoid the
> messages from flooding with the dump_stacks?

I don't follow, sorry.

If your system too noisy, fix the log level. But usually when UBIFS prints
an error followed by a stack trace, it is something serious you should address
and not trying to make the error message look less scary.

Thanks,
//richard

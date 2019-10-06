Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7AFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DDC20867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HdT5usuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfJFTdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:33:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44935 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfJFTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:33:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id r16so10435618edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r2veK1juFpJOpq2B+7dAWorW0CIcDxfoPULVB2Vc96M=;
        b=HdT5usuhBapvf/2MvAGHQ0ZhOBP2RARClB8AMYZ+8IcaCtPcsvswtrhD7ZEy/gmCiq
         QsbqgDr1EYHYKaQt46kBXGbpB2J0Qbdhf6FqJNFZSwcota2DHPAO0WlerDqSKdIbRd5E
         vfY/BCxZ8wlH1m5y3N5i4DGXUUhfAkUae2ljI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2veK1juFpJOpq2B+7dAWorW0CIcDxfoPULVB2Vc96M=;
        b=IB7eX1nKyRJ90ZWVNDGSNDxaeFu+Uw7p9Kj6HKJWohrDbthu44xYwY8tGdWZNUUnbH
         wVyhBV8pGE76S4ae2D6U2v5mwMuqvMcUkRnzzMA0iaz/WIOApVail1YUcBHLsklCsg2R
         APjFtVrfvrBRS7LMop+mAmNlVof8KlaESQ36oDxxXMgqyBcjfqazemehAsoXZIEjTz1P
         oKIa+/W0KzTPoktM34aI9yLKFU86RWipEEu1zNL7dnGB91GrZnGTJrvjYSx0xZFu0G8o
         pTda5J5Z3lMDeRehoOKmLmRSSHb5QI8Zrd/CMurSYGq1aFGb5TzRjyrrm5WOdOHtDOxn
         s+mw==
X-Gm-Message-State: APjAAAXsXWN9JMrgN15bZGf3rCVLVjkkkRdnBdnrlIPE8SoZTN8n4JTl
        Sqs9o/+7zlavqHiQkAgh68gNAkG81GuTTw==
X-Google-Smtp-Source: APXvYqx1D4zGnHclIa27LBdJchSds9o9/dnTwTwg3jvXOqRC2EzTiJuOOBEiKmpdj1TtUKvLcKfcww==
X-Received: by 2002:a05:6402:1a45:: with SMTP id bf5mr25206034edb.275.1570390386956;
        Sun, 06 Oct 2019 12:33:06 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id jo12sm1560802ejb.7.2019.10.06.12.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 12:33:06 -0700 (PDT)
Subject: Re: [PATCH v3] docs: Use make invocation's -j argument for
 parallelism
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201909241627.CEA19509@keescook>
 <eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk>
 <201910040904.43B61E4@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b95ded2e-474a-5f7b-af07-30732e8cdb41@rasmusvillemoes.dk>
Date:   Sun, 6 Oct 2019 21:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201910040904.43B61E4@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 18.08, Kees Cook wrote:
> On Fri, Oct 04, 2019 at 11:15:46AM +0200, Rasmus Villemoes wrote:
>> On 25/09/2019 01.29, Kees Cook wrote:
>>> +# Extract and prepare jobserver file descriptors from envirnoment.
>>
>> Ah, reading more carefully you set O_NONBLOCK explicitly. Well, older
>> Makes are going to be very unhappy about that (remember that it's a
>> property of the file description and not file descriptor). They don't
>> expect EAGAIN when fetching a token, so fail hard. Probably not when
>> htmldocs is the only target, because in that case the toplevel Make just
>> reads back the exact number of tokens it put in as a sanity check, but
>> if it builds other targets/spawns other submakes, I think this breaks.
> 
> Do you mean the processes sharing the file will suddenly gain
> O_NONBLOCK? I didn't think that was true, 

It is. Quoting man fcntl

   File status flags
       Each  open  file  description has certain associated status
flags, initialized by open(2) and possibly modified by
       fcntl().  Duplicated file descriptors (made with dup(2),
fcntl(F_DUPFD), fork(2), etc.) refer  to  the  same  open
       file description, and thus share the same file status flags.

...  On Linux, this  command
              can  change  only  the O_APPEND, O_ASYNC, O_DIRECT,
O_NOATIME, and O_NONBLOCK flags.

> we could easily just restore the state before exit.

That doesn't really help - and I'm a bit surprised you'd even suggest
that. I don't know if open(/proc/self/fd/...) would give you a new
struct file.

>>> +# Return all the reserved slots.
>>> +os.write(writer, jobs)
>>
>> Well, that probably works ok for the isolated case of a toplevel "make
>> -j12 htmldocs", but if you're building other targets ("make -j12
>> htmldocs vmlinux") this will effectively inject however many tokens the
>> above loop grabbed (which might not be all if the top-level make has
>> started things related to the vmlinux target), so for the duration of
>> the docs build, there will be more processes running than asked for.
> 
> That is true, yes, though I still think it's an improvement over the
> existing case of sphinx-build getting run with -jauto which lands us in
> the same (or worse) position.

Yes, I agree that that's not ideal either. And probably it's not a big
problem in practice (I don't think a lot of people build the docs, let
alone do it while also building the kernel), but it might be rather
surprising and somewhat hard to "debug" to suddenly have a load twice
what one expected.

> The best solution would be to teach sphinx-build about the Make
> jobserver, though I expect that would be weird. Another idea would be to
> hold the reservation until sphinx-build finishes and THEN return the
> slots? That would likely need to change from a utility to a sphinx-build
> wrapper...

Yes, a more general solution would be some kind of generic wrapper that
would hog however many tokens it could get hold of and run a given
command with a commandline slightly modified to hand over those tokens -
then wait for that process to exit and give back the tokens. That would
work for any command that knows about parallelism but doesn't support
the make jobserver model. (I'd probably implement that by creating a
pipe, fork(), then exec into the real command, while the child simply
blocks in a read on the pipe waiting for EOF and then writes back the
tokens, to simplify the "we have to report exit/killed-by-signal status
to the parent).

Rasmus

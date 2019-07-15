Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F93C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC52B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOPeN0JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfGOPKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:10:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfGONz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:55:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so7452592pfg.10;
        Mon, 15 Jul 2019 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AY/nB4f3mWLEDWoqoDEwhnoOsZXC8d+VvPhR/4MeddE=;
        b=AOPeN0JYvr+d//PyK+JaN17bbM8Mb9TlH61mKJRLsChN+2WBgy7HnmpamI3KC/Mjua
         sp6s2J48btOOXPoHMTUGo5weCEK1mlZ/u4MewkIY4LbE+GxBT6Ht20khYLY0UVO8FDcv
         7SsfnFkGXOX0PQgc7dh9tbk2zutUqmo6RpHdIRR2brINRZ7aAvVBapRORZiKwHbPePbo
         06JTwHoVTUDw9YB0Uuktm97RxmNxqYhBV6PBJTxXYW6VwNdxbe1FCaUU505hwsHEGXmv
         wqtGt83tpCa+7i/KXJf+XqKRt3HZzfjSHK/g5jIFT6xgNoADKnRMU31kZWJdKuXyBXtX
         Mxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AY/nB4f3mWLEDWoqoDEwhnoOsZXC8d+VvPhR/4MeddE=;
        b=Hgyvuw5fFvk3BK+VdgwR6LOvIFPmQ1MU6qGCyb7zYlx9aUm+BE8ty0a6T0g6/Kp/5Q
         lNapz/H6H4eZ6RzUCdzNR0jDuJdkz6NKISjLhQLjM4seRrHh1gD8gZW3rtlqZX3HOPXA
         KFDFTCzVIKaOEPRD5yh059ROH+mPe5N6ToFA5wvXpru8bY1Q+NqLROSoKg1ePhKdVPyL
         KKTxzg1VCHxIZgKMbF4Tdwwb0YqOBdL7g1Hlvefuf8FCF2IiaovqDUMsQyGtnnMDcK4l
         n0a5wkGUE1GP7jKXbe7cfZQMcJr7rSBPJkCb9xTRl4iVh2d2EETxCAOaTvApCBSDlP6g
         148A==
X-Gm-Message-State: APjAAAUz2nsIX6q77oVjWy22YsQgWb392UjZ2nqyQpGFmmg7U5687ke7
        7fA3DY3WOZ077gSNUC8UHEQ=
X-Google-Smtp-Source: APXvYqzlXOtDMsIBvJ+VV4Ay1OOpQjT5v+LEIb4LHx6uSBdytpLJfnNixgukI5DBL48PSIUzcMfYnA==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr29623552pje.121.1563198955184;
        Mon, 15 Jul 2019 06:55:55 -0700 (PDT)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id p27sm29427517pfq.136.2019.07.15.06.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 06:55:54 -0700 (PDT)
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using devicetree
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
 <f0cee7b6-b83b-b74c-82f5-f43e39bd391a@gmail.com>
 <20190624115223.db1e53549a15c6548bfa1fa1@kernel.org>
 <e5e3f55b-095b-e6fc-8734-d888ba5c87f3@gmail.com>
 <20190625140004.a74443238596b297a558a66f@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c01bd567-0c8b-ec32-773b-fb95bfcdcd50@gmail.com>
Date:   Mon, 15 Jul 2019 06:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625140004.a74443238596b297a558a66f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Note that Masami has submitted v2 of the patch with further discussion.  I
noticed that I had left some comments unanswered in this thread, so I am
doing this reply before moving on to reply to the v2 thread.

Feel free to move the discussion to v2 instead of replying to this email
if you find that easier.

On 6/24/19 10:00 PM, Masami Hiramatsu wrote:
> Hi Frank,
> 
> On Mon, 24 Jun 2019 15:31:07 -0700
> Frank Rowand <frowand.list@gmail.com> wrote:
>>>>> Currently, kernel support boot-time tracing using kernel command-line
>>>>> parameters. But that is very limited because of limited expressions
>>>>> and limited length of command line. Recently, useful features like
>>>>> histogram, synthetic events, etc. are being added to ftrace, but it is
>>>>> clear that we can not expand command-line options to support these
>>>>> features.
>>>>
>>>> "it is clear that we can not expand command-line options" needs a fuller
>>>> explanation.  And maybe further exploration.
>>>
>>> Indeed. As an example of tracing settings in the first mail, even for simple
>>> use-case,  the trace command is long and complicated. I think it is hard to
>>> express that as 1-liner kernel command line. But devicetree looks very good
>>> for expressing structured data. That is great and I like it :)
>>
>> But you could extend the command line paradigm to meet your needs.
> 
> But the kernel command line is a command line. Would you mean encoding the 
> structured setting in binary format with base64 and pass it? :(

If you want to put structured data in the command line, then yes, you could use
an ascii safe form, such as base64, to contain it.  If that is what you want.


> 
>>>> Devicetree is NOT for configuration information.  This has been discussed
>>>> over and over again in mail lists, at various conferences, and was also an
>>>> entire session at plumbers a few years ago:
>>>>
>>>>    https://elinux.org/Device_tree_future#Linux_Plumbers_2016_Device_Tree_Track
>>>
>>> Thanks, I'll check that.
> 
> I found following discussion in etherpad log, https://elinux.org/Device_tree_plumbers_2016_etherpad
> ----
> If you have data that the kernel does not have a good way to get, that's OK to put into DT.
> 
>     Operating points are OK - but should still be structured well.
> ----
> 
> This sounds like if it is structured well, and there are no other way,
> we will be able to use DT as a channel.
> 
>>>>
>>>> There is one part of device tree that does allow non-hardware description,
>>>> which is the "chosen" node which is provided to allow communication between
>>>> the bootloader and the kernel.
>>>
>>> Ah, "chosen" will be suit for me :)
>>
>> No.  This is not communicating boot loader information.
> 
> Hmm, it's a kind of communication with the operator of the boot loader, since there
> is an admin or developer behind it. I think the comminication is to communicate
> with that human. Then if they intend to trace boot process, that is a kind of
> communication.

The quote from the plumbers 2016 devicetree etherpad ("Operating points are OK ...)
conveniently ignores a sentence just a few lines later:

   "If firmware is deciding the operating point, then it's OK to convey it via DT."

The operating points example is clearly communicating boot loader information to
the kernel.

Something the admin or developer wants to communicate is not boot loader
information.


> 
> [...]
>>>>> - Can we use devicetree for configuring kernel dynamically?
>>>>
>>>> No.  Sorry.
>>>>
>>>> My understanding of this proposal is that it is intended to better
>>>> support boot time kernel and driver debugging.  As an alternate
>>>> implementation, could you compile the ftrace configuration information
>>>> directly into a kernel data structure?  It seems like it would not be
>>>> very difficult to populate the data structure data via a few macros.
>>>
>>> No, that is not what I intended. My intention was to trace boot up
>>> process "without recompiling kernel", but with a structured data.
>>
>> That is debugging.  Or if you want to be pedantic, a complex performance
>> measurement of the boot process (more than holding a stopwatch in your
>> hand).
> 
> Yeah, that's right.
> 
>> Recompiling a single object file (containing the ftrace command data)
>> and re-linking the kernel is not a big price in that context).
> 
> No, if I can use DT, I can choose one of them while boot up.
> That will be a big difference.
> (Of course for that purpose, I should work on boot loader to support
> DT overlay)

This is debugging kernel drivers.  I do not think that it is a big cost for
a kernel developer to re-link the kernel.  On any reasonable modern
development system this should be a matter of seconds, not minutes.

Compiling a devicetree source is not significantly less time.  (To be
fair, you imply that you would have various compiled devicetrees to
choose from at boot time.  It may be realistic to have a library of
ftrace commands, or it may be more realistic that someone debugging
a kernel driver will create a unique ftrace command set for the
particular case they are debugging.)

> 
>>  Or if
>> you create a new communication channel, you will have the cost of
>> creating that data object (certainly not much different than compiling
>> a devicetree) and have the bootloader provide the ftrace data object
>> to the kernel.
> 
> Yes, and for me, that sounds like just a reinvention of the wheel.
> If I can reuse devicetree infrastructure, it is easily done (as I
> implemented in this series. It's just about 500LOC (and YAML document)

Or you can just use the existing ftrace boot command line syntax.


> 
> I can clone drivers/of/ code only for that new communication channel,
> but that makes no one happy. :(
> 
>>> For such purpose, we have to implement a tool to parse and pack the
>>> data and a channel to load it at earlier stage in bootloader. And
>>> those are already done by devicetree. Thus I thought I could get a
>>> piggyback on devicetree.
>>
>> Devicetree is not the universal dumping ground for communicating
>> information to a booting kernel.  Please create another communication
>> channel.
> 
> Why should we so limit the availability of even a small corner of existing
> open source software...?

Because the proposal is a mis-use of devicetree.

> 
> Thank you,
> 


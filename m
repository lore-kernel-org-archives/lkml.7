Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983B8C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5193020674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBFFjWT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfFXWbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:31:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41011 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfFXWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:31:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so8299743pff.8;
        Mon, 24 Jun 2019 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDhvHfU4nGf0uonBKZjM1IEpg98UHFSrxt5pp3t51DY=;
        b=UBFFjWT7LOuvou/845a+CpgFGAlCRZd/d++Vvm5MbyCdmOB6uDYUhbEZ46v6N5zAw3
         0UAgIHRt3RaI/dlynHv55AsUjRAHWaonVi1wqTPvZuJlfiVMJJaRb/cin9Mr6NFkvdui
         nMZFmNk5xoI1k5S4W6grKEW9L7l6u4bAOKTmk2n3X40eN33za1M+v5xtKsmz2r0RlxaS
         J/QNi8p8XnVGYuKm29TwOxkfYfEtV/KSzg4sNpuwsumcNAq+lyBhZBAMiasEmDfIq1es
         rynDtul/z1NJoxaykKAPa4ue4pVR9POUH59gfeo/PDuHR83srjLeTwgpIzp+R8hWqoIJ
         WMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDhvHfU4nGf0uonBKZjM1IEpg98UHFSrxt5pp3t51DY=;
        b=o0fgnHQdD1BCEWJXMBsSEuqUaUFIdPE6Bp/N33bSyg3sgMFZ/xNJoR0d1qHB6mO7o2
         d/tiH6VwEWo0SmNNBOBjAXMpGnnjms9Qq3xhywjjOdqP/OrUnoODqVf5vp4sKy/pvdIN
         ydGJQv3gV6eG8sZxzEio4VrD+BZWxQ5G5IRm2K2seEj9SZ4MWueGU/TtcbIivOtObrpe
         oA9+Kt0v+LUJcKx7Mn64VV69yTshrtXQiOYlnT8HPoTlsf3yGJoOQuvMBTFn/rRPag8l
         BEaJhx3bavBhsyX5OTYQiEhmoAjCzHbnGeVIJLq6b0rrJDBbYSBOON51UJy1dHu+Q7ML
         ONBQ==
X-Gm-Message-State: APjAAAVT08rZ5SectYDUzIxYRn49mTD5rRFKOZVnUWtdKW+ChmqFx2kZ
        xlvwC8vfCi1R0lovBLhLbI0=
X-Google-Smtp-Source: APXvYqxBVF71hCnhocjdmBxf48aLLf2UsC8HofCR0uK+Bz9FPmtB5MKqsbtad7nULsExdR7GNFUqVQ==
X-Received: by 2002:a17:90a:346c:: with SMTP id o99mr26952184pjb.20.1561415469102;
        Mon, 24 Jun 2019 15:31:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m11sm398116pjv.21.2019.06.24.15.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 15:31:08 -0700 (PDT)
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e5e3f55b-095b-e6fc-8734-d888ba5c87f3@gmail.com>
Date:   Mon, 24 Jun 2019 15:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624115223.db1e53549a15c6548bfa1fa1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/19 7:52 PM, Masami Hiramatsu wrote:
> Hi Frank,
> 
> Thank you for your comment!
> 
> On Sun, 23 Jun 2019 12:58:45 -0700
> Frank Rowand <frowand.list@gmail.com> wrote:
> 
>> Hi Masami,
>>
>> On 6/21/19 9:18 AM, Masami Hiramatsu wrote:
>>> Hi,
>>>
>>> Here is an RFC series of patches to add boot-time tracing using
>>> devicetree.
>>>
>>> Currently, kernel support boot-time tracing using kernel command-line
>>> parameters. But that is very limited because of limited expressions
>>> and limited length of command line. Recently, useful features like
>>> histogram, synthetic events, etc. are being added to ftrace, but it is
>>> clear that we can not expand command-line options to support these
>>> features.
>>
>> "it is clear that we can not expand command-line options" needs a fuller
>> explanation.  And maybe further exploration.
> 
> Indeed. As an example of tracing settings in the first mail, even for simple
> use-case,  the trace command is long and complicated. I think it is hard to
> express that as 1-liner kernel command line. But devicetree looks very good
> for expressing structured data. That is great and I like it :)

But you could extend the command line paradigm to meet your needs.

> 
>>>
>>> Hoever, I've found that there is a devicetree which can pass more
>>> structured commands to kernel at boot time :) The devicetree is usually
>>> used for dscribing hardware configuration, but I think we can expand it
>>
>> Devicetree is standardized and documented as hardware description.
> 
> Yes, at this moment. Can't we talk about some future things?> 
>>> for software configuration too (e.g. AOSP and OPTEE already introduced
>>> firmware node.) Also, grub and qemu already supports loading devicetree,
>>> so we can use it not only on embedded devices but also on x86 PC too.
>>
>> Devicetree is NOT for configuration information.  This has been discussed
>> over and over again in mail lists, at various conferences, and was also an
>> entire session at plumbers a few years ago:
>>
>>    https://elinux.org/Device_tree_future#Linux_Plumbers_2016_Device_Tree_Track
> 
> Thanks, I'll check that.
> 
>>
>> There is one part of device tree that does allow non-hardware description,
>> which is the "chosen" node which is provided to allow communication between
>> the bootloader and the kernel.
> 
> Ah, "chosen" will be suit for me :)

No.  This is not communicating boot loader information.

> 
>> There clearly are many use cases for providing configuration information
>> and other types of data to a booting kernel.  I have been encouraging
>> people to come up with an additional boot time communication channel or
>> data object to support this use case.  So far, no serious proposal that
>> I am aware of.
> 
> Hmm, then, can we add "ftrace" node under "chosen" node?
> It seems that "chosen" is supporting some (flat) properties, and I would
> like to add a tree of nodes for describing per-event setting.
> 
> What about something like below? (do we need "compatible" ?)
> 
> chosen {
> 	linux,ftrace {
> 		tp-printk;
> 		buffer-size-kb = <400>;
> 		event0 {
> 			event = "...";
> 		};
> 	};
> };
> 
> [..]
>>>
>>> I would like to discuss on some points about this idea.
>>>
>>> - Can we use devicetree for configuring kernel dynamically?
>>
>> No.  Sorry.
>>
>> My understanding of this proposal is that it is intended to better
>> support boot time kernel and driver debugging.  As an alternate
>> implementation, could you compile the ftrace configuration information
>> directly into a kernel data structure?  It seems like it would not be
>> very difficult to populate the data structure data via a few macros.
> 
> No, that is not what I intended. My intention was to trace boot up
> process "without recompiling kernel", but with a structured data.

That is debugging.  Or if you want to be pedantic, a complex performance
measurement of the boot process (more than holding a stopwatch in your
hand).

Recompiling a single object file (containing the ftrace command data)
and re-linking the kernel is not a big price in that context).  Or if
you create a new communication channel, you will have the cost of
creating that data object (certainly not much different than compiling
a devicetree) and have the bootloader provide the ftrace data object
to the kernel.

> 
> For such purpose, we have to implement a tool to parse and pack the
> data and a channel to load it at earlier stage in bootloader. And
> those are already done by devicetree. Thus I thought I could get a
> piggyback on devicetree.

Devicetree is not the universal dumping ground for communicating
information to a booting kernel.  Please create another communication
channel.

> 
> Thank you,
> 


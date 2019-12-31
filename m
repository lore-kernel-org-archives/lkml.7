Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DBC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550BB2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="v0AqecdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfLaCAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:00:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38828 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaCAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:00:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so44112936otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 18:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bFHWIMTxQ5Y+2/Lps2HjQqsb23aKZRWfueEdefFBMqo=;
        b=v0AqecdGErWfR/UDK5DdT080Iwn6OcQKKc7EJG0ekeRUER7iBbIFSQGN6BhdkjkX89
         NkTlcexh1TDOwV85ShBkfstViTwDCbpZzXT/zZ+LXDm9lH7dz2HqCklRstR60O5Plt/Q
         +NtHKOVjE9x9TdcZ+tKhKeiOnt0VRueiAVmDIBklfwsXyUP/+t4C1lhTjoP3L+qtQQDL
         TgWvn9qdkNQ9kUONVX8UAX7AS2EyudP3L7uXqDc9JsKaeM/EhfgMMXYWz0B224GZEWZP
         dLMlCNqI2L2sWHv7ae5q2I+F+QbRi9uYnC5b1GCzyxZ1X2SbSBlR1BQpdx+BC5iEfwe0
         k1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFHWIMTxQ5Y+2/Lps2HjQqsb23aKZRWfueEdefFBMqo=;
        b=P8uFUgs9fTNp9Xd+k6h26HdNrxysU4w0naRMQHoEtkPIYmRwPYS4HQ+wj8y3jqlYdK
         xVioD/b4eAsO8WCcpqavvI4AIjkvPve/vrejx2aKGjgVG0rzUg5tocsneyDNqkwUFaAO
         gAQegRAqj7lsRKExmlmJ3lWX2muOll050kEG//cdb1iV1QUFSxcFVN1qEzqIquUXvxUS
         Ld4R4HdyqwY8c7TLPjSXC/sG2W3iVpdjVlekzAAwNyeCw8iWkAGIprC0Rjwk6+vYtqEG
         zPtzJIILodO/27pDxVl2L74MZUrr7jSRuoq/h9wkdzxM1O6bI7YIYHC2ATLZf0Ljyny0
         3kDg==
X-Gm-Message-State: APjAAAWRgc5n/1hXnc2LuNQjh5uFHUJzrVxa62pOEKaiONq3pJduoFyA
        5gLbD2A09zWjtEz9gsYZrkqFO5QOYFM=
X-Google-Smtp-Source: APXvYqz3gOWJRcUQRhkeBzcf+TrPu+EblEw3Zq9a0RtGPmmOGfy0H83e06lsBbx4xj30zIvFExvc3Q==
X-Received: by 2002:a9d:7e8c:: with SMTP id m12mr79798726otp.346.1577757642042;
        Mon, 30 Dec 2019 18:00:42 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id 4sm16651672otu.0.2019.12.30.18.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 18:00:41 -0800 (PST)
Subject: Re: Why is CONFIG_VT forced on?
From:   Rob Landley <rob@landley.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
Message-ID: <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
Date:   Mon, 30 Dec 2019 20:04:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/19 7:45 PM, Rob Landley wrote:
> On 12/30/19 6:59 PM, Randy Dunlap wrote:
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> # CONFIG_VT is not set
>>
>> But first you must set/enable EXPERT.  See the bool prompt.
> 
> Wait, the if doesn't _disable_ the symbol? It disables _editability_ of the
> symbol, but the symbol can still be on (and displayed) when the if is false?
> (Why would...)
> 
> Ok. Thanks for pointing that out. Any idea why the menuconfig help text has no
> mention of this?

So if I disable CONFIG_EXPERT, using miniconfig I then need to manually switch on:

./init/Kconfig:	bool "Namespaces support" if EXPERT
./init/Kconfig:	bool "Multiple users, groups and capabilities support" if EXPERT
./init/Kconfig:	bool "Sysfs syscall support" if EXPERT
./init/Kconfig:	bool "open by fhandle syscalls" if EXPERT
./init/Kconfig:	bool "Posix Clocks & timers" if EXPERT
./init/Kconfig:	bool "Enable support for printk" if EXPERT
./init/Kconfig:	bool "BUG() support" if EXPERT
./init/Kconfig:	bool "Enable ELF core dumps" if EXPERT
./init/Kconfig:	bool "Enable full-sized data structures for core" if EXPERT
./init/Kconfig:	bool "Enable futex support" if EXPERT
./init/Kconfig:	bool "Enable eventpoll support" if EXPERT
./init/Kconfig:	bool "Enable signalfd() system call" if EXPERT
./init/Kconfig:	bool "Enable timerfd() system call" if EXPERT
./init/Kconfig:	bool "Enable eventfd() system call" if EXPERT
./init/Kconfig:	bool "Use full shmem filesystem" if EXPERT
./init/Kconfig:	bool "Enable AIO support" if EXPERT
./init/Kconfig:	bool "Enable IO uring support" if EXPERT
./init/Kconfig:	bool "Enable madvise/fadvise syscalls" if EXPERT
./init/Kconfig:	bool "Enable membarrier() system call" if EXPERT
./init/Kconfig:	bool "Load all symbols for debugging/ksymoops" if EXPERT
./init/Kconfig:	bool "Enable rseq() system call" if EXPERT
./init/Kconfig:	bool "Enabled debugging of rseq() system call" if EXPERT
./init/Kconfig:	bool "PC/104 support" if EXPERT
./init/Kconfig:	bool "Enable VM event counters for /proc/vmstat" if EXPERT

plus of course

./arch/x86/Kconfig.cpu:	bool "Supported processor vendors" if EXPERT
./arch/x86/Kconfig:	bool "DMA memory allocation support" if EXPERT
./arch/x86/Kconfig:	bool "Enable DMI scanning" if EXPERT
./arch/x86/Kconfig:	bool "Enable support for 16-bit segments" if EXPERT
./arch/x86/Kconfig:       bool "Enable vsyscall emulation" if EXPERT
./arch/x86/Kconfig:	bool "Enable the LDT (local descriptor table)" if EXPERT
./arch/x86/Kconfig:	bool "Read CNB20LE Host Bridge Windows" if EXPERT
./arch/x86/Kconfig:	bool "ISA bus support on modern systems" if EXPERT
./arch/x86/Kconfig:	bool "ISA-style DMA support" if (X86_64 && EXPERT)

So nobody noticed you have a structural "this config option actually switches
this thing _off_" implemented via magic symbol then?

I think the right fix here involves running sed after kconfig does its thing...

Rob

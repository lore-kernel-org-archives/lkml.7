Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781E21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572285664;
	bh=jYHTq2fhIHq1FOGacNdIHCM7MFR7pavyDtJAQBFVzZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YUMKR87WtIhvy10MKRRHINROrsFhl3ITMg2XowecLH+CevDpGncsErF82vpxOP5Ae
	 /mYT6A963rpDo6bq6SQ2v92Vx3c0EmXJ2fQ+8jfm/xv0/Aqd0yrFLjZVMMDx0GlcEX
	 waMnPCDuSTnarJ5Uk6j7/DqVw3PIABQNO7ESzFx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbfJ1SBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfJ1SBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:01:01 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B75C20862
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572285660;
        bh=jYHTq2fhIHq1FOGacNdIHCM7MFR7pavyDtJAQBFVzZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHQ5BW+4IbC5n3E0yGSonfPNMLwwnaEyifNaFo6GjGnbmAiIscG86OpPWOXR5I7kf
         Ep5LUXW/3jqk8p75rF6+VTgdRwfsjxidebVeo0ID2shPpfIGVuPOHAkM597TiF1+qK
         f96abHy/p7boIglCDvJVWbePMCwf684Vnx0io62Y=
Received: by mail-wr1-f46.google.com with SMTP id w18so10913623wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:01:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUMjqONxv3aY4JK21xjZlBC6pKEc1eNUzDiOUpLoBVESVRhnPcI
        dMbkwPddfAj+9I+tijgoghZa5HQ6+1D1caNxBZBk0A==
X-Google-Smtp-Source: APXvYqzF/Z3m2iR7JMx3xMDTWkMb5TSAWZEwFovg5TksxxCMUY3r6eSG+zFmZVn16rMZZ9yO4EsPweoUVVftFsNQ3Hs=
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr15475859wrt.195.1572285658852;
 Mon, 28 Oct 2019 11:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
 <20191025064225.GA22917@1wt.eu> <20191028094253.054fbf9c@hermes.lan>
In-Reply-To: <20191028094253.054fbf9c@hermes.lan>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 28 Oct 2019 11:00:47 -0700
X-Gmail-Original-Message-ID: <CALCETrWvkTyHWy4yWEwWjV+apUZC6kruBgpOG5d-J4QHa0-uAw@mail.gmail.com>
Message-ID: <CALCETrWvkTyHWy4yWEwWjV+apUZC6kruBgpOG5d-J4QHa0-uAw@mail.gmail.com>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        dev@dpdk.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 28, 2019, at 10:43 AM, Stephen Hemminger <stephen@networkplumber.o=
rg> wrote:
>
> =EF=BB=BFOn Fri, 25 Oct 2019 08:42:25 +0200
> Willy Tarreau <w@1wt.eu> wrote:
>
>> Hi Andy,
>>
>>> On Thu, Oct 24, 2019 at 09:45:56PM -0700, Andy Lutomirski wrote:
>>> Hi all-
>>>
>>> Supporting iopl() in the Linux kernel is becoming a maintainability
>>> problem.  As far as I know, DPDK is the only major modern user of
>>> iopl().
>>>
>>> After doing some research, DPDK uses direct io port access for only a
>>> single purpose: accessing legacy virtio configuration structures.
>>> These structures are mapped in IO space in BAR 0 on legacy virtio
>>> devices.
>>>
>>> There are at least three ways you could avoid using iopl().  Here they
>>> are in rough order of quality in my opinion:
>> (...)
>>
>> I'm just wondering, why wouldn't we introduce a sys_ioport() syscall
>> to perform I/Os in the kernel without having to play at all with iopl()/
>> ioperm() ? That would alleviate the need for these large port maps.
>> Applications that use outb/inb() usually don't need extreme speeds.
>> Each time I had to use them, it was to access a watchdog, a sensor, a
>> fan, control a front panel LED, or read/write to NVRAM. Some userland
>> drivers possibly don't need much more, and very likely run with
>> privileges turned on all the time, so replacing their inb()/outb() calls
>> would mostly be a matter of redefining them using a macro to use the
>> syscall instead.
>>
>> I'd see an API more or less like this :
>>
>>  int ioport(int op, u16 port, long val, long *ret);
>>
>> <op> would take values such as INB,INW,INL to fill *<ret>, OUTB,OUTW,OUL
>> to read from <val>, possibly ORB,ORW,ORL to read, or with <val>, write
>> back and return previous value to <ret>, ANDB/W/L, XORB/W/L to do the
>> same with and/xor, and maybe a TEST operation to just validate support
>> at start time and replace ioperm/iopl so that subsequent calls do not
>> need to check for errors. Applications could then replace :
>>
>>    ioperm() with ioport(TEST,port,0,0)
>>    iopl() with ioport(TEST,0,0,0)
>>    outb() with ioport(OUTB,port,val,0)
>>    inb() with ({ char val;ioport(INB,port,0,&val);val;})
>>
>> ... and so on.
>>
>> And then ioperm/iopl can easily be dropped.
>>
>> Maybe I'm overlooking something ?
>> Willy
>
> DPDK does not want to system calls. It kills performance.
> With pure user mode access it can reach > 10 Million Packets/sec
> with a system call per packet that drops to 1 Million Packets/sec.

If you are getting 10 MPPS with an OUT per packet, I=E2=80=99ll buy you a
whole case of beer.

I=E2=80=99m suggesting that, on virtio-legacy, you benchmark the performanc=
e
hit of using a syscall to ring the doorbell.  Right now, you're doing
an OUT instruction that traps to the hypervisor, probably gets
emulated, and goes out to whatever host-side driver is running.  The
cost of doing that is going to be quite high, especially on older
machines.  I'm guessing that adding a syscall to the mix won't make
much difference.

--Andy

Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4B82070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574457961;
	bh=FKzKBV4TrdrboPXJLjDitQfRN7V8x3JRJ+NB94Pa52I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=maDEXgRIvHQ1I/HBu0JeYKZinhkYIbhTkxHzVlRqzq8D19J5ReFmJLm6rdoK2eOgm
	 7gixEa+SyVtf/oQmfHEPu6G8XboviSVfXgivUJ5KApNVPjhpwMXELKxNGljSzcyZhy
	 EZBKiWIpTG2SgoNoX5/+FIY6aDcGyiboAETdrsfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKVV0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:26:00 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A452070E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574457959;
        bh=FKzKBV4TrdrboPXJLjDitQfRN7V8x3JRJ+NB94Pa52I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFLa8Gfrw+96ytj7yfFR1oAct0LFyIj/vBsqSwf/g89Vcbw9gYI2MHkK0uw/oSkzM
         oSfrdbI2LjNvvK/GJSh8WqSejYfOYYpI7TI2pkE0ScpnNx6DTMNNgtAapHeICHZxhi
         pUg9wBztBNYIOy+VUYIYrJG51Q1j2NoPE0H9Ud9Q=
Received: by mail-wm1-f49.google.com with SMTP id n188so7295183wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 13:25:59 -0800 (PST)
X-Gm-Message-State: APjAAAUEivmufSfcBArehKoTe8yWmkEoXpDgl62S7PeO9nyTEkIFow6t
        HlM6B/d8F6W231bUdtQoxEepBDXzVP6C2hLB/IyRfA==
X-Google-Smtp-Source: APXvYqy6t80pvZKluqCHJUkVWRNG7hNSjpDTA74mJdLEio4HNsVjWA/Sslppf9mIq45V4hOoFDA/XhLbQR7+Uo9z0TY=
X-Received: by 2002:a1c:1f8d:: with SMTP id f135mr7047041wmf.79.1574457957590;
 Fri, 22 Nov 2019 13:25:57 -0800 (PST)
MIME-Version: 1.0
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com> <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net> <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com> <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD20D@ORSMSX115.amr.corp.intel.com>
 <20191122202345.GC2844@hirez.programming.kicks-ass.net> <20191122204204.GA192370@romley-ivt3.sc.intel.com>
In-Reply-To: <20191122204204.GA192370@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Nov 2019 13:25:45 -0800
X-Gmail-Original-Message-ID: <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
Message-ID: <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:29 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Fri, Nov 22, 2019 at 09:23:45PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 22, 2019 at 06:02:04PM +0000, Luck, Tony wrote:
> > > > it requires we get the kernel and firmware clean, but only warns about
> > > > dodgy userspace, which I really don't think there is much of.
> > > >
> > > > getting the kernel clean should be pretty simple.
> > >
> > > Fenghua has a half dozen additional patches (I think they were
> > > all posted in previous iterations of the patch) that were found by
> > > code inspection, rather than by actually hitting them.
> >
> > I thought we merged at least some of that, but maybe my recollection is
> > faulty.
>
> At least 2 key fixes are in TIP tree:
> https://lore.kernel.org/lkml/157384597983.12247.8995835529288193538.tip-bot2@tip-bot2/
> https://lore.kernel.org/lkml/157384597947.12247.7200239597382357556.tip-bot2@tip-bot2/

I do not like these patches at all.  I would *much* rather see the
bitops fixed and those patches reverted.

Is there any Linux architecture that doesn't have 32-bit atomic
operations?  If all architectures can support them, then we should add
set_bit_u32(), etc and/or make x86's set_bit() work for a
4-byte-aligned pointer.

--Andy

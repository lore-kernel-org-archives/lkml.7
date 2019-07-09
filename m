Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F3AC73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A620844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562707269;
	bh=pmYqDuWhUgg/aEU1e1PfiXHDyg8QWSD/w7/3Em8VXOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zg8EbHf7LGft5OfBXD7mS/da7VXzdxMFhP0FZ+qLuEfNtPPySGlgU6ev1Jubi2cFu
	 oU7bDKbewvL+JzjjzFJPjfccJl/Mz9WVYyNx66vPH+OXqt2pXYmws16zsMpB5QXWwl
	 3q3ERPrYhdxjF853GAGB2OFe7MWjvvy+w7FK1Grs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfGIVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:21:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:21:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so21008988ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyOalFl+LpnRq+Sf5WkkuvdPIYl6jGnFKnBN6iCgqk8=;
        b=Zm/IjcRhOmpCYyMjt8s7PUw/5Sq+thMqxHpNV7qHYcdgPBRJhHdF9JxRi+c3KvXqTV
         4qJ1Emr57xWvkQSthseBxldVCM3R2GqAEJXJXng+DW81GEsnI5MXGn7FTpe5CFe0XrEL
         rVSPpJqyKjmVcpLOeduHuJXBFNjsXzc9lzzpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyOalFl+LpnRq+Sf5WkkuvdPIYl6jGnFKnBN6iCgqk8=;
        b=meHPfeM50XvT85+k2LfccRWm2Oy+QknERhz1E4Om5JokRsXWnJdEWbrY2yHFWoWlX5
         rOx4wT+XPIe46y7LtlSA8o+Un8y1KAen4fyDRfn6Lefsca1HMPFF67atgd6RjRZ1uSwo
         F4cU4VGZf+f0iA/uaTs4JoHyR5mSdWxHrafvByK6WmmXLSPl2GJCCG5daChJtpMmT+S8
         aAx1rOF+SP0N/kZKDyE4zA1Vzad9SJd0PgYgf8GLvh5swjeDkFLBNXZwP4XMkeJM7P41
         RtPiOM2Xm+MeKZ1eFkNDMXz9glWOnSfxda8d/OIH0VpgOqDxyfUChErMPtAMdswBhMHZ
         M7kA==
X-Gm-Message-State: APjAAAWOk5IPya4CqoK2EQyPgKi/xfZCd/cPi8nk/oHGarajS0Gsip8Z
        +n8tnCe5zRcr/1ZkjkBnp3HFGs0UbYQ=
X-Google-Smtp-Source: APXvYqyAI80S6T1/CBTlBvpRWTWRgcwwstGbkL3Ke0DtTLxA1o+do/NBpkHOoxn8eSIzfsQKmgb7ig==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr4318931ljg.83.1562707264994;
        Tue, 09 Jul 2019 14:21:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x18sm12543lfe.42.2019.07.09.14.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:21:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m23so20954201lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 14:21:03 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr15452233ljj.156.1562707263461;
 Tue, 09 Jul 2019 14:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com>
In-Reply-To: <20190708162756.GA69120@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 14:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
Message-ID: <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After doing a lot of build testing and merging, I finally got around
to actually boot-testing the result.

Something in this series has broken booting for me. Or rather, things
*boot*, but then it hangs in user space, with

   A start job is running for udev Wait for Complete Device Initialization

it does this on both my desktop and laptop, although the exact hang is
different (on my laptop, it hangs earlier - I don't even get to input
the disk encryption keys).

I'm bisecting, and it will take a while to pinpoint, but I can already
tell that it's from one of these pulls:

    Pull x86 topology updates from Ingo Molnar:
    Pull x86 platform updayes from Ingo Molnar:
    Pull x86 paravirt updates from Ingo Molnar:
    Pull x86 AVX512 status update from Ingo Molnar:
    Pull x86 cleanups from Ingo Molnar:
    Pull x86 cache resource control update from Ingo Molnar:
    Pull x86 build updates from Ingo Molnar:
    Pull x86 asm updates from Ingo Molnar:
    Pull scheduler updates from Ingo Molnar:

Will keep you updated as bisection narrows it down.

              Linus

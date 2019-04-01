Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D71C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800720830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfDAITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:19:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44841 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732053AbfDAITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:19:23 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so2748673uaa.11;
        Mon, 01 Apr 2019 01:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi4VVhCnwzE7TGhfTNJ/QcHC5Ku4Q1slp8yXTNUFiDo=;
        b=nHGKtOWVc/86wyxHKEKpvP6otb2jfpVxreXbhIloC9QN2m4QUIK5pRI77P9Gsa1XM7
         /1MEKJ6emSmFzb0NxHX7BO0EpJyWdkOmQFNpLGmyjZgn15tozn5mSguDZaq/pH7mxxAk
         z0VOd3MW7qP8tiU8ABWyldUGvoy+46ZIpnXeRSU4N9jBtqWFB20oQ3B714sLP7hgeorC
         Fh4R/QbiYvL360GNNjvHYCCRUVDkjQ+snT7n3u/obqMQxcRf4q4HgZQ5/YEmSXibwMeS
         keptmSiVmT0niMpdOeutVHuqAEvBuBrbBR2K7VtBG5Kcw27VKYB2+UMUusJbjhUT5z2y
         FwVQ==
X-Gm-Message-State: APjAAAUMep3ASKZesTnN8A5imBYn2qOmwQVwHzN+QNrUH90EUiqtYZIO
        Ks/Tw5CqPgd38BUaKW5Bb6tD5aR17z/k72HKN+4=
X-Google-Smtp-Source: APXvYqxJi/GXwr/J+Fh+LQC9u7TI2IurOQqD4suI2QB4uLRYdsz5ftciuB1c4tsA3iXfp/QYnZKnzwlks1pz6daiLf4=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr31137677uao.86.1554106761510;
 Mon, 01 Apr 2019 01:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de>
In-Reply-To: <20190325144737.703921-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 10:19:09 +0200
Message-ID: <CAMuHMdXa1qvNzAOFNBs4s6uNvNU4PX8O17K-c12eLni698Lf_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Add the io_uring and pidfd_send_signal system calls to all architectures.
>
> These system calls are designed to handle both native and compat tasks,
> so all entries are the same across architectures, only arm-compat and
> the generic tale still use an old format.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

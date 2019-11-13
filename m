Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DB22459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5exURhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKMMJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:09:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35102 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfKMMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:09:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id n4so2315701qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rddNLtX3eHORFLQmvU8mlE1ysXOKyRdEfiw7vLIbIiQ=;
        b=S5exURhG3Szc1WELD7v7ch57Cqqr396aeOIatKnY+XkN4CuTynj3Bi/eHPBmrUknia
         3KXdhpC1krXUvBZgJ/VfEkL8PVTIYQBovGsSunW4HqAt4yxwc49FWA/X/obuBCtN9ATE
         A9686GVH1/MgOi6Y3g0ZjgLRAPakCEyfy721d+0oyZNnTBKRZJCsASak59VoRA9/UdxE
         4tgjnB6bJ25XTs0uP2b/5HRzPecLd9+4t3sAnPl1TEmstDwc8PJQA9Bi/YHcL2QeHloy
         Yd1kMKh0UAXHonfY2532HqIYnfyNya56yGMJi/NDoL8U1Q9Kx9w7eiiWuNEJKd0cLYtI
         dLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rddNLtX3eHORFLQmvU8mlE1ysXOKyRdEfiw7vLIbIiQ=;
        b=Fwh1/S2fGvEZ/1TnM658C7gWHGnStQ4KLFPVvSEM8CO/e+TdWXNLfdKpU8/+YAyDXv
         Fb3c4zUuhLOFuIIPrG0XFg4CMtfULK/L0M8wXggAMPp+WR3iTXpSESP31bpK8tPwlkSq
         /sN9oODL7yals8X7RSRmWBchsFC8yNgEZTkvnMabbaA1hAZZ6OahdpTBnE5/IBeLTOTH
         hSmjX6QF8zQB/12g+c3Xwa1nSFwMQBXDoMFZBhU6Cd84j6WPFMREZShrgg4koCVnxwuQ
         N209zPP3HT3Iu2oNgng51ShtDy4xQArla+Q6u8M8u4U1UFOPPC1MC5kdKcn51M9/9k7+
         zZlw==
X-Gm-Message-State: APjAAAXRHppn5sQv3vwxlYYmwLR2HwBgyNp/ySPOdOaqyC/HSJnUXP8n
        2+2/29I0PTfo9w7JDnPGIsqqdAIl+cA=
X-Google-Smtp-Source: APXvYqyAnS3aeRECEimYuT0Vvs9IMowZ23xajXE7wICvLZ0dFrw4Ce9u9EyAlAuiUa5L2AuifeHZaA==
X-Received: by 2002:ac8:1a88:: with SMTP id x8mr2223280qtj.65.1573646970725;
        Wed, 13 Nov 2019 04:09:30 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a18sm886663qkc.2.2019.11.13.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 04:09:29 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 736B540D3E; Wed, 13 Nov 2019 09:09:27 -0300 (-03)
Date:   Wed, 13 Nov 2019 09:09:27 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] perf probe: Generate event name with line number
Message-ID: <20191113120927.GA14646@kernel.org>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
 <157314407850.4063.2307803945694526578.stgit@devnote2>
 <20191111140450.GB9365@kernel.org>
 <20191111140625.GC9365@kernel.org>
 <20191111140733.GD9365@kernel.org>
 <20191112173131.e484666a4ae1bbd7708ccf15@kernel.org>
 <20191113080157.9d6316e9826dd5aed874537e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113080157.9d6316e9826dd5aed874537e@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 13, 2019 at 08:01:57AM +0700, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> On Tue, 12 Nov 2019 17:31:31 +0700
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > # perf probe --list
> > > > >   probe:kernel_read_l1 (on kernel_read@fs/read_write.c)
> > > > >   probe:kernel_read_l2 (on kernel_read:1@fs/read_write.c)
> > > > 
> > > > 
> > > > Also look above at the listing, I would expect this instead:
> > > > 
> > > > # perf probe --list
> > > >   probe:kernel_read_l1 (on kernel_read:1@fs/read_write.c)
> > > >   probe:kernel_read_l2 (on kernel_read:2@fs/read_write.c)
> > > > 
> > > > Right?
> > 
> > Yes, it should be so.
> 
> Hmm, this looks the limiation of debuginfo generated by gcc.
> Let me explain what happens. So, here is the decoded Line info in
> debuginfo for kernel_read (is defined in fs/read_write.c:423)
> 
> ---
> $ readelf -wL /usr/lib/debug/boot/vmlinux-5.0.0-32-generic 
> ...
> read_write.c                                 444  0xffffffff812b435d        
                                               ^^^
					       424, right?
> read_write.c                                 424  0xffffffff812b4370               x
> read_write.c                                 425  0xffffffff812b4375               x
> read_write.c                                 426  0xffffffff812b4375       1       x
> read_write.c                                 428  0xffffffff812b4375       2       x
> 
> ---
> This shows the line number info points the kernel_read entry address is
> on #424, this means we can not distinguish kernel_read:0 and kernel_read:1
> from only the address information.cw

If both 0xffffffff812b435d and 0xffffffff812b4370 are associated with
line 424, then we should present on 'perf probe -L' just the first one
and do the same when converting from address to name when presenting
with 'perf probe -l'?

> (maybe huristically we can distinguish it by the "_L1" suffix. But if
> user gives another event name, it doesn't work.)

> ---
> 
> /build/linux-pvZVvI/linux-5.0.0/arch/x86/include/asm/current.h:
> current.h                                     13  0xffffffff812b4375       3       x
> current.h                                     15  0xffffffff812b4375       4       x
> current.h                                     15  0xffffffff812b4375       5       x
> current.h                                     15  0xffffffff812b4375       6       x
> current.h                                     15  0xffffffff812b4375       7       x
> 
> /build/linux-pvZVvI/linux-5.0.0/fs/read_write.c:
> read_write.c                                 424  0xffffffff812b4375       8
> 
> ---
> And it seems that the dwarf_getsrc_die() returns the last line info
> correspoinding to given address (0xffffffff812b4375) even if it is
> not a stetement line. This is why probe:kernel_read_l2 is 
> on kernel_read:1. I will fix that.

by going backwards from what dwarf_getsrc_die() returns till it finds a
statement line?
 
> However, again, as long as the different lines are encoded in same

It is possible as well to have different addresses associated with the
same source code line.

> address, we can not distinguish them except for checking "_L*"
> suffix.
> 
> Possible solutions are
>  - Do not allow user to put probes on lines which shares the address
>    with other lines (user can put a probe only on the earliest line)


>  - Warn user that the line shares address with other lines and put
>    the probe with the earliest line number suffix.
>  - Just warn user. 
> 
> THank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo

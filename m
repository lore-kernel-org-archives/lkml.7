Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6728CC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A354218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoru+PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405190AbfIIOKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:10:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405006AbfIIOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:10:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so7903250pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhLOjyAxlv5hvB+opiwBQ6lHh3q9XNgiJ5S7TQfrU0o=;
        b=NLoru+PPO4d2ul2bHGfePBx0BjpruaO0FMALx/pYwX60yTabxnY7/YHC2lXVrud/Jo
         l6fAQ+bOpnG3zjqUgjvzun4Ms4Jq1XEF9mLV1cNV0zkPLNQD7RshflLzTGWlJtEyc3OO
         i4NA65JWz7EDfTJe+d0Pq5DnmCBDLU6v8hNXLvzSgKmtvvrRv0CyTctIFb70L/A+cYqQ
         kUVNC7aCDQHgKEnHNmvF9fg5lbDpA2DH0rryrYmXNcRxbrfCD/3jjY2gxqFfl3AP7t8e
         FSrWfddTrvPBUUkXRVzd94lqfr03mr6e7sABgcgBbESvSwDemRJTWNNze8R+nrLBwNPY
         Ykag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhLOjyAxlv5hvB+opiwBQ6lHh3q9XNgiJ5S7TQfrU0o=;
        b=U4gFH65YzT7dUcBwwAxcHa59YM1ZL3PIinBtzyCC1zHtUTi/wO1V1LdZNP4vvTiBhU
         p1ib3tYQbjr23LQXJizzOR5aNRgAl22v27ATnajAJToAKsjJSX5ymjnl+kQFsAuGu/vD
         weVW6+81PbG9skI3zGsRoLMolAIp9dtlzKivCFaTjc8MNnHVADKDndI0xcNdwiX11dq/
         fDrtjDpqHTED/Ddw5uYWQtvA210VZLjK4WApwB06pn8QF4SpN8qWUPS8kfLMmy8XENT9
         ULE3M5QtpbssSxzimmyKyEozzYqnN7ZBjT9OmNad8ibGck2eYwa8lWNaqQSlvwuaIyzx
         SxzQ==
X-Gm-Message-State: APjAAAWXsnFkmVIBfAYgPtPR2f0n99nUrySnEiGlR6CpwFqtRUYCCzT/
        ZWltDstr1UhYoN35Ff7+faSsCeVsdJ6oBw==
X-Google-Smtp-Source: APXvYqx95hTnC2f7WnsoV34LVzxoGGngBpO741sLdYteMNXiE1KayLJWs9EYiFIZQPX9Y0weE89KEA==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr2399275pjt.126.1568038234157;
        Mon, 09 Sep 2019 07:10:34 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id v18sm15452954pfn.24.2019.09.09.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:10:33 -0700 (PDT)
Date:   Mon, 9 Sep 2019 22:10:26 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] kconfig/hacking: make 'kernel hacking' menu better
 structured
Message-ID: <20190909141024.rq2pdl2vqqdmdm4m@mail.google.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
 <81a27c4e-98d4-bf6a-c81c-b85666c9a366@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a27c4e-98d4-bf6a-c81c-b85666c9a366@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 05:44:54PM -0700, Randy Dunlap wrote:
> On 9/7/19 6:27 PM, Changbin Du wrote:
> > This series is a trivial improvment for the layout of 'kernel hacking'
> > configuration menu. Now we have many items in it which makes takes
> > a little time to look up them since they are not well structured yet.
> > 
> > Early discussion is here:
> > https://lkml.org/lkml/2019/9/1/39
> > 
> > Changbin Du (8):
> >   kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
> >     Instruments'
> >   kconfig/hacking: Create submenu for arch special debugging options
> >   kconfig/hacking: Group kernel data structures debugging together
> >   kconfig/hacking: Move kernel testing and coverage options to same
> >     submenu
> >   kconfig/hacking: Move Oops into 'Lockups and Hangs'
> >   kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
> >   kconfig/hacking: Create a submenu for scheduler debugging options
> >   kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
> > 
> >  lib/Kconfig.debug | 627 ++++++++++++++++++++++++----------------------
> >  1 file changed, 324 insertions(+), 303 deletions(-)
> 
> Hi,
> 
> Series applies to v5.3-rc7.  Has some problems applying to linux-next.
>
Let me rebase to linux-next.

> Under 'Compile-time checks and compiler options', "Debug Filesystem" does not belong here.
> Maybe move it under 'Generic Kernel Debugging Instruments'.
> 
yes, let's move it to 'Generic Kernel Debugging Instruments'.

> I mostly like it.  I might have put 'Debug notifier call chains' under
> 'Debug kernel data structures', but that's not a big deal.
> 
no problem.

> -- 
> ~Randy

-- 
Cheers,
Changbin Du

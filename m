Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FE820872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="OlkVx09T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441360AbfJQVPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:15:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33439 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394781AbfJQVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:15:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so2082625pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N2Epa6eQ8h5nF5GpuTglLChG4vrT18flVFq+2Tba3tU=;
        b=OlkVx09TcbkuPAXc8d6cqWufOTcsnhWRgl3HOwAl4hbpqZkM6z0ulZo4PsOhz4PQO/
         feHz+1mG+8YSj40XCbrG8n+RIU88IrEijvpXnT4G573h1cDw1sDXLAxwCQDb8JednPiq
         rUN+VPHBH0AFMftUymDESeQZn5JKLn/evJ888=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2Epa6eQ8h5nF5GpuTglLChG4vrT18flVFq+2Tba3tU=;
        b=dZKTvm4FpNIyfRSWaDhwTChAr53rGapnwry9NxA+/e18Pq2M/G1n9KfhwifJ/dRkFz
         SZdDmMj64r2J8n+e1DCohnQy6nLyUQw8HyCnANUBH/2HgjhEQd+oPDund/OsUAuhHWQA
         LLGrVVUy7ZBjRU7eBx9s1ZoEny4Ec/6Mk8TzAHj/2nxRskjgKLGHb/oDU1bMB0qVtQO/
         5hjY+mlvM94A+9mDC+ufBVBue3ot8Pr2YbXZhK3TDuJmkkDdv43vC0odrrQ7HSmNllxB
         ssmcLHQnpN8WknxhRZt+N0MYwsRnesqDMjjwI7Km4RpYsHTAuzwmUNzkOaWLQoUsL7Y/
         KP4w==
X-Gm-Message-State: APjAAAWqsVNRDt9P+P9E0zWKVdWv8UPvu8hwwtP9qhAACFPZ7gKj8ep0
        Lh+BB2104Lq7aUYLbw1zp4tasQ==
X-Google-Smtp-Source: APXvYqxGWsmR5wgG0JENqlJfOUPWEvt3OFoWsXfYwf0OA5ESiLPsL89eFb3lfG1VeHC+Z4esehDI4A==
X-Received: by 2002:a65:6082:: with SMTP id t2mr6424176pgu.363.1571346920389;
        Thu, 17 Oct 2019 14:15:20 -0700 (PDT)
Received: from shiro (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.gmail.com with ESMTPSA id r18sm3390292pgm.31.2019.10.17.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 14:15:19 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:15:15 +0900
From:   Daniel Palmer <daniel@0x0f.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: mstar: Add machine for MStar infinity family
 SoCs
Message-ID: <20191017211513.GA12691@shiro>
References: <20191014061617.10296-1-daniel@0x0f.com>
 <20191014061617.10296-2-daniel@0x0f.com>
 <CAK8P3a2U7U31eF_POU2=eCU+E1DH-wnR2uHr-VZYWLy25hLjKg@mail.gmail.com>
 <20191016203219.GA5191@shiro>
 <CAK8P3a2Tqpwg6=3N2DhcDj9JMo6jt0sY+sYmnNmzZ5Rcao=iMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Tqpwg6=3N2DhcDj9JMo6jt0sY+sYmnNmzZ5Rcao=iMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 03:02:22PM +0200, Arnd Bergmann wrote:
> > I've moved this into infinity_barriers_init() using ioremap() as suggested.
> > I'd like to keep the fixed remap address for now as there are some
> > drivers in the vendor code that might be useful until rewrites are done but
> > are littered with hard coded addresses.
>
> Maybe keep the infinity_io_desc as an out-of-tree patch then? You can
> simply do both, and ioremap() will return the hardcoded address.

That makes sense.
 
> > I've taken the lock out and tested that the ethernet isn't sending garbage
> > and everything looks good.
> 
> I would not expect a missing spinlock to have an observable effect, the
> question is more whether it's correct in all rare corner cases where
> the barrier is interrupted and the interrupt handler uses another barrier.
> 
> I think it is, but I would recommend adding a comment to explain this if
> you drop the spinlock. (or a comment about why this works with fiq if you
> keep the lock).

I think I'll drop the lock for now and add it back if it becomes apparent
it's needed. I suspect it was added in the vendor code out of habit instead
of need.

Thanks for the input.

Daniel

Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B37C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0B21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHI15Eqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfJJIjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:39:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44314 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387811AbfJJIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:39:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id u12so3192397pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RGh2rO2aZYwHa/Y1Cj8hBGbPD5Mu0Wu+i6Qq6LV4LEI=;
        b=aHI15Eqn17jVYTeOisUaG2auUiaQ9Nh+Y7ptTdWinJ1D3CXNzQAzCh2dgAqnt61w3B
         shS9tNsgTFeFis0h9W2AJaZ8WOu5myce8cgqJjQFZGe81ASkeqMBzHZXVL6TM0XrIo3s
         7JaIPCbTICFYmy2d71zVsvFX5yjP5z/rBsgpzVV0K8c63MQCbpRIPzeyVBlSRny44Y2A
         XFs54k1CecH15wp7YrNupz+s8oA62/OlvvQ1AzWs/biKAYX5ggWeQCQwo1JaxNu+uKbT
         qzS6QPNOblP/TLgoj/yOmZyh6jqeV/ysNpy6UhH7VO4CxKr6rn4bKkUpndITvBBs9/R3
         gmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RGh2rO2aZYwHa/Y1Cj8hBGbPD5Mu0Wu+i6Qq6LV4LEI=;
        b=JEFMD157Wg5ZqCvgWVaSOc0bbB6EfSRxnckkkqALfMrXfKG8+cVYW5iNKsDUcQ8ta6
         +nSWxxnMyExticl2IGVVtpFFUQW0yfmusHVu9jP4P9drirlzYk7V0tfKGLeLqpTevDFd
         Z21MkZKkvuTthx2F+JRKqBexlV931hLhJJS30bNJ7oEvrwMueuy13Szxfv4gfoq2NLOo
         j4xDy6ifesLoMhJNdJGj/GjiTRiH51Y54LnKXrwQPxTdSrM7l1C1PrSh+jqEQsxVl5t+
         w6n7wsZNS4NujPdWRE7QyfYuhAYJ0EtCNNs0++Sn/1tXZ1PEvc+ecvqwh7F9SdqRWMpS
         ZYtQ==
X-Gm-Message-State: APjAAAVRazs2VMmrOoITAVhNaiktqjiRtwpUWn/mGVCQjpCzahoS9UuH
        Rmjhyp6bQTZzKBS6ndWSyZA=
X-Google-Smtp-Source: APXvYqxxJGpGtx+qnVTeAkt3lio/jTq+tq/6mQIKQBzMhZ3ZINbYhp1XjojUTNdL+hN8xqrkFn6Wsg==
X-Received: by 2002:a65:66c3:: with SMTP id c3mr7121338pgw.448.1570696755438;
        Thu, 10 Oct 2019 01:39:15 -0700 (PDT)
Received: from localhost ([2001:e60:1023:519f:3055:27ff:fe5a:5b5c])
        by smtp.gmail.com with ESMTPSA id h4sm5010117pfg.159.2019.10.10.01.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:39:14 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:39:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, john.ogness@linutronix.de,
        akpm@linux-foundation.org, Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010083908.GA2521@jagdpanzerIV>
References: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
 <20191010082110.dreavjarni7mkvv6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010082110.dreavjarni7mkvv6@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/19 10:21), Petr Mladek wrote:
[..]
> > > Considering that console.write is called from essentially arbitrary code
> > > path IIUC then all the locks used in this path should be pretty much
> > > tail locks or console internal ones without external dependencies.
> > 
> > That's a good expectation, but I guess it's not always the case.
> > 
> > One example might be NET console - net subsystem locks, net device
> > drivers locks, maybe even some MM locks (skb allocations?).
> > 
> > But even more "commonly used" consoles sometimes break that
> > expectation. E.g. 8250
> > 
> > serial8250_console_write()
> >  serial8250_modem_status()
> >   wake_up_interruptible()
> > 
> > And so on.
> 
> I think that the only maintainable solution is to call the console
> drivers in a well defined context (kthread). We have finally opened
> doors to do this change.

Yeah, that's a pretty complex thing, I suspect. Panic flush to
netcon may deadlock if oops occurs under one of those "important
MM locks" (if any MM locks are actually involved in ATOMIC skb
allocation). If there are such MM locks, then I think flush_on_panic
issue can't be address by printing kthread or ->atomic_write callback.

> Using printk_deferred() or removing the problematic printk() is
> a short term workaround. I am not going to block such patches.
> But the final decision will be on maintainers of the affected subsystems.

Agreed.

	-ss

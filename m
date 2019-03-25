Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB42CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE720879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P42uoXG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfCYTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:18:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYTS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:18:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so7028917pgk.12;
        Mon, 25 Mar 2019 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIHHZ3FD3YD5rfxC7jU56AkxNTXXOuDSDd5Nedw0L3k=;
        b=P42uoXG/kK7eYsrT/jgGidM4UhV85BHw3eC5YvaE40T+DX62lRcDUBnY3aA9HbiL0H
         Zvj2J8+40c/Za7gXtSMgpdl/2WODe8rK8MemjrPwz2THGRdDBoib1cIWwbd7W/uEbFCR
         tZjZ3WxIgd7Jj8J3BZfPsJIDWHqt5lPIIpvHQ/25EWNJp6DRME/wMHrjr7Q61wVyJI9t
         KLsOtuAVnRQo3a5TSh237ZpdlvFrRdjwIv0xgBYQjcFX+Mt03AKc0PNm9oEbyCrPuW6N
         12l9xl/L8lXymSrfX6fuyG5FnzuIqzCyVXejOWTNpCYqRDtQKeb/JDjb7N8m9X01p+YU
         5F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIHHZ3FD3YD5rfxC7jU56AkxNTXXOuDSDd5Nedw0L3k=;
        b=bErAHOo8BqZYwx/fvvzh6Qsz0HtC64NVScouiibk9rRWaEp1kEC2A1QTibZF0lqNn5
         O+seW3+8AWalJVO/ZHVhadDW5IFt4bzWUUy8kqpQ0uMECMPhCw7VAwvTPsyoyS6t/LQC
         tuVQoKP+JhTJqZ+EOEb8zCDqwRwsxWwUyAZ6qIbDSAN/DehCqd+JUciZzwX/50kaXJbZ
         UIeo0rJcp34EGhsQqL/cRtxjjgGh5IeOmW4DwV47aMGwDrpGjRHW2WqZfoBMFV75rrAu
         QBtrpZ35SEqo8VS7IRsrhx35xiCSHXDJS2gc0p6ybvXsysOizlvIF8MH4bYWo4vM4fxd
         lk7Q==
X-Gm-Message-State: APjAAAXQMzwwAGH4IFpWz85IGsaZYgGzzg/XP38WwMVmJf7uvNwk+1qd
        trs55Jm+w+EPsU/hFEpLFIUkyB0C
X-Google-Smtp-Source: APXvYqydR8ZNCbpihzjiv3vARLkd3Jp5rEqThyyHuvhsLN+T9w162SHk78BcxT4oWqedQgfRT7DwCw==
X-Received: by 2002:a62:183:: with SMTP id 125mr25866780pfb.146.1553541507187;
        Mon, 25 Mar 2019 12:18:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 8sm50123408pfs.50.2019.03.25.12.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:18:26 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:18:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "wanghai (M)" <wanghai26@huawei.com>,
        syzbot <syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com>,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        davem@davemloft.net, f.fainelli@gmail.com, idosch@mellanox.com,
        joe@perches.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        yuehaibing@huawei.com
Subject: Re: kernel BUG at net/core/net-sysfs.c:LINE!
Message-ID: <20190325191824.GB97916@dtor-ws>
References: <000000000000e644ba0584bdf7e8@google.com>
 <20190323171621.GF9224@smile.fi.intel.com>
 <280fdb18-4948-968d-faa6-23197cd2b23e@huawei.com>
 <20190325161031.GH9224@smile.fi.intel.com>
 <20190325185554.GA97916@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325185554.GA97916@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:55:54AM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 25, 2019 at 06:10:31PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2019 at 11:20:01PM +0800, wanghai (M) wrote:
> > > thanks , Can it be fixed like this?
> > 
> > I dunno. I think no, it can't.
> 
> I agree, it can't.
> 
> > 
> > As far as I can see the issue happened due to freeing entire network device at
> > the point of putting reference count to the device (struct device is embedded
> > into struct net_device).
> > 
> > When it happens the access to _any_ field of struct net_device will crash the
> > system.
> > 
> > Basically it means that put_device() should be carefully placed case-by-case,
> > because on real hardware the actual device is parent and usually no-one does
> > access to the child without need. On the contrary the tunX devices are
> > artificial and are controlled by the network stack.
> > 
> > So, it means we need to do something like
> > 
> > ret = register_netdev(...);
> > if (ret) {
> > 	put_device(&ndev->dev);
> > 	...
> > }
> > 
> > But as I mentioned, it would be tricky to not break something else.
> 
> I'd say that the entity that called alloc_netdev() should be the one
> that calls put_device() (but the way of free_netdev()), not net/core
> code. Do we have a driver that is messed up and does not do proper
> cleanup?

OK, looking at this some more, I think we need to set dev->reg_state =
NETREG_REGISTERED earlier, right after successful call to device_add()
as at this point the device is alive as far as device core is concerned.
The queue kobjects have to be managed separately, for that I'd pull the
code out of netdev_register_kobject() and move it into
register_netdevice() and ensure that we clean up there properly.

Thanks.

-- 
Dmitry

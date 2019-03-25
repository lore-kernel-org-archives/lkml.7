Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A3620854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTwTnzWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfCYSz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:55:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39738 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfCYSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:55:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so6874503pfo.6;
        Mon, 25 Mar 2019 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dw0VvLBGwJTqF/64+kqqlgKABVOUA/GYBFbkDj22U7o=;
        b=oTwTnzWfBmo4Rc+RTwjlMKpy6bFNUL9OkQPAMhk7laVLBHaxwsvqQGtY7vglJRnBWb
         rz18l3pV9Wd9RP+CeYWne2j05hzc5C7+1CwtjtIt+FN4nWEO0ojK/wtOJCIFxj2qL8NJ
         LpDa/l+BciImYIZH0X7OfiNR5v8Rnx6d0XrP4uagIWjkonrMccOUQoj2+lmFOWYFHA07
         5cE+UsrrxuotqCCknhDBMvFvxYRMokPPWD5u82L9MM9t2LREkqWaz/GhzHsiRWLIkgmq
         BgpWeI0z41y+9TBFbndIAiAnfrL0upYXzSAmuFDGyGFe0j3DVh5EKKjhberMyrUhP+iT
         a/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dw0VvLBGwJTqF/64+kqqlgKABVOUA/GYBFbkDj22U7o=;
        b=WBX/RyxlfZ/8YdWBu1RMYDK21R2qqyiMzpE4MWeiJaYuJaD4AHBzvwPiCGv+ezgYPy
         zZfySjqu5JjFLnTdj5cFAnAE/O6iUZXvQQyOrRmv6yuf5TVb+Iz92GrC31wKIcNxAvoo
         LWfePFi5GCJy+bPfnnZIH4raZ82JXGcmPUFEQjWTWSGwGyoImV3w9oLy7+dssiGyAt2e
         S8munxmE+t3A0ZcDn2eZ0xv7OXzeIOdalAUNym6b9J0TwYIQvWJ4P6CaX473e605Qyvd
         thIIcU8NOgqw/r/SZ7y5LO8eaZfpiF36WFkWQGV04/9t2z1f/XhI1ImsNw5ldXKbRkrK
         2vLA==
X-Gm-Message-State: APjAAAV2T/sOhUIHLgQRTaP74t3MyFpJBbV41r8IrGvTb0me6H25VXti
        1pR7qtr8pRIPN3aho0Z8QIs=
X-Google-Smtp-Source: APXvYqxodkZ1qxHiM8crO76CiF+Pm53btUZ1bzTLYPF7QL7C3je+JJ9sXOVjMLYXSwf01h3XEf/YSQ==
X-Received: by 2002:a62:1c4:: with SMTP id 187mr25399914pfb.256.1553540157559;
        Mon, 25 Mar 2019 11:55:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m16sm12473991pfi.29.2019.03.25.11.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:55:56 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:55:54 -0700
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
Message-ID: <20190325185554.GA97916@dtor-ws>
References: <000000000000e644ba0584bdf7e8@google.com>
 <20190323171621.GF9224@smile.fi.intel.com>
 <280fdb18-4948-968d-faa6-23197cd2b23e@huawei.com>
 <20190325161031.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325161031.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:10:31PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 11:20:01PM +0800, wanghai (M) wrote:
> > thanks , Can it be fixed like this?
> 
> I dunno. I think no, it can't.

I agree, it can't.

> 
> As far as I can see the issue happened due to freeing entire network device at
> the point of putting reference count to the device (struct device is embedded
> into struct net_device).
> 
> When it happens the access to _any_ field of struct net_device will crash the
> system.
> 
> Basically it means that put_device() should be carefully placed case-by-case,
> because on real hardware the actual device is parent and usually no-one does
> access to the child without need. On the contrary the tunX devices are
> artificial and are controlled by the network stack.
> 
> So, it means we need to do something like
> 
> ret = register_netdev(...);
> if (ret) {
> 	put_device(&ndev->dev);
> 	...
> }
> 
> But as I mentioned, it would be tricky to not break something else.

I'd say that the entity that called alloc_netdev() should be the one
that calls put_device() (but the way of free_netdev()), not net/core
code. Do we have a driver that is messed up and does not do proper
cleanup?

Thanks.

-- 
Dmitry

Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58976C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D1207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573318561;
	bh=NII4p2LVtsB0K8578zjEcfH/mWBNZm3pM2aPPJWFfiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tYCBJtSDCAgbnCnRYPwTRXpoK+6Fj4fbEMUs8k46pw1VXqm+TxEKIgLrPivR+xubk
	 w/UkQy8ByGTgd2x/NRjZLdVJh3LIhfr8rbBDxW82J4YHJUHENk6UEeTDku7UvivmsY
	 xkNbgGVS2CzQLI7De4nI+uNEex86cCD7eHhGUESQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfKIQ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 11:56:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43405 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfKIQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 11:55:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id q5so763417lfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2juaR4N9HkKYkFj/Me6q1Rmtkh59YUIyKDzT0tJwhA=;
        b=SHWwPuPL46oT9TwssCs5E9HQgkXl78UXPuMPT9c5C1bWX24ruixFw09ayc1bpEFfYB
         Qz8vyyLhUHRS/caCQMeX4nzgDzvp6CgXz3CyvTlXvw6VSIODM46GtlVnJBa9ER3phQHm
         kIoEXR7Y/uMwwhVWg3aWDaLXeIMzl4lzn3kek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2juaR4N9HkKYkFj/Me6q1Rmtkh59YUIyKDzT0tJwhA=;
        b=ClHLjPs1BkqhivgdLVPKB4Q81Tew4pNHjWly8QbIKU5pwRXjZ9iz8XeqOj1L45mA9Q
         k9WuqZXwQmwsRWtLzLvICZmnOE0OwmS7py8ZmBKbfWLSs4hBqdgRV9+kaftvICqmT7aF
         JOwO36h+q5o+SoDIQMWPBPnaDJ9oJHrIlZp1uLO7+z0C7x7hw3/SxvWKWOq/XOliwydq
         iOLBocqCUNKU9d+0zep0Uqzpxn1AD/+/Ep1spVPHZKIQzkwBrrkj8phKcHdYnDnutzi/
         3s2p8MCRCBX2dIlh/sSLJxpC9+43JDyyIikkmFzyFG9D0fsZ09rZadn0zpVw07cGfbjT
         9mmg==
X-Gm-Message-State: APjAAAV592pjaJjF/jmXPuj+ILwyySecu2QL9hlp30+ao/EHTGwGiwRe
        0oxaiDPdwGOZ5A+WffbOLnyYD3ixd3w=
X-Google-Smtp-Source: APXvYqyGfMMACu8etafGknX98cg7JYfHRA2IQL50s0DKYzMIsciQpd5ah+onhoS2hc+1xknHnqeB0w==
X-Received: by 2002:a19:40c7:: with SMTP id n190mr10540647lfa.37.1573318556185;
        Sat, 09 Nov 2019 08:55:56 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m8sm3859954ljj.80.2019.11.09.08.55.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 08:55:54 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id p18so9426485ljc.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 08:55:54 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr2080671ljj.48.1573318554230;
 Sat, 09 Nov 2019 08:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20190927044243.18856-1-riteshh@linux.ibm.com> <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com> <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk> <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk> <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk> <20191109031333.GA8566@ZenIV.linux.org.uk>
In-Reply-To: <20191109031333.GA8566@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Nov 2019 08:55:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
Message-ID: <CAHk-=wg9e5PDG-y-j6uryc0RCbfZ36yB0a8qBb2hCWNrH4r_3g@mail.gmail.com>
Subject: Re: [PATCH][RFC] race in exportfs_decode_fh()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wugyuan@cn.ibm.com, Jeff Layton <jlayton@kernel.org>,
        hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We have derived the parent from fhandle, we have a disconnected dentry for child,
> we go look for the name.  We even find it.  Now, we want to look it up.  And
> some bastard goes and unlinks it, just as we are trying to lock the parent.
> We do a lookup, and get a negative dentry.  Then we unlock the parent... and
> some other bastard does e.g. mkdir with the same name.  OK, nresult->d_inode
> is not NULL (anymore).  It has fuck-all to do with the original fhandle
> (different inumber, etc.) but we happily accept it.

No arguments with your patch, although I doubt that this case has
actually ever happened in practice ;)

              Linus

Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C065C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359F2184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fynXpHfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGCR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:58:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42486 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:58:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so2923152edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/9cTFwI/OwlNaBPgc9AgydNLFrFVDXBjb7U5jFe3I8=;
        b=fynXpHfi7h3sPyJhYOGOQMSSjIXflnUSAM6i2o+E0Rt3iLhfV54jT0shwCOhMn3i8h
         3G1biyOv0lfyRnhm6Y27J9sshhuXSj8CEtQ59EHoB3bHaMRp3qqdjkKoAbhNIyA9SV4Y
         ytx3s/MSZj+pSlZtgwiCOKwYQ7S570xHz131M4+GpU03barJyPpInel3pGyRgi+K1q//
         059Zw79OTEcRPePHDsYfqv14GwtiPnWkWnvfwfruXZjbsv61/uaIKU8qAEUOT8SIfyb2
         b8sWOs3390IaFVYpE3SxhgZDkCSfvCgKPRX4XGIwMqI6MjK6dFwgOmlUNKBsrLim1xN6
         WOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/9cTFwI/OwlNaBPgc9AgydNLFrFVDXBjb7U5jFe3I8=;
        b=Xq47XsOanvFmliQ9YcpGPyAdsygdiT1f0wlbFkkEW4PPztFtCV0XvxqBfH0JSxlJ6I
         qwp1YglZeFM3xLpFedGJPpy+sX0zovVNlQIeRQORf6geYtUY7h7DiREOxjRkew/k/Prm
         wlVLSg9cc61gyHIIqwVBNuLrxWhAbHfN13bdJxT2Ga47EcMdh21zdGIXPUCvN9i2bXTF
         s/fJPqQcTzl4i7Gp2dVEigwdu0UvOgzyEC7x9oUcswyRIQeY923n+9wOJfkhjey69Ixs
         mE9IPNSLr0oIsrpErJAnsDnhDtWWWfXmJJKqbwmVi6zCJbO1u8571UnD9UpKfjzEjyDy
         tB1A==
X-Gm-Message-State: APjAAAWchmzXG3AMHu5zDxIvnWYhJ7ydwpRnVt9QmR0G82v3xX1J1iAW
        SVgemP7TYkwyEu2QgUFiomE=
X-Google-Smtp-Source: APXvYqzwUasdiBJwrmHqwtKXo8am1kWsWyLtsKwXK5UGoB317QOh/8GxyHQSrm6NsYXLrpOjNm4K/w==
X-Received: by 2002:a17:906:5814:: with SMTP id m20mr35790934ejq.252.1562176727800;
        Wed, 03 Jul 2019 10:58:47 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id b1sm580928ejo.9.2019.07.03.10.58.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 10:58:47 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:58:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
Message-ID: <20190703175845.GA68011@archlinux-epyc>
References: <20190703081119.209976-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703081119.209976-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:10:55AM +0200, Arnd Bergmann wrote:
> When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> produces an annoying warning from clang, which is particularly annoying
> for allmodconfig builds:
> 
> fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
> include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
> include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })
>                                        ^~~~
> 
> After playing with it for a while, I have found a way to rephrase the
> macro in a way that should work well with both gcc and clang and not
> produce this warning. The open-coded __WAIT_QUEUE_HEAD_INIT_ONSTACK
> is a little more verbose than the original version by Peter Zijlstra,
> but avoids the gcc-ism that suppresses warnings when assigning a
> variable to itself.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for sending the fix for these warnings, they are the last
major ones that I can see across various defconfig and allyesconfig
testing. This resolves all of them.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

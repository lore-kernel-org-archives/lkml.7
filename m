Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE77C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE921530
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562892592;
	bh=hG9I44CFYS1MTQmr1kY9trRGzao7qgQxMfXyrbM0GBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O2rLT6aOtw8X+e3c2hQQl3QrYIQjqVvKmMeosQr3Y2JJNm85coCtDUDxejW8Kz1aY
	 lR3TvajKI3Ly+QQptfLfr8GEPrtjxP0N8o9ivVgvZ/SLICdMO9fUIhCaMKPOhP7lkn
	 xtEV+xHSBlbcm7B9Rb3XTk5RuthCq5A2D0aHDAdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfGLAtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfGLAtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:49:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5196208E4;
        Fri, 12 Jul 2019 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562892590;
        bh=hG9I44CFYS1MTQmr1kY9trRGzao7qgQxMfXyrbM0GBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V5F/xOkV9kH/8uHtDSY3toK1lcbgaYtzMAr9FWwHB8QsxorTBbrgjhBHJ1WEHF7Mj
         H7aVIV9bEKa+rWAm2d/kaVpYQ0sKxP3rZUQIjovZEHzkpqGU4IHqxZgXLifFRM2/Go
         aIGKvrWyI6B9QNiy2DNHHgquJ87K+BozMXtSOMdI=
Date:   Thu, 11 Jul 2019 17:49:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
Message-Id: <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
In-Reply-To: <20190703081119.209976-1-arnd@arndb.de>
References: <20190703081119.209976-1-arnd@arndb.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Jul 2019 10:10:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

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

<scratches head>

Surely clang is being extraordinarily dumb here?

DECLARE_WAIT_QUEUE_HEAD_ONSTACK() is effectively doing

	struct wait_queue_head name = ({ __init_waitqueue_head(&name) ; name; })

which is perfectly legitimate!  clang has no business assuming that
__init_waitqueue_head() will do any reads from the pointer which it was
passed, nor can clang assume that __init_waitqueue_head() leaves any of
*name uninitialized.

Does it also warn if code does this?

	struct wait_queue_head name;
	__init_waitqueue_head(&name);
	name = name;

which is equivalent, isn't it?


The proposed solution is, effectively, to open-code
__init_waitqueue_head() at each DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
callsite.  That's pretty unpleasant and calls for an explanatory
comment at the __WAIT_QUEUE_HEAD_INIT_ONSTACK() definition site as well
as a cautionary comment at the __init_waitqueue_head() definition so we
can keep the two versions in sync as code evolves.


Hopefully clang will soon be hit with the cluebat (yes?) and this
change becomes obsolete in the quite short term.  Surely 6-12 months
from now nobody will be using the uncluebatted version of clang on
contemporary kernel sources so we get to remove this nastiness again. 
Which makes me wonder whether we should merge it at all.


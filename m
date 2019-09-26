Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B67222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIZMPN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfIZMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:15:13 -0400
Received: from oasis.local.home (unknown [65.39.69.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91A8206E0;
        Thu, 26 Sep 2019 12:15:10 +0000 (UTC)
Date:   Thu, 26 Sep 2019 08:15:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] tracing: Fix clang -Wint-in-bool-context warnings in
 IF_ASSIGN macro
Message-ID: <20190926081506.63c6a0c6@oasis.local.home>
In-Reply-To: <CAOrgDVMqOqKtY-9FNV5iHWmz6GFqsH=ugwYp77Zwfr3Niw0ebg@mail.gmail.com>
References: <20190925172915.576755-1-natechancellor@gmail.com>
        <CAKwvOdmO255nWf2PrfJ54X95ShNbYPf0FK2x=f57LmzOrCmJug@mail.gmail.com>
        <CAOrgDVMqOqKtY-9FNV5iHWmz6GFqsH=ugwYp77Zwfr3Niw0ebg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 01:37:29 +0200
Dávid Bolvanský <david.bolvansky@gmail.com> wrote:

> GCC C frontend does not warn, GCC C++ FE does. https://godbolt.org/z/_sczyM
> 
> So I (we?) think there is something weird in gcc frontends.
> 
> >> I can't think of a case that this warning is a bug (maybe David can  
> explain more),
> 
> In this case or generally? General bug example:
> 
> if (state == A || B)
> 
> (should be if (state == A || state == B))
> 
> Since this is just one occurrence and I recommend to just land this small
> fix.
> 

Can we add the above comment to the commit log. I was stuck on
wondering what was wrong with the original code, and was ignoring the
patch because I couldn't see what was wrong.

-- Steve

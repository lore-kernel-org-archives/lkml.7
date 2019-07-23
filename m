Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DECC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63FD21911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhxsHlPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfGWHXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:23:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36371 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbfGWHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:23:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so28610430lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+0af/di8neZDo+ch0WCMnUUscgz6jkCHX1aQFfEODRI=;
        b=MhxsHlPusMQTH9eD1GJz8oyq7mT2YG5azSgg7bRoDo7VEMsxXYZF7j7nP7mlsaXfvq
         ie0+9Uc0WK+0n7xUlotoO6A7L93mSGjUo52282K2iQMr9BINiI0oEUz/FM5FDYvy9n3A
         sDEacNGZUnsnpxZ7QJFQwvaxb8WlvykLh/u/uNDWXQw5HFMiL7aQiMrgpw3CTBVfqCN6
         F+CBxTIo6nM/VHzanMg9QT+O+KK6cahYV829TI+r1/t4P4DzU8MuxhvZ9VUua1rjF0HI
         uEg8Sx+gFzTmqvL69hCiqoQOEccliaITZYA+wLCsyxycYd7+aIxlFbaiR9M8Xaq7o6vJ
         okLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+0af/di8neZDo+ch0WCMnUUscgz6jkCHX1aQFfEODRI=;
        b=bz8qONEAGl+lZLsr+N2I+9VQIa8Irzb2+qNml/ebebed85TPyMrK5dg1bVNO1MMovW
         vTke1oDLdi5cDXkkLCudtP6Q7iEyYQh4f1U8ZjIgeCDi2BoInDU4dPvmHEuu0geGe+80
         K8xt1tXczt3uh2O1FtUAJ5297yQsTDlsgUKs3YOc+FdNNofyu8Ia6MfroLqK/VXhqfyw
         eFRkaWuPWXAsH0b1kGgmQsNKTtpqL3tCCYQupu6hzq/sVY5LU+aPxhn2aHlRScjwJzLX
         1TrnBRVMMxM3iCWzZBjTuv4fa1eXxeMmFuObW5Yw/o4P7T4jGVSJh6nPjoA192NtS/Gk
         RpSQ==
X-Gm-Message-State: APjAAAXpcEdv5r1OY39RHtVyLjLXJoqTG2RypnadX/BueENsF2dbbBQt
        nEUJtnm2W4raEEOw0TvBPVc+0UG1dcE=
X-Google-Smtp-Source: APXvYqy0uyb6kww7paN7ZWCOTJXyOuYlTfL/GXmPkkTx3QAGtsk6893sieyg1J9R2d0l/uREK6gM+A==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr33542945lff.81.1563866620067;
        Tue, 23 Jul 2019 00:23:40 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id v202sm6378235lfa.28.2019.07.23.00.23.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 00:23:39 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id E582C460729; Tue, 23 Jul 2019 10:23:38 +0300 (MSK)
Date:   Tue, 23 Jul 2019 10:23:38 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_prctl(): simplify arg2 judgment when calling
 PR_SET_TIMERSLACK
Message-ID: <20190723072338.GD4832@uranus.lan>
References: <1563852653-2382-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563852653-2382-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:30:53AM +0800, Yang Xu wrote:
> arg2 will never < 0, for its type is 'unsigned long'. So negative
> judgment is meaningless.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  kernel/sys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 2969304c29fe..399457d26bef 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2372,11 +2372,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			error = current->timer_slack_ns;
>  		break;
>  	case PR_SET_TIMERSLACK:
> -		if (arg2 <= 0)
> +		if (arg2)
> +			current->timer_slack_ns = arg2;
> +		else
>  			current->timer_slack_ns =
>  					current->default_timer_slack_ns;
> -		else
> -			current->timer_slack_ns = arg2;
>  		break;
>  	case PR_MCE_KILL:
>  		if (arg4 | arg5)

From a glance it looks correct to me, but then...

1) you might simply compare with zero, iow if (arg2 == 0)
   instead of changing 7 lines
2) according to man page passing negative value should be acceptable,
   though it never worked as expected. I've been grepping "git log"
   for this file and the former API is coming from

commit 6976675d94042fbd446231d1bd8b7de71a980ada
Author: Arjan van de Ven <arjan@linux.intel.com>
Date:   Mon Sep 1 15:52:40 2008 -0700

    hrtimer: create a "timer_slack" field in the task struct

which is 11 years old by now. Nobody complained so far even when man
page is saying pretty obviously

       PR_SET_TIMERSLACK (since Linux 2.6.28)
              Each thread has two associated timer slack values:  a  "default"
              value, and a "current" value.  This operation sets the "current"
              timer slack value for the calling  thread.   If  the  nanosecond
              value  supplied in arg2 is greater than zero, then the "current"
              value is set to this value.  If arg2 is less than  or  equal  to
              zero,  the  "current"  timer  slack  is  reset  to  the thread's
              "default" timer slack value.

So i think to match the man page (and assuming that accepting negative value
has been supposed) we should rather do

	if ((long)arg2 < 0)

Thoughts?
